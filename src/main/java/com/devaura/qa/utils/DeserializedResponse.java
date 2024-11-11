package com.devaura.qa.utils;

import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.restassured.response.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DeserializedResponse {

    private static final Logger logger = LoggerFactory.getLogger(DeserializedResponse.class);
    private static final ObjectMapper mapper = new ObjectMapper();

    /**
     * Deserializes the given REST Assured response into an object of the specified class type.
     *
     * @param response the response to deserialize
     * @param clazz    the class of T
     * @param <T>     the type of the desired object
     * @return an instance of T deserialized from the response
     * @throws IOException if there is an error during deserialization
     */
    public static <T> T deserializedResponse(Response response, Class<T> clazz) throws IOException {
        T responseDeserialized = mapper.readValue(response.asString(), clazz);
        String jsonStr = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(responseDeserialized);
        logger.info("Handling Response: \n" + jsonStr);
        return responseDeserialized;
    }
}