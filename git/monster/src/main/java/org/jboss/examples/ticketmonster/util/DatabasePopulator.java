package org.jboss.examples.ticketmonster.util;

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
import org.springframework.jdbc.datasource.init.ScriptStatementFailedException;

@Singleton
@Startup
@TransactionManagement(TransactionManagementType.BEAN)
public class DatabasePopulator {
	@PostConstruct
	private void startup() throws NamingException, SQLException { 
		Context jndiContext = new InitialContext();
        DataSource dataSource = (DataSource)jndiContext.lookup("java:jboss/datasources/MySQLDS");

		ResourceDatabasePopulator rdp = new ResourceDatabasePopulator();    
		rdp.addScript(new ClassPathResource("import.sql"));

		Connection connection = dataSource.getConnection();
		try {
			rdp.populate(connection);
		} catch(ScriptStatementFailedException e) {
			/* ignore */
		}
	}
}
