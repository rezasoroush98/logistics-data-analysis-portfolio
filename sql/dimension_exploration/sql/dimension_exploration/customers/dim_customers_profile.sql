-- =============================================================================
-- dim_customers Exploration – Big Picture & Distribution
-- Purpose: Profile customer base (counts, revenue potential, types, credit terms)
-- Author: Reza Asgari Soroush
-- Date: March 2026
-- =============================================================================

-- 1. Overall KPIs + data quality summary
WITH summary AS (
    SELECT
        COUNT(*) AS total_customers,
        COUNT(DISTINCT customer_id) AS unique_ids,
        COUNT(*) FILTER (WHERE customer_name IS NULL OR customer_type IS NULL) AS missing_key_fields,
        COUNT(*) FILTER (WHERE annual_revenue_potential IS NULL) AS missing_revenue,
        COUNT(*) FILTER (WHERE credit_terms_days IS NULL) AS missing_credit_terms,
        COUNT(*) FILTER (WHERE annual_revenue_potential <= 0) AS zero_or_negative_revenue
    FROM dim_customers
)
SELECT
    'Total customers'                       AS measure_name,
    total_customers                         AS measure_value
FROM summary

UNION ALL SELECT 'Unique customer IDs', unique_ids FROM summary
UNION ALL SELECT 'Missing key fields (name/type)', missing_key_fields FROM summary
UNION ALL SELECT 'Missing revenue potential', missing_revenue FROM summary
UNION ALL SELECT 'Missing credit terms', missing_credit_terms FROM summary
UNION ALL SELECT 'Zero/negative revenue potential', zero_or_negative_revenue FROM summary

UNION ALL SELECT 'Average annual revenue potential ($)', 
    ROUND(AVG(annual_revenue_potential)::numeric, 2) FROM dim_customers

UNION ALL SELECT 'Median annual revenue potential ($)', 
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_revenue_potential)::numeric, 2) FROM dim_customers

UNION ALL SELECT 'Average credit terms (days)', 
    ROUND(AVG(credit_terms_days)::numeric, 2) FROM dim_customers;


-- 2. Distribution by customer_type, primary_freight_type, account_status (CUBE)
SELECT
    COALESCE(customer_type, 'All Types')             AS customer_type,
    COALESCE(primary_freight_type, 'All Freight')    AS primary_freight_type,
    COALESCE(account_status, 'All Statuses')         AS account_status,
    
    COUNT(*)                                         AS number_of_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total_customers,
    
    SUM(annual_revenue_potential)                    AS total_potential_revenue,
    ROUND(100.0 * SUM(annual_revenue_potential) / SUM(SUM(annual_revenue_potential)) OVER (), 2) 
                                                     AS pct_of_total_revenue,
    
    ROUND(AVG(annual_revenue_potential), 2)          AS avg_revenue_per_customer
FROM dim_customers
GROUP BY CUBE(customer_type, primary_freight_type, account_status)
ORDER BY 
    GROUPING(customer_type) DESC, 
    GROUPING(primary_freight_type) DESC, 
    GROUPING(account_status) DESC,
    total_potential_revenue DESC;


-- 3. Statistical summary of revenue potential & credit terms
SELECT
    'Annual Revenue Potential ($)' AS metric,
    ROUND(MIN(annual_revenue_potential)::numeric, 2) AS minimum,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_revenue_potential)::numeric, 2) AS median,
    ROUND(AVG(annual_revenue_potential)::numeric, 2) AS mean,
    ROUND(VAR_SAMP(annual_revenue_potential)::numeric, 2) AS variance,
    ROUND(STDDEV(annual_revenue_potential)::numeric, 2) AS std_deviation,
    ROUND(MAX(annual_revenue_potential)::numeric, 2) AS maximum
FROM dim_customers

UNION ALL

SELECT
    'Credit Terms (days)' AS metric,
    MIN(credit_terms_days) AS minimum,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY credit_terms_days) AS median,
    ROUND(AVG(credit_terms_days)::numeric, 2) AS mean,
    ROUND(VAR_SAMP(credit_terms_days)::numeric, 2) AS variance,
    ROUND(STDDEV(credit_terms_days)::numeric, 2) AS std_deviation,
    MAX(credit_terms_days) AS maximum
FROM dim_customers;
