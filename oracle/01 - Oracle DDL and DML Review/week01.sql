-- LAB EXERCISES

--Produce a list of all customer names in which the first letter of the first and 
--last names is in uppercase and the rest are in lowercase.

SELECT * FROM CUSTOMERS;

SELECT (INITCAP(LASTNAME) || ' ' || INITCAP(FIRSTNAME)) AS NAME FROM CUSTOMERS;

--Create a list of all customer numbers along with text indicating whether the customer
--has been referred by another customer. Display the text �NOT REFERRED� if the customer wasn�t referred 
--to JustLee Books by another customer or �REFERRED� if the customer was referred.

SELECT CUSTOMER#, DECODE(REFERRED, NULL, 'NOT REFERRED', 'REFERRED') AS CUSTOMER_REFERRED FROM CUSTOMERS;
SELECT CUSTOMER#, NVL2(REFERRED, 'RFERRED', 'NOT REFERRED') AS CUSTOMER_REFERRED FROM CUSTOMERS;

--Determine the amount of total profit generated by the book purchased on order 1002. 
--Display the book title and profit. The profit should be formatted to display a dollar sign and two decimal places. 
--Take into account that the customer might not pay the full retail price, and each item ordered can involve multiple copies.

SELECT B.TITLE, TO_CHAR(OI.QUANTITY * (PAIDEACH - COST), '$999.99') AS PROFIT
FROM ORDERITEMS OI JOIN BOOKS B USING(ISBN) WHERE ORDER#=1002;

--Display a list of all book titles and the percentage of markup for each book. 
--The percentage of markup should be displayed as a whole number 
--(that is, multiplied by 100) with no decimal position, followed by a percent sign 
--(for example, .2793 = 28%). (The percentage of markup should reflect the difference
--between the retail and cost amounts as a percent of the cost.).

SELECT TITLE, CONCAT(CEIL(100 * (RETAIL - COST)/COST), '%') AS MARKUP FROM BOOKS;

--Display the current day of the week, hour, minutes, and seconds of the 
--current date setting on the computer you�re using.

SELECT 
sysdate AS "Current Date",
INITCAP(TO_CHAR(sysdate, 'DY')) as "Day" ,
TO_CHAR(sysdate, 'HH') as "Hour",
TO_CHAR(sysdate, 'MI') as "Minutes",
TO_CHAR(sysdate, 'SS') as "Seconds"
FROM DUAL;

--Create a list of all book titles and costs. Precede each book�s cost with asterisks so 
--that the width of the displayed Cost field is 12.

SELECT TITLE, LPAD(COST, 12, '*') FROM BOOKS;

--Determine the length of data stored in the ISBN field of the BOOKS table. 
--Make sure each different  length value is displayed only once (not once for each book).

SELECT DISTINCT(LENGTH(ISBN)) AS "ISBN LENGTH" FROM BOOKS;

--Using today�s date, determine the age (in months) of each book that JustLee sells. 
--Make sure only whole months are displayed; ignore any portions of months. 
--Display the book title, publication date, current date, and age.

SELECT 
TITLE, 
PUBDATE AS "PUBLICATION DATE", 
SYSDATE AS "CURRENT DATE",
FLOOR(MONTHS_BETWEEN(SYSDATE, PUBDATE)) AS AGE
FROM BOOKS;

--Determine the calendar date of the next occurrence of Wednesday, based on today�s date.
--Produce a list of each customer number and the third and fourth digits of his 
--or her zip code. The query should also display the position of the first occurrence
--of a 3 in the customer number, if it exists.

