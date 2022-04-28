SELECT dp.name_partner as service, fa2.pk_dim_subscriber as  subscriber,
fa2.date_activate as activation_date, do2.name_organization as organization,ds.pk_dim_athlete as athlete
FROM trusted.fac_activatepartners fa2 
LEFT JOIN trusted.dim_subscribers ds on ds.pk_dim_subscriber =fa2.pk_dim_subscriber 
LEFT JOIN trusted.dim_partners dp on fa2.pk_dim_partner = dp.pk_dim_partner 
LEFT JOIN trusted.dim_athletes as da2 on ds.pk_dim_athlete = da2.pk_dim_athlete  
LEFT JOIN trusted.dim_contracts as dc on    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization  
WHERE dc.date_onboarding is not null 
AND ds.pk_dim_athlete != -1
AND dc.pk_dim_status_contract =2
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
GROUP BY   subscriber ,service,organization ,activation_date, athlete 
ORDER BY organization 