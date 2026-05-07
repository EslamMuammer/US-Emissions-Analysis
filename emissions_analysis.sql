SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE) / NULLIF(population, 0) AS emissions_per_capita
FROM emissions_data
ORDER BY emissions_per_capita DESC
LIMIT 20;


SELECT
    state_abbr,
    SUM(CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)) AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 20;


SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE) AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 20;

SELECT state_abbr, SUM("GHG emissions mtons CO2e") AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC;

SELECT county_name, state_abbr, "GHG emissions mtons CO2e"
FROM emissions_data
ORDER BY "GHG emissions mtons CO2e" DESC
LIMIT 10;

SELECT state_abbr, 
       SUM("GHG emissions mtons CO2e") / SUM(population) AS emissions_per_capita
FROM emissions_data
GROUP BY state_abbr
ORDER BY emissions_per_capita DESC;

SELECT doe_climate_zone, AVG("GHG emissions mtons CO2e") AS avg_emissions
FROM emissions_data
GROUP BY doe_climate_zone
ORDER BY avg_emissions DESC;

SELECT county_name, state_abbr, "GHG emissions mtons CO2e"
FROM emissions_data e1
WHERE "GHG emissions mtons CO2e" > (
    SELECT AVG("GHG emissions mtons CO2e")
    FROM emissions_data e2
    WHERE e1.state_abbr = e2.state_abbr
);

SELECT state_abbr, 
       SUM("vehicle miles traveled (miles)") AS total_vmt,
       SUM("GHG emissions mtons CO2e") AS total_ghg
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_ghg DESC
LIMIT 5;

SELECT county_name, "GHG emissions mtons CO2e",
CASE 
    WHEN "GHG emissions mtons CO2e" > 500000 THEN 'High'
    WHEN "GHG emissions mtons CO2e" BETWEEN 100000 AND 500000 THEN 'Medium'
    ELSE 'Low'
END AS emission_category
FROM emissions_data;

SELECT county_name, state_abbr, 
       ("GHG emissions mtons CO2e" / population) AS efficiency_score
FROM emissions_data
WHERE population > 100000
ORDER BY efficiency_score ASC
LIMIT 10;

SELECT population_cohort, AVG("GHG emissions mtons CO2e") AS avg_emissions
FROM emissions_data
GROUP BY population_cohort
ORDER BY population_cohort;

SELECT state_abbr, 
       SUM("consumption (MWh)") AS total_mwh,
       SUM("GHG emissions mtons CO2e") AS total_ghg
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_mwh DESC;

SELECT county_name, state_abbr, "GHG emissions mtons CO2e", employment
FROM emissions_data
WHERE employment < 5000 AND "GHG emissions mtons CO2e" > 200000
ORDER BY "GHG emissions mtons CO2e" DESC;

SELECT state_abbr, 
       SUM("GHG emissions mtons CO2e") * 100.0 / SUM(SUM("GHG emissions mtons CO2e")) OVER() AS percentage_of_total
FROM emissions_data
GROUP BY state_abbr
ORDER BY percentage_of_total DESC;

SELECT county_name, "consumption (gallons)", "GHG emissions mtons CO2e"
FROM emissions_data
ORDER BY "consumption (gallons)" DESC
LIMIT 10;

SELECT state_abbr, 
       SUM("expenditures in Millions") / SUM("GHG emissions mtons CO2e") AS cost_per_mton
FROM emissions_data
GROUP BY state_abbr
ORDER BY cost_per_mton DESC;

SELECT MIN("GHG emissions mtons CO2e") AS min_ghg,
       MAX("GHG emissions mtons CO2e") AS max_ghg,
       AVG("GHG emissions mtons CO2e") AS avg_ghg,
       STDDEV("GHG emissions mtons CO2e") AS std_dev_ghg
FROM emissions_data;

SELECT state_abbr, 
       SUM("GHG emissions mtons CO2e") / NULLIF(SUM(employment), 0) AS emissions_per_job
FROM emissions_data
GROUP BY state_abbr
ORDER BY emissions_per_job DESC;

SELECT state_abbr, county_name, "GHG emissions mtons CO2e",
       RANK() OVER(PARTITION BY state_abbr ORDER BY "GHG emissions mtons CO2e" DESC) as rank_in_state
FROM emissions_data
QUALIFY rank_in_state <= 3; 

SELECT county_name, state_abbr,
       "GHG emissions mtons CO2e" / NULLIF("occuped housing units", 0) AS emissions_per_housing_unit
FROM emissions_data
WHERE "occuped housing units" > 0
ORDER BY emissions_per_housing_unit DESC
LIMIT 10;

SELECT county_name, 
       "consumption (TcF)" AS gas_consumption, 
       "GHG emissions mtons CO2e" AS ghg_total
FROM emissions_data
WHERE "consumption (TcF)" IS NOT NULL
ORDER BY "consumption (TcF)" DESC
LIMIT 15;

SELECT county_name, state_abbr, 
       "vehicle miles traveled (miles/capita)" AS miles_per_person,
       "GHG emissions mtons CO2e"
FROM emissions_data
WHERE "vehicle miles traveled (miles/capita)" > (SELECT AVG("vehicle miles traveled (miles/capita)") FROM emissions_data)
ORDER BY "GHG emissions mtons CO2e" ASC
LIMIT 10;