-- Add daily limits columns to user table
ALTER TABLE "user" ADD COLUMN IF NOT EXISTS daily_transfer_limit DOUBLE PRECISION DEFAULT 10000.0;
ALTER TABLE "user" ADD COLUMN IF NOT EXISTS daily_withdraw_limit DOUBLE PRECISION DEFAULT 5000.0;

-- Create activity_log table
CREATE TABLE IF NOT EXISTS activity_log (
    id BIGSERIAL PRIMARY KEY,
    user_user_id BIGINT,
    activity_type VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    ip_address VARCHAR(50),
    timestamp TIMESTAMP NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (user_user_id) REFERENCES "user"(user_id)
);

-- Create password_reset_token table
CREATE TABLE IF NOT EXISTS password_reset_token (
    id BIGSERIAL PRIMARY KEY,
    token VARCHAR(255) NOT NULL UNIQUE,
    user_id BIGINT NOT NULL,
    expiry_date TIMESTAMP NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_activity_log_user ON activity_log(user_user_id);
CREATE INDEX IF NOT EXISTS idx_activity_log_timestamp ON activity_log(timestamp);
CREATE INDEX IF NOT EXISTS idx_password_reset_token_token ON password_reset_token(token);
CREATE INDEX IF NOT EXISTS idx_primary_transaction_date ON primary_transaction(date);
CREATE INDEX IF NOT EXISTS idx_savings_transaction_date ON savings_transaction(date);
