--
-- Table structure for table role
--

DROP TABLE IF EXISTS role;
CREATE TABLE role
(
    role_id SERIAL PRIMARY KEY,
    name    varchar(255) DEFAULT NULL
);

--
-- Insert data for table role
--

INSERT INTO role (role_id, name)
VALUES (0, 'ROLE_USER'),
       (1, 'ROLE_ADMIN');

