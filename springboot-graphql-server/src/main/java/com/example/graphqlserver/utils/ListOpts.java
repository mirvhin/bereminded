package com.example.graphqlserver.utils;

import org.springframework.util.*;

import java.util.*;

public class ListOpts {
  public static final ListOpts DEFAULT = new Builder().build();
  private static final String STR_MAX = "max";
  private static final String STR_OFFSET = "offset";
  private static final String STR_SORT = "sort";

  private final Optional<Integer> offset;
  private final Optional<Integer> max;
  private final List<Sort> sort;

  public ListOpts(Builder b) {
    offset = b.getOffset();
    max = b.getMax();
    sort = b.getSort();
  }

  public static ListOpts from(Map<String, Object> opts) {
    Builder builder = new Builder();

    if(Objects.isNull(opts))
      return DEFAULT;

    if(opts.containsKey(STR_MAX))
      builder.max((Integer) opts.get(STR_MAX));

    if(opts.containsKey(STR_OFFSET))
      builder.offset((Integer) opts.get(STR_OFFSET));

    if(opts.containsKey(STR_SORT)) {
      String[] sortKeys = StringUtils.split(opts.get(STR_SORT).toString(), ":");

      builder.sort(sortKeys[0], sortKeys[1].equals("asc") ? SortSeq.ASC : SortSeq.DESC);
    }

    return builder.build();
  }

  public Optional<Integer> getOffset() {
    return offset;
  }

  public Optional<Integer> getMax() {
    return max;
  }

  public List<Sort> getSort() {
    return sort;
  }

  public static class Builder {
    private Optional<Integer> offset = Optional.empty();
    private Optional<Integer> max = Optional.empty();
    private List<Sort> sort = new ArrayList<>();

    public Builder offset(Integer arg) {
      offset = Optional.of(arg);
      return this;
    }

    public Optional<Integer> getOffset() {
      return offset;
    }

    public Builder max(Integer arg) {
      max = Optional.of(arg);
      return this;
    }

    public Optional<Integer> getMax() {
      return max;
    }

    public Builder sort(String name, SortSeq seq) {
      sort.add(new Sort(name, seq));
      return this;
    }

    public List<Sort> getSort() {
      return sort;
    }

    public ListOpts build() {
      return new ListOpts(this);
    }
  }
}
