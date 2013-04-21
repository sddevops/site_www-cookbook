name             "site_www"
maintainer       "Alexander van Zoest"
maintainer_email "cookbooks@vanzoest.com"
license          "Apache 2.0"
description      "Installs/Configures www.sddevops.org"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"


supports "ubuntu"

depends  "apache2"
depends  "git", "~> 2.3.0"
