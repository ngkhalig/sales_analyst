--MERGING ALL DATASET
SELECT * INTO dbo.combined_data
FROM dbo.sales_Canada
UNION ALL
SELECT * FROM dbo.sales_China
UNION ALL
SELECT * FROM dbo.sales_India
UNION ALL
SELECT * FROM dbo.sales_Nigeria
UNION ALL
SELECT * FROM dbo.sales_UK
UNION ALL
SELECT * FROM dbo.sales_US 

--CHECKING MISSING VALUE
SELECT * 
FROM dbo.combined_data
WHERE  Transaction_ID is null 
	or Date is null
	or Country is null 
	or Product_ID is null
	or Product_Name is null
	or Category is null
	or Price_per_Unit is null
	or Quantity_Purchased is null
	or Cost_Price is null
	or Discount_Applied is null
	or Payment_Method is null
	or Customer_Age_Group is null
	or Customer_Gender is null 
	or Store_Location is null
	or Sales_Rep is null

--UPDATING

--Updating "Quantity_Purchased"

/* Trong bộ dữ liệu hiện có, các yếu tố như quốc gia (Country), độ tuổi (Age) và giới tính (Gender) có thể ảnh hưởng đáng kể đến quyết định mua hàng của khách hàng. 
Cụ thể, văn hóa tiêu dùng đặc trưng theo từng quốc gia, trải nghiệm và nhu cầu theo độ tuổi, cũng như hành vi tiêu dùng theo giới tính là những yếu tố thường được 
chứng minh có tác động đến số lượng hàng hóa khách hàng quyết định mua.
--> Fill giá trị null của Quantity_Purchased bằng giá trị trung bình của các hàng dữ liệu có cùng Country, Age và Gender*/

UPDATE dbo.combined_data
SET Quantity_Purchased = 
    (
        SELECT ROUND(AVG(Quantity_Purchased), 0)
        FROM dbo.combined_data
        WHERE Country = 'Nigeria' and Customer_Age_Group = 'Adult' and Customer_Gender = 'Male' 
    )
WHERE Transaction_ID = '00a30472-89a0-4688-9d33-67ea8ccf7aea'

--Updating "Price_per_Unit"
UPDATE dbo.combined_data
SET Price_per_Unit = (
    SELECT AVG(Price_per_Unit)
    FROM dbo.combined_data AS sub
    WHERE sub.Country = dbo.combined_data.Country
      AND Price_per_Unit IS NOT NULL
)
WHERE Price_per_Unit IS NULL;

--Updating "Discount_Applied"
UPDATE dbo.combined_data
SET Discount_Applied = (
    SELECT AVG(Price_per_Unit)
    FROM dbo.combined_data AS sub
    WHERE sub.Country = dbo.combined_data.Country
      AND Discount_Applied IS NOT NULL
)
WHERE Discount_Applied IS NULL;

--CHECKING FOR DUPLICATE VALUE
SELECT COUNT(Transaction_ID)
FROM dbo.combined_data
GROUP BY "Transaction_ID"
HAVING COUNT(Transaction_ID)>1;


