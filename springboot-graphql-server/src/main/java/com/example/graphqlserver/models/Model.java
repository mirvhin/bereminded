package com.example.graphqlserver.models;

import java.time.LocalDateTime;
import java.time.ZoneOffset;

import org.hibernate.annotations.UuidGenerator;

import com.example.graphqlserver.utils.DateUtils;
import jakarta.persistence.*;

@MappedSuperclass
public class Model {
	@Id
	@UuidGenerator
	private String id;

  @Column(nullable = false)
  private LocalDateTime created;

  @Column(nullable = false)
  private LocalDateTime updated;

  public String getId() {
    return id;
  }

  public void setId(String arg) {
    id = arg;
  }

  public Model withId(String arg) {
    setId(arg);
    return this;
  }

  public Long getCreated() {
    return created.toEpochSecond(ZoneOffset.UTC);
  }

  public Model setCreated(LocalDateTime arg) {
    created = arg;
    return this;
  }

  public Long getUpdated() {
    return updated.toEpochSecond(ZoneOffset.UTC);
  }

  public Model setUpdated(LocalDateTime arg) {
    updated = arg;
    return this;
  }

  @PostPersist
  public void afterInsert() {

  }

  @PrePersist
  public void beforeInsert() {
    created = DateUtils.utcNow();
    updated = created;
  }

  @PreUpdate
  public void beforeUpdate() {
    updated = DateUtils.utcNow();
  }

  @PostUpdate
  public void afterUpdate() {

  }

  @PreRemove
  public void beforeDelete() {

  }

//  public void delete() {
//    transaction(() -> getEntityManager().remove(this));
//  }

//  public Model save() {
//    getEntityManager()
//      .unwrap(Session.class)
//      .saveOrUpdate(this);
//    return this;
//  }
}
