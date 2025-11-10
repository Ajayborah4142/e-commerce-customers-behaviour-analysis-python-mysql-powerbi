#  E-Commerce Customer Behaviour Analysis using SQL  

![SQL Badge](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql)
![Project Badge](https://img.shields.io/badge/Project-Type%3A%20Data%20Analysis-green)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

##  Project Overview  

This project analyzes **customer behavior, sales performance, and engagement patterns** using a comprehensive **E-Commerce dataset**.  
The goal is to uncover **actionable insights** that can help businesses optimize marketing strategies, improve user experience, and increase profitability.

By leveraging **SQL** for descriptive, diagnostic, and analytical queries, this project covers multiple dimensions — demographics, revenue, discounts, delivery, and customer satisfaction.

---

##  Database Setup  

### Step 1: Create Database and Table  
```sql
DROP DATABASE IF EXISTS E_Commerce_Customers_Behaviour;
CREATE DATABASE E_Commerce_Customers_Behaviour;
USE E_Commerce_Customers_Behaviour;

CREATE TABLE customers (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Customer_ID VARCHAR(50),
    Date DATE,
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50),
    Product_Category VARCHAR(100),
    Unit_Price VARCHAR(100),
    Quantity INT,
    Discount_Amount FLOAT,
    Total_Amount FLOAT,
    Payment_Method VARCHAR(100),
    Device_Type VARCHAR(100),
    Session_Duration_Minutes INT,
    Pages_Viewed INT,
    Is_Returning_Customer VARCHAR(100),
    Delivery_Time_Days INT,
    Customer_Rating INT
);

```
##  Analysis Categories
### 1. Customer Demographics

* What is the average age of customers?

* Which city has the most customers?

* What is the gender distribution?

* Which age group contributes most to total revenue?

* How many returning vs new customers are there?

### 2. Sales & Revenue Insights

* What is the total revenue generated?

* Which product category has the highest total sales?

* What is the average order value (AOV)?

* Which city generated the highest revenue?

* What is the impact of discount percentage on sales?

### 3. Pricing & Discounts

* What is the average discount given?

* Which category offers the highest average discount?

* Is there a correlation between discount and total amount?

* Do high discounts lead to higher sales quantity?

###  4. Customer Behaviour

* What is the average session duration?

* Do returning customers spend more time on the site?

* What is the average number of pages viewed per session?

* Do customers with longer sessions purchase more items?

* Which device type has the highest average order value?

### 5. Delivery & Experience

* What is the average delivery time (in days)?

* Is there a relationship between delivery time and customer rating?

* Which city has the fastest delivery?

* Do faster deliveries result in higher ratings?

### 6. Customer Satisfaction

* What is the average customer rating overall?

* Which product category has the highest satisfaction (rating)?

* Which payment method has the highest-rated orders?

* Are returning customers giving higher ratings than new ones?

* Who are the top-performing customers based on category, city, and spending?

### Sample Insight Highlights

* ✅ Top City: Contributes the highest total revenue
* ✅ Adults (18–35): Largest spenders across product categories
* ✅ Mobile Users: Show the highest average order value
* ✅ Faster Deliveries: Lead to better customer ratings
* ✅ Returning Customers: Spend longer time on site and rate higher

### SQL Features Used

* DENSE_RANK() and PARTITION BY for ranking and segmentation

* CASE WHEN for age group categorization

* ROUND() and aggregation functions for summaries

* AVG(), SUM(), COUNT() for statistical analysis

* Window functions for advanced customer segmentation

### Conclusion

* This SQL-based project highlights how data-driven insights can optimize:

* Customer retention strategies

* Targeted marketing efforts

* Operational efficiency (delivery, pricing, etc.)

* It’s a demonstration of real-world E-Commerce analytics using pure SQL — with no BI tool dependencies.

###  Author

* 👤 Ajay Borah
* 💼 Aspiring Data Analyst | SQL | Excel | Power BI | Python (Pandas)

