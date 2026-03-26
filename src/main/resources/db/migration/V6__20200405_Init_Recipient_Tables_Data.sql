--
-- Table structure for table recipient
--

DROP TABLE IF EXISTS recipient;
CREATE TABLE recipient
(
    id             BIGSERIAL PRIMARY KEY,
    account_number varchar(255) DEFAULT NULL,
    description    varchar(255) DEFAULT NULL,
    email          varchar(255) DEFAULT NULL,
    name           varchar(255) DEFAULT NULL,
    phone          varchar(255) DEFAULT NULL,
    user_id        BIGINT DEFAULT NULL
);

CREATE INDEX idx_recipient_user ON recipient(user_id);

ALTER TABLE recipient
    ADD CONSTRAINT fk_recipient_user FOREIGN KEY (user_id) REFERENCES "user" (user_id);

--
-- Insert data for table recipient
--

INSERT INTO recipient (id, account_number, description, email, name, phone, user_id)
VALUES (1, '213425635454', 'Rent payment', 'tomson@gmail.com', 'Mr. Tomson', '1112223333', 1),
       (2, '453452341324', 'Gym payment', 'fitness@gmail.com', 'LtdFitness', '323245345', 1),
       (3, '5465464234542', 'Tax payment 20%', 'taxes@mail.fi', 'TaxSystem', '34254353', 1);

