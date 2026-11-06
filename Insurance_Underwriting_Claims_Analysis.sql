
-- PROJECT: Insurance Underwriting & Claims Analysis Using SQL
-- Database: CLAIMS
-- Table: insurance_data
-- Dataset: 20 dummy/sample records from Kaggle

USE CLAIMS;

-- Q1. Which gender has the highest number of claims?
SELECT gender, COUNT(claim_id) AS total_claims
FROM insurance_data
WHERE claim_id IS NOT NULL
GROUP BY gender
ORDER BY total_claims DESC;

-- Q2. Which two countries have the lowest number of claims?
SELECT address_country, COUNT(claim_id) AS total_claims
FROM insurance_data
WHERE claim_id IS NOT NULL
GROUP BY address_country
ORDER BY total_claims ASC
LIMIT 2;

-- Q3. Which city has the highest number of claims?
SELECT address_city, COUNT(claim_id) AS total_claims
FROM insurance_data
WHERE claim_id IS NOT NULL
GROUP BY address_city
ORDER BY total_claims DESC
LIMIT 1;

-- Q4. Which policy type is purchased most frequently?
SELECT policy_type, COUNT(policy_id) AS total_policies
FROM insurance_data
WHERE policy_id IS NOT NULL
GROUP BY policy_type
ORDER BY total_policies DESC
LIMIT 1;

-- Q5. What is the distribution of policies by status?
SELECT policy_status, COUNT(policy_id) AS total_policies
FROM insurance_data
WHERE policy_id IS NOT NULL
GROUP BY policy_status
ORDER BY total_policies DESC;

-- Q6. What is the percentage distribution of claims by status?
SELECT
    claim_status,
    COUNT(claim_id) AS total_claims,
    ROUND(
        COUNT(claim_id) * 100.0 /
        (SELECT COUNT(claim_id)
         FROM insurance_data
         WHERE claim_id IS NOT NULL), 2
    ) AS percentage
FROM insurance_data
WHERE claim_id IS NOT NULL
GROUP BY claim_status
ORDER BY percentage DESC;

-- Q7. How are applications distributed across risk categories?
SELECT
    risk_category,
    COUNT(applicant_id) AS total_applications,
    ROUND(
        COUNT(applicant_id) * 100.0 /
        (SELECT COUNT(applicant_id) FROM insurance_data), 2
    ) AS percentage
FROM insurance_data
GROUP BY risk_category
ORDER BY total_applications DESC;

-- Q8. How many claims has each customer submitted?
SELECT applicant_id, COUNT(claim_id) AS total_claims
FROM insurance_data
WHERE claim_id IS NOT NULL
GROUP BY applicant_id
ORDER BY total_claims DESC;

-- Q9. How many applications are approved, pending or under review?
SELECT
    underwriting_decision,
    COUNT(applicant_id) AS total_applications
FROM insurance_data
GROUP BY underwriting_decision
ORDER BY total_applications DESC;

-- Q10. What is the average claim processing time?
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(claim_resolution_date, '%Y-%m-%d'),
                STR_TO_DATE(claim_filing_date, '%Y-%m-%d')
            )
        ), 2
    ) AS average_processing_days
FROM insurance_data
WHERE claim_filing_date IS NOT NULL
AND claim_resolution_date IS NOT NULL;

-- Q11. How many policies are there under each policy type?
SELECT policy_type, COUNT(policy_id) AS total_policies
FROM insurance_data
WHERE policy_id IS NOT NULL
GROUP BY policy_type
ORDER BY total_policies DESC;

-- Q12. How many customers have more than one previous claim?
SELECT
    COUNT(*) AS customers_with_more_than_one_previous_claim
FROM insurance_data
WHERE previous_claim_count > 1;
