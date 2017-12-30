require 'spec_helper'
require 'serverspec'

describe group('bitbucket') do
  it { should exist }
end

describe user('bitbucket') do
  it { should exist }
  it { should belong_to_group 'bitbucket' }
  it { should have_home_directory '/home/bitbucket' }
  it { should have_login_shell '/bin/false' }
end

describe file('/opt/jdk') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/home/bitbucket') do
  it { should be_directory }
  it { should be_owned_by 'bitbucket' }
  it { should be_grouped_into 'bitbucket' }
end

describe file('/opt/atlassian/bitbucket') do
  it { should be_directory }
  it { should be_owned_by 'bitbucket' }
  it { should be_grouped_into 'bitbucket' }
end

describe file('/var/opt/atlassian/application-data/bitbucket') do
  it { should be_directory }
  it { should be_owned_by 'bitbucket' }
  it { should be_grouped_into 'bitbucket' }
end

describe file('/opt/atlassian/bitbucket/bin/_start-webapp.sh') do
  it { should contain 'JVM_MINIMUM_MEMORY=2g' }
  it { should contain 'JVM_MAXIMUM_MEMORY=4g' }
  it { should contain 'JVM_SUPPORT_RECOMMENDED_ARGS="-server"' }
end

describe file('/opt/atlassian/bitbucket/bin/set-bitbucket-home.sh') do
  it { should contain 'BITBUCKET_HOME=/var/opt/atlassian/application-data/bitbucket' }
end