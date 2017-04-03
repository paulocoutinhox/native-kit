#include <jni.h>
#include <string>
#include <vector>

#include <http/HttpClient.h>

std::string jstring2string(JNIEnv *env, jstring jStr)
{
	if (!jStr)
	{
		return "";
	}

	std::vector<char> charsCode;
	const jchar *chars = env->GetStringChars(jStr, NULL);
	jsize len = env->GetStringLength(jStr);
	jsize i;

	for (i = 0; i < len; i++)
	{
		int code = (int) chars[i];
		charsCode.push_back(code);
	}

	env->ReleaseStringChars(jStr, chars);

	return std::string(charsCode.begin(), charsCode.end());
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_prsolucoes_nativekit_HttpClient_get(JNIEnv *env, jobject jobj, jstring url)
{
	NK::HttpClient *httpClient = new NK::HttpClient();
	std::string paramUrl = jstring2string(env, url);
	std::string response = httpClient->get(paramUrl);
	return env->NewStringUTF(response.c_str());
}