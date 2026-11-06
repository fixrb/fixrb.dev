# With the gem in a Gemfile, this is require "kvstore/specification";
# here the two projects sit side by side.
require_relative "../../kvstore/lib/kvstore/specification"

class HashStore
  def initialize = @entries = {}
  def fetch(key) = @entries[key]
  def store(key, value) = tap { @entries[key] = value }
  def delete(key) = @entries.delete(key)
end

exit(Fix[:KVStore].test { HashStore.new })
