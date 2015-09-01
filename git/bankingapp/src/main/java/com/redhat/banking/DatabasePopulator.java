package com.redhat.banking;

import java.sql.Connection;
import java.sql.SQLException;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;

@Singleton
@Startup
@TransactionManagement(TransactionManagementType.BEAN)
public class DatabasePopulator {
	@PostConstruct
	private void startup() throws NamingException, SQLException { 
		Context jndiContext = new InitialContext();
        DataSource dataSource = (DataSource)jndiContext.lookup("java:jboss/datasources/MySqlDS");

		ResourceDatabasePopulator rdp = new ResourceDatabasePopulator();    
		rdp.addScript(new ClassPathResource("import.sql"));

		Connection connection = dataSource.getConnection();
		rdp.populate(connection);
	}
}
