#ruby 1.9.3   
#ruby 
#
require 'rubygems'
require 'openstack'


class SwiftStorage

   @user = 'newhire:newhire'
   @key  = 'testing'
   @url  = 'http://10.110.178.38:8080/auth/v1.0' 

   #connect to Swift(nginx)  
   swiftstorage = OpenStack::Connection.create(:username => @user, :api_key => @key, :auth_url => @url, :service_type => "object-store")
   #print information about Swift 
   puts swiftstorage.get_info  
   # create container 
   puts swiftstorage.create_container('lingchuan')
   # Get list of containers under this account:
   puts swiftstorage.containers
   # Get details of containers under this account:
   puts swiftstorage.containers_detail

   # Check if a container exists
   puts swiftstorage.container_exists?("no_such_thing")
   puts swiftstorage.container_exists?("lingchuan")


   ##Warning## Delete container
   puts swiftstorage.delete_container("lingchuan")

   # Get a container (OpenStack::Swift::Container object):
   puts  swiftstorage.container("myfiles")

   # Retrieve container metadata:
   puts swiftstorage.container("myfiles").container_metadata
   # Retrieve user defined metadata:
   puts swiftstorage.container("myfiles").metadata 

   # Set user defined metadata:
   puts swiftstorage.container("myfiles").set_metadata({"X-Container-Meta-Author"=> "garfield", "version"=>"1.2", :date=>"today"})
  
   ## Get list of objects:
   puts swiftstorage.container("myfiles").objects 

   # Get list of objects with details:
   puts swiftstorage.container("myfiles").objects_detail

   # Check if container is empty:
   puts swiftstorage.container("myfiles").empty?

   # Check if object exists:
   puts swiftstorage.container("myfiles").object_exists?("cf-mongodb.txt")

   # Create new object   #[can also supply File.open(/path/to/file) and the data]
  puts swiftstorage.container("myfiles").create_object("file-from-ruby-api", {:metadata=>{"herpy"=>"derp"}, :content_type=>"text/plain"}, "this is the data from mem")
#  puts swiftstorage.container("myfiles").create_object("file-from-ruby-api", {:metadata=>{"herpy"=>"derp"}, :content_type=>"text/plain"}, File.open("/root/testfile.zip"))

  # Delete object
  # puts swiftstorage.container("myfiles").delete_object("file-from-ruby-api") 
 
# Get handle to an OpenStack::Swift::StorageObject Object
   #puts swiftstorage.container("myfiles").object("file-from-ruby-api")

  # Get object metadata
  # puts swiftstorage.container("myfiles").object("file-from-ruby-api").object_metadata




end
