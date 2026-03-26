DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    enabled BOOLEAN NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    password VARCHAR(255),
    phone VARCHAR(255),
    username VARCHAR(255),
    primary_account_id BIGINT,
    savings_account_id BIGINT,
    
    CONSTRAINT fk_primary_account
        FOREIGN KEY (primary_account_id) REFERENCES primary_account (id),
        
    CONSTRAINT fk_savings_account
        FOREIGN KEY (savings_account_id) REFERENCES savings_account (id)
);

-- Insert data
INSERT INTO users (
    user_id, email, enabled, first_name, last_name,
    password, phone, username, primary_account_id, savings_account_id
) VALUES
(1, 'uzumaki_naruto@konohagakure.co.jp', true, 'Uzumaki', 'Naruto',
 '$2a$12$DWCryEwHwbTYCegib92tk.VST.GG1i2WAqfaSwyMdxX0cl0eBeSve',
 '5551112345', 'User', 1, 1),

(2, 'uchiha_sasuke@konohagakure.co.jp', true, 'Uchiha', 'Sasuke',
 '$2a$12$hZR7pcSf0JU/OTXR3TOyuu8r6C6n.JZE8Ei47E4LZs1t0Aq1AO6oC',
 '1111111111', 'Admin', 2, 2);
