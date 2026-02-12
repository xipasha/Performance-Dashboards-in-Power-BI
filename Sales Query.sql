SELECT DISTINCT

-- columns needed from the joins made

sod.SalesOrderID,
soh.OrderDate,
soh.SalesOrderNumber,
soh.Status,
YEAR(soh.OrderDate) as OrderYear,
DATENAME (MONTH,soh.OrderDate) as [Order Month Name],
MONTH(soh.OrderDate) as [Order Month],
prop.Name as [product Name],
prop.ProductID,
procat.Name as [Product category],
prosub.Name as [Product Subcategory],
sod.OrderQty,
sod.UnitPrice,
sod.UnitPriceDiscount,
sod.LineTotal,
sod.UnitPrice * sod.OrderQty AS [Gross Revenue],
st.Name as [Territory Name],
soh.SalesPersonID,
CONCAT(pp.FirstName, ' ', pp.LastName) AS SalesPersonName
-- JOINS --

-- soh is salesOrderHeader
FROM sales.SalesOrderHeader AS soh
-- sod is salesOrderDetail
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
-- st is sales territory
INNER JOIN Sales.SalesTerritory AS st ON  st.TerritoryID = soh.TerritoryID
-- sp is sales person
INNER JOIN Sales.SalesPerson AS sp ON sp.TerritoryID = soh.TerritoryID
-- 
INNER JOIN Sales.SalesOrderHeader on SalesOrderHeader.SalesPersonID = soh.SalesPersonID
-- pp is person
INNER JOIN Person.Person AS pp ON pp.BusinessEntityID = sp.BusinessEntityID
-- prop is person
INNER JOIN Production.Product AS prop ON sod.ProductID = prop.ProductID
-- prosub is product subcategory
INNER JOIN production.ProductSubcategory AS prosub ON prosub.ProductSubcategoryID = prop.ProductSubcategoryID
-- procat is product category
INNER JOIN production.ProductCategory AS procat ON prosub.ProductCategoryID = procat.ProductCategoryID

--ORDER BY OrderDate DESC;