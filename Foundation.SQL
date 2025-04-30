
-- Select * from airports (-- 2 DASH IN SQL MEANS IGNORE THIS DATA OR LINE)

-- Select * from PatientStay

Select 
    ps.PatientId
    , ps.Hospital
    , ps.AdmittedDate
    , ps.DischargeDate
    , DATEDIFF(day, ps.AdmittedDate, ps.DischargeDate) as LengthOfStay
    , DATEADD(WEEK, -14, ps.AdmittedDate) as ReminderDate
    , ps.Tariff
    , ps.Ward
    , ps.Ethnicity
from PatientStay ps
WHERE ps.Hospital in ('PRUH','Oxleas')
AND ps.Ward LIKE '%Surgery'
-- AND ps.Admitted BETWEEN '2024-02-27' AND '2024-03-01'
Order by ps.AdmittedDate DESC, ps.PatientId DESC


SELECT COUNT(*) FROM PatientStay ps

SELECT 
count(*) as NumberOfPatient
FROM PatientStay ps

SELECT COUNT(ps.Ethnicity) as NumberOfPatients FROM PatientStay ps

SELECT
ps.Hospital
ps.Ward
    ,Count(*) as NumberOfPatients
    ,SUM(ps.tariff) as totalTariff
    ,AVG(ps.Tariff) as averageTariff
    ,MAX(ps.Tariff) as HighestTariff
    ,MIN(PS.Tariff) as MinTariff
from PatientStay ps
Group by ps.Hospital, ps.Ward
-- ORDER BY ps.Hospital, ps.Ward
ORDER BY NumberOfPatients DESC

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps LEFT JOIN DimHospitalbad dh ON ps.Hospital = dh.Hospital
where ps.hospital IS NULL

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps LEFT JOIN DimHospitalbad dh ON ps.Hospital = dh.Hospital
where dh.hospital IS NULL

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM
    PatientStay ps INNER JOIN DimHospitalbad dh ON ps.Hospital = dh.Hospital
-- where dh.hospital IS NULL

SELECT * FROM DimHospitalBad






WHERE ps.Hospital in ('PRUH','Oxleas')



SELECT 
    AVG(ps.Tariff) as AverageTariff
FROM PatientStay ps

SELECT 
    ps.Ward,
    AVG(ps.Tariff) as AverageTariff
FROM PatientStay ps
GROUP BY ps.hospital, ps.Ward

--AND ps.AdmittedDate >= '2024-02-27'
--AND ps.AdmittedDate <='2024-03-01'

PK - STANDS FOR PrimaryKey

Select * From DimHospital



  

