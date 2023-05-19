Select * 
From Portfolio.dbo.NashvilleHousing

-- Date Format

Alter Table Portfolio..NashvilleHousing
Add  SaleDateConverted Date

Update Portfolio..NashvilleHousing  
SET SaleDateConverted = CONVERT  (Date , SaleDate)

Select  SaleDateConverted , CONVERT(Date , SaleDate) from Portfolio.dbo.NashvilleHousing


-- Duplicates and Null May be Occur for Duplicates order by

SELECT a.ParcelID , a.PropertyAddress , b.ParcelID , b.PropertyAddress , ISNULL(a.PropertyAddress , b.PropertyAddress)
FROM Portfolio.dbo.NashvilleHousing a
JOIN Portfolio.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


Update a 
SET a.PropertyAddress = ISNULL(a.PropertyAddress , b.PropertyAddress)
FROM Portfolio.dbo.NashvilleHousing a
JOIN Portfolio.dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-- Split Address & City

SELECT SUBSTRING(PropertyAddress , 1 , CHARINDEX(',',PropertyAddress)-1),
SUBSTRING(PropertyAddress , CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))
FROM Portfolio..NashvilleHousing

--Getting Street and City

ALTER TABLE Portfolio.dbo.NashvilleHousing
add PropertySplitAddress nvarchar(255)

UPDATE Portfolio.dbo.NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress , 1 , CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE Portfolio.dbo.NashvilleHousing
add PropertySplitCity nvarchar(255)

UPDATE Portfolio.dbo.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress , CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))

Select  * from Portfolio..NashvilleHousing

-- Owner Address Split 

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 3) ,
PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 2) ,
PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 1) 
FROM Portfolio.dbo.NashvilleHousing


ALTER TABLE Portfolio.dbo.NashvilleHousing
add OwnerSplitCity nvarchar(255)

UPDATE Portfolio.dbo.NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 2)

ALTER TABLE Portfolio.dbo.NashvilleHousing
add OwnerSplitAddress nvarchar(255)

UPDATE Portfolio.dbo.NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 3)

ALTER TABLE Portfolio.dbo.NashvilleHousing
add OwnerSplitState nvarchar(255)

UPDATE Portfolio.dbo.NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',' , '.') , 1)


SELECT * From Portfolio.dbo.NashvilleHousing


-- Change YES NO to Y N

SELECT Distinct(SoldAsVacant) , COUNT(SoldAsVacant)
from Portfolio.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2



SELECT SoldAsVacant ,
Case WHEN SoldAsVacant = 'N' then 'NO'
	WHEN SoldAsVacant  =  'Y' then 'YES'
	else SoldAsVacant
	END
from Portfolio..NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant = Case WHEN SoldAsVacant = 'N' then 'NO'
	WHEN SoldAsVacant  =  'Y' then 'YES'
	else SoldAsVacant
	END
from Portfolio..NashvilleHousing 

