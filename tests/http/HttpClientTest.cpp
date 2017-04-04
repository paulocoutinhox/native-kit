#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#import <HttpClient.h>
#import <string>
#import <iostream>

TEST_CASE("HttpClient - Get Request", "[HttpClient]")
{
	std::string url = "http://httpbin.org/get";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->get(url);

	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Get Request HTTPS", "[HttpClient]")
{
	std::string url = "https://httpbin.org/get";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->get(url);
	
	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}

TEST_CASE("HttpClient - Get Request UTF8", "[HttpClient]")
{
	std::string url = "https://httpbin.org/get?coracao'";
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->get(url);
	
	REQUIRE(response.find("\"url\": \"" + url + "\"") != std::string::npos);
}