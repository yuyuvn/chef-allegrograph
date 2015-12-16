#
# Cookbook Name:: AllegroGraph
# Recipe:: default
#

case node['platform_family']
when 'rhel', 'fedora', 'centos'
  remote_file '/tmp/' + node['allegrograph']['package_name'] + '.rpm' do 
    source node['allegrograph']['rpm_url']
    checksum node['allegrograph']['rpm_checksum']
    not_if { ::File.exists?("/etc/agraph/agraph.cfg") }
  end

  rpm_package node['allegrograph']['package_name'] do 
    action :install
    source '/tmp/' + node['allegrograph']['package_name'] + '.rpm'
  end

  directory '/etc/agraph' do
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end
  
  template 'cfgfile' do
    path '/etc/agraph/agraph.cfg'
    source 'agraph.cfg.erb'
    owner  'root'
    mode 0755
    action :create
  end
  
  service 'agraph' do
    action :start
  end
else
  remote_file '/tmp/' + node['allegrograph']['package_name'] + '.tar.gz' do 
    source node['allegrograph']['tar_url']
    checksum node['allegrograph']['tar_checksum']
    not_if { ::File.exists?("/usr/local/allegrograph/bin/agraph-control") }
  end
  
  directory '/tmp/agraph' do
    owner 'root'
    group 'root'
    mode 0755
    action :create
  end
  
  execute "unpack allegrograph" do
    command "tar xzf /tmp/#{node['allegrograph']['package_name']}.tar.gz --strip-components=1 -C /tmp/agraph"
    creates "/usr/local/allegrograph"
  end
  
  execute "install allegrograph" do
    command "/tmp/agraph/install-agraph /usr/local/allegrograph --non-interactive --super-user #{node['allegrograph']['super_user']['name']} --super-password #{node['allegrograph']['super_user']['password']} --runas-user root"
    creates "/usr/local/allegrograph"
  end
  
  template 'cfgfile' do
    path '/usr/local/allegrograph/lib/agraph.cfg'
    source 'agraph.cfg.erb'
    owner  'root'
    mode 0755
    action :create
  end
  
  execute "start allegrograph" do
    command "/usr/local/allegrograph/bin/agraph-control --config /usr/local/allegrograph/lib/agraph.cfg start"
  end
end
