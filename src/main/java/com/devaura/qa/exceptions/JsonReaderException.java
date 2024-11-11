package com.devaura.qa.exceptions;

public class JsonReaderException extends Exception {
    public JsonReaderException(String message) {
        super(message);
    }

    public JsonReaderException(String message, Throwable cause) {
        super(message, cause);
    }
}