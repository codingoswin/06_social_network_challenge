TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (username, email_address) VALUES ('username1', 'username1@gmail.com');
INSERT INTO user_accounts (username, email_address) VALUES ('username2', 'username2@gmail.com');
INSERT INTO posts (title, content,number_of_views, user_account_id) VALUES ('title1', 'content1', 100, 1);
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('title2', 'content2', 200, 2);
