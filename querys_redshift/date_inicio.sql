with max_subs as (select pk_org,
max(n_subs) as max_subs
from (SELECT dc.pk_dim_organization as pk_org, count(dc.pk_dim_athlete) as n_subs, DATE(DATE_TRUNC('day',dc.date_start)) as date_inicio2
FROM trusted.dim_contracts as dc
WHERE dc.pk_dim_agreement != 187
AND dc.pk_dim_organization != 312
and dc.principal_contract = true
and dc.is_invalid= false
GROUP BY pk_org, date_inicio2)
group by pk_org)
select do2.name_organization as organization,
count(dc2.pk_dim_athlete) as initial_users,
DATE(DATE_TRUNC('day',dc2.date_start)) as date_inicio
from trusted.dim_contracts dc2
left join  max_subs on pk_org = dc2.pk_dim_organization
left join trusted.dim_organizations do2 on pk_org = do2.pk_dim_organization
WHERE dc2.pk_dim_agreement != 187
AND dc2.pk_dim_organization != 312
and dc2.principal_contract = true
group by do2.name_organization, max_subs, dc2.date_start
having initial_users = max_subs