SELECT do2.name_organization as organization,
		count(dc.pk_dim_subscriber) as num_subscribers,
		sum(dc.is_onboarding) as num_onboarding,
		100*sum(dc.is_onboarding)/count(dc.pk_dim_subscriber)::integer  as perc_activation,
        do2.pk_dim_organization as id
FROM trusted.dim_contracts as dc 
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization 
WHERE dc.date_end >= '{date_end_quarter}'
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
and dc.principal_contract = true
and do2.is_excluded is not true
and dc.is_invalid= false
GROUP BY organization, id

