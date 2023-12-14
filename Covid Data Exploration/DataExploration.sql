Select * 
From public."CovidDeaths"
where continent is not null
order by 3,4;

Select location ,date, total_cases, new_cases, total_deaths, population
From public."CovidDeaths"
where continent is not null
order by 1,2;

-- Total Cases vs Total Deaths
Select location ,date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as "DeathsPerCases"
From public."CovidDeaths"
where location like '%State%'
order by 1,2;

-- Total Cases vs Population
Select location ,date, population, total_cases, (total_cases/population)*100 as "CasesperPopulation"
From public."CovidDeaths"
-- where location like '%State%'
order by 1,2;

--Infection rate vs Population
Select location , population, max(total_cases) as "HighestInfectionCount", (max(total_cases)/population)*100 as "PercentPopulationInfected"
From public."CovidDeaths"
-- where location like '%State%'
group by population, location
order by "PercentPopulationInfected" desc;

-- Deaths vs Population
Select location , max(total_deaths) as "TotalDeathCount"
From public."CovidDeaths"
where continent is not null
group by  location
order by "TotalDeathCount" desc;

-- By Continent
Select location , max(total_deaths) as "TotalDeathCount"
From public."CovidDeaths"
where continent is null
group by  location
order by "TotalDeathCount" desc;

Select continent , max(total_deaths) as "TotalDeathCount"
From public."CovidDeaths"
where continent is not null
group by  continent
order by "TotalDeathCount" desc;


--Global Numbers
Select date , sum(new_cases) as "Total_cases", sum(new_deaths) as "Total_deaths", (sum(new_deaths)/nullif(sum(new_cases),0))*100 as "DeathsPerCases"
From public."CovidDeaths"
where continent is not null
group by date
order by 1,2;

-- Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population,  vac.new_vaccinations,
	sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location, dea.date) as "RollingTotalVaccinations"
From public."CovidDeaths" dea
join public."CovidVaccinations" vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;


-- Use CTE

with PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingTotalVaccinations )
as(
Select dea.continent, dea.location, dea.date, dea.population,  vac.new_vaccinations,
	sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location, dea.date) as "RollingTotalVaccinations"
From public."CovidDeaths" dea
join public."CovidVaccinations" vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3
)

Select *, (RollingTotalVaccinations/population)*100 as "PercentVaccinated"
from PopvsVac;


-- Use Temp Table
drop table if exists PercentPopulationVaccinated;
create table PercentPopulationVaccinated(
	Continent text, 
	location text, 
	Date date, 
	Population numeric, 
	New_vaccinations numeric,
	RollingTotalVaccinations numeric
);

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population,  vac.new_vaccinations,
	sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location, dea.date) as "RollingTotalVaccinations"
	
From public."CovidDeaths" dea
join public."CovidVaccinations" vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;

Select *, (RollingTotalVaccinations/population)*100 as "PercentVaccinated"
From PercentPopulationVaccinated;

-- Create View to store date for later visualizations 
drop view if exists PercentPopulationVaccinatedView;
create view PercentPopulationVaccinatedView as
Select dea.continent, dea.location, dea.date, dea.population,  vac.new_vaccinations,
	sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location, dea.date) as "RollingTotalVaccinations"
	
From public."CovidDeaths" dea
join public."CovidVaccinations" vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;
--order by 2,3;

select *
from PercentPopulationVaccinatedView;



-- For tableau vizualization

--1
Select  sum(new_cases) as "Total_cases", sum(new_deaths) as "Total_deaths", (sum(new_deaths)/nullif(sum(new_cases),0))*100 as "DeathsPerCases"
From public."CovidDeaths"
where continent is not null
-- group by date
order by 1,2;


--2 

Select location , sum(new_deaths) as "TotalDeathCount"
From public."CovidDeaths"
where continent is null and location not in ('World', 'European Union', 'International')
group by  location
order by "TotalDeathCount" desc;

--3
--Infection rate vs Population
Select location , population, max(total_cases) as "HighestInfectionCount", (max(total_cases)/population)*100 as "PercentPopulationInfected"
From public."CovidDeaths"
-- where location like '%State%'
group by population, location
order by "PercentPopulationInfected" desc;

--4 
Select location , population, date , max(total_cases) as "HighestInfectionCount", (max(total_cases)/population)*100 as "PercentPopulationInfected"
From public."CovidDeaths"
-- where location like '%State%'
group by location, Population,  date
order by "PercentPopulationInfected" desc;