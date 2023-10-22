package com.example.graphqlserver.models;

//import com.example.graphqlserver.jpa.Repository;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "[user]")
public class User extends Model {
  private static final String USERNAME = "root";
  private static final String PASSWORD = "root";

//  private static final Repository<User> repo = new Repository<>(User.class);
  private String username;
  private String name;
  private String password;
  @Transient
  private String accessToken;

  
  public String getUsername() {
    return username;
  }

  public void setUsername(String arg) {
    this.username = arg;
  }

  public User withUsername(String arg) {
    setUsername(arg);
    return this;
  }

  public String getName() {
    return name;
  }

  public void setName(String arg) {
    this.name = arg;
  }

  public User withName(String arg) {
    setName(arg);
    return this;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String arg) {
    this.password = arg;
  }

  public User withPassword(String arg) {
    setPassword(arg);
    return this;
  }

  // TODO: Improve authentication
  public static User authenticate(User user, String username, String password) {
    if(username.equals(user.getUsername()) && password.equals(user.getPassword())) {
      user.accessToken = "accessToken";
      return user;
    }
    return null;
  }
}
