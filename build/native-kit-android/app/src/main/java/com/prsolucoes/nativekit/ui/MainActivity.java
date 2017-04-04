package com.prsolucoes.nativekit.ui;

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

    public void doGetRequest(View view) {
        HttpClient httpClient = new HttpClient();
        String content = httpClient.get("https://httpbin.org/get?coracao");
        tvContent.setText(content);
        Toast.makeText(this, content, Toast.LENGTH_LONG).show();
    }
}
