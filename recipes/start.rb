case node['platform_family']
when 'rhel', 'fedora', 'centos'
  service 'agraph' do
    action :start
  end
else
  execute "start allegrograph" do
    command "/etc/agraph/bin/agraph-control --config /etc/agraph/agraph.cfg restart"
  end
end
