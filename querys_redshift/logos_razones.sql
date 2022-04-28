select do2.pk_dim_organization as id_org,
do2.name_organization as organization,
min(dc.date_start) as inicio_cont,
min(dc.date_onboarding) as primer_onb,
sum(case when dc.pk_dim_status_contract=2 then 1 else 0 end) as activos,
count(dc.pk_dim_contract) as total,
donas.donations as donaciones,
dc2.business_name as razon_social
from trusted.dim_organizations do2
left join trusted.dim_contracts dc on dc.pk_dim_organization = do2.pk_dim_organization
left join trusted.dim_companies dc2 on dc2.pk_dim_organization = do2.pk_dim_organization 
left join (SELECT sum(fe.val_count) as donations,
do2.name_organization as orga
from trusted.fac_exchanges fe
left join trusted.dim_organizations do2 on do2.pk_dim_organization = fe.pk_dim_organization
WHERE DATE(DATE_TRUNC('day',(fe.date_exchange))) >= '{date_start_quarter}' ---date_start_quarter
AND DATE(DATE_TRUNC('day',(fe.date_exchange)))  <= '{date_end_quarter}' ---date_end_quarter
AND do2.pk_dim_organization != 312
GROUP BY orga) as donas on do2.name_organization = donas.orga
where do2.pk_dim_organization != 312
and dc.principal_contract = true --, tipo )
GROUP BY do2.name_organization, donas.donations, do2.pk_dim_organization,razon_social
order by id_org