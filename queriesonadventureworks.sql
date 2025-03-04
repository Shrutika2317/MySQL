
-- Top 5 products
select Product_Name, sum(SalesAmount) as TotalSales from adventuresales
group by Product_Name order by TotalSales desc limit 5;

select concat(round(sum(SalesAmount)/1000000,1),'M') as TotalSales from adventuresales;  -- Total sales
select concat(round(sum(Profit)/1000000,1),'M') as TotalProfit from adventuresales;     -- Total profit
select concat(round(sum(TotalProductCost)/1000000,1),'M') as TotalProductCost from adventuresales;     -- Total product cost
select count(OrderQuantity) as Total_Orders from adventuresales;   -- Total orders

-- Monthwise sales
select Month_Name, concat(round(sum(SalesAmount)/1000000,1),'M') as TotalSales from adventuresales
group by Month_Name;

-- yearwise sales
select Year, concat(round(sum(SalesAmount)/1000000,2),'M') from adventuresales group by Year;

-- production cost and sales by year
select Year, concat(round(sum(SalesAmount)/1000000,2),'M') as TotalSales, concat(round(sum(TotalProductCost)/1000000,3),'M') as TotalProdCost from adventuresales group by Year;

-- Region sales
select t.SalesTerritoryRegion as Region, concat(round(sum(a.SalesAmount)/1000000,3),'M') as TotalSales from salesterritory t
left join adventuresales a on t.SalesTerritoryKey = a.SalesTerritoryKey
group by Region;

-- Top 5 Customers
select CustomerFullName, round(sum(SalesAmount),2) as Total_Sales from adventuresales group by CustomerFullName order by Total_Sales desc limit 5;

-- category orders
select p.ProductCategoryName as Category, count(a.OrderQuantity) as no_of_orders from products p
left join adventuresales a on p.ProductKey = a.ProductKey
group by Category
having count(a.OrderQuantity) > 0;

-- percentage of Category oders
select 
    p.ProductCategoryName as Category, 
    SUM(a.OrderQuantity) as total_orders,
    ROUND((SUM(a.OrderQuantity) * 100.0) / (select SUM(OrderQuantity) from adventuresales), 2) as order_percentage
from products p
left join adventuresales a on p.ProductKey = a.ProductKey
group by Category
having total_orders > 0
order by order_percentage desc;


