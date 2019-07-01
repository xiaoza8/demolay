package com.hxkc.config;

import javax.annotation.PostConstruct;

import com.hxkc.config.shiro.freemarker.ShiroTags;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FreeMarkerConfig {

    @Autowired
    private freemarker.template.Configuration configuration;

    @PostConstruct
    public void setSharedVariable() {
    	try {
			configuration.setSharedVariable("shiro", new ShiroTags());
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
