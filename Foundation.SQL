
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
--AND AdmittedDate between '2024-02-27' AND '2024-03-01'
--AND ps.AdmittedDate >= '2024-02-27'
--AND ps.AdmittedDate <='2024-03-01'




  

