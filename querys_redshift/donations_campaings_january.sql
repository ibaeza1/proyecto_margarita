SELECT sum(fd.val_donated_calories) as calories_don , sum(fd.val_donated_calories)/500 as donations, do2.name_organization as organization, dc2.name_campaign as campaign
FROM trusted.fac_donations fd 
LEFT JOIN trusted.dim_subscribers ds on ds.pk_dim_athlete = fd.pk_dim_athlete 
LEFT JOIN trusted.dim_contracts  dc on    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations  do2  on do2.pk_dim_organization = dc.pk_dim_organization 
LEFT JOIN trusted.dim_campaigns dc2 on dc2.pk_dim_campaign = fd.pk_dim_campaign 
WHERE fd.date_donation >='{date_start_quarter}'
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
and dc.pk_dim_status_contract = 2
GROUP BY organization, campaign 