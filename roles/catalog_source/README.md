# catalog_source
This role patches the CatalogSources to update their intervals and disables the CatalogSources based on the values provided in the catalog and source variables.

The role assumes that the target cluster has the openshift-marketplace namespace and the CatalogSource and OperatorHub resources defined.

- catalog: This variable contains an array of objects, each representing a CatalogSource and its update interval. The name field specifies the name of the CatalogSource, and the value field specifies the update interval in the format of "duration".
- source: This variable contains an array of objects, each representing a CatalogSource and its disabled status. The name field specifies the name of the CatalogSource, and the value field specifies whether the CatalogSource should be disabled (true or false).
- Patch CatalogSources: This task loops through the catalog variable and uses the k8s module to patch the CatalogSources in the openshift-marketplace namespace. It updates the update interval of each CatalogSource based on the value field in the catalog variable.
- Disable CatalogSources: This task loops through the source variable and uses the k8s module to disable the CatalogSources in the cluster OperatorHub. It sets the disabled field of each CatalogSource based on the value field in the source variable.

### Role Variables
Default role variables that are defined.
```yaml
catalog:
  - name: "redhat-operators"
    value: "60m0s"
  - name: "certified-operators"
    value: "60m0s"
  - name: "community-operators"
    value: "60m0s"
source:
  - name: "redhat-marketplace"
    value: true
```

### Example Usage
Example invocation of the role in a playbook

```yaml
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
    - catalog_source
```

OR if you want to override some default variables

```yaml
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  vars:
    catalog:
      - name: "redhat-operators"
        value: "30m0s"

  roles:
    - catalog_source
```
