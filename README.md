# What is a Database?

A database is (1) a collection of data and (2) contains a method for accessing and manipulating that data. In other words, it's a structured set of computerized data with an accessible interface.

A Database Management System is the programme that lets you interface with the data in your database, for example PostgreSQL, MySQL, Oracle Database, SQLite.

# MySQL vs SQL

SQL (Structrured Query Language) is the language you use to talk to your database.

Working with MySQL is primarily writing SQL.

SQL is the [standard language](https://www.iso.org/standard/63555.html) that multiple database management systems implement.

```SQL
SELECT * FROM Users WHERE Age >= 18;
```

What makes database management systems unique are the features they offer, not the language.

# Creating Databases

```SQL
CREATE DATABASE database_name;
```

# Dropping Databases

```SQL
DROP DATABASE database_name;
```

# Using Databases

In MySQl the `USE` command specifies which database you want to work with.

```SQL
USE database_name;
```

`SELECT database();` shows you the currently used database.

# Tables

Tables are the heart of SQL. A relational database is just a bunch of tables.

Tables are a collection of related data held in a structured format within a database.

Within tables, columns act as headers, rows contain the actual data.

## Data Types

When you create a new table you need to specify what data types its columns will contain. You cannot have inconsistent data types, for example strings and numbers mixed.

There are many data types in SQL. You'll use a subset based on your needs, which will change over time.

`INT` represents a whole number (up to a max value of 2147483647). `INT`s can be negative or 0.

`VARCHAR` represents a variable-length string between 1 and 255 characters.

# Creating Tables

```SQL
CREATE TABLE table_name
(
  column_name data_type,
  column_name data_type
);
```

```SQL
SHOW TABLES;
```

```SQL
SHOW COLUMNS FROM table_name;
```

or (though they are technically different)

```SQL
DESC table_name;
```

# Deleting Tables

```SQL
DROP TABLE table_name;
```

# Adding Data to Tables

```SQL
INSERT INTO table_name (col_1, col_2)
VALUES  (val_1, val_2),
        (val_3, val_4),
        (val_5, val_6);
```

### MySQL Warnings

If you try to insert data that defies the data type or limits for a column, you'll get a warning. To see them use

```SQL
SHOW WARNINGS;
```

## NULL and NOT_NULL

`NULL` indicates an unknown value. It does not mean zero.

You can require values by specifying that a field is `NOT NULL`.

## Setting Deafult Values

```SQL
CREATE TABLE table_name (
  name VARCHAR(50) DEFAULT 'No name provided',
  age INT DEFAULT 21
);
```

You can combine `NOT NULL` and `DEFAULT` to prevent `NULL` being deliberately inserted.

# Primary Keys

Each record needs to be uniquely identifiable. The easiest way to do this is to assign an ID.

A Primary Key is a unique identifier on a row.

```SQL
CREATE TABLE unique_cats (
  cat_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  age INT,
  PRIMARY KEY (cat_id)
  );
```

# CRUD Commands

- CREATE - `INSERT INTO ...`

- READ - `SELECT ... FROM ...`

- UPDATE - `UPDATE ... SET ... WHERE ...`

- DELETE - `DELETE FROM ... WHERE ...`

## WHERE Clause

```SQL
SELECT * FROM cats WHERE age = 4;
```

By default the `WHERE` clause is case insensitive.

## Aliases

Aliases can make your results easier to read.

```SQL
SELECT name AS cat_name FROM cats;
```

## Updating

When updating, use `SELECT` first to make sure you're targeting the right data.

## Deleting

`DELETE FROM table_name` will delete all the contents of the table, unlike `DROP TABLE table_name` which will delete the table itself.
