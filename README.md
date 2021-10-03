# MySQL Notes

Notes from Colt Steele's MySQL Bootcamp.

## What is a Database?

A database is (1) a collection of data and (2) contains a method for accessing and manipulating that data. In other words, it's a structured set of computerized data with an accessible interface.

A Database Management System is the programme that lets you interface with the data in your database, for example PostgreSQL, MySQL, Oracle Database, SQLite.

## MySQL vs SQL

SQL (Structrured Query Language) is the language you use to talk to your database.

Working with MySQL is primarily writing SQL.

SQL is the [standard language](https://www.iso.org/standard/63555.html) that multiple database management systems implement.

```SQL
SELECT * FROM Users WHERE Age >= 18;
```

What makes database management systems unique are the features they offer, not the language.

## Creating Databases

```SQL
CREATE DATABASE database_name;
```

## Dropping Databases

```SQL
DROP DATABASE database_name;
```

## Using Databases

In MySQl the `USE` command specifies which database you want to work with.

```SQL
USE database_name;
```

`SELECT database();` shows you the currently used database.

## Tables

Tables are the heart of SQL. A relational database is just a bunch of tables.

Tables are a collection of related data held in a structured format within a database.

Within tables, columns act as headers, rows contain the actual data.

## Data Types

When you create a new table you need to specify what data types its columns will contain. You cannot have inconsistent data types, for example strings and numbers mixed.

There are many data types in SQL. You'll use a subset based on your needs, which will change over time.

`INT` represents a whole number (up to a max value of 2147483647). `INT`s can be negative or 0.

`VARCHAR` represents a variable-length string between 1 and 255 characters.

## Creating Tables

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

## Deleting Tables

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

If you try to insert data that defies the data type or limits for a column, you'll get a warning. To see a list of them, use:

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

## Primary Keys

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

## CRUD Commands

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

## String Functions

String functions allow you to alter how you print out your data. They do not change the data in the database.

### Executing SQL files

`source path_to_file/file_name.sql`

### CONCAT

`CONCAT` lets you combine data for cleaner output.

```sql
CONCAT (column, 'text', anotherColumn, 'more text')

SELECT CONCAT (author_fname, ' ', author_lname) AS full_name FROM books;
```

`CONCAT_WS` stands for Concat with Seperator, which is useful when you are concatenating multiple fields together with the same symbol.

```sql
SELECT CONCAT_WS(' - ', title, author_fname, author_lname) FROM books;
```

### SUBSTRING

`SUBSTRING` (or `SUBSTR`) lets you select individual parts of a string.

You can set a start and end index. If you don't provide an end index, it will include the remainder of the string. If you provide a negative index, it will count back from the end of the string.

**MySQL indexes from 1, not 0.**

```sql
SELECT SUBSTRING ('Hello World', 1, 4);
-- Hell

SELECT SUBSTRING ('Hello World', 7;
-- World

SELECT SUBSTRING('Hello World', -3);
-- rld

SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
```

### REPLACE

`REPLACE` replaces parts of a string. It is case sensitive.

```sql
SELECT REPLACE('Hello World', 'Hell', '%$#@');
-- %$#@o World

SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');
-- cheese and bread and coffee and milk
```

### REVERSE

`REVERSE` lets you reverse a string.

```sql
SELECT REVERSE('Hello World');
-- dlroW olleH
```

### CHAR_LENGTH

`CHAR_LENGTH` counts the characters in a given string.

```sql
SELECT CHAR_LENGTH('Hello World');
-- 11

SELECT
  CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long')
FROM books;
```

### UPPER and LOWER

`UPPER` and `LOWER` will change a string's case.

```sql
SELECT UPPER('Hello World');
-- HELLO WORLD

SELECT LOWER('Hello World');
-- hello world
```

You can combine string functions. The inner function will be evaluated first.

```sql
SELECT
  CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title'
FROM books;
```

But keep in mind how many arguments a string function expects. For example, `CONCAT` expects two arguments.

```sql
✅ SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS "full name in caps" FROM books; -- This works

❌ SELECT CONCAT(UPPER(author_fname, ' ', author_lname)) AS "full name in caps" FROM books; -- This doesn't work
```

## Refining Selections

### DISTINCT

`DISTINCT` is used in conjunction with `SELECT` to exclude duplicate results.

```sql
SELECT DISTINCT author_lname FROM books;
```

You can apply `DISTINCT` to a combination of values.

```sql
SELECT DISTINCT author_fname, author_lname FROM books;
```

## ORDER BY

`ORDER BY` lets you sort your results.

```sql
SELECT author_lname FROM books ORDER BY author_lname;
```

By default, it is in ascending alphanumeric order. You can specify if you want ascending or descending order with `ASC` or `DESC`.

```sql
SELECT author_lname FROM books ORDER BY author_lname DESC;
```

If you are selecting multiple fields you can specify which field to sort by with its number.

```sql
-- order by author_fname
SELECT title, author_fname, author_lname FROM books ORDER BY 2;
```

You can order by two different columns, though you won't very often. It will use the second column if there are any conflicts.

```sql
SELECT author_fname, author_lname FROM books ORDER BY author_lname, author_fname;
```

## LIMIT

`LIMIT` lets you specify a number for how many results you want to select. It's often used in conjunction with `ORDER BY`.

You can use a comma-seperated list to specify a starting point and limit (which could be useful for pagination). If you want to select all rows from a certain point to the end of the table you'll have to do this.

```sql
SELECT title, released_year FROM books ORDER BY released_year LIMIT 5;

-- skip 10 rows, return 15 rows
SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 10, 15;
```

## LIKE

`LIKE` allows for fuzzier searching than `WHERE`.

It's case-insensitive, `%` serves as a wildcard for any characters, and `_` serves as a wildcard to specify exactly one character.

If you're searching for a field with '%' or '\_' in it, you escape it with a \, `%\%%`.

```sql
-- returns where title is: anything da anything
SELECT * from books WHERE author_fname LIKE '%da%';

-- returns where stock quantity is 4 characters lon
SELECT * from books WHERE stock_quantity LIKE '____';
```

## Aggregate Functions

Aggregate functions let you combine data to get meaning out of it, for example finding totals and averages.

## COUNT

`COUNT` will count whatever you tell it to count.

```sql
-- returns total number of rows
SELECT COUNT(*) FROM books;

-- returns number of distinct first names
SELECT COUNT(DISTINCT author_fname) FROM books;

-- returns total number of unique authors
SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;
```
