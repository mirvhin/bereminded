package com.example.graphqlserver.jpa;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.graphqlserver.models.Reminder;

public interface ReminderRepository extends CrudRepository<Reminder, String> {
}