package com.devaura.qa.utils;

import java.util.HashMap;
import java.util.Map;

import com.github.dzieciou.testing.curl.CurlRestAssuredConfigFactory;
import com.github.dzieciou.testing.curl.Options;

import io.restassured.RestAssured;
import io.restassured.config.RestAssuredConfig;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

public class TestContext {

	public Response response;
	public Map<String, Object> session = new HashMap<String, Object>();
	private static final String CONTENT_TYPE = PropertiesFileReader.getProperty("content.type");

	public RequestSpecification requestSetup() {
		RestAssured.reset();
		Options options = Options.builder().logStacktrace().build();
		RestAssuredConfig config = CurlRestAssuredConfigFactory.createConfig(options);
		RestAssured.baseURI = PropertiesFileReader.getProperty("baseURL");
		return RestAssured.given().config(config).filter(new RequestResponseInterceptor()).contentType(CONTENT_TYPE)
				.accept(CONTENT_TYPE);
	}

	// New method to retrieve session data with type safety @JuanTous 
	public <T> T getSessionData(String key, Class<T> clazz) {
		Object data = session.get(key);
		if (clazz.isInstance(data)) {
			return clazz.cast(data);
		} else {
			throw new ClassCastException("Cannot cast to " + clazz.getName());
		}
	}
}