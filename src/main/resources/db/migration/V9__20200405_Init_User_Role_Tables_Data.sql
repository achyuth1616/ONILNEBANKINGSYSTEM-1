--
-- Table structure for table user_role
--

DROP TABLE IF EXISTS user_role;
CREATE TABLE user_role
(
    user_role_id BIGSERIAL PRIMARY KEY,
    role_id      INT DEFAULT NULL,
    user_id      BIGINT DEFAULT NULL
);

CREATE INDEX idx_user_role_role ON user_role(role_id);
CREATE INDEX idx_user_role_user ON user_role(user_id);

ALTER TABLE user_role
    ADD CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    ADD CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES role (role_id);

--
-- Insert data for table user_role
--

INSERT INTO user_role (user_role_id, role_id, user_id)
VALUES (1, 0, 1),
       (2, 1, 2);