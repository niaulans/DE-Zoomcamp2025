### Data Modelling 
| ETL | ELT |
| -- | -- |
| Slightly more stable and compliant data analysis | Faster and more flexible data analysis |
| Higher storage and compute costs | Lower cost and lower maintenance |

### Kimball's Dimensional Modelling
```
Objective: 
- Deliver data understandable to the business users.
- Deliver fast query performance

Approach:
- Prioritise user understandability and query performance over non redundant data (3NF)

Other approaches:
- Bill Inmon
- Data vault
```

### Elements of Dimensional Modelling 
```
Star schema:
  Fact tables:
  - Measurements, metrics, or facts
  - Corresponds to a business process
  - "verbs"

  Dimensions tables:
  - Corresponds to business entity
  - Provides context to a business process
  - "noun"
```

###  Architecture of Dimensional Modelling
```
Stage Area:
- Contains the raw data
- Not meant to be exposed to everyone

Processing Area:
- From raw data to data models
- Focuses in efficiency
- Ensuring standards

Presentation Area:
- Final presentation of the data
- Exposure to business stakeholder
```

### What is dbt
```
dbt = transformation workflow that allows anyone that knows SQL to deploy analytics code following software engineering best practices like modularity, portability, CI/CD, and documentation.

Develop -> Test and document -> Deployment (version control and CI/CD)
```

### How does dbt work?
```
Each model is:
- A .sql file
- Select statement, no DDL or DML
- A file that dbt will compile and run in our DWH
```

### How to use dbt?
```
dbt Core: Open source project that allows the data transformation
- Build and runs a dbt project (.sql and .yml files)
- Includes SQL compilation logic, macros, and database adapters
- Includes a CLI interface to run dbt commands locally
- Open source and free to use 

dbt Cloud: SaaS application to develop and manage dbt projects.
- Web-based IDE and cloud CLI to develop, run and test a dbt projects
- Managed environments
- Jobs orchestration
- Logging and alerting
- Integrated documentation
- Admin and metadata API
- Semantic layer
```

### How are we going to use dbt?
```
BigQuery:
- Development using cloud IDE
- No local installation of dbt core

PostgreSQL:
- Development using a local IDE of your choice
- Local installation of dbt core connecting to the Postgres database
- Running dbt models through the CLI
```

