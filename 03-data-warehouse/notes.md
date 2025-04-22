## Data Warehouse

### OLAP vs OLTP
|  | OLAP | OLTP |
| --- | --- | --- |
| Purpose | Control and run essential business operations in real time | Plan, solve, problems, support decisions, discover hidden insights |
| Data updates | Short, fast updates, initiated by user | Data periodically refrehed with scheduled, long-running batch jobs |
| Database design | Normalized databases for efficiency | Denormalized databases for analysis |
| Space requirements | Generally small if historical data is archived | Generally large due to aggregating large datasets |
| Backup and recovery | Regular backups required to ensure business continuity and meet legal and governance requirements | Lost data can be reloaded from OLTP database as needed in lieu of regular backups |
| Productivity | Increases productivity of end users | Increases productivity of business managers, data analysts, and executives |
| Data view | List day-to-day business transactions | Multi-dimentional view of enterprise data |
| User examples | Customer-facing personnel, clerks, online shoppers | Knowledge workers such as data analysts, business analysts, and executives |

### What is a data warehouse?
```
- OLAP solution
- Used for reporting and data analysis
```

### BigQuery
```
- Serverless data warehouse
- Software as well as infrastructure built-in features like
    - machine learning
    - geospatial analysis
    - business intelligence
- BigQuery maximizes flexibility by separating the compute engine that analyzes your data from your storage



