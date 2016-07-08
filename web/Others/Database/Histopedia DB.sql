CREATE DATABASE Histopedia CHARACTER SET utf8 COLLATE utf8_general_ci;
USE Histopedia;

CREATE TABLE user
(
    user_id int NOT NULL AUTO_INCREMENT,
    email varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    country varchar(255),
    city varchar(255),
    user_desc varchar(255),
    gender varchar(255),
    photo LONGBLOB,
    activate INT NOT NULL DEFAULT 0,
    rkey varchar(25),
    PRIMARY KEY (user_id)
);

CREATE TABLE project
(
    project_id int NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    project_desc varchar(255),
    is_published INT DEFAULT  0,
    user_id INT,
    creation_date TIMESTAMP,
    views INT DEFAULT  0,
    likes INT DEFAULT  0,
    photo LONGBLOB,
    PRIMARY KEY (project_id),
    FOREIGN KEY (user_Id) REFERENCES user(user_Id) ON DELETE CASCADE 
);

CREATE TABLE search
(
    project_id int NOT NULL,
    tag_name varchar(255) NOT NULL,
    PRIMARY KEY (project_id, tag_name),
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE event
(
    event_id int NOT NULL AUTO_INCREMENT,
    is_published int DEFAULT  0,
    project_id int,
    year int NOT NULL,
    month int NOT NULL,
    day int NOT NULL,
    details TEXT,
    map_zoom_level int NOT NULL,
    lat double NOT NULL, 
    lng double NOT NULL,
    PRIMARY KEY (event_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE marker
(
    marker_id int NOT NULL AUTO_INCREMENT,
    event_id int,
    lat double NOT NULL, 
    lng double NOT NULL,
    title varchar(255),
    icon varchar(255),
    PRIMARY KEY (marker_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE
);

CREATE TABLE infowindow
(
    infowindow_id int NOT NULL AUTO_INCREMENT,
    event_id int,
    marker_id int,
    lat double NOT NULL, 
    lng double NOT NULL,
    title varchar(255),
    content varchar(255),
    PRIMARY KEY (infowindow_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE,
    FOREIGN KEY (marker_id) REFERENCES marker(marker_id) ON DELETE CASCADE
);

      
CREATE TABLE circle
(
    circle_id int NOT NULL AUTO_INCREMENT,
    event_id int,
    lat double NOT NULL, 
    lng double NOT NULL,
    radius double NOT NULL,
    strokeColor varchar(255),
    strokeOpacity double,
    strokeWeight double,
    fillColor varchar(255),
    fillOpacity double,
    PRIMARY KEY (circle_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE
);


CREATE TABLE polygon
(
    polygon_id int NOT NULL AUTO_INCREMENT,
    event_id int,
    polygon_type varchar(255) NOT NULL DEFAULT 'polygon',
    strokeColor varchar(255),
    strokeOpacity double,
    strokeWeight double,
    fillColor varchar(255),
    fillOpacity double,
    coordinates TEXT NOT NULL,
    PRIMARY KEY (polygon_id),
   FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE
);

/*
please do note forget default images table it is called testtb and have to columns (id, img)
then create 2 rows in that table
row 1 inser id = 1 and put default image for user
row 1 inser id = 2 and put default image for project
*/
 
CREATE TABLE testtb
(
    id int NOT NULL primary key,
    img LONGBLOB
);
