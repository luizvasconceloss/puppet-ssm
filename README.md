# ssm

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ssm](#setup)
    * [What ssm affects](#what-ssm-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ssm](#beginning-with-ssm)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Downloads and installs the amazon-ssm-agent, i.e. the EC2 run command agent

## Setup

### Setup Requirements

This module support Ubuntu 14.04 (Trusty) and 12.04 (Precise) and CentOS 6.3+
Pull requests for other distributions welcome.

## Usage

    class { 'ssm':
      region => 'us-east-1',
    }

## Limitations

Only tested with Ubuntu 14.04 (Trusty) and 12.04 (Precise) by myself.
@chroto submitted a pull request for CentOS support, I assume he tested it. :-)

Will not work with any other distros. Pull requests accepted.

## Release Notes/Contributors/Etc. **Optional**

Check the CHANGELOG.md for release notes and bug fixes.

