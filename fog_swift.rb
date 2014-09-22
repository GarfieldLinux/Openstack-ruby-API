require 'fog'


class FogSwift
      
   @service  = ''
   @container_name = ''

    
   def initialize(_username,_appuser,_apppasswd,_authurl)
      begin
         @container_name = _username
         @service = Fog::Storage.new({
            :provider            => 'OpenStack',     # OpenStack Fog provider
            :openstack_username  => _appuser,        # Your OpenStack Username
            :openstack_api_key   => _apppasswd,      # Your OpenStack Password
            :openstack_auth_url  => _authurl         # Your OpenStack auth_url 
         })
      rescue  Exception => e
          puts "Unable to connect to Swift server , Message: #{e}"
          exit
      end
   end

def show_service_requests
   puts @service.requests.to_s
end

def show_service_head_containers
   response = @service.head_containers
   puts response.to_s
   #response.status  
   puts response.headers.to_s
   puts response.status.to_s
   puts response.body.to_s
end

def show_all_containers 
   #show all the containers under user 
   puts @service.directories.to_s
end

def create_container()
   #create container
   puts @service.directories.create(:key => @container_name)
end

def get_container()
   #get_container
   puts @service.directories.get(@container_name).to_s
end

def show_container_files()
   #show container files
   puts "get all the files under one container " 
   puts @service.directories.get(@container_name).files
end

def upload_container_file(_file_name,_source_file_path,_file_data)
   if (_source_file_path != '') && (_file_data =='') then
   #upload file under one container  data from file on disk
      file = @service.directories.get(@container_name).files.create(:key => _file_name, :body => File.open(_source_file_path))
   elsif (_source_file_path == '') && (_file_data !='') then
   #upload file under one container  data from file in mem 
      file = @service.directories.get(@container_name).files.create(:key => _file_name, :body => _file_data)
   else
      puts "wrong number of arguments"
      return -1
      exit
   end   
end

def download_contain_file(_swift_filename,_download_filename)
   #To get one file and rename  
   File.open(_download_filename, 'w') do | f |
      @service.directories.get(@container_name).files.get(_swift_filename) do | data, remaining, content_length |
         f.syswrite data
      end
   end
   #If a file object has already been loaded into memory, you can save it as follows:
   #File.open('germany.jpg', 'w') {|f| f.write(file_object.body) }
end

def get_file_message(_filename)
   #To get one file 
   puts @service.directories.get(@container_name).files.get(_filename).to_s
end

def delete_container_file(_swift_filename)
   #To delete a file:
   puts  @service.directories.get(@container_name).files.get(_swift_filename).destroy
end

end

############################################################## test ###################################################################

vmswift_a = FogSwift.new('vmswift_a','newhire:newhire','testing','http://10.110.178.38:8080/auth/v1.0') 

vmswift_a.create_container()

vmswift_a.show_all_containers()

vmswift_a.upload_container_file('vmswift_a.txt','','vmswift_a content')
vmswift_a.download_contain_file('vmswift_a.txt','a.txt')
vmswift_a.upload_container_file('vmswift_a.txt','','vmswift_a content update')
vmswift_a.download_contain_file('vmswift_a.txt','a.txt')

