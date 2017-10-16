-- Find all the information on all the catchers (position 2) in the database.
SELECT * FROM Player WHERE position=2;
-- Find the name and age of all pitchers (position 1) on the Rays.
SELECT name,age FROM Player WHERE position=1 AND team='Rays';
-- Find the name, number, and team of all outfielders (positions 7 through 9) who are 25 years old or younger.
SELECT name,number,team FROM Player WHERE position >= 7 AND position <= 9 AND age <= 25;
-- Find the name and number of all infielders (positions 3 through 6) on the Red Sox.
SELECT name,number FROM Player WHERE position >= 3 AND position <= 6 AND team='Red Sox';
-- Find the name, number, and team of all pitchers who are over 30 years old.
SELECT name,number,team FROM Player WHERE position=1 AND age > 30;
