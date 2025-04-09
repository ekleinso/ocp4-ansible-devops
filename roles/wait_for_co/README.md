# wait_for_co
This role waits for all the cluster operators on freshly installed OpenShift cluster to be ***Available***. It can be used as part of a larger playbook to make sure the cluster is operational before performing additional configurations.

The following steps are taken by the role

- The first task gathers all the Cluster Operators using the **k8s_info** module.
- The second task loops through the gathered Cluster Operators and adds their names to a list called operators.
- The third task waits for each Cluster Operator to be in the ***Available*** state using the **k8s_info** module with the wait parameter set to true.

These tasks ensure that the Cluster Operators are gathered and that they are all available before proceeding with further tasks in the Ansible playbook.

### Example Usage
Example invocation of the role in a playbook
```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
  - wait_for_co
```
