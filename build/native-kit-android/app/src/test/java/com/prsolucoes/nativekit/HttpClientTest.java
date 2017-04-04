package com.prsolucoes.nativekit;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class HttpClientTest {

    static {
        System.loadLibrary("native-kit-android");
    }

    @Test
    public void get() throws Exception {
        /*
        HttpClient httpClient = new HttpClient();
        String content = httpClient.get("https://httpbin.org/get?coracao");
        String desired = "";
        assertEquals(desired, content);
        */
    }

}