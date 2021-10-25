-- DROP DATABASE instagram_db;
CREATE DATABASE instagram_db;
USE instagram_db;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  image_url VARCHAR(255) NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  comment_text VARCHAR(255) NOT NULL,
  photo_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO users (username) VALUES
('BlueTheCat'),
('CharlieBrown'),
('ColtSteele');

INSERT INTO photos (image_url, user_id) VALUES
('/asdfqwer', 1),
('/hjgfjhuy', 2),
('/uerfdoiy', 2);

INSERT INTO comments (comment_text, user_id, photo_id) VALUES
('Meow', 1, 2),
('Amazing shot!', 3, 2),
('I <3 this', 2, 1);