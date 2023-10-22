package com.example.graphqlserver.models.input;

public record UpdateReminderInput(String id, String title, String description, boolean isDone) {}