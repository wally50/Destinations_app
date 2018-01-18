
CREATE DATABASE destinations

CREATE TABLE places (
  id SERIAL PRIMARY KEY,
  name VARCHAR (255) NOT NULL,
  image_url VARCHAR (400) NOT NULL,
  locale VARCHAR (255) NOT NULL,
  description VARCHAR (1000)
);

CREATE TABLE activities (
  id SERIAL PRIMARY KEY,
  things_to_do VARCHAR (255) NOT NULL,
  place_id INTEGER NOT NULL,
  FOREIGN KEY (place_id) REFERENCES places (id) ON DELETE RESTRICT
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body VARCHAR (500) NOT NULL,
  place_id INTEGER NOT NULL,
  FOREIGN KEY (place_id) REFERENCES places (id) ON DELETE RESTRICT
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(300) NOT NULL,
  password_digest VARCHAR(400)
);

INSERT INTO places (name, image_url, locale, description) VALUES ('bimbi park', 'https://68.media.tumblr.com/tumblr_lsey1ma2aj1r1uyj6o1_1280.jpg', 'cape otway', "Camping to 4 star cabins and all in between." );



#
