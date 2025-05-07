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

### Anatomy of a dbt model
```sql
{{
  config(materialized='table')
}}

SELECT * 
FROM staging.source_table
WHERE records_state = 'ACTIVE'
```

```sql
-- Compiled code
CREATE TABLE my_schema.my_model AS (
  SELECT *
  FROM staging.source_table
  WHERE record_state = 'ACTIVE'
)
```

```
Several materialization strategies:
- Table = physical representations of data that are created and stored in the database
- View = virtual tables created by dbt that can be required like regular tables
- Incremental= powerful feature of dbt that allow for efficient updates to existing tables, reducing the need for full data refreshes
- Ephemeral = temporary and exist only for the duration of a single dbt run
```

### Macros
```
- Use control structures (if statements and for loops) in SQL
- Use environtment variables in your dbt project for production deployments
- Operate on the results of one query to generate another query
- Abstract snippets of SQL into reusable macros - these are analogous to functions in most programming languages.
```

### Packages
```
- Like libraries in other programming languages
- Standalone dbt projects, with models and macros that tackle a specific problem area
- By adding a package to your project, the package's models and acros will become part of your own prroject
- Imported in the packages.yml file and imported by running "dbt deps"
- A list of useful packages can be find in dbt package hub
```

### Variables
```
- Variables are useful for defining values that should be used across the project
- With a macro, dbt allows us to pprovide data to models for compilation
- To use a variable we use tha {{ var('...') }} function
- Variables can defined in two ways:
  - In the dbt_project.yml file 
    vars:
    payment_type_values: [1, 2, 3, 4, 5, 6]
  - On the command line
    {% if var('is_test_run', default=true) %}

    limit 100

    {% endif %}
```

### Tests
```
- Assumptions that we make about our data
- Tests in dbt are essentially a select sql query
- These assumptions get compiled to sql that returns the amount of failing records
- Tests are defined on a column in the .yml file
- dbt provides basic tests to check if the column values are:
  - unique
  - not null
  - accepted values
  - a foreign key to another table
- You can create your custom tests as queries
```

### Documentation
```
- dbt provides a way to generate documentation for your dbt project and render it as a website
- The documentation for your prpject includes:
  - Information about your project:
    - Model code 
    - Model dependencies
    - Cources
    - Auto generated DAG from the ref and source macros
    - Descriptions and tests
  - Information about your data warehouse 
    - Column names and data types
    - Tables stats like size and rows
- dbt docs can also be hosted in dbt cloud

dbt docs generate 
```

### Deployment
```
- Process of running the models we created in our development in a production environment
- Development and later deployment allows us to continue, building models and testing them without affecting aour production environment
- A deployment environment will normally have a different schema in our data warehouse and ideally a different user
- A development - deployment workflow will be something like:
  - Develop in a user branch
  - Open a PR to merge into the main branch
  - Merge the branch to the main branch
  - Run the neew models in the production environment using the main branch
  - Schedule the models
```

### Running a dbt project in production
```
- dbt cloud includes a scheduler where to create jobs to run in production
- A single job can run multiple commands
- Jobs can be triggered manually or on schedule
- Each job will keep a log of the runs over time
- Each run will also have the logs for each comman
- A job could also generate documentation, that could be viewed under the run information
- If dbt source freshness was run, the results can also be viewed at the end of a job
```

### What is Continuous Integration (CI) ?
```
- CI is the practice of regularly merge development branches into a central repository, after which automated builds and tests are run
- The goal is to reduce bugs to production code and maintain a more stable project
- dbt allows us to enable CI on pull requests
- Enabled via webhooks from GitHub or GitLab
- When a PR is ready to be merged, a webhooks is recevived in dbt Cloud that will enqueue a new run of the specified job
- The run of the CI job will be againts a temporary schema
- No PR will be able to be merged unless the run has been completed successfully
```





