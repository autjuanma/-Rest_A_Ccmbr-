package com.devaura.qa.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class PropertiesFileReader {

    private static final Logger LOG = LogManager.getLogger(PropertiesFileReader.class);
    private static final String PROPERTIES_FILE_PATH = "config.properties";
    private static Properties properties;

    static {
        loadProperties();
    }

    private static void loadProperties() {
        properties = new Properties();
        try (InputStream input = new FileInputStream(PROPERTIES_FILE_PATH)) {
            properties.load(input);
        } catch (IOException e) {
            LOG.error("Error loading properties file: " + PROPERTIES_FILE_PATH, e);
        }
    }

    /**
     * Retrieves the value of the specified property.
     *
     * @param property the name of the property to retrieve
     * @return the property value, or null if not found
     */
    public static String getProperty(String property) {
        if (properties == null) {
            LOG.warn("Properties have not been loaded. Returning null for property: " + property);
            return null;
        }
        return properties.getProperty(property) != null ? properties.getProperty(property).trim() : null;
    }
}