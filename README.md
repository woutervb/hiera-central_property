# hiera-central_property
This project is used to integrate a tool for storing key-value pairs in an
unique hierarchical way with puppet. This tool can be found on github:
[https://github.com/woutervb/central_property].

When using this integration option the hiera framework has to be installed.

The other requirement is that the hierarchy defined in central is the reverse
of the dns as used for the nodenames in puppet. This means that a host with
as fqdn: _www.vanbommelonline.nl_ needs to have it parameters defined in a
hierarchy defined like the one below

    nl
      vanbommelonline
       - key-value pair 1
       - key-value pair 2
       - key-value pair 3
        www
         - key-value pair 1 override

If a puppet manifest referes to the key of key-value pair 1, then for this
node the override value will be used in the manifests. For other nodes the
value as defined at the vanbommelonline level.

# Example hiera.yaml file
In order to make a connection it is needed to setup the application
central_property on an http server (no https at the moment, sorry).
The following YAML file (in /etc/puppet/hiera.yaml) can be used as an
example for the integration:

    ---
    :backends: - property_central

    :logger: console

    :property_central:
       :url: http://property_central.hostname.fqdn:8000

Examples on how to use hiera within puppet can be found at
[http://projects.puppetlabs.com/projects/hiera]

# License
This project is licensed under [GPLv2].
[GPLv2]: http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
[https://github.com/woutervb/central_property]: 
https://github.com/woutervb/central_property
[http://projects.puppetlabs.com/projects/hiera]: 
http://projects.puppetlabs.com/projects/hiera