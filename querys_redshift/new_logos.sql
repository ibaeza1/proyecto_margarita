select do2.pk_dim_organization as id_org,
do2.name_organization as organization,
min(dc.date_start) as inicio_cont,
min(dc.date_onboarding) as primer_onb,
sum(case when dc.pk_dim_status_contract=2 then 1 else 0 end) as activos,
count(dc.pk_dim_contract) as total,
from trusted.dim_organizations do2
left join trusted.dim_contracts dc on dc.pk_dim_organization = do2.pk_dim_organization
where do2.pk_dim_organization != 312
and dc.principal_contract = true --, tipo )
and dc.date_start::date <= '2022-03-05'
and do2.is_excluded is not true
GROUP BY do2.name_organization, donas.donations, do2.pk_dim_organization
order by id_org