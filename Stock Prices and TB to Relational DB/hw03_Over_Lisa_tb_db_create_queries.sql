-- Create and use database for tb count data
CREATE DATABASE tb_db;

USE tb_db;

-- Create tables tb_count, country_info, sex_info, age_group_info

CREATE TABLE `country_info` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `country` text,
  `country_name` text,
  PRIMARY KEY (`country_id`)
);

CREATE TABLE `sex_info` (
  `sex_id` int NOT NULL,
  `sex_who` text,
  `sex` text,
  `sex_name` text,
  PRIMARY KEY (`sex_id`)
);

CREATE TABLE `age_group_info` (
  `age_group_id` int NOT NULL AUTO_INCREMENT,
  `age_group` text,
  PRIMARY KEY (`age_group_id`)
);

CREATE TABLE `tb_counts` (
  `year` int NOT NULL,
  `country_id` int NOT NULL,
  `sex_id` int NOT NULL,
  `age_group_id` int NOT NULL,
  `count` double DEFAULT NULL,
  PRIMARY KEY (`year`,`country_id`,`sex_id`,`age_group_id`),
  FOREIGN KEY (country_id) REFERENCES country_info(country_id),
  FOREIGN KEY (sex_id) REFERENCES sex_info(sex_id),
  FOREIGN KEY (age_group_id) REFERENCES age_group_info(age_group_id)
);

-- Query all columns for all age groups and genders in the country AO
SELECT tb.year, c.country, s.sex, a.age_group, tb.count
FROM tb_counts tb
LEFT JOIN country_info c
ON tb.country_id = c.country_id
LEFT JOIN sex_info s
ON tb.sex_id = s.sex_id
LEFT JOIN age_group_info a
ON tb.age_group_id = a.age_group_id
WHERE c.country = 'AO';

-- Query all columns for all age groups and genders for country AO or AR
SELECT tb.year, c.country, s.sex, a.age_group, tb.count
FROM tb_counts tb
LEFT JOIN country_info c
ON tb.country_id = c.country_id
LEFT JOIN sex_info s
ON tb.sex_id = s.sex_id
LEFT JOIN age_group_info a
ON tb.age_group_id = a.age_group_id
WHERE c.country IN ('AO', 'AR');

-- Query all columns for females in all age groups for country AF
SELECT tb.year, c.country, s.sex, a.age_group, tb.count
FROM tb_counts tb
LEFT JOIN country_info c
ON tb.country_id = c.country_id
LEFT JOIN sex_info s
ON tb.sex_id = s.sex_id
LEFT JOIN age_group_info a
ON tb.age_group_id = a.age_group_id
WHERE c.country = 'AF' AND s.sex = 'f';

-- Return all columns and rows consistent with the long-format tidy dataset
SELECT tb.year
, CASE WHEN c.country = 'UX' 
  THEN NULL 
  ELSE c.country 
  END AS country
, s.sex
, CASE WHEN a.age_group = 'Unknown' 
  THEN NULL 
  ELSE a.age_group 
  END AS age_group
, tb.count
FROM tb_counts tb
LEFT JOIN country_info c
ON tb.country_id = c.country_id
LEFT JOIN sex_info s
ON tb.sex_id = s.sex_id
LEFT JOIN age_group_info a
ON tb.age_group_id = a.age_group_id;

