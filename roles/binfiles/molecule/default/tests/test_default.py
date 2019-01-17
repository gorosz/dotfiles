import os
import pytest

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_local_bin_folder_created(host):
    local_bin_dir = host.file("/home/gergelyorosz/.local/bin")

    assert local_bin_dir.is_directory


@pytest.mark.parametrize('f', ["b1", "b2"])
def test_bin_files_get_linked(f, host):
    ff = host.file("/home/gergelyorosz/.local/bin/{}".format(f))
    assert ff.is_symlink
    assert ff.linked_to == "/home/gergelyorosz/dotfiles/roles/binfiles/files/{}".format(f)
