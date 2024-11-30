# COVID-19-Data-Analysis-and-Insights

## Overview
This project provides insights into the global and regional impact of COVID-19, focusing on cases, deaths, and vaccination trends. The analysis was conducted using SQL queries to explore and manipulate the dataset effectively.

## Features
- **Total Cases vs. Total Deaths:** Analyze the likelihood of death if infected with COVID-19.
- **Total Cases vs. Population:** Evaluate the percentage of the population infected by COVID-19.
- **Highest Infection Rates:** Identify countries with the highest infection rates relative to their population.
- **Global and Regional Death Counts:** Compare death counts across continents and countries.
- **Vaccination Analysis:** Analyze vaccination trends, including rolling totals and percentage of vaccinated populations.

## Tech Stack
- **SQL:** For data analysis and querying.
- **Databases:** Data sourced from `CovidDeaths` and `CovidVaccinations` tables.
- **Optional Visualization Tools:** Data prepared for integration with tools like Power BI, Tableau, or Python for visual insights.

## Analysis Highlights
1. Likelihood of death upon contracting COVID-19 (`DeathPercentage` metric).
2. Percentage of population infected by COVID-19 (`PopulationPercentageInfected` metric).
3. Ranking of countries and continents by infection and death rates.
4. Vaccination progress globally and regionally using rolling vaccination metrics.

## Key Components
### Queries
- Advanced SQL techniques including:
  - Common Table Expressions (CTEs)
  - Window Functions (e.g., rolling totals)
  - Temporary Tables
  - Joins and aggregations
  - Views for data persistence

### Database Tables
- **CovidDeaths:** Contains data on COVID-19 cases, deaths, and population for each location and date.
- **CovidVaccinations:** Contains data on daily new vaccinations for each location and date.

## How to Use
1. **Run Queries:** Execute the SQL queries in a SQL-compatible environment (e.g., MySQL, SQL Server, PostgreSQL).
2. **Dataset:** Ensure you have access to datasets `CovidDeaths` and `CovidVaccinations`.
3. **Visualize:** Use the generated views or results for visualization using tools like Tableau, Power BI, or Excel.

## Future Improvements
- Automate the analysis pipeline.
- Integrate with Python for advanced visualizations and dashboards.
- Explore machine learning models for trend prediction.

## Acknowledgements
Data sourced from publicly available COVID-19 datasets.
https://ourworldindata.org/covid-deaths
