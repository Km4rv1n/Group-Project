package com.marvin.example.jobportal.exceptions;

public class ApplicationExistsException extends RuntimeException {
    public ApplicationExistsException(String message) {
        super(message);
    }
}
