USE Bankloan;
-- BANK LOAN REPORT QUERY DOCUMENT

--Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan;
 
--MTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan
WHERE MONTH(issue_date) = 12;
 
--PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan
WHERE MONTH(issue_date) = 11;
 

--Total Funded Amount
 
SELECT CONCAT('£', FORMAT(SUM(loan_amount), '#,##0')) AS Total_Funded_Amount FROM bank_loan;

--MTD Total Funded Amount
SELECT CONCAT('£', FORMAT(SUM(loan_amount), '#,##0')) AS Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 12;
 
--PMTD Total Funded Amount
SELECT CONCAT('£', FORMAT(SUM(loan_amount), '#,##0')) AS Total_Funded_Amount FROM bank_loan
WHERE MONTH(issue_date) = 11;
 

--Total Amount Received
SELECT CONCAT('£', FORMAT(SUM(total_payment), '#,##0')) AS Total_Amount_Collected FROM bank_loan;
 
--MTD Total Amount Received
SELECT CONCAT('£', FORMAT(SUM(total_payment), '#,##0')) AS Total_Amount_Collected FROM bank_loan
WHERE MONTH(issue_date) = 12;
 
--PMTD Total Amount Received
SELECT CONCAT('£', FORMAT(SUM(total_payment), '#,##0')) AS Total_Amount_Collected FROM bank_loan
WHERE MONTH(issue_date) = 11;
 

--Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Avg_Int_Rate FROM bank_loan;
 
--MTD Average Interest
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Avg_Int_Rate FROM bank_loan
WHERE MONTH(issue_date) = 12;
 
--PMTD Average Interest
SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Avg_Int_Rate FROM bank_loan
WHERE MONTH(issue_date) = 11;
 

--Avg DTI
SELECT ROUND(AVG(dti)*100,2) AS Avg_DTI FROM bank_loan;
 
--MTD Avg DTI
SELECT ROUND(AVG(dti)*100,2) AS MTD_Avg_DTI FROM bank_loan
WHERE MONTH(issue_date) = 12;
 
--PMTD Avg DTI
SELECT ROUND(AVG(dti)*100,2) AS PMTD_Avg_DTI FROM bank_loan
WHERE MONTH(issue_date) = 11;
 

--GOOD LOAN ISSUED
--Good Loan Percentage
SELECT
    CONCAT(CAST(ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id),2) AS DECIMAL(10,2)),' %') AS Good_Loan_Percentage
FROM bank_loan;
 
--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 
--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 

--Good Loan Amount Received
SELECT CONCAT('£', FORMAT(SUM(total_payment), '#,##0')) AS Good_Loan_amount_received FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
 

--BAD LOAN ISSUED
--Bad Loan Percentage
SELECT
    CONCAT(CAST(ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id),2) AS DECIMAL(10,2)), ' %') AS Bad_Loan_Percentage
FROM bank_loan;
 
--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan
WHERE loan_status = 'Charged Off'
 
--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan
WHERE loan_status = 'Charged Off'
 
--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan
WHERE loan_status = 'Charged Off'
 

--LOAN STATUS
SELECT
     loan_status,
     COUNT(id) AS LoanCount,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount,
     AVG(int_rate * 100) AS Interest_Rate,
     AVG(dti * 100) AS DTI
FROM
   bank_loan
GROUP BY
   loan_status
 
--Loan Status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status
 


--B.BANK LOAN REPORT | OVERVIEW

--MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)
 

--STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY address_state
ORDER BY address_state
 

--TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY term
ORDER BY term
 

--EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY emp_length
ORDER BY emp_length
 
--PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY purpose
ORDER BY purpose
 

--HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY home_ownership
ORDER BY home_ownership
 

--Purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
