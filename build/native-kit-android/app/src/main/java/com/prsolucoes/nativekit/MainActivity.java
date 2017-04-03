package com.prsolucoes.nativekit;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView tv = (TextView) findViewById(R.id.sample_text);

        HttpClient httpClient = new HttpClient();

        Log.i(MainActivity.class.getName(), "Starting request...");
        String content = httpClient.get("https://httpbin.org/get?coração");
        Log.i(MainActivity.class.getName(), "Finished request");
        Log.i(MainActivity.class.getName(), "Content: " + content);
        tv.setText(httpClient.get("https://httpbin.org/get"));
        Log.i(MainActivity.class.getName(), "Text defined");
        Toast.makeText(this, content, Toast.LENGTH_LONG).show();
    }

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("native-kit-android");
    }
}
