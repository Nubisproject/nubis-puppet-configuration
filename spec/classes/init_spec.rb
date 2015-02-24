require 'spec_helper'
describe 'nubis_configuration' do

  context 'with defaults for all parameters' do
    it { should contain_class('nubis_configuration') }
  end
end
