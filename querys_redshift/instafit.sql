SELECT subscriber ,activation_date,organization, athlete
FROM(
SELECT fui.pk_dim_subscriber as  subscriber,
fui.date_created as activation_date,
do2.name_organization as organization,
ds.pk_dim_athlete as athlete,
row_number() OVER(PARTITION BY subscriber ORDER BY activation_date) AS rn
FROM trusted.fac_using_instafit fui
LEFT JOIN trusted.dim_subscribers ds on ds.pk_dim_subscriber =fui.pk_dim_subscriber
LEFT JOIN trusted.dim_athletes as da2 on ds.pk_dim_athlete = da2.pk_dim_athlete
LEFT JOIN trusted.dim_contracts as dc on    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.date_onboarding is not null
AND do2.pk_dim_organization != 312
AND ds.pk_dim_athlete != -1
AND dc.pk_dim_status_contract =2
AND dc.pk_dim_agreement != 187
GROUP BY subscriber ,organization, athlete, activation_date
ORDER BY organization, subscriber, activation_date
) sub
WHERE rn = 1
AND activation_date  <= '{date_end_quarter}'
