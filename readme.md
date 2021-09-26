Repro for xerial sqlite-jdbc native lib loading on Alpine musl with glibc install & glibc linked jre

# Build
* mvn package
* docker build .
* docker run --rm $id
# Repro
* tag `ok` demonstrates success case with sqlite-jdbc 3.23.1
    ```shell
    $ docker run --rm 6cbb
    SQLite JDBC 3.23.1
    ```
* tag `fail` demonstrates failure with sqlite-jdbc 3.36.0 
    ```shell
     docker run --rm 0c0
     Failed to load native library:sqlite-3.36.0-110120d0-32c8-495c-affe-12ee5d24f92e-libsqlitejdbc.so. osinfo: Linux-Alpine/x86_64
  java.lang.UnsatisfiedLinkError: /tmp/sqlite-3.36.0-110120d0-32c8-495c-affe-12ee5d24f92e-libsqlitejdbc.so: libc.musl-x86_64.so.1: cannot open shared object file: No such file or directory
  Exception in thread "main" java.sql.SQLException: Error opening connection
  at org.sqlite.SQLiteConnection.open(SQLiteConnection.java:244)
  at org.sqlite.SQLiteConnection.<init>(SQLiteConnection.java:61)
  at org.sqlite.jdbc3.JDBC3Connection.<init>(JDBC3Connection.java:28)
  at org.sqlite.jdbc4.JDBC4Connection.<init>(JDBC4Connection.java:21)
  at org.sqlite.JDBC.createConnection(JDBC.java:115)
  at org.sqlite.JDBC.connect(JDBC.java:90)
  at java.sql.DriverManager.getConnection(DriverManager.java:664)
  at java.sql.DriverManager.getConnection(DriverManager.java:270)
  at io.github.laurinomme.App.main(App.java:9)
  Caused by: java.lang.Exception: No native library found for os.name=Linux-Alpine, os.arch=x86_64, paths=[/org/sqlite/native/Linux-Alpine/x86_64:/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib]
  at org.sqlite.SQLiteJDBCLoader.loadSQLiteNativeLibrary(SQLiteJDBCLoader.java:389)
  at org.sqlite.SQLiteJDBCLoader.initialize(SQLiteJDBCLoader.java:68)
  at org.sqlite.core.NativeDB.load(NativeDB.java:63)
  at org.sqlite.SQLiteConnection.open(SQLiteConnection.java:240)
  ... 8 more

  ```