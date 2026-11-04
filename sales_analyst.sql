SELECT * FROM dbo.combined_data

--Adding “Profit” column
ALTER TABLE dbo.combined_data 
ADD Profit Numeric(10,2)

UPDATE dbo.combined_data
SET Profit = Total_Amount - (Cost_Price + Quantity_Purchased)

--Sales Revenue & Profit by Country (Combined Query)
SELECT 
    Country, 
    Total_revenue = SUM(Total_Amount),
    Total_Profit = SUM(Profit)
FROM dbo.combined_data
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Country
ORDER BY Total_Revenue DESC

--Top 5 Best-Selling Products (During the Period)
SELECT TOP 5
    Product_Name, 
    Total_Units_Sold = SUM(Quantity_Purchased)
FROM dbo.combined_data
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Product_Name
ORDER BY SUM(Quantity_Purchased) DESC


--Best Sales Representatives (During the Period)
SELECT TOP 5
    Sales_Rep, 
    Total_Sales = SUM(Total_Amount)
FROM dbo.combined_data
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Sales_Rep
ORDER BY SUM(Total_Amount) DESC

--Which store locations generated the highest sales?
SELECT TOP 5
    Store_Location,
	Country,
    Total_Sales = SUM(Total_Amount),
    Total_Profit = SUM(Profit)
FROM dbo.combined_data
WHERE "Date" BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Store_Location, Country
ORDER BY Total_Sales DESC

--What are the key sales and profit insights for the selected period?
SELECT 
    Min_Sales_Value = MIN(Total_Amount),
    Max_Sales_Value = MAX(Total_Amount),
    Avg_Sales_Value = AVG(Total_Amount),
    Total_Sales_Value = SUM(Total_Amount),
    Min_Profit = MIN(Profit),
    Max_Profit = MAX(Profit),
    Avg_Profit = AVG(Profit),
    Total_Profit = SUM(Profit)
FROM dbo.combined_data
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14';
