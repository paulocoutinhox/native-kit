#ifndef HttpClient_H
#define HttpClient_H

#include <string>
#include <sstream>

namespace NK 
{

	class HttpClient 
	{
		
		public:
			std::string get(std::string url);
		
		private:
			static size_t writeDataCallback(void *contents, size_t size, size_t nmemb, void *userdata);

	};

}

#endif