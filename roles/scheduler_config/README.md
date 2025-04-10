## scheduler_config
The role configures the OpenShift cluster to have specific node roles and schedules workloads on them. It also creates a MachineConfigPool for infra nodes and moves the Ingress Controller to the infra nodes.

Pre-requisites: The role file assumes that the OpenShift cluster is already installed and the necessary command line tools are available.

Explanation for files:
- configure-scheduler.yaml: This task sets the master nodes to be non-schedulable, meaning workloads cannot be scheduled on them.
- create-infra-mcp.yaml: This task creates a MachineConfigPool for infra nodes, which is a group of nodes that are managed by the Machine Config Operator.
- gather-nodes.yaml: This task gathers all the nodes in the OpenShift cluster.
- label-infra-nodes.yaml: This task labels the nodes that have "infra" in their name with the "node-role.kubernetes.io/infra" label and the "workload" label set to "infra". It also taints the nodes with the same labels to make sure workloads cannot be scheduled on them.
- label-worker-nodes.yaml: This task labels all the worker nodes with the "workload" label set to "generic".
- main.yml: This task includes all the other task files in the correct order.
- move-infra-workload.yaml: This task moves the Ingress Controller to the infra nodes by adding node selectors and tolerations to its configuration.

Overall, this role is designed to configure the OpenShift cluster to have specific node roles and schedules workloads on them, as well as create a MachineConfigPool for infra nodes and move the Ingress Controller to the infra nodes.

### Example Usage
Example invocation of the role in a playbook
```yaml
---
- name: Cluster config
  gather_facts: no
  hosts: localhost
  
  roles:
    - scheduler_config
```
