DROP DATABASE IF EXISTS E_Commerce_Customers_Behaviour;
CREATE DATABASE E_Commerce_Customers_Behaviour;

USE E_Commerce_Customers_Behaviour;


DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
Order_ID VARCHAR(20) PRIMARY KEY  ,
Customer_ID	VARCHAR(50) ,
Date DATE ,
Age	INT ,
Gender VARCHAR(10) ,
City VARCHAR(50) ,	
Product_Category VARCHAR(100) ,
Unit_Price VARCHAR(100) ,	
Quantity INT ,
Discount_Amount	FLOAT ,
Total_Amount FLOAT ,	
Payment_Method VARCHAR(100) ,
Device_Type	VARCHAR(100) ,
Session_Duration_Minutes INT ,
Pages_Viewed INT ,
Is_Returning_Customer VARCHAR(100) ,	
Delivery_Time_Days INT ,
Customer_Rating INT 

);

SET GLOBAL LOCAL_INFILE=ON;
LOAD DATA LOCAL INFILE "C:/Users/Lenovo/OneDrive/Documents/SQL Programming/ecommerce_customer_behavior_dataset.csv"  INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-------------------------------------------------------------------------------------------------------------------------------------------

-------------------------- Customer Demographics ----------------------------------------------

# Q.1) What is the average age of customers overall?

SELECT AVG(Age) FROM customers ;

# Q.2) Which city has the most customers?

SELECT City, COUNT(*) AS Total_Customers FROM customers 
GROUP BY City
ORDER BY Total_Customers DESC 
LIMIT 1 ;

# Q.3) What is the gender distribution of customers (Male vs Female)?

SELECT Gender, 
       ROUND(SUM(Total_Amount),2) Total_distribution
FROM customers 
GROUP BY Gender ;

# Q.4) Which age group contributes most to total revenue?

SELECT 
CASE 
    WHEN Age BETWEEN 0 AND 12 THEN 'Child'
    WHEN Age BETWEEN 13 AND 17 THEN 'Teen'
    WHEN Age BETWEEN 18 AND 35 THEN 'Adult'
    WHEN Age BETWEEN 36 AND 55 THEN 'Middle-Aged'
    ELSE 'Sinior'
    END AS Age_Group , 
    ROUND(SUM(Total_Amount),2) Total_contributes
    FROM customers
    GROUP BY Age_Group
    ORDER BY Total_contributes DESC ;
    

# Q.5) How many returning vs new customers are there?

SELECT COUNT(*) FROM customers 
WHERE Is_Returning_Customer  = 'Yes' ;

SELECT Customer_ID, COUNT(*) 
FROM customers 
GROUP BY Customer_ID
HAVING COUNT(*) > 1 ;

------------------------------------ 2. Sales & Revenue Insights -------------------------------

# Q.6) What is the total revenue generated?

SELECT ROUND(SUM(Total_Amount),2) AS Total_Revenue 
FROM customers ;

# Q.7) Which product category has the highest total sales?

SELECT Product_Category, 
       ROUND(SUM(Total_Amount),2) AS Total_sales
FROM customers 
GROUP BY Product_Category
ORDER BY Total_sales DESC 
LIMIT 1 ;

# Q.8) What is the average order value (AOV) per customer? 

SELECT Order_ID, Customer_ID,
ROUND(AVG(Total_Amount) OVER(),2) AS Avg_Value
FROM customers ;

# Q.9) Which city generated the highest total revenue?

SELECT City, 
	   ROUND(SUM(Total_Amount),2) AS Total_Revenue 
FROM customers 
GROUP BY City
ORDER BY Total_Revenue DESC 
LIMIT 1 ;

# Q.10) What is the discount percentage impact on total sales?

SELECT 
      ROUND(SUM(Discount_Amount) / SUM(Total_Amount) * 100,2) AS Percentage 
FROM customers ;

---------------------------- Pricing & Discounts -------------------------------------

# Q.11) What is the average discount amount across all orders?

SELECT ROUND(AVG(Discount_Amount),2) AS Avg_Discount 
	   FROM customers ;

# Q.12) Which product category offers the highest average discount?

SELECT Product_Category, 
       AVG(Discount_Amount) AS Avg_Discount
FROM customers 
GROUP BY Product_Category
ORDER BY Avg_Discount DESC 
LIMIT 1 ; 

# Q.13) Is there any correlation between discount and total amount?

SELECT 
    (SUM((Discount_Amount - d.mean_d) * (Total_Amount - t.mean_t)) /
     (SQRT(SUM(POW(Discount_Amount - d.mean_d, 2)) * 
           SUM(POW(Total_Amount - t.mean_t, 2))))) AS Correlation
FROM customers,
     (SELECT AVG(Discount_Amount) AS mean_d FROM customers) d,
     (SELECT AVG(Total_Amount) AS mean_t FROM customers) t;

# Q.14) Do high discounts lead to higher sales quantity?

SELECT * 
FROM customers
ORDER BY Discount_Amount DESC ,
		 Quantity DESC ;

------------------------------ Customer Behaviour Analysis -------------------------

# Q.15) What is the average session duration of customers?

SELECT ROUND(AVG(Session_Duration_Minutes),2) AS Avg_Session_Duration_Minutes
       FROM customers ;

# Q.16) Do returning customers spend more time on the site than new ones?

