--
-- Table structure for table primary_transaction
--

DROP TABLE IF EXISTS primary_transaction;
CREATE TABLE primary_transaction
(
    id                 BIGSERIAL PRIMARY KEY,
    amount             double precision NOT NULL,
    available_balance  decimal(19, 2) DEFAULT NULL,
    date               TIMESTAMP       DEFAULT NULL,
    description        varchar(255)   DEFAULT NULL,
    status             varchar(255)   DEFAULT NULL,
    type               varchar(255)   DEFAULT NULL,
    primary_account_id BIGINT DEFAULT NULL
);

CREATE INDEX idx_primary_transaction_account ON primary_transaction(primary_account_id);

ALTER TABLE primary_transaction
    ADD CONSTRAINT fk_primary_transaction_account FOREIGN KEY (primary_account_id) REFERENCES primary_account (id);

--
-- Insert data for table primary_transaction
--

INSERT INTO primary_transaction (id, amount, available_balance, date, description, status, type, primary_account_id)
VALUES (1, 5000, 5000.00, '2017-01-13 00:57:16', 'Deposit to Primary Account', 'Finished', 'Account', 1),
       (2, 1500, 3500.00, '2017-01-13 00:57:31', 'Withdraw from Primary Account', 'Finished', 'Account', 1),
       (3, 1300, 2200.00, '2017-01-13 00:58:03', 'Between account transfer from Primary to Savings', 'Finished',
        'Account', 1),
       (4, 500, 1700.00, '2017-01-13 00:59:08', 'Transfer to recipient Mr. Tomson', 'Finished', 'Transfer', 1),
       (5, 1500, 3200.00, '2017-01-13 01:11:38', 'Deposit to Primary Account', 'Finished', 'Account', 1),
       (6, 400, 2800.00, '2017-01-13 01:11:46', 'Withdraw from Primary Account', 'Finished', 'Account', 1),
       (7, 2300, 2000.00, '2017-01-13 01:13:48', 'Between account transfer from Primary to Savings', 'Finished',
        'Account', 1),
       (8, 300, 1700.00, '2017-01-13 01:14:14', 'Transfer to recipient TaxSystem', 'Finished', 'Transfer', 1);