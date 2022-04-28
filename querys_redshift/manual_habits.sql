with contracts as (SELECT dc.pk_dim_athlete as atleta, dc.pk_dim_organization as orga 
FROM trusted.dim_contracts dc 
WHERE dc.pk_dim_athlete != -1 
and dc.principal_contract = true 
and dc.pk_dim_organization != 312 
and dc.is_invalid= false
and dc.is_onboarding = 1) 
select count(distinct fa.pk_dim_athlete ) as atleta, dc.orga,do2.name_organization as name_organization
from contracts dc
left join trusted.fac_activities fa  on dc.atleta = fa.pk_dim_athlete 
left join trusted.dim_organizations do2 on dc.orga = do2.pk_dim_organization
where fa.date_start AT TIME ZONE 'America/Santiago'::date >= '2022-01-01'
and fa.date_start AT TIME ZONE 'America/Santiago'::date  <= '2022-03-31'
and fa.pk_dim_habit >= 9
and fa.pk_dim_habit <= 22
group by dc.orga,do2.name_organization