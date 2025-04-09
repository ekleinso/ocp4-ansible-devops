# admin_acks
This role patches the admin-acks ConfigMap in the openshift-config namespace. The ConfigMap contains a list of acknowledgments for API removals in different Kubernetes versions. The role uses Ansible's set_fact and k8s modules to transform the list into a map and patch the ConfigMap, respectively.

This role assumes that the target cluster has the k8s Ansible collection installed and configured.

- The admin_acks variable is a list of dictionaries, where each dictionary contains a name and value key.
- The set_fact task transforms the list into a map using the combine filter.
- The k8s task patches the admin-acks ConfigMap in the openshift-config namespace with the transformed map.
- The debug task displays the result of the patch operation.
- The set_fact task transforms the list into a map using the combine filter.
- The k8s task patches the admin-acks ConfigMap in the openshift-config namespace with the transformed map.
- The debug task displays the result of the patch operation.

### Role Variables
Default role variables that are defined.
```yaml
admin_acks:
  - name: "ack-4.8-kube-1.22-api-removals-in-4.9"
    value: "true"
  - name: "ack-4.9-kube-1.23-api-removals-in-4.10"
    value: "true"
  - name: "ack-4.10-kube-1.24-api-removals-in-4.11"
    value: "true"
  - name: "ack-4.11-kube-1.25-api-removals-in-4.12"
    value: "true"
  - name: "ack-4.12-kube-1.26-api-removals-in-4.13"
    value: "true"
  - name: "ack-4.13-kube-1.27-api-removals-in-4.14"
    value: "true"
  - name: "ack-4.14-kube-1.28-api-removals-in-4.15"
    value: "true"
```

### Example Usage
Example invocation of the role in a playbook

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
  - admin_acks
```

OR if you want to override some default variables

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost
  vars:
    admin_acks:
      - name: "ack-4.15-kube-1.29-api-removals-in-4.16"
        value: "true"
      - name: "ack-4.16-kube-1.30-api-removals-in-4.17"
        value: "true"

  roles:
  - admin_acks
```
