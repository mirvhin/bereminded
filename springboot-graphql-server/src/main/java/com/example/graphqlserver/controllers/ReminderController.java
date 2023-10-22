package com.example.graphqlserver.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.graphql.data.method.annotation.SchemaMapping;
import org.springframework.stereotype.Controller;

import com.example.graphqlserver.exceptions.ReminderNotFoundException;
import com.example.graphqlserver.jpa.ReminderRepository;
import com.example.graphqlserver.models.Reminder;
import com.example.graphqlserver.models.input.AddReminderInput;
import com.example.graphqlserver.models.input.UpdateReminderInput;

@Controller
public class ReminderController {
	@Autowired
	ReminderRepository reminderRepository;
	
    @MutationMapping
    public Reminder addReminder(@Argument AddReminderInput addReminderInput) {
    	Reminder reminder = new Reminder();
    	reminder.setTitle(addReminderInput.title());
    	reminder.setDescription(addReminderInput.description());
    	reminder.setDone(false);
        return reminderRepository.save(reminder);
    }
    
    @MutationMapping
    public Reminder updateReminder(@Argument UpdateReminderInput updateReminderInput) {
    	Optional<Reminder> reminder = reminderRepository.findById(updateReminderInput.id());
    	if (reminder.isPresent()) {
    		Reminder update = reminder.get();
    		update.setTitle(updateReminderInput.title());
    		update.setDescription(updateReminderInput.description());
    		update.setDone(updateReminderInput.isDone());
    		reminderRepository.save(update);
    		return update;
        }
    	// handle error for updating invalid id
    	throw new ReminderNotFoundException("Reminder not found");
    }
    
    @QueryMapping
    public Reminder getReminder(@Argument String id) {
    	Reminder result = null;
    	Optional<Reminder> reminder = reminderRepository.findById(id);
    	if (reminder.isPresent()) {
    		Reminder update = reminder.get();
    		result = update;
        }
        return result;
    }
    
    @QueryMapping
    public List<Reminder> getAllReminders(@Argument String id) {
    	List<Reminder> result = new ArrayList<Reminder>();
    	reminderRepository.findAll().forEach(result::add);;
        return result;
    }
}