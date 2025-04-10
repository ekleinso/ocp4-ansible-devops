# certificates
This role is used to configure the cluster's ingress controller with a custom certificate and to configure the cluster's proxy with a custom root CA certificate.

The role file assumes that the necessary environment variables are set, which are used to populate the variables in the defaults/main.yml file.

The defaults/main.yml file contains the default values for the variables used in the role. The values are set using the lookup function, which retrieves the values from the environment variables.

The tasks/ingress_cert.yml file creates a Kubernetes secret with the custom certificate and key, and then patches the ingress controller to use this secret as the default certificate. The when condition ensures that the tasks in this file are only executed if the ingress_certificate variable is set.

The tasks/main.yml file includes the root_ca_cert.yml and ingress_cert.yml tasks based on the values of the ingress_certificate and ingress_key variables. This allows the role to be flexible and only execute the necessary tasks.

The tasks/root_ca_cert.yml file configures the cluster's proxy with the custom root CA certificate. It creates a ConfigMap with the root CA certificate and then updates the proxy configuration to use this ConfigMap. The when condition ensures that the tasks in this file are only executed if the root_ca variable is set and the root_ca_configmap variable is not set to "user-ca-bundle".

### Role Variables
Default role variables that are defined.
```yaml
root_ca: "{{ lookup('env', 'ROOT_CA') | default('', true) }}"
root_ca_configmap: "{{ lookup('env', 'ROOT_CA_SECRET') | default('user-ca-bundle', true) }}"
ingress_certificate: "{{ lookup('env', 'INGRESS_CERTIFICATE') | default('', true) }}"
ingress_key: "{{ lookup('env', 'INGRESS_KEY') | default('', true) }}"
```

### Example Usage
Example invocation of the role in a playbook
```yaml
---
- name: Cluster config
  gather_facts: no
  hosts: localhost
  vars:
    root_ca: "<base64 encoded PEM file>"
    root_ca_configmap: "custom-ca-bundle"
    ingress_certificate: "<base64 encoded PEM file>"
    ingress_key: "<base64 encoded PEM file>"

  roles:
    - certificates
```
