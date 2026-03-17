# World Cup Database ⚽

Relational database project built using **PostgreSQL** and **Bash scripting**.
This project automates the process of parsing World Cup game data from a CSV file, inserting it into a relational structure, and performing complex SQL queries to extract tournament statistics.

## 📌 Project Overview

The database is designed to manage and analyze historical World Cup match data using:
* **Automated Data Loading:** A Bash script (`insert_data.sh`) that reads `games.csv` and populates the database.
* **Relational Mapping:** Clean separation between teams and game results.
* **Data Integrity:** Implementation of `FOREIGN KEY` constraints, `UNIQUE` constraints, and `NOT NULL` requirements.
* **Advanced Querying:** A dedicated script (`queries.sh`) to generate reports using `JOIN`, `GROUP BY`, and `ORDER BY`.

## 🗂 Database Structure

### Tables
* **teams**: Stores unique names of participating countries.
* **games**: Stores details of every match (year, round, scores, and participants).

### Relationships
* A **team** can participate in many **games** (as either `winner` or `opponent`).
* Each **game** tracks two references to the `teams` table via Foreign Keys.

## 🛠 Technologies Used
* **PostgreSQL** (Relational Database)
* **Bash / Shell** (Automation & Scripting)
* **SQL** (Data Analysis)

## 💾 Database Setup & Usage

The repository includes the full environment to recreate the project:

### 1. Rebuild the Database
The file `worldcup.sql` contains the schema dump. To restore it, run:
```bash
psql -U postgres < worldcup.sql
