
-- Top Countries (Overall)
CREATE VIEW top_countries AS
SELECT country, SUM(total_visitors) AS total_visitors
FROM tourism_data
GROUP BY country
ORDER BY total_visitors DESC;

-- Yearly Trend
CREATE VIEW yearly_trend AS
SELECT year, SUM(total_visitors) AS total_visitors
FROM tourism_data
GROUP BY year
ORDER BY year;


-- Country-Year Detail

CREATE VIEW country_year_analysis AS
SELECT 
    country,
    year,
    total_visitors,
    male,
    female,
    air,
    sea,
    rail,
    land,
    growth_rate
FROM tourism_data;

-- Gender Summary

CREATE VIEW gender_summary AS
SELECT 
    country,
    SUM(male) AS total_male,
    SUM(female) AS total_female
FROM tourism_data
GROUP BY country;

-- Travel Mode Summary

CREATE VIEW travel_mode_summary AS
SELECT 
    AVG(air) AS avg_air,
    AVG(sea) AS avg_sea,
    AVG(rail) AS avg_rail,
    AVG(land) AS avg_land
FROM tourism_data;

-- Growth Analysis

CREATE VIEW growth_analysis AS
SELECT 
    country,
    year,
    growth_rate
FROM tourism_data
WHERE growth_rate IS NOT NULL;

-- Top 5 Countries Per Year

CREATE VIEW top_countries_per_year AS
SELECT *
FROM (
    SELECT 
        country,
        year,
        total_visitors,
        RANK() OVER (PARTITION BY year ORDER BY total_visitors DESC) AS rank
    FROM tourism_data
) ranked
WHERE rank <= 5;


-- Monthly Trend
CREATE VIEW monthly_trend AS
SELECT year, month, ffa
FROM tourism_monthly;


-- Overall KPI View

CREATE VIEW overall_kpi AS
SELECT 
    SUM(total_visitors) AS total_visitors,
    AVG(growth_rate) AS avg_growth_rate,
    SUM(male) AS total_male,
    SUM(female) AS total_female
FROM tourism_data;

-- Country Contribution %
CREATE VIEW country_contribution AS
SELECT 
    country,
    SUM(total_visitors) AS total_visitors,
    ROUND(100.0 * SUM(total_visitors) / SUM(SUM(total_visitors)) OVER (), 2) AS percentage
FROM tourism_data
GROUP BY country
ORDER BY total_visitors DESC;