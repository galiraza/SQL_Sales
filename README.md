# SQL_Sales

## Retail Supply Chain Analysis

A small project that demonstrates how to load retail CSV data into a local SQLite database and run analytical SQL queries to extract sales and supply-chain insights.

**Contents & purpose**

- Load CSVs from `Data/CSV/` into a local SQLite database at `Data/SQL_db/salesss.db`.
- Run SQL queries (examples included) to answer common business questions (top customers, product sales, regional performance).

## Project structure

- `main.ipynb` — Jupyter notebook that loads CSVs, pushes them into SQLite, and runs example queries.
- `Data/CSV/` — source CSV files: `Customers.csv`, `Location.csv`, `Orders.csv`, `Products.csv`.
- `Data/SQL_db/` — directory for the generated SQLite DB (`salesss.db`).

## Prerequisites

- Python 3.8+ installed
- Recommended Python packages: `pandas` and `sqlite3` (standard library). Install `pandas` with pip if needed:

```bash
pip install pandas
```

## Quick usage

1. Open `main.ipynb` in Jupyter or VS Code and run the cells in order. The notebook does the following:
	 - Reads CSVs from `Data/CSV/` into pandas DataFrames.
	 - Creates/opens SQLite DB at `Data/SQL_db/salesss.db` and writes the DataFrames as SQL tables.
	 - Runs example SQL queries and displays results as pandas DataFrames.

2. Alternatively, run a small Python script (or the notebook code) to create the DB programmatically. The notebook contains this snippet:

```python
import pandas as pd
import sqlite3

Customers = pd.read_csv("Data/CSV/Customers.csv", encoding="latin1", sep=";")
Location = pd.read_csv("Data/CSV/Location.csv", encoding="latin1", sep=";")
Orders = pd.read_csv("Data/CSV/Orders.csv", encoding="latin1", sep=";")
Products = pd.read_csv("Data/CSV/Products.csv", encoding="latin1", sep=";")

conn = sqlite3.connect("Data/SQL_db/salesss.db")
Customers.to_sql("customers", conn, if_exists="replace", index=False)
Location.to_sql("Location", conn, if_exists="replace", index=False)
Orders.to_sql("Orders", conn, if_exists="replace", index=False)
Products.to_sql("Products", conn, if_exists="replace", index=False)

conn.close()
```

## Example SQL queries

1) Top 10 customers by total sales:

```sql
SELECT c.[Customer Name],
			 SUM(o.Quantity * o.Sales) AS Total_Sales
FROM Orders o
JOIN customers c ON o.[Customer ID] = c.[Customer ID]
GROUP BY c.[Customer Name]
ORDER BY Total_Sales DESC
LIMIT 10;
```

2) Total sales by product:

```sql
SELECT p.[Product Name],
			 SUM(o.Quantity * o.Sales) AS Total_Sales
FROM Orders o
JOIN Products p ON o.[Product ID] = p.[Product ID]
GROUP BY p.[Product Name]
ORDER BY Total_Sales DESC;
```

3) Sales by region (using `Location` table):

```sql
SELECT l.Region,
			 SUM(o.Quantity * o.Sales) AS Total_Sales
FROM Orders o
JOIN Location l ON o.[Location ID] = l.[Location ID]
GROUP BY l.Region
ORDER BY Total_Sales DESC;
```

Notes
- Column names in the CSVs may include spaces; use square brackets (e.g., `[Customer Name]`) in SQL when necessary.
- Adjust encodings/separators if your CSVs differ.

## Next steps / suggestions

- Run `main.ipynb` to create the DB and explore the included example queries.
- If you'd like, I can:
	- Add a small `create_db.py` script to automate DB creation.
	- Add a `requirements.txt` for easy installs.
	- Expand the README with specific business-question examples.

---
Life is not a piece of cake — but data can make decisions easier.