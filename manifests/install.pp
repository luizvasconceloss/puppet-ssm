# Install the ssm package
class ssm::install inherits ssm {
  case $::operatingsystem {
    'Ubuntu': {
      exec { 'download_ssm-agent':
        command => "/usr/bin/wget -N https://amazon-ssm-${::region}.s3.amazonaws.com/latest/debian_amd64/amazon-ssm-agent.deb -O /opt/amazon-ssm-agent.deb",
        path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
        creates => '/opt/amazon-ssm-agent.deb',
      }

      package { 'amazon-ssm-agent':
        provider  => 'dpkg',
        source    => '/opt/amazon-ssm-agent.deb',
        subscribe => Exec['download_ssm-agent'],
      }
    }
    'CentOS': {
      exec { 'download_ssm-agent':
        command => "/usr/bin/wget -N https://amazon-ssm-${::region}.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm -O /opt/amazon-ssm-agent.rpm",
        path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
        creates => '/opt/amazon-ssm-agent.rpm',
      }
      package { 'amazon-ssm-agent':
        provider  => 'rpm',
        source    => '/opt/amazon-ssm-agent.rpm',
        subscribe => Exec['download_ssm-agent'],
      }
    }
    default: { fail("The ${module_name} module is not supported on ${::osfamily}/${::operatingsystem}.") }
  }
}

