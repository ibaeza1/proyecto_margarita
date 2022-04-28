SELECT sum(fe.val_count) as donations, do2.name_organization as organization, dc2.name_campaign as campaign,dd.name_donationtype as type_donation, dc2.pk_dim_campaign as id_campaign, fe.date_exchange::date as date_exchange
FROM trusted.fac_exchanges fe 
LEFT JOIN trusted.dim_subscribers ds on ds.pk_dim_athlete = fe.pk_dim_athlete 
LEFT JOIN trusted.dim_contracts  dc on    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations  do2  on do2.pk_dim_organization = dc.pk_dim_organization 
LEFT JOIN trusted.dim_campaigns dc2 on dc2.pk_dim_campaign = fe.pk_dim_campaign 
left join trusted.dim_donationtypes dd on dd.pk_dim_donationtype = dc2.pk_dim_donationtype
WHERE fe.date_exchange >= '{date_start_quarter}'
AND fe.date_exchange <= '{date_end_quarter}'
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
and fe.date_exchange >= dc.date_onboarding
and fe.date_exchange <= dc.date_end
and dc.is_invalid= false
GROUP BY organization, campaign ,type_donation,id_campaign,date_exchange
order by organization,date_exchange