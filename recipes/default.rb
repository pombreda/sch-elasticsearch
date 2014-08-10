#
# Cookbook Name:: sch-elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 David F. Severski
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# only run the ebs recipe if we're running on EC2
if node.attribute?('cloud') && node['cloud']['provider'] == "ec2"
  include_recipe "elasticsearch::ebs"
end

include_recipe "elasticsearch::data"
include_recipe "elasticsearch::default"
include_recipe "elasticsearch::plugins"

#override the logging template with our version, which has a 7 day rotation
template "logging.yml" do
  path   "#{node['elasticsearch']['path']['conf']}/logging.yml"
  source "logging.yml.erb"
  owner  node['elasticsearch']['user'] and group node['elasticsearch']['user'] and mode 0755

  notifies :restart, 'service[elasticsearch]' unless node['elasticsearch']['skip_restart']
end