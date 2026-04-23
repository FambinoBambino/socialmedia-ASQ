-- Users
INSERT INTO users (user_id, password, email, name, profile_picture, bio) VALUES
                                                    ('alice',   'Alice Chen',     'coffee and code'),
                                                    ('bob',     'Bob Martinez',   'hiking enthusiast'),
                                                    ('charlie', 'Charlie Park',   'night owl developer'),
                                                    ('diana',   'Diana Russo',    'photography + travel'),
                                                    ('eve',     'Eve Thompson',   'music and math');

-- Posts (use subqueries so we don't hardcode IDs)
INSERT INTO posts (author_id, content) VALUES
                                           ((SELECT id FROM users WHERE username = 'alice'),   'Just deployed my first Spring Boot app!'),
                                           ((SELECT id FROM users WHERE username = 'alice'),   'PostgreSQL > MySQL, fight me'),
                                           ((SELECT id FROM users WHERE username = 'bob'),     'Hit the summit at Camelback today. Views were unreal.'),
                                           ((SELECT id FROM users WHERE username = 'charlie'), 'Debugging at 3am hits different'),
                                           ((SELECT id FROM users WHERE username = 'charlie'), 'Hot take: tabs > spaces'),
                                           ((SELECT id FROM users WHERE username = 'diana'),   'Golden hour in Sedona never disappoints'),
                                           ((SELECT id FROM users WHERE username = 'eve'),     'Euler identity is the most beautiful equation ever');

-- Follows
INSERT INTO follows (follower_id, followed_id) VALUES
                                                   ((SELECT id FROM users WHERE username = 'alice'),   (SELECT id FROM users WHERE username = 'bob')),
                                                   ((SELECT id FROM users WHERE username = 'alice'),   (SELECT id FROM users WHERE username = 'charlie')),
                                                   ((SELECT id FROM users WHERE username = 'bob'),     (SELECT id FROM users WHERE username = 'alice')),
                                                   ((SELECT id FROM users WHERE username = 'bob'),     (SELECT id FROM users WHERE username = 'diana')),
                                                   ((SELECT id FROM users WHERE username = 'charlie'), (SELECT id FROM users WHERE username = 'alice')),
                                                   ((SELECT id FROM users WHERE username = 'diana'),   (SELECT id FROM users WHERE username = 'eve')),
                                                   ((SELECT id FROM users WHERE username = 'eve'),     (SELECT id FROM users WHERE username = 'alice'));

-- Likes
INSERT INTO likes (user_id, post_id) VALUES
                                         ((SELECT id FROM users WHERE username = 'bob'),     (SELECT id FROM posts WHERE content LIKE 'Just deployed%')),
                                         ((SELECT id FROM users WHERE username = 'charlie'), (SELECT id FROM posts WHERE content LIKE 'Just deployed%')),
                                         ((SELECT id FROM users WHERE username = 'alice'),   (SELECT id FROM posts WHERE content LIKE 'Hit the summit%')),
                                         ((SELECT id FROM users WHERE username = 'diana'),   (SELECT id FROM posts WHERE content LIKE 'Golden hour%')),
                                         ((SELECT id FROM users WHERE username = 'eve'),     (SELECT id FROM posts WHERE content LIKE 'PostgreSQL%'));

-- Comments
INSERT INTO comments (post_id, author_id, content) VALUES
                                                       ((SELECT id FROM posts WHERE content LIKE 'Just deployed%'),
                                                        (SELECT id FROM users WHERE username = 'bob'),
                                                        'Nice! What stack?'),
                                                       ((SELECT id FROM posts WHERE content LIKE 'Hit the summit%'),
                                                        (SELECT id FROM users WHERE username = 'alice'),
                                                        'So jealous, I need to get out more'),
                                                       ((SELECT id FROM posts WHERE content LIKE 'tabs > spaces%'),
                                                        (SELECT id FROM users WHERE username = 'eve'),
                                                        'This is objectively wrong');