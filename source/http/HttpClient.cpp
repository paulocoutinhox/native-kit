#include "HttpClient.h"
#include <iostream>

#include <curl/easy.h>
#include <curl/curlbuild.h>

NK::HttpClient::HttpClient()
{
	curl = curl_easy_init();

	userAgent = "NativeKit";
	verbose = false;
	followLocation = true;
	forbideReuse = false;

	timeout = 30;	
	connectTimeout = 30;

	caPath = "";
	caInfo = "";
	
	sslVersion = CURL_SSLVERSION_DEFAULT;
	sslVerifyPeer = true;
	sslVerifyHost = true;
}

NK::HttpClient::~HttpClient()
{
	if (curl)
	{
		curl_easy_cleanup(curl);
	}
}

void NK::HttpClient::reset()
{
	curl_easy_setopt(curl, CURLOPT_HTTPGET, 0L);
	curl_easy_setopt(curl, CURLOPT_HTTPPOST, 0L);
	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, NULL);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
}

std::string NK::HttpClient::doRequest(std::string url)
{
	std::string readBuffer;

	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);

	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, HttpClient::writeDataCallback);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, (followLocation == true ? 1L : 0L));
	curl_easy_setopt(curl, CURLOPT_VERBOSE, (verbose == true ? 1L : 0L));
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (sslVerifyPeer == true ? 1L : 0L));
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (sslVerifyHost == true ? 2L : 0L));
	curl_easy_setopt(curl, CURLOPT_FORBID_REUSE, (forbideReuse == true ? 1L : 0L));
	curl_easy_setopt(curl, CURLOPT_USERAGENT, userAgent.c_str());
	curl_easy_setopt(curl, CURLOPT_TIMEOUT, timeout);
	curl_easy_setopt(curl, CURLOPT_CAPATH, caPath.c_str());
	curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, connectTimeout);
	curl_easy_setopt(curl, CURLOPT_SSLVERSION, sslVersion);

	int res = curl_easy_perform(curl);

	return readBuffer;
}

std::string NK::HttpClient::doGet(std::string url)
{
	reset();

	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);

	return doRequest(url);
}

std::string NK::HttpClient::doPost(std::string url, std::string data)
{
	reset();

	curl_easy_setopt(curl, CURLOPT_POST, 1L);
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, data.c_str());
	curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, data.size());

	return doRequest(url);
}

std::string NK::HttpClient::doPut(std::string url, std::string data)
{
	const char *method = "PUT";
	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method);
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, data.c_str());
	curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, data.size());

	return doRequest(url);
}

std::string NK::HttpClient::doDelete(std::string url)
{
	reset();

	const char *method = "DELETE";
	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method);

	return doRequest(url);
}

std::string NK::HttpClient::doHead(std::string url)
{
	reset();

	const char *method = "HEAD";
	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1L); 

	return doRequest(url);
}

std::string NK::HttpClient::doPatch(std::string url)
{
	reset();

	const char *method = "PATCH";
	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method);

	return doRequest(url);
}

void NK::HttpClient::setSSLVerifyPeer(bool sslVerifyPeer)
{
	this->sslVerifyPeer = sslVerifyPeer;
}

void NK::HttpClient::setSSLVerifyHost(bool sslVerifyHost)
{
	this->sslVerifyHost = sslVerifyHost;
}

void NK::HttpClient::setFollowLocation(bool followLocation)
{
	this->followLocation = followLocation;
}

void NK::HttpClient::setVerbose(bool verbose)
{
	this->verbose = verbose;
}

void NK::HttpClient::setForbideReuse(bool forbideReuse)
{
	this->forbideReuse = forbideReuse;
}

void NK::HttpClient::setTimeout(int timeout)
{
	this->timeout = timeout;
}

void NK::HttpClient::setUserAgent(std::string userAgent)
{
	this->userAgent = userAgent;
}

void NK::HttpClient::setCertificateAuthorityPath(std::string caPath)
{
	this->caPath = caPath;
}

void NK::HttpClient::setConnectTimeout(int connectTimeout)
{
	this->connectTimeout = connectTimeout;
}

void NK::HttpClient::setSSLVersion(int sslVersion)
{
	this->sslVersion = sslVersion;
}

void NK::HttpClient::setCertificateAuthorityInfo(std::string caInfo)
{
	this->caInfo = caInfo;
}

size_t NK::HttpClient::writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata)
{
	((std::string *)userdata)->append((char *)contents, size * nmemb);
	return (size * nmemb);
}