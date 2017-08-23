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
    
}
