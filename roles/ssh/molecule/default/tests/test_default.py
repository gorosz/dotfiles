import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_ssh_key_files(host):
    private_key = host.file(os.path.expanduser('~/.ssh/id_rsa'))
    public_key = host.file(os.path.expanduser('~/.ssh/id_rsa.pub'))

    assert private_key.exists
    assert public_key.exists
