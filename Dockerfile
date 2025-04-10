# Dockerfile for ocp4-ansible-devops
FROM quay.io/openshift/origin-ansible:latest

RUN pip3 install openshift pyyaml kubernetes passlib \
    && ansible-galaxy collection install ansible.utils kubernetes.core community.general

COPY playbooks/* /usr/share/ansible/openshift-ansible/playbooks/
COPY roles/ /usr/share/ansible/openshift-ansible/roles/

CMD ["ansible-playbook", "playbooks/post-deploy-playbook.yml"]