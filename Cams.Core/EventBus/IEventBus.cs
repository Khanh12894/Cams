using XichLip.Core.EventBus.RabbitMQ;
using System;
using System.Collections.Generic;
using System.Text;

namespace XichLip.Core.EventBus
{
    public interface IEventBus
    {
        /// <summary>
        /// Publishes the specified event data.
        /// </summary>
        /// <param name="eventData">The event data.</param>
        void Publish(EventData eventData);
        /// <summary>
        /// Subscribes this instance.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="TH">The type of the h.</typeparam>
        void Subscribe<T, TH>()
            where T : EventData
            where TH : IEventHandler;
        /// <summary>
        /// Unsubscribes this instance.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <typeparam name="TH">The type of the h.</typeparam>
        void Unsubscribe<T, TH>()
             where T : EventData
             where TH : IEventHandler;
    }
}
