SELECT 
fa.pk_dim_athlete as athlete,
count(fa.bk_activity) as num_meditations,
round(sum(fa.val_value)/60) as min_meditation_bc,
(case when round(sum((case when fa.val_value > 4200 then 0 else fa.val_value end))/60) is null then 0 else round(sum((case when fa.val_value > 4200 then 0 else 
fa.val_value end))/60) end) as min_meditation,
do2.name_organization as organization
FROM trusted.dim_subscribers as ds
LEFT JOIN trusted.dim_athletes as da2 on da2.pk_dim_athlete = ds.pk_dim_athlete
LEFT JOIN trusted.fac_activities as fa on  fa.pk_dim_athlete = ds.pk_dim_athlete
LEFT JOIN trusted.dim_contracts as dc on  dc.pk_dim_subscriber = ds.pk_dim_subscriber
LEFT JOIN  trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.date_onboarding is not null
AND do2.pk_dim_organization != 312
AND fa.date_start >=  '{date_start_quarter}'
AND fa.date_start  <= '{date_end_quarter}'
AND ds.pk_dim_athlete != -1
and fa.date_start >= dc.date_start
and fa.date_start <= dc.date_end
and dc.is_invalid= false
AND dc.pk_dim_agreement != 187
AND (fa.pk_dim_sport =128
OR fa.pk_dim_habit = 3)
GROUP BY fa.pk_dim_athlete,do2.name_organization 
