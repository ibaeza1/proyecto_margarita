SELECT ds.pk_dim_documenttype , ds.bk_identification_value , dc.pk_dim_subscriber as  subscriber, do2.name_organization as organization, ds.pk_dim_athlete as athlete
FROM trusted.dim_subscriberscontacts ds
LEFT JOIN trusted.dim_contracts as dc on    ds.pk_dim_athlete  = dc.pk_dim_athlete
LEFT JOIN trusted.dim_organizations as do2  on do2.pk_dim_organization = dc.pk_dim_organization
WHERE dc.pk_dim_athlete != -1
AND do2.pk_dim_organization != 312