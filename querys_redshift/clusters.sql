select dc.pk_dim_athlete as athlete, ca.cluster_activities as labels,dc.pk_dim_organization
from analytics.clustering_activities ca
left join trusted.dim_contracts dc on dc.pk_dim_athlete = ca.pk_dim_athlete
where ca.date_cluster::date = '2022-03-31'
AND dc.pk_dim_organization != 312
and dc.principal_contract = true
and dc.pk_dim_agreement != 187
and dc.is_invalid= false
AND dc.date_end >= '2022-03-31'