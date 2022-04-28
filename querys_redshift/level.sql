select fal.pk_dim_athlete as athlete,
fal.pk_dim_level as nivel,
dc.pk_dim_organization as organization,
do2.name_organization as name_organization,
fal.date_start as date_start,
fal.date_end as date_end
from trusted.dim_contracts dc
left join trusted.fac_athletes_level fal  on dc.pk_dim_athlete = fal.pk_dim_athlete
left join trusted.dim_organizations do2 on dc.pk_dim_organization = do2.pk_dim_organization
where dc.pk_dim_organization != 312
and dc.principal_contract = true
and dc.date_end >= '2022-03-31'
and fal.date_start <= '2022-03-31'
and dc.pk_dim_athlete != -1
AND dc.pk_dim_agreement != 187
and dc.date_start <= '2022-03-31'
order by athlete,date_start ,date_end 