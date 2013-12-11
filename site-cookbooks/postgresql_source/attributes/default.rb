###
## Install Settings
####

# Version
default['postgres']['version'] =  "postgresql-9.2.5"

# Directory
default['postgres']['dir'] = "/usr/local/postgresql_9_2_5"
default['postgres']['src_dir'] = "/usr/local/src/"

# User
default['postgres']['install_user'] = "postgres"
default['postgres']['install_group'] = "postgres"

# Configure Options
default['postgres']['configure'] = "--prefix=#{default['postgres']['dir']}"

# User
default['postgres']['user']         = "postgres"
default['postgres']['group']        = "postgres"
