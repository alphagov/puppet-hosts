require 'spec_helper'

describe 'hosts' do
  context 'purge' do
    it { should contain_resources('host').with_purge(true) }
  end

  context 'fqdn' do
    let(:facts) {{
      :hostname  => 'foo',
      :fqdn      => 'foo.example.com',
      :ipaddress => '1.1.1.1',
    }}

    it {
      should contain_host('foo.example.com').with(
        :ip           => '1.1.1.1',
        :host_aliases => 'foo',
      )
    }
  end

  context 'loopback' do
    it { should contain_host('localhost').with_ip('127.0.0.1') }
    it { should contain_host('ip6-localnet').with_ip('fe00::0') }
    it { should contain_host('ip6-mcastprefix').with_ip('ff00::0') }
    it { should contain_host('ip6-allnodes').with_ip('ff02::1') }
    it { should contain_host('ip6-allrouters').with_ip('ff02::2') }

    it {
      should contain_host('ip6-localhost').with(
        :ip           => '::1',
        :host_aliases => 'ip6-loopback',
      )
    }
  end
end
