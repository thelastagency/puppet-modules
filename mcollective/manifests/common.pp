class mcollective::common {
	package { "mcollective-common": 
       provider => rpm, 
       ensure => installed, 
       source => "http://puppetlabs.com/downloads/mcollective/mcollective-common-0.4.10-1.el5.noarch.rpm",
	}
}