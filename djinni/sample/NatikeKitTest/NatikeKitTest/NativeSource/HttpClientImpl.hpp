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
        
        static std::shared_ptr<HttpClient> create();
        
    };
    
}

#endif /* HttpClientImpl_hpp */
