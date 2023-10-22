package com.example.graphqlserver.utils;

public class Sort {
  private final String name;
  private final SortSeq seq;

  public Sort(String name, SortSeq seq) {
    this.name = name;
    this.seq = seq;
  }

  public String getName() {
    return name;
  }

  public SortSeq getSeq() {
    return seq;
  }
}
