# Class activemq::redhat
#
# This class installs the packages needed for the ActiveMQ package provided in 
# http://marionette-collective.org/activemq/

class activemq::redhat {

    package { "java-1.6.0-openjdk":
        ensure => present,
    }

    #package { "activemq-info-provider":
    #    ensure => present,
    #}

    package { "activemq-info-provider":
		provider => rpm,
		source => "http://puppetlabs.com/downloads/mcollective/activemq-info-provider-5.4.0-2.el5.noarch.rpm"
        ensure => installed,
    }


}

