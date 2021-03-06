# Encoding: UTF-8

require_relative '../spec_helper'

describe 'dnsmasq-local::default::config' do
  describe file('/etc/dnsmasq.d/dns.conf') do
    it 'is listening on the local interface only' do
      expect(subject.content).to match(/^interface=$/)
    end

    it 'is not caching lookup results' do
      expect(subject.content).to match(/^cache-size=0$/)
    end

    it 'is sticking to the system ephemeral port range' do
      expect(subject.content).to match(/^query-port=0$/)
    end
  end
end
