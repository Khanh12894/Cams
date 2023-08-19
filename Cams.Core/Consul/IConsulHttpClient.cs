using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace XichLip.Core.Consul
{
    public interface IConsulHttpClient
    {
        Task<T> GetAsync<T>(string serviceName, string servicePath, string queryString="");
        Task<T> GetAuthAsync<T>(string serviceName, string servicePath, string token, string queryString = "");

        Task<T> PostAsync<T>(string serviceName, string servicePath, object content);
        Task<T> PostAuthAsync<T>(string serviceName, string servicePath, string token, object content);
    }
}
