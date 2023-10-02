--Data Exploration Project

select *
from PortfolioProject..SuperstoreCustomerDemographics

select *
from PortfolioProject..SuperstoreSales

--Number of products sold

select ProductName, count(ProductName) NumberOfProductSold 
from PortfolioProject..SuperstoreSales
group by ProductName
order by NumberOfProductSold desc

--Amount of Sales per Product

select ProductName, max(Sales) as AmountOfSales
from PortfolioProject..SuperstoreSales
group by ProductName
order by AmountOfSales desc

--Amount of Profit per product

select ProductName, max(Profit) as Profit
from PortfolioProject..SuperstoreSales
group by ProductName
order by Profit desc


select ProductName, max(Sales) as AmountOfSales, ShipMode
from PortfolioProject..SuperstoreSales
group by ProductName, ShipMode
order by AmountOfSales desc

--Total Sales and Total Profit from 2011 to 2014

select sum(sales) as TotalSales, sum(profit) as TotalProfit
from PortfolioProject..SuperstoreSales

--Sales, Profit, and Percent of Sales per month from 2011 to 2014

select year(OrderDate) as BusinessYear, month(OrderDate) as Month, 
sum(Sales) as TotalSales, sum(profit) as TotalProfit, 
(sum(profit)/sum(Sales))*100 as PercentOfSales
from PortfolioProject..SuperstoreSales sal
group by year(OrderDate), month(OrderDate)
order by BusinessYear, Month

--Sales, Profit, and Percent of Sales per year from 2011 to 2014

select year(OrderDate) as BusinessYear,
sum(Sales) as TotalSales, sum(profit) as TotalProfit,
(sum(profit)/sum(Sales))*100 as PercentOfSales
from PortfolioProject..SuperstoreSales sal
group by year(OrderDate)
order by BusinessYear

--Total Sales and Total Profit per State from 2011 to 2014

select State, Sum(Sales) TotalSales, Sum(Profit) TotalProfit, (sum(profit)/sum(Sales))*100 as PercentOfSales
from PortfolioProject..SuperstoreSales sal
join PortfolioProject..SuperstoreCustomerDemographics dem
	on sal.CustomerID = dem.CustomerID
group by OrderDate, state
Order by TotalSales desc, TotalProfit desc

--Total Sales and Total Profit per Segment from 2011 to 2014

select Segment,Category,[Sub-Category], Sum(Sales) TotalSales, Sum(Profit) TotalProfit
from PortfolioProject..SuperstoreSales sal
join PortfolioProject..SuperstoreCustomerDemographics dem
	on sal.CustomerID = dem.CustomerID
group by Segment,Category,[Sub-Category]
order by TotalSales desc, TotalProfit desc

--Rolling Total Sales per Day

with CTE_Sales as(
select State, OrderDate, Sum(Sales) TotalSales
from PortfolioProject..SuperstoreSales sal
join PortfolioProject..SuperstoreCustomerDemographics dem
	on sal.CustomerID = dem.CustomerID
group by State, OrderDate
)
select *, Sum(TotalSales) over (partition by OrderDate order by State,OrderDate) RollingTotalSalesPerDay
from CTE_Sales
Order by OrderDate

