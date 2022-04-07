---
title: "Reading Note: PostgreSQL view and materialized view"
tags: software database postgresql
---

A view is a database object that is of a stored query.

A view is defined based on one or more tables which are known as base tables. When you create a view, you create a query and assign a name to the query. It is useful for wrapping a commonly used complex query.

The **regular views** do not store any data except the **materialized views**.

## Materialized Views in PostgreSQL

The **regular views** are the virtual tables that represent the data of the underlying tables. The regular views do not store any data except the **materialized views**.

Materialized views in **PostgreSQL** use the rule system like views do, but persist the results in a table-like form. The main differences between:

```postgresql
CREATE MATERIALIZED VIEW mymatview AS SELECT * FROM mytab;
```

and:

```postgresql
CREATE TABLE mymatview AS SELECT * FROM mytab;
```

are the materialized view cannot subsequently be directly updated and that the query used to create the materialized view is sorted in exactly the same way that a view's query is stored so that fresh data can be generated for the materialized view with:

```postgresql
REFRESH MATERIALIZED VIEW mymatview;
```

## Usage

Materialized views cache the result of a complex and expensive query and allow you to refresh this result periodically. It is useful in many cases that require fast data access.

While access to the data stored in a materialized view is often much faster than accessing the underlying tables directly or through a view, the data is not always current.

Example:

```postgresql
CREATE TABLE invoice (
    invoice_no    integer        PRIMARY KEY,
    seller_no     integer,       -- ID of salesperson
    invoice_date  date,          -- date of sale
    invoice_amt   numeric(13,2)  -- amount of sale
);
```

If people want to be able to quickly graph historical sales data, they might want to summarize, and they may not care about the incomplete data for the current date:

```postgresql
CREATE MATERIALIZED VIEW sales_summary AS
  SELECT
      seller_no,
      invoice_date,
      sum(invoice_amt)::numeric(13,2) as sales_amt
    FROM invoice
    WHERE invoice_date < CURRENT_DATE
    GROUP BY
      seller_no,
      invoice_date;

CREATE UNIQUE INDEX sales_summary_seller
  ON sales_summary (seller_no, invoice_date);
```

This materialized view might be useful for displaying a graph in the dashboard created for salespeople. A job could be scheduled to update the statistics each night using this SQL statement:

```postgresql
REFRESH MATERIALIZED VIEW sales_summary;
```

**Read more:**

- More good examples from official PostgreSQL documentation: [Rules Materialized Views](https://www.postgresql.org/docs/14/rules-materializedviews.html
- I found a good tutorial related to how to use regular views and materialized views here [PostgreSQL Views](https://www.postgresqltutorial.com/postgresql-views/)

## References

- <https://www.postgresql.org/docs/14/rules-materializedviews.html>
- <https://www.postgresqltutorial.com/postgresql-views/>
