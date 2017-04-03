#ifndef HttpClient_H
#define HttpClient_H

#include <string>
#include <sstream>
#include <curl/curl.h>

namespace NK
{

	class HttpClient
	{

	public:
		HttpClient();

		~HttpClient();

		std::string get(std::string url);

	private:
		CURL *curl;

		static size_t writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata);

		bool sslVerifyPeer;
		bool sslVerifyHost;
		bool followLocation;
		bool verbose;
		bool forbideReuse;

		std::string userAgent;

	};

}

#endif