# vault
This role file retrieves information from vault and sets as facts for use in the ansible automation.

- tasks/main.yml: This file contains the tasks that are executed by the role. It retrieves a secret from vault and sets facts to be used in subsequent ansible roles.

### Example Usage
Example invocation of the role in a playbook

```yaml
---
- name: Configure Cluster
  gather_facts: no
  hosts: localhost

  roles:
  - vault
```
