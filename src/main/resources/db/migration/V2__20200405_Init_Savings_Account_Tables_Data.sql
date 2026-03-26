--
-- Table structure for table savings_account
--

DROP TABLE IF EXISTS savings_account;
CREATE TABLE savings_account
(
    id              BIGSERIAL PRIMARY KEY,
    account_balance decimal(19, 2) DEFAULT NULL,
    account_number  int NOT NULL
);

--
-- Insert data for table savings_account
--

INSERT INTO savings_account (id, account_balance, account_number)
VALUES (1, 4250.00, 11223147),
       (2, 0.00, 11223151);

