-- Check Date format
SELECT "SaleDate"
FROM public."NashvilleHousingData"

-- Format Property Address
SELECT *
FROM public."NashvilleHousingData"
where "PropertyAddress" is null 
order by "ParcelID"

-- Used Coalesca instead of ISNULL for postgress
SELECT a."ParcelID", a."PropertyAddress", b."ParcelID", b."PropertyAddress", COALESCE( a."PropertyAddress", b."PropertyAddress" )
FROM public."NashvilleHousingData" a
join public."NashvilleHousingData" b
	on a."ParcelID" = b."ParcelID"
	and a."UniqueID" <> b."UniqueID"
where a."PropertyAddress" is null

-- Did not work used below to update null property address
-- Update a
-- SET "PropertyAddress" = COALESCE( a."PropertyAddress", b."PropertyAddress" )
-- FROM public."NashvilleHousingData"  as a
-- join public."NashvilleHousingData" as b
-- 	on a."ParcelID" = b."ParcelID"
-- 	and a."UniqueID" <> b."UniqueID"
-- where a."PropertyAddress" is null


Update public."NashvilleHousingData"  as a
SET "PropertyAddress" = COALESCE( a."PropertyAddress", b."PropertyAddress" )
from public."NashvilleHousingData" as b
where a."PropertyAddress" is null

--Splitting Address into Address, City, State

Alter Table public."NashvilleHousingData"
add PropertySplitAddress varchar(255);

Update public."NashvilleHousingData"
Set PropertySplitAddress = substring("PropertyAddress", 1, position(','in "PropertyAddress")-1)

Alter Table public."NashvilleHousingData"
add PropertySplitCity varchar(255);

Update public."NashvilleHousingData"
Set PropertySplitCity = substring("PropertyAddress", position(','in "PropertyAddress")+1, length("PropertyAddress") )

Alter Table public."NashvilleHousingData"
add OwnerSplitAddress varchar(255);

Update public."NashvilleHousingData"
Set OwnerSplitAddress = split_part("OwnerAddress", ',',1)

Alter Table public."NashvilleHousingData"
add OwnerSplitCity varchar(255);

Update public."NashvilleHousingData"
Set OwnerSplitCity = split_part("OwnerAddress", ',',2)

Alter Table public."NashvilleHousingData"
add OwnerSplitState varchar(255);

Update public."NashvilleHousingData"
Set OwnerSplitState = split_part("OwnerAddress", ',',1)

--Clean Sold As Vacant column

select distinct("SoldAsVacant"), count("SoldAsVacant")
from public."NashvilleHousingData"
group by "SoldAsVacant"
order by 2

Select "SoldAsVacant",
Case when "SoldAsVacant" = 'Y' then 'Yes'
when "SoldAsVacant" = 'N' then 'No'
Else "SoldAsVacant"
end
from public."NashvilleHousingData"

Update public."NashvilleHousingData"
Set "SoldAsVacant"  = Case 
	when "SoldAsVacant" = 'Y' then 'Yes'
	when "SoldAsVacant" = 'N' then 'No'
	Else "SoldAsVacant"
	end
	
	
--Remove Duplicates
With RowNumCTE as (
Select *,
	Row_number() Over(
	Partition by "ParcelID",
				"PropertyAddress",
				"SalePrice",
				"SaleDate",
				"LegalReference"
				Order by
					"UniqueID"
				) row_num
from public."NashvilleHousingData"
)
Select *
From RowNumCTE
where row_num >1 
order by "PropertyAddress"


--Deleteing from table using CTE in Postgres
WITH cte AS (
    SELECT
        "UniqueID"
    FROM (
        SELECT
            "UniqueID",
            ROW_NUMBER() OVER (PARTITION BY "ParcelID",
				"PropertyAddress",
				"SalePrice",
				"SaleDate",
				"LegalReference"
				Order by "UniqueID") row_num
        FROM 
            public."NashvilleHousingData"
    ) s
    WHERE row_num > 1
)
DELETE FROM public."NashvilleHousingData"
WHERE "UniqueID" IN (SELECT * FROM cte)

-- Remove Unsed Columns
Alter Table public."NashvilleHousingData"
Drop Column "OwnerAddress" ,Drop Column "PropertyAddress",Drop Column "TaxDistrict"

Alter Table public."NashvilleHousingData"
Drop Column "SaleDate"