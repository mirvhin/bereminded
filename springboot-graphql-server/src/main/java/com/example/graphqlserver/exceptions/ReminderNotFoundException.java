package com.example.graphqlserver.exceptions;

public class ReminderNotFoundException extends RuntimeException {

   public ReminderNotFoundException(String message) {
       super(message);
   }
}