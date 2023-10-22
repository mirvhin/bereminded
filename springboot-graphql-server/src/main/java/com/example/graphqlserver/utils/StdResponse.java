package com.example.graphqlserver.utils;

public class StdResponse {
  private int status;

  private String message;

  private String code;

  public StdResponse(int status, String message, String code) {
    this.status = status;
    this.message = message;
    this.code = code;
  }
}
