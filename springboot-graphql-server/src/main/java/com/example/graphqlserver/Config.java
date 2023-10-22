package com.example.graphqlserver;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import java.io.*;
import java.util.*;

@Component
public class Config {
  private final Logger log = LoggerFactory.getLogger(Config.class);

  private final Properties props;

  @Autowired
  public Config() {
    props = new Properties();
    try {
      props.load(new FileReader("conf/config.properties"));
    }
    catch(IOException e) {
      log.error("IOException", e);
    }
  }

  public Config(Properties props) {
    this.props = props;
  }

  public Properties getProperties() {
    return props;
  }

  public String getProperty(String prop) {
    return getProperties().getProperty(prop);
  }
}
