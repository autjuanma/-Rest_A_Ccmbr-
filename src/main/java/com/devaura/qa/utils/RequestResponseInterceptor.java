package com.devaura.qa.utils;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import io.restassured.filter.Filter;
import io.restassured.filter.FilterContext;
import io.restassured.response.Response;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.FilterableResponseSpecification;

public class RequestResponseInterceptor implements Filter {
    private static final Logger LOG = LogManager.getLogger(RequestResponseInterceptor.class);

    @Override
    public Response filter(FilterableRequestSpecification requestSpec, FilterableResponseSpecification responseSpec, FilterContext ctx) {
        Response response = ctx.next(requestSpec, responseSpec);
        
        StringBuilder logMessage = new StringBuilder();
        logMessage.append("=========================================================================================\n")
                  .append("Request Method   : ").append(requestSpec.getMethod()).append("\n")
                  .append("Request URI      : ").append(requestSpec.getURI()).append("\n")
                  .append("Request Headers   :\n").append(requestSpec.getHeaders()).append("\n");

        Object requestBody = requestSpec.getBody();
        if (requestBody != null) {
            logMessage.append("Request Body     : ").append(requestBody.toString()).append("\n");
        }

        logMessage.append("Response Status   : ").append(response.getStatusLine()).append("\n")
                  .append("Response Headers  :\n").append(response.getHeaders()).append("\n")
                  .append("Response Body     : ").append(response.getBody().prettyPrint()).append("\n")
                  .append("=========================================================================================");

        LOG.info(logMessage.toString());
        
        return response;
    }
}