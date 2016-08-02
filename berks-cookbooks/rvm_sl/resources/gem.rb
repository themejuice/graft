resource_name :rvm_gem

default_action :create

property :instance_name, String, name_property: true
property :ruby_version, required: true
property :home, String, default: node['rvm']['user']['home']
property :user_name, String, default: node['rvm']['user']['name']

action :create do
  gem_version = instance_name

  execute 'installing_gem' do
    environment 'HOME' => home
    command "bash -l -c 'rvm use #{ruby_version}; gem install #{gem_version}'"
    user user_name
    group 'rvm'
  end
end
