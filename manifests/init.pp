# = Class: hosts
#
# Manage standard /etc/hosts entries:
#
# - IPv4 loopback.
# - IPv6 lookback and multicast.
#
# == Parameters:
#
# [*purge*]
#   Purge unmanaged hosts entries. This is recommended.
#   Default: true
#
class hosts(
  $purge = true
) {
  resources { 'host':
    purge => $purge,
  }

  host { $::fqdn:
    ensure        => present,
    ip            => '127.0.1.1',
    host_aliases  => $::hostname,
  }

  host {
    'localhost':
      ensure        => present,
      ip            => '127.0.0.1';
    'ip6-localhost':
      ensure        => present,
      ip            => '::1',
      host_aliases  => [
        'ip6-loopback',
        'localhost',
      ];
    'ip6-localnet':
      ensure        => present,
      ip            => 'fe00::0';
    'ip6-mcastprefix':
      ensure        => present,
      ip            => 'ff00::0';
    'ip6-allnodes':
      ensure        => present,
      ip            => 'ff02::1';
    'ip6-allrouters':
      ensure        => present,
      ip            => 'ff02::2';
  }
}
