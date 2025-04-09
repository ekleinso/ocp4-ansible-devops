# add_bmh_workers
This role file creates a BareMetalHost (BMH) object for each node in the bmh_nodes list. It also creates secrets for BMC authentication and network configuration. The role then waits for the BMH to be in a ready state before proceeding.

Pre-requisites: The Ansible controller must have access to the OpenShift cluster and the metal3-io/metal-operator must be installed in the cluster.

Explanation for files:

- defaults/main.yml: This file contains the default variables used in the role. It includes the region, node details, and secrets for BMC authentication and network configuration.
- tasks/main.yml: This file contains the tasks that are executed by the role. It creates the BMC secret, nmstate secret, and BareMetalHost object for each node in the bmh_nodes list. It also waits for the BMH to be in a ready state before proceeding.

The tasks in the role file are used to create the necessary resources in the OpenShift cluster to manage the BareMetalHost nodes. The BMC secret contains the username and password for BMC authentication, while the nmstate secret contains the network configuration for the nodes. The BareMetalHost object represents the physical hardware and its configuration. The role then waits for the BMH to be in a ready state before proceeding, ensuring that the nodes are ready to be used.

### Role Variables
Default role variables that are defined.
```yaml
bmh_region: "us-east-1"
bmh_nodes:
  - name: "worker03"
    bmcuser: "admin"
    bmcpassword: "password"
    bmcurl: "redfish-virtualmedia://192.168.7.13:8000/redfish/v1/Systems/ocpxe-worker03"
    rootDevice: "/dev/vda"
    bootMACAddress: "aa:54:00:ea:33:b2"
    bootMode: "UEFI"
    online: true
    zone: "us-east-1a"
```

### Example Usage
Example invocation of the role in a playbook

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
  - add_bmh_workers
```

OR if you want to override some default variables

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost
  vars:
    bmh_nodes:
      - name: "worker01"
        bmcuser: "admin"
        bmcpassword: "password"
        bmcurl: "redfish-virtualmedia://192.168.7.11:8000/redfish/v1/Systems/ocpxe-worker01"
        rootDevice: "/dev/vda"
        bootMACAddress: "aa:54:00:ea:33:b0"
        bootMode: "UEFI"
        online: true
        zone: "us-east-1a"
      - name: "worker02"
        bmcuser: "admin"
        bmcpassword: "password"
        bmcurl: "redfish-virtualmedia://192.168.7.12:8000/redfish/v1/Systems/ocpxe-worker02"
        rootDevice: "/dev/vda"
        bootMACAddress: "aa:54:00:ea:33:b1"
        bootMode: "UEFI"
        online: true
        zone: "us-east-1b"
  roles:
  - add_bmh_workers
```

The role has been used in a simulated baremetal environment with kvm/libvirt and sushy tools.