SELECT NEXT_DAY(SYSDATE, 'WEDNESDAY') AS "NEXT WEDNESDAY" FROM DUAL;
SELECT 
CUSTOMER#, 
INSTR(CUSTOMER#, 3),
ZIP, 
SUBSTR(ZIP, 3, 2) AS "THIRD AND FOURTH DIGITS" 
FROM CUSTOMERS;

-- ADVANCED CHALLENGE
SELECT 
TITLE as "Title", 
CATEGORY as "Category",
TO_CHAR(RETAIL, '999.99') AS "Current Price",
TO_CHAR(DECODE(
    CATEGORY,
    'COMPUTER', RETAIL * 1.1, 
    'FITNESS', RETAIL * 1.15,
    'SELF HELP', RETAIL * 1.25,
    RETAIL * 1.03
), '999.99') AS "Revised Price"
FROM BOOKS
ORDER BY CATEGORY, TITLE;


-- CASE STUDY
--List the following information for all crimes that have a period greater than 14 days between
--the date charged and the hearing date: crime ID, classification, date charged, hearing date,
--and number of days between the date charged and the hearing date.

SELECT 
CRIME_ID, 
CLASSIFICATION, 
DATE_CHARGED, HEARING_DATE, 
(HEARING_DATE - DATE_CHARGED) AS "DAYS INTERVAL"
FROM CRIMES
WHERE (HEARING_DATE - DATE_CHARGED) >= 14;


--Produce a list showing each active police officer and his or her community assignment, 
--indicated by the second letter of the precinct code. Display the community description 
--listed in the following chart, based on the second letter of the precinct code.

SELECT 
OFFICER_ID, LAST, PRECINCT, SUBSTR(PRECINCT, 2, 1) FROM OFFICERS WHERE STATUS='A';

--Produce a list of sentencing information to include criminal ID, name 
--(displayed in all uppercase letters), sentence ID, sentence start date, and length 
--in months of the sentence. The number of months should be shown as a whole number. 
--The start date should be displayed in the format �December 17, 2009.�
SELECT 
CRIMINAL_ID, 
UPPER(FIRST || ' ' || LAST) AS NAME,
SENTENCE_ID,
TO_CHAR(START_DATE, 'Month DD, YYYY') AS "START DATE",
FLOOR(MONTHS_BETWEEN(END_DATE, START_DATE)) AS "MONTHS"
FROM SENTENCES S 
JOIN CRIMINALS C USING(CRIMINAL_ID);

--A list of all amounts owed is needed. Create a list showing each criminal name, charge ID,
--total amount owed (fine amount plus court fee), amount paid, amount owed, and payment 
--due date. If nothing has been paid to date, the amount paid is NULL. Include only 
--criminals who owe some amount of money. Display the dollar amounts with a dollar sign 
--and two decimals.

SELECT * FROM CRIME_CHARGES; -- CRIME_ID FINE_AMOUNT AMOUNT_PAID COURT_FEE
SELECT * FROM CRIMINALS; -- CRIMINAL_ID
SELECT * FROM CRIMES; -- CRIMINAL_ID, CRIME_ID

SELECT 
UPPER(FIRST || ' ' || LAST) AS NAME,
CRIMINAL_ID,
CHARGE_ID,
TO_CHAR(FINE_AMOUNT + COURT_FEE, '$9999.99') AS "TOTAL AMOUNT OWNED",
TO_CHAR(AMOUNT_PAID, '$9999.99') AS "AMOUNT PAID",
TO_CHAR((FINE_AMOUNT + COURT_FEE) - AMOUNT_PAID, '$9999.99') AS "AMOUNT OWNED",
PAY_DUE_DATE
FROM CRIMINALS 
JOIN CRIMES USING(CRIMINAL_ID)
JOIN CRIME_CHARGES USING (CRIME_ID)
WHERE (FINE_AMOUNT + COURT_FEE) - AMOUNT_PAID != 0;


-- TO CHARACTER
-- TO DATE
-- TO NUMBER

-- CONVERTING DATES INTO STRINGS
SELECT 
sysdate AS "Current Date",
TO_CHAR(sysdate, 'D') as "Day",
INITCAP(TO_CHAR(sysdate, 'DY')) as "Day",
INITCAP(TO_CHAR(sysdate, 'DAY', 'NLS_DATE_LANGUAGE = PORTUGUESE')) as "Day Portuguese" ,
TO_CHAR(sysdate, 'MM') as "Number Month",
TO_CHAR(sysdate, 'Month') as "Name of the Month",
TO_CHAR(sysdate, 'HH') as "Hour",
TO_CHAR(sysdate, 'WW') as "Week of the Year",
TO_CHAR(sysdate, 'W') as "Week of the Month",
TO_CHAR(sysdate, 'MI') as "Minutes",
TO_CHAR(sysdate, 'SS') as "Seconds",
TO_CHAR(sysdate, 'YYYY-MM-DD') as "Complete Date",
TO_CHAR(sysdate, 'YYYY_MM_DD') as "Complete_Date"
FROM DUAL;

-- CONVERTING NUMBERS TO STRINGS

SELECT 
TO_CHAR(123456.789, '999999.9'),
TO_CHAR(123456.789, '$999999.999'),
TO_CHAR(123, '00000')
FROM DUAL;


-- TO_NUMBER

-- CONVERTING STRINGS INTO NUMBER

SELECT 
TO_NUMBER('1234.56'), -- without mask
TO_NUMBER('1234.56', '9999.99'), -- number of digits 
TO_NUMBER('4687841', '9999999') -- no decimals
FROM DUAL;

-- TO_DATE
-- CONVERT A CHARACTER VALUE TO A DATE VALUE

SELECT
TO_DATE('10-SEP-2023'),
TO_DATE('2023/10/09', 'YYYY/DD/MM'),
TO_DATE('2023/10/SEP', 'YYYY/DD/MM')
FROM DUAL;