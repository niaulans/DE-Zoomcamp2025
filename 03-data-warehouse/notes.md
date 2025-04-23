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
```

### BigQuery Cost
```
- On demand pricing
    - 1 TB data processed = $5
- Flat rate pricing
    - Based on number of pre requested slots
    - 100 slots -> $2000/month = 400 TB data processed on demand pricing
```

### BigQuery partition 
```
- Time-unit column 
- Ingestion time (_PARTITIONTIME)
- Integer range partitioning
- When using Time unit or ingestion time
    - daily
    - hourly
    - monthly or yearly
- Number of partitions limit is 4000
```

### BigQuery clustering
```
- Columns you specify are used to colocate related data
- Order of the column is important
- The order of the specified columns determines the sort of the data
- Clustering improves
    - Filter queries
    - Aggregate queries
- Table with data size < 1 GB, don't  show significant improvement with partitioning and clustering
- You can specify up to four clustering columns
```

### BigQuery Clustering Data Types
```
Clustering columns must be top-level, non-repeated columns of the following data types:
- DATE
- BOOL
- GEOGRAPHY
- INT64
- NUMERIC
- BIGNUMERIC
- STRING
- TIMESTAMP
- DATETIME
```

### Partitioning vs Clustering
| CLustering | Partitioning |
| --- | --- |
| Cost benefit unknown | Cost benefit upfront |
| You need more granularity than partitioning alone allows | You need partition-level management |
| Your queries commonly use filters or aggregation againts multiple particular columns | Filter aggregate on single column | 
| The cardinality of the number of valus in a column or group of columns is large | |

### Clustering over partitioning
```
- Partitioning results in a small amount of data per partition (less than 1 GB)
- Partitioning results in a large number of partitions (more than 4000)
- Partitioning results in your mutation operation modifying the majority of partitions in the table frequently (every few minutes)
```

### BigQuery Best Practices
```
- Cost reduction 
    - Avoid SELECT *
    - Price your queries before running them
    - Use clustered or partitioned tables
    - Use streaming inserts with caution
    - Materialize query results in staged tables

- Query performance
    - Filter on partitioned columns
    - Denormalize data
    - Use nested or repeated columns
    - Use external data sources appropriately
    - Don't use it, in case u want a high query performance
    - reduce data before using a JOIN
    - Don't treat WITH clauses as prepared statements
    - Avoid oversharding tables
    - Avoid Javascript UDFs
    - Use approximate aggregation functions
    - Order Last, for query operations to maximize performance
    - Optimize your JOIN patterns
    - As a best practice, place the table with the largest number of rows, followed by the table with the smallest number of rows, and then place the remaining tables in order of size
```




