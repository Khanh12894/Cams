
using log4net;
using XichLip.Core.EventBus.RabbitMQ.IImplementation;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace XichLip.Core.EventBus.RabbitMQ
{
    public class EventBusRabbitMQ : IEventBus
    {
        /// <summary>
        /// 队列名称
        /// </summary>
        private string queueName = "QUEUE";
        /// <summary>
        /// 交换机名称
        /// </summary>
        private string exchangeName = "directName";
        /// <summary>
        /// 交换类型
        /// </summary>
        private string exchangeType = "direct";
        private IFactoryRabbitMQ _factory;
        private IEventBusManager _eventBusManager;
        private ILogger<EventBusRabbitMQ> _log;
        private readonly IConnection connection;
        private readonly IModel channel;
        public EventBusRabbitMQ(IFactoryRabbitMQ factory, IEventBusManager eventBusManager, ILogger<EventBusRabbitMQ> log)
        {
            _factory = factory;
            _eventBusManager = eventBusManager;
            _eventBusManager.OnRemoveEventHandler += OnRemoveEvent;
            _log = log;
            connection = _factory.CreateConnection();
            channel = connection.CreateModel();
        }
        private void OnRemoveEvent(object sender, ValueTuple<Type, Type> args)
        {
            channel.QueueUnbind(queueName, exchangeName, args.Item1.Name);
        }
        public void Publish(EventData eventData)
        {
            string routeKey = eventData.GetType().Name;
            var queueEventName = queueName + "_" + routeKey;
            //channel.QueueDeclare(queueName, true, false, false, null);
            string message = JsonConvert.SerializeObject(eventData);
            byte[] body = Encoding.UTF8.GetBytes(message);

            channel.QueueDeclare(queue: queueEventName,
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

            channel.BasicPublish(exchange: "",
                                 routingKey: queueEventName,
                                 basicProperties: null,
                                 body: body);
            //channel.BasicPublish(exchangeName, routeKey, null, body);
        }

        public void Subscribe<T, TH>()
            where T : EventData
            where TH : IEventHandler
        {
            try
            {


                _eventBusManager.AddSub<T, TH>();
                //string routeKey = typeof(T).Name;
                //var queueEventName = queueName + "_" + routeKey;
                ////channel.QueueBind("", queueEventName, typeof(T).Name);
                //channel.QueueDeclare(queue: queueEventName,
                //                     durable: false,
                //                     exclusive: false,
                //                     autoDelete: false,
                //                     arguments: null);

                ////channel.QueueDeclare(queueName, true, false, false, null);
                //var consumer = new EventingBasicConsumer(channel);
                //consumer.Received += async (model, ea) =>
                // {
                //     string eventName = ea.RoutingKey;
                //     byte[] resp = ea.Body.ToArray();
                //     string body = Encoding.UTF8.GetString(resp);
                //     _log.LogInformation(body);
                //     try
                //     {
                //         Type eventType = _eventBusManager.FindEventType(eventName);
                //         T eventData = (T)JsonConvert.DeserializeObject(body, eventType);
                //         IEventHandler<T> eventHandler = _eventBusManager.FindHandlerType(eventType) as IEventHandler<T>;
                //         await eventHandler.Handler(eventData);
                //     }
                //     catch (Exception ex)
                //     {
                //         throw ex;
                //     }

                // };
                //channel.BasicConsume(queueName, true, consumer);


                string routeKey = typeof(T).Name;
                var queueEventName = queueName + "_" + routeKey;

                var connection2 = _factory.CreateConnection();

                var channel2 = connection2.CreateModel();

                channel2.QueueDeclare(
                    queue: queueEventName,
                    durable: false,
                    exclusive: false,
                    autoDelete: false,
                    arguments: null);

                var consumer2 = new EventingBasicConsumer(channel2);

                //consumer2.Received += Consumer_Received;
                consumer2.Received += async (model, ea) =>
                 {
                     string eventName = ea.RoutingKey.Replace(queueName + "_", "");
                     byte[] resp = ea.Body.ToArray();
                     string body = Encoding.UTF8.GetString(resp);
                     _log.LogInformation(body);
                     try
                     {
                         Type eventType = _eventBusManager.FindEventType(eventName);
                         T eventData = (T)JsonConvert.DeserializeObject(body, eventType);
                         IEventHandler<T> eventHandler = _eventBusManager.FindHandlerType(eventType) as IEventHandler<T>;
                         await eventHandler.Handler(eventData);
                     }
                     catch (Exception ex)
                     {
                         throw ex;
                     }

                 };

                channel2.BasicConsume(
                    queue: queueEventName,
                    autoAck: false,
                    consumer: consumer2);

            }
            catch (Exception ex)
            {
                // Queue not found
            }
        }
        public void Consumer_Received(object sender, BasicDeliverEventArgs e)
        {
            byte[] resp = e.Body.ToArray();
            string body = Encoding.UTF8.GetString(resp);
            var message = JsonConvert.SerializeObject(body);
            var test = 1;
        }

        public void Unsubscribe<T, TH>()
           where T : EventData
           where TH : IEventHandler
        {
            if (_eventBusManager.HaveAddHandler(typeof(T)))
            {
                _eventBusManager.RemoveEventSub<T, TH>();
            }
        }
    }
}
