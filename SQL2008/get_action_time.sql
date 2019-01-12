SET NOCOUNT ON

DECLARE @time_snapshot VARCHAR(50)

SELECT @time_snapshot = CONVERT(VARCHAR(50), GETDATE(), 113)

PRINT
	SUBSTRING(@time_snapshot, 8, 4) + '-' +
	+ UPPER(SUBSTRING(@time_snapshot, 4, 3)) + '-' +
	+ SUBSTRING(@time_snapshot, 1, 2) + 'T'
	+ SUBSTRING(@time_snapshot, 13, 2) + 'H'
	+ SUBSTRING(@time_snapshot, 16, 2) + 'M'
	+ SUBSTRING(@time_snapshot, 19, 2) + 'S'