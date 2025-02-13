# Checking for NULL values

SELECT 
  COUNT(*) AS null_count
FROM `bank_data.bank_info`
WHERE NULL;

------------------------------------------------
# Checking for duplicate data

SELECT 
  CustomerId,
  COUNT(*)
FROM `bank_data.bank_info`
GROUP BY
  CustomerId
HAVING COUNT(*) >1;

------------------------------------------------
# Checking for key outliers

SELECT *
FROM `bank_data.bank_info`
WHERE
  CreditScore <350 or CreditScore >850;

DELETE FROM `bank_data.bank_info`
WHERE Balance <0;

DELETE FROM `bank_data.bank_info`
WHERE EstimatedSalary <0;

------------------------------------------------
# Creating age buckets

ALTER TABLE `bank_data.bank_info`
ADD COLUMN age_group STRING;

UPDATE `bank_data.bank_info`
SET age_group = CASE
  WHEN Age BETWEEN 18 and 25 THEN '18-25'
  WHEN Age BETWEEN 25 and 34 THEN '25-34'
  WHEN Age BETWEEN 35 and 54 THEN '35-54'
  ELSE '55+'
END
WHERE 
  Age is NOT NULL;

------------------------------------------------
# Standardizing column names / Dropping unnecessary columns (surname, row_number)

SELECT 
    CustomerId AS customer_id,
    CreditScore AS credit_score,
    Geography AS region,
    Gender AS gender,
    age_group,
    Tenure AS tenure,
    Balance AS balance,
    NumOfProducts AS num_products,
    HasCrCard AS has_credit_card,
    IsActiveMember AS is_active,
    EstimatedSalary AS estimated_salary,
    Exited AS churned
FROM `bank_data.bank_info`;


