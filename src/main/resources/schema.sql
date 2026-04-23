CREATE TABLE Users (
                       user_id INT SERIAL PRIMARY KEY,
                       password    VARCHAR(32),
                       email   VARCHAR(32) UNIQUE,
                       name    VARCHAR(16),
                       profile_picture BYTEA,
                       bio VARCHAR(128)
);
-- Add settings and following list attributes?

CREATE TABLE Post (
                      post_id INT SERIAL UNIQUE,
                      user_id INT REFERENCES Users(user_id),
                      parent_post_id INT NULL, -- NULL = parent post, else reply
                      numOfReplies    INT DEFAULT 0,
                      numOfLikes  INT DEFAULT 0,
                      numOfShares INT DEFAULT 0,
                      created_at TIMESTAMP,
                      PRIMARY KEY (post_id, user_id)
);

CREATE TABLE PostLike (
                          post_id INT,
                          user_id INT,
                          created_at TIMESTAMP,
                          PRIMARY KEY(post_id, user_id)
);

CREATE TABLE PostShare (
                           post_id INT,
                           user_id INT,
                           created_at TIMESTAMP,
                           PRIMARY KEY(post_id, user_id)
);

CREATE TABLE PostContent (
                             content_id INT SERIAL PRIMARY KEY,
                             post_id INT,
                             content_type VARCHAR(20),   -- 'text', 'image', 'video', etc.
                             text_content TEXT,
                             media_url VARCHAR(500),
                             FOREIGN KEY (post_id) REFERENCES Post(post_id)
);

CREATE TABLE Follows (
                         follower_key INT REFERENCES Users(user_id) ON DELETE CASCADE,
                         followed_key INT REFERENCES Users(user_id) ON DELETE CASCADE,
                         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (follower_key, followed_key),
                         CHECK (follower_key != followed_key)
)