--
-- Table structure for table savings_transaction
--

DROP TABLE IF EXISTS savings_transaction;
CREATE TABLE savings_transaction
(
    id                 BIGSERIAL PRIMARY KEY,
    amount             double precision NOT NULL,
    available_balance  decimal(19, 2) DEFAULT NULL,
    date               TIMESTAMP       DEFAULT NULL,
    description        varchar(255)   DEFAULT NULL,
    status             varchar(255)   DEFAULT NULL,
    type               varchar(255)   DEFAULT NULL,
    savings_account_id BIGINT DEFAULT NULL
);

CREATE INDEX idx_savings_transaction_account ON savings_transaction(savings_account_id);

ALTER TABLE savings_transaction
    ADD CONSTRAINT fk_savings_transaction_account FOREIGN KEY (savings_account_id) REFERENCES savings_account (id);

--
-- Insert data for table savings_transaction
--

INSERT INTO savings_transaction (id, amount, available_balance, date, description, status, type, savings_account_id)
VALUES (1, 1000, 1000.00, '2017-01-13 00:57:40', 'Deposit to savings Account', 'Finished', 'Account', 1),
       (2, 150, 2150.00, '2017-01-13 01:11:15', 'Withdraw from savings Account', 'Finished', 'Account', 1),
       (3, 400, 1750.00, '2017-01-13 01:11:23', 'Withdraw from savings Account', 'Finished', 'Account', 1),
       (4, 2000, 3750.00, '2017-01-13 01:11:30', 'Deposit to savings Account', 'Finished', 'Account', 1),
       (5, 1500, 2250.00, '2017-01-13 01:13:38', 'Between account transfer from Savings to Primary', 'Finished',
        'Transfer', 1),
       (6, 300, 4250.00, '2017-01-13 01:14:02', 'Transfer to recipient LtdFitness', 'Finished', 'Transfer', 1);

