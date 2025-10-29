# SQL Developer Internship - Elevate Labs

# Task 6 – Subqueries and Nested Queries

This repository contains SQL queries demonstrating subqueries inside `SELECT`, `WHERE`, and `FROM` clauses.  

## Database Schema

**Tables**
- `Customers(CustomerID, CustomerName, City)`
- `Products(ProductID, ProductName, Price)`
- `Orders(OrderID, CustomerID, ProductID, Quantity, OrderDate)`

Relationships:
- One Customer → Many Orders  
- One Product → Many Orders  

### Tools Used
*  **MySQL Workbench**: Used to connect to the database, write, and execute the SQL queries[cite: 5].
* **SQL Language**: For writing the queries.

| Type | Description |
|------|--------------|
| Scalar Subquery | Subquery returns single value used in SELECT/WHERE. |
| Correlated Subquery | Uses outer query’s column in inner query. |
| Subquery in WHERE (IN, EXISTS, =) | Filter rows using results from another query. |
| Derived Table (Subquery in FROM) | Treat subquery result as temporary table. |
| Nested Subqueries | Multiple layers of subqueries for complex aggregation. |

## Interview Questions & Answers

1. **What is a subquery?**  
  A query nested inside another query that returns data used by the outer query.

2. **Difference between subquery and join?**  
  Join combines tables horizontally for related data; subquery embeds one query inside another for derived values or filters.

3. **What is a correlated subquery?**  
  A subquery that references columns from the outer query and executes once per row.

4. **Can subqueries return multiple rows?**  
  Yes – used with `IN`, `ANY`, `ALL` operators.

5. **How does EXISTS work?**  
  Checks whether the subquery returns any rows (true/false).

6. **How is performance affected?**  
  Multiple subquery executions may slow performance; joins or derived tables are often faster.

7. **What is a scalar subquery?**  
  Returns a single value (one row, one column) usable like a literal.

8. **Where can we use subqueries?**  
  In `SELECT`, `FROM`, `WHERE`, `HAVING`, and `UPDATE` clauses.

9. **Can a subquery be in FROM clause?**  
  Yes – it’s called a **derived table**.

10. **What is a derived table?**  
  A subquery used in the `FROM` clause that temporarily acts as a table for the outer query.

## Files in Repository
- `task6_subqueries.sql` → main SQL script.  
- `README.md` → documentation and Q&A.  

**Author**
**Shefali Deshpande**

