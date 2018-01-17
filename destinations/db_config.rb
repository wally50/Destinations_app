# settings for activerecord

require 'pg'
require 'active_record'
options = {
  adapter: 'postgresql',
  database: 'destinations'
}

ActiveRecord::Base.establish_connection(options)
