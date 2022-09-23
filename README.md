# ocp4-ansible-devops
A collection of ansible roles facilitating Day-2 operations for OpenShift

ansible-galaxy collection git+https://github.com/ekleinso/ocp4-ansible-devops.git

namespace: ibmce
collection: ocp_ansible

roles:
- ibmce.ocp_ansible.wait_for_odf
- ibmce.ocp_ansible.mvie
- ibmce.ansible_version_check

Sample playbook
```yaml
---
- name: Deploy MVIE
  gather_facts: no
  hosts: localhost
  vars:
   cluster_file_storage_class: ocs-storagecluster-cephfs
   cluster_block_storage_class: ocs-storagecluster-ceph-rbd
   mvie_storage_class: ocs-storagecluster-cephfs

   ibm_entitlement_key: "{{ lookup('env', 'IBM_ENTITLEMENT_KEY') }}"
   gpu_channel: v1.8
   gpu_namespace: openshift-operators
   gpu_driver_version: 450.80.02

  roles:
   - ibmce.ocp_ansible.wait_for_odf
   - ibm.mas_devops.ibm_catalogs
   - ibm.mas_devops.nvidia_gpu
   - ibmce.ocp_ansible.mvie
```

