package com.example.graphqlserver;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.graphql.execution.DataFetcherExceptionResolverAdapter;
import org.springframework.stereotype.*;

import com.example.graphqlserver.exceptions.InvalidCredentialsException;
import com.example.graphqlserver.exceptions.ReminderNotFoundException;

import graphql.ErrorType;
import graphql.GraphQLError;
import graphql.GraphqlErrorBuilder;
import graphql.schema.DataFetchingEnvironment;

import java.io.*;
import java.util.*;

@Component
public class CustomExceptionResolver extends DataFetcherExceptionResolverAdapter {
    @Override
    protected GraphQLError resolveToSingleError(Throwable ex, DataFetchingEnvironment env) {
    	if (ex instanceof InvalidCredentialsException) {
            return GraphqlErrorBuilder.newError()
              .errorType(CustomErrorTypes.APIUnauthorizedException)
              .message(ex.getMessage())
              .path(env.getExecutionStepInfo().getPath())
              .location(env.getField().getSourceLocation())
              .build();
        } if (ex instanceof ReminderNotFoundException) {
        	return GraphqlErrorBuilder.newError()
				.errorType(ErrorType.DataFetchingException)
				.message(ex.getMessage())
				.path(env.getExecutionStepInfo().getPath())
				.location(env.getField().getSourceLocation())
				.build();
        } 

    	else {
            return null;
        }
    }
}