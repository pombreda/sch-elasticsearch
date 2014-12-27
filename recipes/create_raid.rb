#
# Cookbook Name:: sch-elasticsearch
# Recipe:: create_raid
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

instance_storage = ["/dev/xvdb", "/dev/xvdc"]
Chef::Log.warn("instance storage array is: #{instance_storage}")
mnt_index = 1

instance_storage.each do |dv|
  Chef::Log.warn("Unmounting device: #{dv} at /mnt/ephemeral#{mnt_index}")
  mount "/mnt/ephemeral#{mnt_index}" do
    device dv
    action [ :umount, :disable ]
  end
  mnt_index = mnt_index + 1
end

mdadm "/dev/md0" do
  devices instance_storage
  level 0
  action [ :create, :assemble ]
end