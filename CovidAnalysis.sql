-- select * 
-- from CovidVaccinations 
-- order by 3, 4

select * 
from CovidDeaths 
WHERE continent is not null
order by 3, 4

-- Select data that we are going to be using 

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent is not null
ORDER BY 1, 2 

-- Loking at the total Cases vs Total Deaths 
-- Shows likelihood of dying if we contract covid in our country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%india%' and continent is not null
ORDER BY 1, 2 

-- Looking at the Total Cases vs Population 
--Shows what percentage of population get Covid
SELECT location, date, population,total_cases, (total_cases/population)*100 as PopulationPercentageInfected
FROM CovidDeaths
WHERE location like '%india%' and continent is not null
ORDER BY 1, 2 

-- Looking at Countries with Hiest Infection rate compared to population 
SELECT location,population,max(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PopulationPercentageInfected
FROM CovidDeaths
WHERE continent is not null
GROUP BY Population, location
ORDER BY 4 desc 

-- Showing countries with the Highest Death Count  
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY location 
ORDER BY TotalDeathCount desc 

-- Showing continents with highest death Counts
SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount desc 

-- SELECT location, MAX(total_deaths) as TotalDeathCount
-- FROM CovidDeaths
-- WHERE continent is null
-- GROUP BY location 
-- ORDER BY TotalDeathCount desc 


-- Showing continents with highest death Counts per population 
SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount desc 

--GLOBAL NUMBERS 

SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths) / SUM(new_cases))* 100 as DeathPercentage
FROM CovidDeaths
-- WHERE location like '%india%'  
WHERE continent is not null
-- GROUP BY date
ORDER BY 1, 2 

-- LOOKING AT TOTAL POPULATION VS VACCINATION

SELECT dea.continent, dea.location, CONVERT(DATETIME, dea.date), dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated, 
--(RollingPeopleVaccinated/dea.population)*1000
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location and dea.date = vac.date
WHERE dea.continent is not NULL 
ORDER BY 2, 3


-- USE CTE 

WITH PopvsVac (continent, location, date, Population, new_vaccinations, RollingPeopleVaccinated)
AS  
(
SELECT dea.continent, dea.location, CONVERT(DATETIME, dea.date), dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*1000
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location and dea.date = vac.date
WHERE dea.continent is not NULL 
--ORDER BY 2, 3
)
SELECT *, (RollingPeopleVaccinated/CONVERT(float, Population))*100
FROM PopvsVac

-- TEMP TABLE 

DROP TABLE IF EXISTS #PercentPopulationVaccinated

CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255), 
LOCATION nvarchar(255), 
Date datetime, 
Population numeric, 
New_vaccinations numeric, 
RollingPeopleVaccinated numeric 
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, CONVERT(DATETIME, dea.date), dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*1000
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location and dea.date = vac.date
-- WHERE dea.continent is not NULL 
--ORDER BY 2, 3

SELECT *, (RollingPeopleVaccinated/Population)* 100 
FROM #PercentPopulationVaccinated

-- CREATING VIEW FOR TO STORE DATA FOR LATER VISUALIZATION 

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM 
    CovidDeaths dea 
JOIN 
    CovidVaccinations vac 
ON 
    dea.location = vac.location AND dea.date = vac.date
WHERE 
    dea.continent IS NOT NULL;



-- THIS IS THE VIEW
SELECT * FROM 
PercentPopulationVaccinated