SELECT 
    Is_Returning_Customer,
    ROUND(AVG(Session_Duration_Minutes), 2) AS Avg_Session_Duration
FROM customers
GROUP BY Is_Returning_Customer
ORDER BY Avg_Session_Duration DESC;

# Q.17) What is the average number of pages viewed per session?

SELECT ROUND(AVG(Session_Duration_Minutes),2) AS Avg_Session_Duration_Minutes 
       FROM customers ;

# Q.18) Do customers with longer session durations tend to purchase more items?

SELECT 
    CASE
        WHEN Session_Duration_Minutes < 5 THEN 'Very Short (<5 min)'
        WHEN Session_Duration_Minutes BETWEEN 5 AND 10 THEN 'Short (5–10 min)'
        WHEN Session_Duration_Minutes BETWEEN 11 AND 20 THEN 'Medium (11–20 min)'
        WHEN Session_Duration_Minutes > 20 THEN 'Long (>20 min)'
    END AS Session_Category,
    ROUND(AVG(Quantity), 2) AS Avg_Quantity
FROM customers
GROUP BY Session_Category
ORDER BY Avg_Quantity DESC;

# Q.19) Which device type (Mobile/Desktop/Tablet) has the highest average order value?

SELECT Device_Type, 
       ROUND(AVG(Total_Amount),2) AS Avg_Value 
FROM customers 
GROUP BY Device_Type
ORDER BY Avg_Value DESC ;

--------------------------- 5. Delivery & Experience ------------------------------------------

# Q.20) What is the average delivery time (days) for all orders?

SELECT ROUND(AVG(Delivery_Time_Days),2) AS Avg_Delivery_Time_Days
FROM customers;

# Q.21) Is there a relationship between delivery time and customer rating?

SELECT ROUND(AVG(Delivery_Time_Days),2) AS AVG_Delivery_Time_Days,
	   ROUND(AVG(Customer_Rating),2) AS Avg_Customer_Rating 
FROM customers ;

# Q.22) Which city has the fastest delivery time on average?

SELECT City, 
       AVG(Delivery_Time_Days) AS Avg_Delivery_Time_Days
FROM customers 
GROUP BY City
ORDER BY Avg_Delivery_Time_Days ASC 
LIMIT 1 ;

# Q.23) Do faster deliveries result in higher customer ratings?

SELECT Customer_ID, Customer_Rating ,
       AVG(Delivery_Time_Days) AS Avg_Delivery_Time_Days
FROM customers 
WHERE Customer_Rating = (SELECT MAX(Customer_Rating) FROM customers)
GROUP BY Customer_ID, Customer_Rating
ORDER BY Customer_Rating DESC ,
         Avg_Delivery_Time_Days ASC ;

--------------------------- 6. Customer Satisfaction ------------------------------------------

# Q.24) What is the average customer rating?

SELECT ROUND(AVG(Customer_Rating),2) AS Avg_Customer_Rating 
FROM customers ;

# Q.25) Which product category has the highest customer satisfaction (rating)?

SELECT Product_Category, COUNT(Customer_Rating) AS Customer_Satisfaction_Score 
FROM customers 
WHERE Customer_Rating = 5
GROUP BY Product_Category
ORDER BY Customer_Satisfaction_Score  DESC 
LIMIT 1 ;

# Q.26) Which payment method has the highest rated orders?

SELECT Payment_Method, 
	   COUNT(Customer_Rating) AS Order_Rating
FROM customers
WHERE Customer_Rating IN (4,5)
GROUP BY Payment_Method
ORDER BY Order_Rating DESC 
LIMIT 1 ;

# Q.27) Are returning customers giving higher ratings than new ones?

SELECT Is_Returning_Customer,
       COUNT(Customer_Rating) AS Rating
FROM customers 
WHERE Is_Returning_Customer = 'Yes' AND Customer_Rating IN (4,5)
GROUP BY Is_Returning_Customer
ORDER BY Rating DESC 
LIMIT 1 ;

# Q.28) Which customers have the highest total purchase amount within each product category?

SELECT Customer_ID, Age, Gender, City, Product_Category, Total_Amount
FROM 
( SELECT * ,
DENSE_RANK() OVER(PARTITION BY Product_Category ORDER BY Total_Amount DESC) AS Product_Category_Ranking
FROM customers ) AS T1 
WHERE  T1.Product_Category_Ranking = 1 ;

# Q.29) Which customers have the highest total purchase amount both within their city and for their payment method?

SELECT * FROM
(SELECT *,
DENSE_RANK() OVER(PARTITION BY City ORDER BY Total_Amount DESC) AS City_Ranking,
DENSE_RANK() OVER(PARTITION BY Payment_Method ORDER BY Total_Amount DESC) AS Payment_Method_Ranking
FROM customers ) AS T1 
WHERE City_Ranking = 1 AND Payment_Method_Ranking = 1  ;
      

# Q.30) Who are the top 10 new customers (non-returning) who spent the highest total amount on purchases?

SELECT Customer_ID, Date, Gender, City, Product_Category, Total_Amount
 FROM
(SELECT *, 
DENSE_RANK () OVER (ORDER BY Total_Amount DESC)
FROM customers ) AS T1 
WHERE T1.Is_Returning_Customer = 'No'
LIMIT 10 ;

------------------------------------------------------------------------------------------------------------------------------------------
