CREATE TABLE dummy_entity ( id BIGINT AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(100));
CREATE TABLE element (id BIGINT AUTO_INCREMENT PRIMARY KEY, content BIGINT, Dummy_Entity_key BIGINT,dummy_entity BIGINT);