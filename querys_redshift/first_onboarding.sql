SELECT do2.name_organization as organization, sum(dc.is_onboarding) as n_athletes,DATE(DATE_TRUNC('day',dc.date_onboarding))  as date_cohort
FROM trusted.dim_contracts as dc 
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.date_end >'{date_end_quarter}'
AND dc.pk_dim_status_contract =2
AND dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
GROUP BY organization,date_cohort
order by organization