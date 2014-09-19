require 'fog'

service = Fog::Storage.new({
  :provider            => 'OpenStack',   # OpenStack Fog provider
  :openstack_username  => 'newhire:newhire',      # Your OpenStack Username
  :openstack_api_key   => 'testing',      # Your OpenStack Password
  :openstack_auth_url  => 'http://10.110.178.38:8080/auth/v1.0'
})

puts service.requests.to_s

response = service.head_containers
puts response.to_s 
puts response.status.to_s 


puts service.directories

#create container 
service.directories.create(:key => 'jiafeiz')


puts service.directories.get("myfiles").to_s

#download container files 
puts service.directories.get("myfiles").files


#upload file
file = service.directories.get("jiafeiz").files.create(:key => 'file-from-fog-api.gl', :body => File.open("Openstack-Swift-API.gl"))

#To get one file and rename  
File.open('download-file-from-aoi.gl', 'w') do | f |
  service.directories.get("myfiles").files.get("file-from-fog-api.gl") do | data, remaining, content_length |
    f.syswrite data
  end
end
#If a file object has already been loaded into memory, you can save it as follows:
#File.open('germany.jpg', 'w') {|f| f.write(file_object.body) }

#To get one file 
puts service.directories.get("myfiles").files.get("cf-mongodb.txt")

#To delete a file:
puts  service.directories.get("myfiles").files.get("cf-mongodb.txt").destroy



