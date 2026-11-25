require_relative "specs/duck"
require_relative "../lib/duck"

exit(Fix[:Duck].test { Duck.new })
