SELECT do2.name_organization AS organization ,
round(sum(CASE WHEN fb.val_btg_points > 0 THEN fb.val_btg_points  ELSE 0 END)) AS bettercoins,
round(sum(CASE WHEN fb.val_btg_points < -1 THEN fb.val_btg_points  ELSE 0 END)) AS bettercoins_donadas,
round(bettercoins_donadas/NULLIF(bettercoins ,0),3) AS proporcion_uso_moneda
FROM trusted.fac_bettercoins fb
LEFT JOIN trusted.dim_subscribers ds ON ds.pk_dim_athlete = fb.pk_dim_athlete
LEFT JOIN trusted.dim_contracts  dc ON    ds.pk_dim_subscriber  = dc.pk_dim_subscriber
LEFT JOIN trusted.dim_organizations  do2  ON do2.pk_dim_organization = dc.pk_dim_organization
WHERE ds.pk_dim_athlete != -1
AND fb.date_created >= '{date_start_quarter}'
AND fb.date_created  <= '{date_end_quarter}'
AND do2.pk_dim_organization != 312
and dc.principal_contract = true
and dc.is_invalid= false
and fb.date_created <= dc.date_end
and fb.date_created >= dc.date_start
GROUP BY organization
