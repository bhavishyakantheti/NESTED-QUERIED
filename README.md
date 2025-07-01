# NESTED-QUERIES AND SUB-QUERIES

### Tables used:-
1. customer(customerid, customername, email...)
2. product(productid, pname, price)
3. orders(order_id, customerid, product_id)


**Subqueries**
- Returns only one value like one row, one column.

**Correlated Subquery**
- It refers to a column from the outer query.
- It is evaluted for each row of the outer query.

**Subquery with IN**
- Checks if a value exists in a list of values returned by subquery.

**Subquery with EXISTS**
- Returns true if the subquery returns at least one row.

**Subquery with =**
- It is used when the subquery returns a single value(scalar).

