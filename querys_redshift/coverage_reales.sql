SELECT do2.name_organization as organization, sum(val_earned) as coverage_uf , sum(val_originalbtgpoints) as original_bettercoins ,sum(val_btgpoints) as showed_bettercoins ,db.description_btgpointstype
FROM trusted.fac_insuredcoverages fi
LEFT JOIN trusted.dim_organizations do2 on fi.pk_dim_organization = do2.pk_dim_organization
LEFT JOIN trusted.dim_btgpointstypes db on fi.pk_dim_btgpointstype = db.pk_dim_btgpointstype
left join trusted.dim_agreements da on fi.pk_dim_agreement = da.pk_dim_agreement
left join trusted.dim_currencies dc on da.pk_dim_currency = dc.pk_dim_currency 
WHERE val_factor=100
AND fi.date_habit >= '2022-01-01'
AND fi.date_habit <= '2022-03-31'
AND do2.pk_dim_organization != 312
and dc.pk_dim_currency != 3
GROUP BY organization , db.description_btgpointstype
order by db.description_btgpointstype , organization