SELECT
  gender,
  tenure,
  age_group,
  region,
  num_products,
  has_credit_card,
  CASE WHEN is_active = 1 THEN 'Yes' ELSE 'No' END as is_active,
  CASE
    WHEN credit_score <580 THEN "350-579"
    WHEN credit_score >579 AND credit_score <670 THEN "580-669"
    WHEN credit_score >669 AND credit_score <740 THEN "670-740"
    WHEN credit_score >739 AND credit_score <800 THEN "740-799"
    ELSE "800-850" END as credit_range,
  CASE
    WHEN balance < 1000 THEN '1,000 or less' 
    WHEN balance >999 AND balance <50001 THEN '1,000-50,000'
    WHEN balance >50000 AND balance <125000 THEN '50,001-125,000'
    ELSE 'More than 125,000' END as balance_range,
  CASE
    WHEN estimated_salary <10000 THEN '10,000 or less'
    WHEN estimated_salary >9999 AND estimated_salary <40001 THEN '10,000-40,000'
    WHEN estimated_salary >40000 AND estimated_salary <75001 THEN '40,001-75,000'
    WHEN estimated_salary >75000 AND estimated_salary <125001 THEN '75,001-125,000'
    ELSE 'More than 125,000' END as salary_range,
  COUNT(*) as total_customers,
  SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) as churned_customers,
  ROUND(SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2) as churned_rate
FROM
  `bank_data.clean_bank_data`
GROUP BY
  age_group, region, gender, tenure, num_products, has_credit_card, is_active, credit_range, balance_range, salary_range
ORDER BY
  churned_rate DESC;