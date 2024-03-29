-- false
SELECT 10 != 10;
  
-- true
SELECT 15 > 14 && 99 - 5 <= 94;
  
-- true
SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10;
  
SELECT title, released_year FROM books WHERE released_year < 1980;
  
SELECT title, author_lname FROM books WHERE author_lname='Eggers' OR author_lname='Chabon';
  
SELECT title, author_lname FROM books WHERE author_lname IN ('Eggers','Chabon');
  
SELECT title, author_lname, released_year FROM books WHERE author_lname = 'Lahiri' && released_year > 2000;
  
SELECT title, pages FROM books WHERE pages >= 100 && pages <=200;
  
SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;
  
SELECT 
    title, 
    author_lname 
FROM books 
WHERE 
    author_lname LIKE 'C%' OR 
    author_lname LIKE 'S%';
  
SELECT 
    title, 
    author_lname 
FROM books 
WHERE 
    SUBSTR(author_lname,1,1) = 'C' OR 
    SUBSTR(author_lname,1,1) = 'S';
  
SELECT title, author_lname FROM books 
WHERE SUBSTR(author_lname,1,1) IN ('C', 'S');
  
SELECT 
    title, 
    author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title = 'Just Kids' OR title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM books;
  
SELECT author_fname, author_lname,
    CASE 
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
    END AS COUNT
FROM books 
GROUP BY author_lname, author_fname;