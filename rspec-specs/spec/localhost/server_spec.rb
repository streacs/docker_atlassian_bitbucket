require 'spec_helper'
require 'serverspec'

describe file('/home/bitbucket') do
  it { should be_directory }
  it { should be_owned_by 'bitbucket' }
  it { should be_grouped_into 'bitbucket' }
end