using XichLip.Core.Configure;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace XichLip.Core.EventBus
{
    internal class EventBusManager : IEventBusManager
    {
        public event EventHandler<ValueTuple<Type, Type>> OnRemoveEventHandler;
        private static ConcurrentDictionary<Type, Type> eventhandlers=new ConcurrentDictionary<Type, Type>();
        private readonly ConcurrentDictionary<string, Type> eventTypes = new ConcurrentDictionary<string, Type>();
        private readonly IList<Type> assemblyTypes;
        private readonly IServiceCollection _serviceDescriptors;
        private Func<IServiceCollection, IServiceProvider> _buildServiceProvider;
        public EventBusManager(IServiceCollection serviceDescriptors,Func<IServiceCollection,IServiceProvider> buildServiceProvicer)
        {
            _serviceDescriptors = serviceDescriptors;
            _buildServiceProvider = buildServiceProvicer;
            string dllName = ConfigurationProvider.configuration.GetSection("EventHandler.DLL").Value;
            if (!string.IsNullOrEmpty(dllName))
            {
                assemblyTypes = Assembly.Load(dllName).GetTypes();
            }
        }
        private void OnRemoveEvent(Type eventDataType, Type handler)
        {
            if (OnRemoveEventHandler != null)
            {
                OnRemoveEventHandler(this, new ValueTuple<Type, Type>(eventDataType, handler));
            }
        }
        public void AddSub<T, TH>()
             where T : EventData
             where TH : IEventHandler
        {
            Type eventDataType = typeof(T);
            Type handlerType = typeof(TH);
            if (!eventhandlers.ContainsKey(typeof(T)))
                eventhandlers.TryAdd(eventDataType, handlerType);
            if(!eventTypes.ContainsKey(eventDataType.Name))
                eventTypes.TryAdd(eventDataType.Name, eventDataType);
            if (assemblyTypes != null)
            {
               Type implementationType = assemblyTypes.FirstOrDefault(s => handlerType.IsAssignableFrom(s));
                if (implementationType == null)
                    throw new ArgumentNullException("Không tìm thấy lớp triển khai của {0}", handlerType.FullName);
                _serviceDescriptors.AddTransient(handlerType, implementationType);
            }
        }
        public void RemoveEventSub<T, TH>()
            where T : EventData
            where TH : IEventHandler
        {

            OnRemoveEvent(typeof(T), typeof(TH));
        }
        public bool HaveAddHandler(Type eventDataType)
        {
            if (eventhandlers.ContainsKey(eventDataType))
                return true;
            return false;
        }
        public Type FindEventType(string eventName)
        {
            if(!eventTypes.ContainsKey(eventName))
                throw new ArgumentException(string.Format("eventTypes không có khóa tên lớp {0}", eventName));
            return eventTypes[eventName];
        }
        public object FindHandlerType(Type eventDataType)
        {
            if(!eventhandlers.ContainsKey(eventDataType))
                throw new ArgumentException(string.Format("trình xử lý sự kiện không có khóa thuộc loại {0}", eventDataType.FullName));
           var obj = _buildServiceProvider(_serviceDescriptors).GetService(eventhandlers[eventDataType]);
            if (eventhandlers[eventDataType].IsAssignableFrom(obj.GetType()))
                return obj;
            return null;
        }
    }

}
