#
# Copyright:: Copyright (c) 2013 Alexander van Zoest
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# defaults
default[:site_www][:user] = "vagrant"
default[:site_www][:app_name] = "www"
default[:site_www][:vhostdomain] = "sddevops.org"
default[:site_www][:migrate] = false
default[:site_www][:migrate_command] = ""
default[:site_www][:action] = "deploy"
default[:site_www][:repo] = "git://github.com/sddevops/www.sddevops.org.git"
default[:site_www][:revision] = "master"
