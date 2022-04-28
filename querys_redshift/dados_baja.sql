SELECT do2.pk_dim_organization as id_org, do2.name_organization AS organization,
count(dc.pk_dim_contract) as n_subs,
sum(CASE WHEN dc.pk_dim_status_contract = 4  THEN 1 ELSE 0 END) AS dados_de_baja,
CASE WHEN dados_de_baja = n_subs THEN 1 ELSE 0 END AS churn,
max(dc.date_end) as fecha_churn
FROM trusted.dim_contracts dc
LEFT JOIN trusted.dim_organizations  do2  ON do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
group by organization, do2.pk_dim_organization
having churn = 1
order by churn, organization