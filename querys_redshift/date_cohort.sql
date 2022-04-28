SELECT do3.name_organization as organization,
sum(dc.is_onboarding) as n_athletes,
DATE(DATE_TRUNC('day',dc.date_onboarding))  as date_cohort,
DATE(DATE_TRUNC('day',dc.date_start)) as date_inicio,
DATE(DATE_TRUNC('day',dc.date_end)) as date_baja,
greatest(date_cohort,'{date_start_quarter}') as day_onb,
least(date_baja,'{date_end_quarter}') as day_end,
datediff('day',day_onb,day_end)+1 as diff_dias,
diff_dias * n_athletes as total_days
FROM trusted.dim_contracts as dc
LEFT JOIN trusted.dim_organizations as do3  on do3.pk_dim_organization = dc.pk_dim_organization
WHERE (dc.date_end >= '{date_end_quarter}' or dc.date_end is null)
and dc.pk_dim_athlete != -1
AND dc.pk_dim_agreement != 187
AND do3.pk_dim_organization != 312
and dc.is_invalid= false
and dc.principal_contract = true
and dc.date_created < '{date_end_quarter}' 
and dc.date_onboarding  <= '{date_end_quarter}' 
GROUP BY organization,date_cohort, date_start, date_baja,day_onb,day_end
