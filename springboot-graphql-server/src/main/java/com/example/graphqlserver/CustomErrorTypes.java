package com.example.graphqlserver;

import graphql.ErrorClassification;
import graphql.PublicApi;

/**
 * All the errors in graphql belong to one of these categories
 */
@PublicApi
public enum CustomErrorTypes implements ErrorClassification {
	APIUnauthorizedException
}
