#include "HttpClient.h"
#include <iostream>

#include <curl/easy.h>
#include <curl/curlbuild.h>

NK::HttpClient::HttpClient()
{
	curl = curl_easy_init();

	userAgent = "NativeKit";

	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, followLocation);
	curl_easy_setopt(curl, CURLOPT_VERBOSE, verbose);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, sslVerifyPeer);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, sslVerifyHost);
	curl_easy_setopt(curl, CURLOPT_FORBID_REUSE, forbideReuse);
	curl_easy_setopt(curl, CURLOPT_USERAGENT, &userAgent);
}

NK::HttpClient::~HttpClient()
{
	curl_easy_cleanup(curl);
}

std::string NK::HttpClient::get(std::string url)
{
	std::string readBuffer;

	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_easy_setopt(curl, CURLOPT_HTTPGET, true);
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, HttpClient::writeDataCallback);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

	int res = curl_easy_perform(curl);

	return readBuffer;
}

size_t NK::HttpClient::writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata)
{
	((std::string *) userdata)->append((char *) contents, size * nmemb);
	return (size * nmemb);
}