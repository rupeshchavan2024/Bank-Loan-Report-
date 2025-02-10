SELECT * FROM bank_loan.bank;
USE bank_loan;
-- 1.Total Loan Applications
SELECT COUNT(id) AS TotaL_Loan_Application FROM bank;

-- 2.	Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank;

-- 3. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Recieved FROM bank;

-- 4.Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Avg_Interest_Rate FROM bank;

-- 5.Average Debt-to-Income Ratio (DTI)
SELECT ROUND(AVG(dti)*100,2) AS Avg_DTI FROM bank;
 



-- GOOD LOAN VS BAD LOAN

-- GOOD LOAN 
-- 1.	Good Loan Application Percentage
SELECT 
	(COUNT(CASE 
		WHEN loan_status ='Fully Paid' OR loan_status ='Current' THEN id END)
        *100) /
			COUNT(ID) AS good_loan_percentage 
FROM bank;

-- 2.	Good Loan Applications
SELECT COUNT(loan_status) AS Good_Loan_Applications FROM bank
WHERE loan_status IN('Fully Paid','Current') ;

-- 3.	Good Loan Funded Amount
SELECT SUM(loan_amount) AS 'Good Loan Funded Amount'FROM bank
WHERE loan_status = 'Fully Paid'OR loan_status='Current';

-- 4.Good Loan Total Received Amount
SELECT SUM(total_payment) AS 'Good Loan Total Received Amount'
FROM bank WHERE loan_status= 'Fully Paid' OR loan_status= 'Current';


-- BAD LOAN
-- 1.	Bad Loan Application Percentage
SELECT 
COUNT(loan_status)*100/(SELECT COUNT(*)  FROM bank) AS bad_loan_percentage FROM bank
WHERE loan_status = 'Charged Off';

-- 2.Bad Loan Applications
SELECT COUNT(loan_status) AS Bad_Loan FROM bank
WHERE loan_status = 'Charged Off';

-- 3.Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank
WHERE loan_status='Charged Off';

-- 4.	Bad Loan Total Received Amount
SELECT SUM(total_payment) Bad_Loan_Recieved_Amount FROM bank
WHERE loan_status='Charged Off';


-- Loan Status Grid View
SELECT 
	loan_status,COUNT(id) AS Toatal_Loan_Application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount,
	ROUND(AVG(int_rate*100),2) AS Avg_Int_Rate,
	ROUND(AVG(dti*100),2) AS Debt_To_Income_Ratio
FROM bank
GROUP BY loan_status;

-- Month-to-Date (MTD) Funded Amount,MTD Amount Received
SELECT 
	loan_status,
    SUM(loan_amount) AS MTD_Funded_Amount,
	SUM(total_payment) AS MTD_Amount_Received
FROM bank
WHERE issue_date IS NOT NULL AND MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')) = 12
GROUP BY loan_status;

-- Overview
-- Monthly Trends by Issue Date 
SELECT 
	MONTHNAME(STR_TO_DATE(issue_date,'%d-%m-%Y')) AS Month,
    COUNT(id) AS `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank
GROUP BY MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')),	MONTHNAME(STR_TO_DATE(issue_date,'%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(issue_date,'%d-%m-%Y')) ASC;

-- Regional Analysis by State 
SELECT 
	address_state,
	COUNT(id) AS `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank
GROUP BY address_state;

-- Loan Term Analysis 
SELECT 
	term,
	COUNT(id) AS  `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank
GROUP BY term;

-- Employee Length Analysis 
SELECT 
	emp_length,
    COUNT(id) AS `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank
GROUP BY emp_length;

-- Loan Purpose Breakdown 
SELECT 
	purpose,
    COUNT(id) AS `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank 
GROUP BY purpose;

-- Home Ownership Analysis 
SELECT 
	home_ownership,
    COUNT(id) AS `Total Loan Applications`,
    SUM(loan_amount) AS `Total Funded Amount`,
    SUM(total_payment) AS `Total Amount Received`
FROM bank 
GROUP BY home_ownership