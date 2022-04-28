select distinct ds.pk_dim_service, do2.name_organization
FROM trusted.fac_planservices fp
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = fp.pk_dim_organization
left join trusted.dim_services ds on ds.pk_dim_service = fp.pk_dim_service
-- arreglar codigo--