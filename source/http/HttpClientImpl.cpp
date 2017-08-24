//
//  HttpClientImpl.cpp
//  NatikeKitTest
//
//  Created by Paulo Coutinho on 23/08/17.
//  Copyright © 2017 PRSoluções. All rights reserved.
//

#include "HttpClientImpl.hpp"

namespace NK {
    
    std::shared_ptr<HttpClient> HttpClientImpl::create() {
        return std::make_shared<HttpClient>();
    }
    
    std::string HttpClientImpl::do_get(const std::string &url) {
        return "OK MAN!";
    }
    
    std::string HttpClientImpl::do_put(const std::string &url, const std::string &data) {
        return "OK MAN!";
    }
    
    std::string HttpClientImpl::do_head(const std::string &url) {
        return "OK MAN!";
    }
    
    std::string HttpClientImpl::do_path(const std::string &url) {
        return "OK MAN!";
    }
    
    std::string HttpClientImpl::do_post(const std::string &url, const std::string &data) {
        return "OK MAN!";
    }
    
    std::string HttpClientImpl::do_delete(const std::string &url) {
        return "OK MAN!";
    }
    
}
