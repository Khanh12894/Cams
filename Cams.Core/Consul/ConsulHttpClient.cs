using Consul;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace XichLip.Core.Consul
{
    public class ConsulHttpClient : IConsulHttpClient
    {
        private IConsulClient _consulclient;
        private readonly IHttpClientFactory _clientFactory;

        public ConsulHttpClient(IHttpClientFactory clientFactory, IConsulClient consulclient)
        {
            _clientFactory = clientFactory;
            _consulclient = consulclient;
        }

        public async Task<T> GetAsync<T>(string serviceName, string servicePath, string queryString = "")
        {
            var uri = await GetRequestUriAsync(serviceName, servicePath, queryString);
            var client = _clientFactory.CreateClient();

            var response = await client.GetAsync(uri);

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var content = await response.Content.ReadAsStringAsync();

            return JsonConvert.DeserializeObject<T>(content);
        }
        public async Task<T> GetAuthAsync<T>(string serviceName, string servicePath, string token, string queryString = "")
        {
            var uri = await GetRequestUriAsync(serviceName, servicePath, queryString);
            var client = _clientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            var response = await client.GetAsync(uri);

            if (!response.IsSuccessStatusCode)
            {
                return default(T);
            }

            var content = await response.Content.ReadAsStringAsync();

            return JsonConvert.DeserializeObject<T>(content);
        }
        public async Task<T> PostAsync<T>(string serviceName, string servicePath, object content)
        {
            var uri = await GetRequestUriAsync(serviceName, servicePath);
            var client = _clientFactory.CreateClient();
            var json = JsonConvert.SerializeObject(content);
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = await client.PostAsync(uri, data);
            string result = response.Content.ReadAsStringAsync().Result;
            //response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            //response.EnsureSuccessStatusCode();
            string responseBody = await response.Content.ReadAsStringAsync();

            return JsonConvert.DeserializeObject<T>(responseBody);
        }
        public async Task<T> PostAuthAsync<T>(string serviceName, string servicePath, string token, object content)
        {
            var uri = await GetRequestUriAsync(serviceName, servicePath);
            var client = _clientFactory.CreateClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            var json = JsonConvert.SerializeObject(content);
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = await client.PostAsync(uri, data);
            string result = response.Content.ReadAsStringAsync().Result;
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            response.EnsureSuccessStatusCode();
            string responseBody = await response.Content.ReadAsStringAsync();

            return JsonConvert.DeserializeObject<T>(responseBody);
        }

        private async Task<Uri> GetRequestUriAsync(string serviceName, Uri uri)
        {
            //Get all services registered on Consul
            var allRegisteredServices = await _consulclient.Agent.Services();

            //Get all instance of the service went to send a request to
            var registeredServices = allRegisteredServices.Response?.Where(s => s.Value.Service.Equals(serviceName, StringComparison.OrdinalIgnoreCase)).Select(x => x.Value).ToList();

            //Get a random instance of the service
            var service = GetRandomInstance(registeredServices, serviceName);

            if (service == null)
            {
                //throw new ConsulServiceNotFoundException($"Consul service: '{serviceName}' was not found.",
                //    serviceName);
            }

            var uriBuilder = new UriBuilder(uri)
            {
                Host = service.Address,
                Port = service.Port
            };

            return uriBuilder.Uri;
        }
        private async Task<Uri> GetRequestUriAsync(string serviceName, string servicePath = "", string queryString = "")
        {
            //Get all services registered on Consul
            var allRegisteredServices = await _consulclient.Agent.Services();

            //Get all instance of the service went to send a request to
            var registeredServices = allRegisteredServices.Response?.Where(s => s.Value.Service.Equals(serviceName, StringComparison.OrdinalIgnoreCase)).Select(x => x.Value).ToList();

            //Get a random instance of the service
            var service = GetRandomInstance(registeredServices, serviceName);

            if (service == null)
            {
                //throw new ConsulServiceNotFoundException($"Consul service: '{serviceName}' was not found.",
                //    serviceName);
            }

            var uriBuilder = new UriBuilder()
            {
                Host = service.Address,
                Port = service.Port
            };
            if (!string.IsNullOrEmpty(servicePath))
            {
                uriBuilder.Path = servicePath;
            }
            if (!string.IsNullOrEmpty(queryString))
            {
                uriBuilder.Query = queryString;
            }
            return uriBuilder.Uri;
        }

        private AgentService GetRandomInstance(IList<AgentService> services, string serviceName)
        {
            Random _random = new Random();

            AgentService servToUse = null;
            if(services!=null && services.Count > 0) { 
                servToUse = services[_random.Next(0, services.Count)];
            }
            return servToUse;
        }

    }
}
