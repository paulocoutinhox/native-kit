#import <HttpClient.h>
#import <string>
#import <iostream>

int main(int argc, const char *argv[])
{
	NK::HttpClient *client = new NK::HttpClient();
	std::string response = client->get(argv[1]);
	std::cout << response << std::endl;
	return EXIT_SUCCESS;
}