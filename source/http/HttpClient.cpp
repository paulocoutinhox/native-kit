#include "HttpClient.h"
#include <iostream>

#include <curl/curl.h>
#include <curl/easy.h>
#include <curl/curlbuild.h>

std::string NK::HttpClient::get(std::string url)
{
	std::string readBuffer;

	CURL *curl = curl_easy_init();

	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0);
	curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
	curl_easy_setopt(curl, CURLOPT_FORBID_REUSE, 1L); 

	curl_easy_setopt(curl, CURLOPT_USERAGENT, "NativeKit");

	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, HttpClient::writeDataCallback);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
	curl_easy_setopt(curl, CURLOPT_VERBOSE, false);

	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, false);

	int res = curl_easy_perform(curl);
	
    curl_easy_cleanup(curl);
	
	return readBuffer;
}

size_t NK::HttpClient::writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata) 
{
    ((std::string*)userdata)->append((char*)contents, size * nmemb);
    return (size * nmemb);
}