package com.prsolucoes.nativekit.ui;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.prsolucoes.nativekit.HttpClient;
import com.prsolucoes.nativekit.R;

public class MainActivity extends AppCompatActivity {

    private TextView tvContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        tvContent = (TextView) findViewById(R.id.tvContent);
    }

    static {
        System.loadLibrary("native-kit-android");
    }

    public void showMessage() {
        Toast.makeText(this, "A new message", Toast.LENGTH_SHORT).show();
    }

    public native void warmUp();

    public native void process();

    public void doGetRequestNative(View view) {
        process();
        /*
        new AsyncTask<String, String, String>() {

            @Override
            protected String doInBackground(String... params) {
                HttpClient httpClient = new HttpClient();
                httpClient.setSSLVerifyHost(false);
                httpClient.setSSLVerifyPeer(false);
                return httpClient.doGet("https://httpbin.org/get");
            }

            @Override
            protected void onPostExecute(String result) {
                super.onPostExecute(result);
                tvContent.setText(result);
            }

        }.execute();
        */
    }

    public void doGetRequestAndroid(View view) {
        //process();
        showMessage();
        /*
        new AsyncTask<String, String, String>() {

            @Override
            protected String doInBackground(String... params) {
                HttpClient httpClient = new HttpClient();
                httpClient.setSSLVerifyHost(false);
                httpClient.setSSLVerifyPeer(false);
                return httpClient.doGet("https://httpbin.org/get");
            }

            @Override
            protected void onPostExecute(String result) {
                super.onPostExecute(result);
                tvContent.setText(result);
            }

        }.execute();
        */
    }

}
