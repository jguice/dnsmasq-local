require_relative '../../../spec_helper'

describe 'resource_dnsmasq_local_app::ubuntu::14_04' do
  let(:name) { 'default' }
  let(:action) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(
      step_into: 'dnsmasq_local_app', platform: 'ubuntu', version: '14.04'
    ) do |node|
      %i(name action).each do |p|
        unless send(p).nil?
          node.set['resource_dnsmasq_local_app_test'][p] = send(p)
        end
      end
    end
  end
  let(:converge) do
    runner.converge('resource_dnsmasq_local_app_test')
  end

  context 'the default action (:install)' do
    let(:action) { nil }
    cached(:chef_run) { converge }

    it 'ensures the APT cache is up to date' do
      expect(chef_run).to include_recipe('apt')
    end

    it 'installs the Dnsmasq package' do
      expect(chef_run).to install_package('dnsmasq')
    end
  end

  context 'the :remove action' do
    let(:action) { :remove }
    cached(:chef_run) { converge }

    it 'purges the dnsmasq packages' do
      %w(dnsmasq dnsmasq-base).each { |p| expect(chef_run).to purge_package(p) }
    end
  end
end
