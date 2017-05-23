#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#import <HttpClient.h>
#import <string>
#import <iostream>

TEST_CASE("HttpClient - Get Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/get";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->doGet(url);
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Get Request HTTPS", "[HttpClient]")
{
	std::string url = "https://httpbin.org/get";
	NK::HttpClient *client = new NK::HttpClient();
	client->setSSLVerifyHost(false);
	client->setSSLVerifyPeer(false);

	std::string response = client->doGet(url);
	std::cout << "Response: " << response << std::endl;
	
	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Get Request UTF8", "[HttpClient]")
{
	std::string url = "https://httpbin.org/get?coracao'";
	NK::HttpClient *client = new NK::HttpClient();
	client->setSSLVerifyHost(false);
	client->setSSLVerifyPeer(false);
	
	std::string response = client->doGet(url);
	std::cout << "Response: " << response << std::endl;
	
	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Post Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/post";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->doPost(url, "username=test&password=123456");
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Put Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/put";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->doPut(url, "name=My Name&email=test@email.com");
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Delete Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/delete";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->doDelete(url);
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Patch Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/patch";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->doPatch(url);
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - User Agent", "[HttpClient]")
{
	std::string url = "http://httpbin.org/get";
	std::string userAgent = "New user agent";

	NK::HttpClient *client = new NK::HttpClient();
	client->setUserAgent(userAgent);
	std::string response = client->doGet(url);
	std::cout << "Response: " << response << std::endl;

	REQUIRE(response.find("\"User-Agent\": \"" + userAgent + "\"") != std::string::npos);
}
