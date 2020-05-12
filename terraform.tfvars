# The type of cluster that will be created/used (kubernetes or openshift)
cluster_type="kubernetes"
# Flag indicating if we are using an existing cluster or creating a new one
cluster_exists="false"

# The prefix that should be applied to the cluster name and service names (if not provided
# explicitly). If not provided then the resource_group_name will be used as the prefix.
#name_prefix="<name prefix for cluster and services>"

# The cluster name can be provided (particularly if using an existing cluster). The value
# for cluster name used by the scripts will be set in the following order of presidence:
# - "${cluster_name}"
# - "${name_prefix}-cluster"
# - "${resource_group_name}-cluster"
#cluster_name="<cluster name>"

resource_group_name="<resource group>"
vlan_region="us-east"

# Flag indicating if we are using an existing postgres server or creating a new one
postgres_server_exists="false"
# Vlan config

# The following values tell the IBMCloud terraform provider the details about the new
# cluster it will create.
# If `cluster_exists` is set to `true` then these values are not needed
#vlan_datacenter="wdc04"
#private_vlan_id="2440701"
#public_vlan_id="2440699"
cluster_name="<resource group>-cluster"
cluster_type="kubernetes"
