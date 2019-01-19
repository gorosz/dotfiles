import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_tmux_is_installed(host):
    package = host.package('tmux')
    assert package.is_installed


def test_tmux_folder_is_in_place(host):
    ff = host.file('/home/gergelyorosz/.tmux')
    assert ff.is_symlink
    assert ff.linked_to == '/home/gergelyorosz/dotfiles/roles/tmux/files/tmux.link'


def test_tmux_config_is_in_place(host):
    ff = host.file('/home/gergelyorosz/.tmux.conf')
    assert ff.is_symlink
    assert ff.linked_to == '/home/gergelyorosz/dotfiles/roles/tmux/files/tmux.conf.link'
