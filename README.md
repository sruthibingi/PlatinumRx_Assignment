# PlatinumRx_Assignment
Assignment for Data Analyst Skills


## 📌 Overview

This assignment demonstrates core data analysis skills including SQL querying, spreadsheet data manipulation, and Python programming. The project is divided into three main sections: Hotel & Clinic database analysis, Excel-based ticket analysis, and Python scripting tasks.

---

## 🗄️ SQL Approach

### Hotel Management System

* Created relational tables: `users`, `bookings`, `booking_commercials`, and `items`.
* Used **JOIN operations** to combine booking and billing data.
* Applied **aggregate functions (SUM, MAX)** for billing calculations.
* Used **GROUP BY and HAVING** to filter aggregated results.
* Implemented **window functions (RANK, DENSE_RANK)** to determine:

  * Most/least ordered items
  * Second highest billing customers

### Clinic Management System

* Designed tables: `clinics`, `customer`, `clinic_sales`, and `expenses`.
* Calculated revenue using **SUM(amount)** grouped by sales channel.
* Identified top customers using **ORDER BY + LIMIT**.
* Computed **profit = revenue - expenses** using subqueries.
* Used **window functions** for ranking clinics based on profitability.

---

## 📊 Spreadsheet Approach

* Created two sheets: `ticket` and `feedbacks`.
* Used **INDEX + MATCH (alternative to VLOOKUP)** to populate `ticket_created_at`.
* Extracted date and hour using Excel functions:

  * `INT()` for date comparison
  * `HOUR()` for time comparison
* Added helper columns to identify:

  * Tickets created and closed on the same day
  * Tickets created and closed in the same hour
* Used **COUNTIF / Pivot Table** to get outlet-wise counts.

---

## 🐍 Python Approach

### 1. Time Conversion

* Used integer division (`//`) to calculate hours.
* Used modulo (`%`) to calculate remaining minutes.
* Displayed output in human-readable format.

### 2. Remove Duplicates from String

* Iterated through each character using a loop.
* Maintained a result string to store unique characters.
* Added characters only if not already present.

---

## ⚙️ Tools Used

* SQL: MySQL (tested using DB Fiddle)
* Spreadsheet: Microsoft Excel / Google Sheets
* Programming: Python 3 (VS Code)

---

## ⚠️ Assumptions

* Sample data provided is limited; queries are written to handle general cases.
* All timestamps are assumed to be in the same timezone.
* For monthly analysis, the year considered is **2021**.
* In profitability calculations:

  * Revenue and expenses are aggregated at the same level (month/clinic).
* Excel data does not contain missing or inconsistent `cms_id` values.
* Python scripts assume valid user input (integer for minutes, string for duplicate removal).

---

## ✅ Conclusion

This assignment demonstrates the ability to:

* Design and query relational databases
* Perform data analysis using spreadsheets
* Implement logic-based solutions in Python

All components were tested and verified successfully.
