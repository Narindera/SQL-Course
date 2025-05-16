SELECT
    m.[Date]
    ,m.HomeTeam
    ,m.AwayTeam
    ,m.FTHG
    ,m.FTAG
    ,FTR
FROM
    FootballMatch m;

    SELECT TOP 5
    m.[Date]
    ,m.[HomeTeam]
    ,m.[AwayTeam]
    ,m.[FTHG]
    ,m.[FTAG]
    ,m.[FTR]
FROM
    FootballMatch m
ORDER BY
    m.[Date] DESC;

    SELECT
        [Date],
        COUNT(*) AS MatchCount
    FROM
        FootballMatch
    GROUP BY
        [Date]
    HAVING
        COUNT(*) > 1;

-- how many matches are there in the FootballMatch table?
        SELECT COUNT(*) AS TotalMatches FROM FootballMatch; 

-- which dates had more than one match?
        SELECT [Date]
        FROM FootballMatch
        GROUP BY [Date]
        HAVING COUNT(*) > 1;

-- which month had the most matches?
        SELECT
            DATEPART(month, [Date]) AS MatchMonth,
            COUNT(*) AS MatchCount
        FROM
            FootballMatch
        GROUP BY
            DATEPART(month, [Date])
        ORDER BY
            MatchCount DESC
        OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

        -- which month had the most matches? (with table alias)
        SELECT
            DATEPART(month, m.[Date]) AS MatchMonth,
            COUNT(*) AS MatchCount
        FROM
            FootballMatch m
        GROUP BY
            DATEPART(month, m.[Date])
        ORDER BY
            MatchCount DESC
        OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


SELECT
    Team,
    COUNT(*) AS Played,
    SUM(Wins) AS Won,
    SUM(Draws) AS Drawn,
    SUM(Losses) AS Lost,
    SUM(GoalsFor) AS GoalsFor,
    SUM(GoalsAgainst) AS GoalsAgainst,
    SUM(GoalsFor) - SUM(GoalsAgainst) AS GoalDifference,
    SUM(Wins) * 3 + SUM(Draws) AS Points
FROM (
    -- Home stats
    SELECT
        [HomeTeam] AS Team,
        CASE WHEN [FTHG] > [FTAG] THEN 1 ELSE 0 END AS Wins,
        CASE WHEN [FTHG] = [FTAG] THEN 1 ELSE 0 END AS Draws,
        CASE WHEN [FTHG] < [FTAG] THEN 1 ELSE 0 END AS Losses,
        [FTHG] AS GoalsFor,
        [FTAG] AS GoalsAgainst
    FROM [FootballMatch]
    UNION ALL
    -- Away stats
    SELECT
        [AwayTeam] AS Team,
        CASE WHEN [FTAG] > [FTHG] THEN 1 ELSE 0 END AS Wins,
        CASE WHEN [FTAG] = [FTHG] THEN 1 ELSE 0 END AS Draws,
        CASE WHEN [FTAG] < [FTHG] THEN 1 ELSE 0 END AS Losses,
        [FTAG] AS GoalsFor,
        [FTHG] AS GoalsAgainst
    FROM [FootballMatch]
) AS Stats
GROUP BY Team
ORDER BY Points DESC, GoalDifference DESC, GoalsFor DESC, Team;

-- results from home team perspective
SELECT
    m.[Date],
    m.[HomeTeam],
    m.[AwayTeam],
    m.[FTHG] AS [HomeGoals],
    m.[FTAG] AS [AwayGoals],
    CASE
        WHEN m.[FTHG] > m.[FTAG] THEN 'H'
        WHEN m.[FTHG] < m.[FTAG] THEN 'A'
        ELSE 'D'
    END AS [Result]
FROM
    FootballMatch m

SELECT
    m.HomeTeam as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG AS GoalsAgainst
    ,m.FTR
    --,CASE M.FTR when 'H' THEN 'W' WHEN 'D' WHEN 'A' THEN 'L' END As Result
    ,CASE m.ftr WHEN 'H' THEN 'W' WHEN 'A' THEN 'L' ELSE 'D' END As Result
FROM
    FootballMatch m



SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m

-- results from home team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTAG > m.FTHG then 'W' when M.FTAG = M.FTHG then 'D' else 'L' end as Result
FROM
    FootballMatch m
UNION ALL
--results

-- results from home team perspective
SELECT      
    m.HomeTeam  as Team
    ,m.FTHG AS GoalsFor
    ,m.FTAG  AS GoalsAgainst
--    ,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' WHEN 'A' THEN 'L' END As Result
    --,CASE m.FTR WHEN 'H' THEN 'W' WHEN 'D' THEN 'D' ELSE 'L' END As Result
    ,CASE when m.FTHG > m.FTAG then 'W' when M.FTHG = M.FTAG then 'D' else 'L' end as Result
FROM
    FootballMatch m
UNION ALL
-- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
    ,CASE m.FTR WHEN 'A' THEN 'W' WHEN 'D' THEN 'D' WHEN 'H' THEN 'L' END As Result
FROM
    FootballMatch m

drop table if exists #EPLResults;

-- results from AWAY team perspective
SELECT      
    m.AwayTeam  as Team
    ,m.FTAG AS GoalsFor
    ,m.FTHG  AS GoalsAgainst
    ,CASE when m.FTAG > m.FTHG then 'W' when M.FTAG = M.FTHG then 'D' else 'L' end as Result
FROM
    FootballMatch m

SELECT * FROM #EPLResults

--group by team to build the league table

SELECT
    r.Team
    , sum(r.GoalsFor) as GoalsFor
    , sum(r.GoalsAgainst) as GoalsAgainst
From #EPLResults r
GROUP BY r.team
ORDER BY r.Team


SELECT
    r.Team
    , COUNT(*) as Played
    , sum(r.GoalsFor) as GoalsFor
    , sum(r.GoalsAgainst) as GoalsAgainst
    , sum(r.GoalsFor) - sum(r.GoalsAgainst) as GD
from #EPLResults r
GROUP BY r.Team
ORDER BY r.Team;

SELECT
    r.Team,
    , COUNT(*) AS Played
    , SUM(r.GoalsFor) AS GoalsFor,
    , SUM(r.GoalsAgainst) AS GoalsAgainst,
    , SUM(r.GoalsFor) - SUM(r.GoalsAgainst) AS GD
    , SUM(CASE WHEN r.Result = 'W' THEN 3 WHEN r.Result = 'D' THEN 1 ELSE 0 END) AS Points
    , SUM(CASE WHEN r.Result = 'W' THEN 1 ELSE 0 END) AS Won,
    , SUM(CASE WHEN r.Result = 'D' THEN 1 ELSE 0 END) AS Drawn,
    , SUM(CASE WHEN r.Result = 'L' THEN 1 ELSE 0 END) AS Lost,
FROM #EPLResults r
GROUP BY r.Team
ORDER BY r.Points DESC, GD 
   