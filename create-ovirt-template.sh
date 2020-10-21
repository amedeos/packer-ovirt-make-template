#!/usr/bin/env bash
#
ANSIBLE_PLAYBOOK=$(which ansible-playbook)
VAULT_FILE=vault-file
PLAYBOOKS=(packer-qemu.yaml ovirt-make-template.yaml)

for playbook in "${PLAYBOOKS[@]}"; do
    echo "Run playbook: ${playbook}"
    $ANSIBLE_PLAYBOOK -i hosts --vault-password-file $VAULT_FILE ${playbook}
    STATUS=$?
    if [ ${STATUS} -gt 0 ]; then
        echo "Error in playbook ${playbook}... Exit"
        exit ${STATUS}
    fi
done
