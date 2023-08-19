﻿using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Text;

namespace XichLip.Core.EventBus.RabbitMQ.IImplementation
{
   public interface IFactoryRabbitMQ
    {
        IConnection CreateConnection();
    }
}
