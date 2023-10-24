## Overview 
The objective of this project is to create an ETL-Query pipeline using Databricks to streamline data extraction, transformation, loading, and querying. This involves packaging the project as a command-line tool and interfacing with a SQL Database on Azure Databricks. By loading data into the Databricks SQL warehouse, it enables the execution of complex queries. The pipeline offers users the flexibility to execute each ETL phase independently or the entire process with a single command. The project centers on establishing a cloud-based database and executing data queries through Azure Databricks, encompassing two main components: the development of a data pipeline and the creation of queries, including data joins and aggregations. 

* A [user guide](https://github.com/nogibjj/IDS706_Mini_PJT7/blob/main/user_guide.md) is provided for reference.

* Dataset used: [Hate-crimes](https://github.com/fivethirtyeight/data/blob/master/hate-crimes/hate_crimes.csv)

The dataset is organized into two separate sets by dividing a specific column. This partitioning is done with the intention of merging these datasets together at a later stage for analysis and processing. 

## Workflow Steps
1. Set Up Codespaces and Azure Databricks Configuration
   * Establish a secure foundation for working with Databricks by setting up Codespaces environment and configuring Azure Databricks.
   * Create a database warehouse, generate authentication tokens, and ensure all necessary libraries are installed.
3. Prepare the development environment and packaging the Python Script
   * Package Python script for distribution, making it accessible and user-friendly.
   * Create a command-line interface for execution and specify dependencies 
5. ETL-Query and Automated Testing
   * Organize code for Extract, Transform, Load (ETL) processes and enhance user guidance.
   * Implement automated testing to ensure the correctness and reliability of ETL processes. 
7. Streamlining and Monitoring
   * Streamline workflow by automating tasks with a Makefile and GitHub Actions, making it easy to run ETL processes.
9. CI/CD Setup with GitHub Actions 
    * Set up Continuous Integration and Continuous Deployment (CI/CD) using GitHub Actions, automating testing and code deployment. 

## Query Explanation 
```sql
SELECT a.state, 
        AVG(a.median_household_income) AS average_median_household_income,
        AVG(a.share_unemployed_seasonal) AS average_share_unemployed_seasonal,
        a.share_population_in_metro_areas,
        b.gini_index
    FROM default.hate_crimes1DB AS a
    JOIN default.hate_crimes2DB AS b ON a.id = b.id
    GROUP BY a.state, a.share_population_in_metro_areas, b.gini_index
    ORDER BY b.gini_index
    LIMIT 5
```
This SQL query retrieves data from two tables (hate_crimes1 and hate_crimes2) and performs an inner join based on the id column. It then groups the data by state, share_population_in_metro_areas, and gini_index. Within each group, it calculates the average of median_household_income and share_unemployed_seasonal. The results are ordered by gini_index in ascending order and limited to the top 5 rows. This query is useful for analyzing and summarizing economic and demographic data based on the Gini index. 

## Result of Query 
![image](https://github.com/nogibjj/IDS706_Mini_PJT6/assets/141780408/a0d6eb74-1e18-4d91-a506-a1e8031ed34a)

## Test Result
![image](https://github.com/nogibjj/IDS706_Mini_PJT7/assets/141780408/1f71e465-cd8a-4d31-8b2b-eb6813c1a7b7)

