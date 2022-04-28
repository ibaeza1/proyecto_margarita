SELECT do2.pk_dim_organization,do2.name_organization as organization,
      count(dc.pk_dim_subscriber) as num_subscribers,
      sum(dc.is_onboarding) as num_onboarding,
      min(dc.date_start) as date_inicio--,
      --100*sum(dc.is_onboarding)/count(dc.pk_dim_subscriber)::integer  as perc_activation,
        --CASE WHEN count(dc.pk_dim_subscriber) < 21 THEN 'Micro' WHEN count(dc.pk_dim_subscriber) < 251 THEN 'SME' when count(dc.pk_dim_subscriber) < 1001 then 'Corporate' ELSE 'Enterprise' END as tipo_empresa
FROM trusted.dim_contracts as dc
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.pk_dim_agreement != 187
AND do2.pk_dim_organization != 312
and dc.principal_contract = true
and dc.pk_dim_status_contract = 2 --  dc.pk_dim_status_contract = 2 entonces es activo = 4 es inactivo
GROUP BY do2.pk_dim_organization, organization