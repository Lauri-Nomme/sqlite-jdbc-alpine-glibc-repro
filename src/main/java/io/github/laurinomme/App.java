package io.github.laurinomme;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class App {
    public static void main(String[] args) throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:sqlite::memory:");
        System.out.printf("%s %s", connection.getMetaData().getDriverName(), connection.getMetaData().getDriverVersion());
    }
}
