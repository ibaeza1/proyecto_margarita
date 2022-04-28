SELECT
SUM(fa.val_calories_burned) as calories,
SUM(fa.val_time_seconds/60) as minutes_activities,
ds2.name_es_sport as sport,
fa.pk_dim_sport as id,
fa.pk_dim_habit as habit_type,
SUM(fa.val_steps) as steps,
SUM(fa.val_value) as time_sec_mindfulness,
SUM(fa.val_btg_points) as better_coins,
do2.name_organization as organization
FROM trusted.dim_subscribers as ds
LEFT JOIN trusted.dim_athletes as da2 on ds.pk_dim_athlete = da2.pk_dim_athlete  
LEFT JOIN trusted.fac_activities as fa on  ds.pk_dim_athlete = fa.pk_dim_athlete  
LEFT JOIN trusted.dim_contracts as dc on    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization  
LEFT JOIN trusted.dim_origintypes do3 on do3.pk_dim_origintype = fa.pk_dim_origintype 
LEFT JOIN trusted.dim_sports ds2 on fa.pk_dim_sport = ds2.pk_dim_sport 
WHERE dc.date_onboarding is not null 
AND fa.date_start >= '{date_start_quarter}'
AND fa.date_start  <= '{date_end_quarter}'
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
AND ds.pk_dim_athlete != -1
AND dc.pk_dim_status_contract =2
AND fa.date_start > dc.date_onboarding 
GROUP BY  sport,do2.name_organization, fa.pk_dim_sport, fa.pk_dim_habit
ORDER BY organization 