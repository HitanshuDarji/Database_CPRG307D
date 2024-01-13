-- Name : Hitanshu Janakbhai Darji
-- Course : CPRG307D
-- Lab : 1 SQL Commands and Database Sequences and Views
-- Date : 01/12/2024




-- 1. Display the structure of the MM_MEMBER table.
DESC MM_MEMBER;


-- 2. Add yourself as a member.
INSERT INTO
    MM_MEMBER (MEMBER_ID, LAST, FIRST) 
VALUES
    (15, 'Darji', 'Hitanshu');


-- 3. Modify your membership by adding a made-up credit card number.
-- Do not use your real-life credit card number.
UPDATE
    MM_MEMBER
SET
    CREDIT_CARD = '888888888888'
WHERE
    MEMBER_ID = 15;


-- 4. Remove your membership.
DELETE FROM
    MM_MEMBER
WHERE
    MEMBER_ID = 15;


-- 5. Save your data changes.
COMMIT;


-- 6. Display the title of each movie, the rental ID and the last names of all members who have
-- rented those movies.
-- • Sort the result set by the rental ID.
-- • Ensure that no other information appears.
-- • Use three tables for this query: MM_MEMBER, MM_MOVIE and MM_RENTAL.
-- Restriction: Solve using JOIN…ON as your join method.
SELECT
    r.RENTAL_ID,
    m.MOVIE_TITLE,
    mb.LAST
FROM 
    MM_RENTAL r
JOIN
    MM_MOVIE m ON r.MOVIE_ID = m.MOVIE_ID
JOIN
    MM_MEMBER mb ON mb.MEMBER_ID = r.MEMBER_ID
ORDER BY
    r.RENTAL_ID;


-- 7. Display the title of each movie, the rental ID, and the last names of all members who have
-- rented those movies.
-- • No other information should appear.
-- • Use three tables for this query: MM_MEMBER, MM_MOVIE and MM_RENTAL.
-- Restriction: Solve using the traditional join method, where join is in the WHERE clause.
SELECT
    r.RENTAL_ID,
    m.MOVIE_TITLE,
    mb.LAST
FROM
    MM_RENTAL r,
    MM_MOVIE m,
    MM_MEMBER mb
WHERE
    r.MOVIE_ID = m.MOVIE_ID
    AND
    r.MEMBER_ID = mb.MEMBER_ID;


-- 8. Create a new table called MY_TABLE that is made up of three columns: MY_NUMBER,
-- MY_DATE and MY_STRING, and that have data types: NUMBER, DATE and
-- VARCHAR2(5), respectively.
CREATE TABLE MY_TABLE (
    MY_NUMBER NUMBER,
    MY_DATE DATE,
    MY_STRING VARCHAR2(5)
);


-- 9. Create a new sequence called seq_movie_id. Have the sequence start at 20 and
-- increment by 2.
CREATE SEQUENCE seq_movie_id
START WITH 20
INCREMENT BY 2;


-- 10. Display the sequence information (at least the last number and increment by) from the data
-- dictionary’s user_sequences view.
-- Note: Your output should only show this one sequence.
SELECT
    SEQUENCE_NAME,
    LAST_NUMBER,
    INCREMENT_BY
FROM
    USER_SEQUENCES
WHERE
    SEQUENCE_NAME = 'SEQ_MOVIE_ID';


-- 11. Use a query to display the next sequence number on the screen.
SELECT
    seq_movie_id.NEXTVAL
AS
    next_number
FROM
    dual;


-- 12. Change the sequence created in Step 9 to increment by 5 instead of 2.
ALTER SEQUENCE
    seq_movie_id
    INCREMENT BY 5;


-- 13. Add your favorite movie to the MM_MOVIE table using the sequence created in Step 9 for
-- the movie_id.
-- Notes:
-- • You can create values for the other columns (all columns must be given a value).
-- • MM_MOVIE has a foreign key, which means any value placed in this column must
-- already exist as primary key value in the table being referenced.
-- • MM_MOVIE has a check constraint.
INSERT INTO MM_MOVIE
    (MOVIE_ID, MOVIE_TITLE, MOVIE_CAT_ID, MOVIE_VALUE, MOVIE_QTY)
VALUES
    (seq_movie_id.NEXTVAL, 'Schindler''s List', 2, 12, 1);


-- 14. Create a view named VW_MOVIE_RENTAL using the query from either Step 6 or Step 7.
CREATE VIEW VW_MOVIE_RENTAL AS
SELECT
    r.RENTAL_ID,
    m.MOVIE_TITLE,
    mb.LAST
FROM 
    MM_RENTAL r
JOIN
    MM_MOVIE m ON r.MOVIE_ID = m.MOVIE_ID
JOIN
    MM_MEMBER mb ON mb.MEMBER_ID = r.MEMBER_ID
ORDER BY
    r.RENTAL_ID;


-- 15. Use a query to display the data accessed by the VW_MOVIE_RENTAL view.
SELECT * FROM VW_MOVIE_RENTAL;


-- 16. Using the VW_MOVIE_RENTAL, change the last name of the member who rented the
-- movie with the ID of 2 to Tangier 1.
UPDATE MM_MEMBER
SET last = 'Tangier 1'
WHERE MEMBER_ID = (SELECT MEMBER_ID FROM MM_RENTAL WHERE RENTAL_ID = 2);