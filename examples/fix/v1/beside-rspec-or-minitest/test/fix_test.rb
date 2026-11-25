require "minitest/autorun"
require "rbconfig"

# Every file of fix/ is a test of this suite: passed when it exits with 0,
# and what it wrote is the message when it does not.
class FixTest < Minitest::Test
  Dir.glob(File.join(__dir__, "..", "fix", "**", "*_fix.rb")).each do |file|
    define_method("test_#{File.basename(file, ".rb")}") do
      output, = capture_subprocess_io { system(RbConfig.ruby, file) }
      assert_predicate $?, :success?, output
    end
  end
end
