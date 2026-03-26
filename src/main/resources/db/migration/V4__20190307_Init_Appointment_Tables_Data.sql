-- CREATE DATABASE  IF NOT EXISTS onlinebanking
-- USE onlinebanking;
--
-- Table structure for table appointment
--

DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment
(
    id          BIGSERIAL PRIMARY KEY,
    confirmed   BOOLEAN NOT NULL,
    date        TIMESTAMP DEFAULT NULL,
    description varchar(255) DEFAULT NULL,
    location    varchar(255) DEFAULT NULL,
    user_id     BIGINT DEFAULT NULL
);

CREATE INDEX appointment_id_idx ON appointment(user_id);

ALTER TABLE appointment
    ADD CONSTRAINT fk_appointment_user_id
        FOREIGN KEY (user_id) REFERENCES "user" (user_id)
            ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Insert data for table appointment
--

INSERT INTO appointment (id, confirmed, date, description, location, user_id)
VALUES (1, false, '2017-01-25 14:01:00', 'Want to see someone', 'Indonesia', 1),
       (2, false, '2017-01-30 15:01:00', 'Take credit', 'Indonesia', 1),
       (3, false, '2017-02-16 15:02:00', 'Consultation', 'Indonesia', 1);