package com.example.graphqlserver.jpa;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.example.graphqlserver.models.User;


public interface UserRepository extends CrudRepository<User, String> {
	Optional<User> findByUsername(String username);
}