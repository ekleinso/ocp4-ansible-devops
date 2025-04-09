# htpasswd
This Ansible role is used to enable htpasswd authentication in OpenShift. Creating an initial set of users with cluster-admin rights.

This Ansible role assumes that the Kubernetes cluster is already set up and that the necessary Ansible collections are installed.

- The users variable is a list of user names and passwords.
- The first task creates a ClusterRoleBinding for each user in the users list. This allows the users to have cluster-admin privileges.
- The second task adds each user and their password to a password file using the htpasswd module. This file is suitable for use by OpenShift.
- The third task creates an htpasswd secret in the openshift-config namespace. This secret contains the contents of the password file.
- The fourth task removes the password file.
- The fifth task enables htpasswd authentication by modifying the OAuth configuration.
- The sixth and seventh tasks wait for the Authentication operator to reach the Progressing state and then wait for it to finish reaching that state.

This Ansible role automates the process of setting up user authentication and cluster-admin privileges in an OpenShift environment.

### Role Variables
Default role variables that are defined.
```yaml
users:
  name: zeus
  password: olympus
```

### Example Usage
Example invocation of the role in a playbook

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
  - htpasswd
```

OR if you want to override some default variables

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost
  vars:
    users:
    - name: "my_user"
      password: "my_password"

  roles:
  - htpasswd
```
