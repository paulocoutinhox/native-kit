package com.prsolucoes.nativekit;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Example of a call to a native method
        HttpClient httpClient = new HttpClient();

        TextView tv = (TextView) findViewById(R.id.sample_text);
        tv.setText(httpClient.get("http://ww.prsolucoes.com"));
    }

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("native-kit-android");
    }
}
