DELIMITER $$

CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows(follower_id, followee_id)
        VALUES (OLD.follower_id, OLD.followee_id);
    END;
$$

DELIMITER  ;

-- DELETE FROM follows WHERE follower_id = 2 AND followee_id = 1;




-- Syntax change

-- DELIMITER $$

-- CREATE TRIGGER capture_unfollow
--     AFTER DELETE ON follows FOR EACH ROW
--     BEGIN
--         INSERT INTO unfollows
--         SET
--         follower_id = OLD.follower_id,
--         followee_id = OLD.followee_id;
--     END;
-- $$

-- DELIMITER  ;