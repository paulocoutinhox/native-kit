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

		void reset();
		
		std::string doGet(std::string url);
		std::string doPost(std::string url, std::string data);
		std::string doPut(std::string url, std::string data);
		std::string doDelete(std::string url);
		std::string doHead(std::string url);
		std::string doPatch(std::string url);

		void setSSLVerifyPeer(bool sslVerifyPeer);
		void setSSLVerifyHost(bool sslVerifyHost);
		void setFollowLocation(bool followLocation);
		void setVerbose(bool verbose);
		void setForbideReuse(bool forbideReuse);
		void setTimeout(int timeout);
		void setUserAgent(std::string userAgent);
		void setCertificateAuthorityPath(std::string caPath);
		void setConnectTimeout(int connectTimeout);
		void setSSLVersion(int sslVersion);
		void setCertificateAuthorityInfo(std::string caInfo);

	private:
		CURL *curl;

		std::string doRequest(std::string url);
		static size_t writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata);

		bool sslVerifyPeer;
		bool sslVerifyHost;
		bool followLocation;
		bool verbose;
		bool forbideReuse;
		int timeout;
		int connectTimeout;
		int sslVersion;

		std::string caPath;
		std::string userAgent;
		std::string caInfo;

	};

}

#endif