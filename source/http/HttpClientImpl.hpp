//
//  HttpClientImpl.hpp
//  NatikeKitTest
//
//  Created by Paulo Coutinho on 23/08/17.
//  Copyright © 2017 PRSoluções. All rights reserved.
//

#ifndef HttpClientImpl_hpp
#define HttpClientImpl_hpp

#include <stdio.h>
#include "http_client.hpp"

namespace NK {
    
    class HttpClientImpl : HttpClient {
        
        static std::shared_ptr<HttpClientImpl> create();
        
        std::string do_get(const std::string &url);
        std::string do_put(const std::string &url, const std::string &data);
        std::string do_head(const std::string &url);
        std::string do_path(const std::string &url);
        std::string do_post(const std::string &url, const std::string &data);
        std::string do_delete(const std::string &url);
        
    };
    
}

#endif /* HttpClientImpl_hpp */
