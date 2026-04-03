select * 
from [dbo].[hamif]

DELETE FROM [dbo].[hamif]
WHERE Fx IS NULL OR Fy IS NULL OR Fz IS NULL OR Mz IS NULL OR Ft IS NULL OR Fr IS NULL;

WHERE (SELECT COUNT(*) FROM [dbo].[hamif]) > 50000
AND Time NOT IN (
    SELECT TOP 50000 Time
    FROM [dbo].[hamif]
    ORDER BY Time
);