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
import org.springframework.web.bind.annotation.CrossOrigin;

import com.example.graphqlserver.exceptions.InvalidCredentialsException;
import com.example.graphqlserver.jpa.ReminderRepository;
import com.example.graphqlserver.jpa.UserRepository;
import com.example.graphqlserver.models.Reminder;
import com.example.graphqlserver.models.User;
import com.example.graphqlserver.models.input.AddReminderInput;
import com.example.graphqlserver.models.input.LoginUserInput;
import com.example.graphqlserver.models.input.RegisterUserInput;
import com.example.graphqlserver.models.input.UpdateReminderInput;

@Controller
public class UserController {
	@Autowired
	UserRepository userRepository;
	
    @MutationMapping
    public User login(@Argument LoginUserInput loginUserInput) {
    	User result = null;
    	 Optional<User> user = userRepository.findByUsername(loginUserInput.username());
    	 if (user.isPresent()) {
     		result = User.authenticate(user.get(), loginUserInput.username(), loginUserInput.password());
         }
    	 if(result == null) {
    		 throw new InvalidCredentialsException("Invalid Credentials");
    	 }
    	 return result;
    }
    

//    registerUser(registerUserInput: RegisterUserInput!): User!
    // getUser
    @MutationMapping
    public User registerUser(@Argument RegisterUserInput registerUserInput) {
    	User user = new User();
    	user.setName(registerUserInput.name());
    	user.setUsername(registerUserInput.username());
    	user.setPassword(registerUserInput.password());
        return userRepository.save(user);
    }
}