package com.tphuong.demo.exception;
import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ErrorResponse {
    private Error error;

    @AllArgsConstructor
    @Data
    public static class Error {
        private int code;
        private String message;
    }
}