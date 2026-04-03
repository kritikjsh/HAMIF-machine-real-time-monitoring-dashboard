select * 
from [dbo].[hamif]

DELETE FROM [dbo].[1]
WHERE Fx IS NULL OR Fy IS NULL OR Fz IS NULL OR Mz IS NULL OR Ft IS NULL OR Fr IS NULL;


-- Delete rows after the first 50,000
DELETE FROM [dbo].[1]
WHERE (SELECT COUNT(*) FROM [dbo].[1]) > 50000
AND Time NOT IN (
    SELECT TOP 50000 Time
    FROM [dbo].[1]
    ORDER BY Time
);

-- Declare variables for simulated streaming data
-- Declare variables for simulated streaming data
DECLARE @Counter INT = 1;
DECLARE @TableName NVARCHAR(128) = N[dbo].[1]; -- Replace 'YourTableName' with the actual table name
DECLARE @MaxIterations INT;

-- Get the total number of rows in the table
SELECT @MaxIterations = COUNT(*) FROM [dbo].[1]; -- Replace 'YourTableName' with the actual table name

-- Rest of your script goes here...


-- Create a temporary table to store the simulated streaming data
CREATE TABLE #SimulatedData
(
    Time FLOAT,
    Fx FLOAT,
    Fy FLOAT,
    Fz FLOAT,
    Ft FLOAT,
    Fr FLOAT,
    Mz FLOAT
);

-- Simulated streaming data insertion loop
WHILE @Counter <= @MaxIterations
BEGIN
    -- Insert a single row from your existing table into the temporary table
    INSERT INTO #SimulatedData (Time, Fx, Fy, Fz, Ft, Fr, Mz)
    SELECT TOP 1 Time, Fx, Fy, Fz, Ft, Fr, Mz
    FROM YourTableName
    ORDER BY Time; -- Order by a unique column or primary key to ensure consistent ordering

    -- Increment the counter
    SET @Counter = @Counter + 1;

    -- Pause for a short duration to simulate real-time behavior
    WAITFOR DELAY '00:00:01'; -- 1 second delay

    -- Remove the inserted row from the original table to simulate data processing
    DELETE FROM YourTableName
    WHERE Time = (SELECT TOP 1 Time FROM #SimulatedData);
END;

-- Drop the temporary table
DROP TABLE #SimulatedData;
