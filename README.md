# SQL Data Engineering Projects

The following projects are a collection of SQL projects that I have worked on to practice my skills

> Click the project name below to view the tools I used to build these: 

## Projects

### [1. EDA](./1_EDA/) - Exploratory Data Analysis

![Project 1 Overview](./Resources/images/1_1_Project1_EDA.png)

SQL driven analysis of data engineering job market trends using advanced querying techniques.


**Skills**: Complex joins, aggregations, analytical functions, data quality validation

### [2_DW_Mart_Build/](./2_DW_Mart_Build/) - Data Pipeline - Data Warehouse & Mart
![Data Pipeline Architecture](./Resources/images/1_2_Project2_Data_Pipeline.png)
End-to-end ETL pipeline transforming raw CSV files into a star schema data warehouse and analytical data marts.

**Skills**: Dimensional modeling, ETL pipeline development, data mart architecture, production practices


> 💡 **Live Demo:** You can connect directly to this live dw_marts Data Warehouse on MotherDuck and query the production tables using the DuckDB snippet below:

```sql
-- Run this snippet to attach database
ATTACH 'md:_share/dw_marts_1489/4868df44-6f30-482b-9774-2a6887ba4841';