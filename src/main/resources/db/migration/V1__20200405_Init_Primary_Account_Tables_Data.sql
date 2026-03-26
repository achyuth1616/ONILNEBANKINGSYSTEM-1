-- Create table for primary_account

DROP TABLE IF EXISTS primary_account;
CREATE TABLE primary_account
(
    id              BIGSERIAL PRIMARY KEY,
    account_balance decimal(19, 2) DEFAULT NULL,
    account_number  int NOT NULL
);

-- Insert data for primary_account

INSERT INTO primary_account (id, account_balance, account_number)
VALUES (1, 1700.00, 11223146),
       (2, 0.00, 11223150);