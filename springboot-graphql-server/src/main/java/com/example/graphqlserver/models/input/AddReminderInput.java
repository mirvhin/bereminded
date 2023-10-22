package com.example.graphqlserver.models.input;

public record AddReminderInput(String title, String description, boolean isDone) {}