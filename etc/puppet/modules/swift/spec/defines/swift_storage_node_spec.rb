describe 'swift::storage::node' do

  let :facts do
    {
      :operatingsystem => 'Ubuntu',
      :osfamily        => 'Debian',
      :processorcount  => 1,
      :concat_basedir  => '/var/lib/puppet/concat',
    }
  end

  let :params do
    {
      :zone => "1",
      :mnt_base_dir => '/srv/node'
    }
  end

  let :title do
    "1"
  end

  let :pre_condition do
    "class { 'ssh::server::install': }
     class { 'swift': swift_hash_suffix => 'foo' }
     class { 'swift::storage': storage_local_net_ip => '127.0.0.1' }"
  end

  it {
    should contain_ring_object_device("127.0.0.1:6010")
    should contain_ring_container_device("127.0.0.1:6011")
    should contain_ring_account_device("127.0.0.1:6012")
  }
end
