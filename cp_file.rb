# find env file
# load contents of metadata entry
# add entry
# resave file
require 'json'
# require 'fileutils'

local_file, container_destination = ARGV[0].split(':')
env_file = ARGV[1]

# PREP ENTRY to ENV_VAR_HELPER

# DOES ENV FILE EVEN EXIST?
  # DOES ENV_VAR_HELPER entry exist?
    # DOES entry within ENV_VAR_HELPER exist?
      # if so, modify contents. Else create new entry within ENV_VAR_HELPER

serialized_env_var_helper_data = File.readlines(env_file).find {|line| line =~ '^ENV_VAR_HELPER=' }.sub('ENV_VAR_HELPER=','')
env_var_helper_data = JSON.parse(serialized_env_var_helper_data)

content = File.read(local_file)

# overwrite content data if file instructions already exist
its_not_a_new_entry = false
env_var_helper_data.map! do |entry|
  if entry[:container_destination] == container_destination
    its_not_a_new_entry = true
    entry[:content] = content
  end
  entry
end

# add file instruction if instruction currently does not exist
env_var_helper_data << { content: content, container_destination: container_destination } unless its_not_a_new_entry

env_file_entry = "ENV_VAR_HELPER=#{env_var_helper_data.to_json}"

# write new version of env_file, modifying ENV_VAR_HELPER entry
env_var_helper_entry_not_setup_yet = true
File.open("#{env_file}.new", 'w') do |file|
  File.readlines(env_file).each do |entry|
    if line =~ '^ENV_VAR_HELPER='
      env_var_helper_entry_not_setup_yet = false
      file.puts env_file_entry
    else
      file.puts entry
    end
  end
end

# write new version of env_file, modifying ENV_VAR_HELPER entry
File.open(env_file, 'a') { |f| f.puts env_file_entry } if env_var_helper_entry_not_setup_yet

File.delete(env_file)
File.rename("#{env_file}.new", env_file)
