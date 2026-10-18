require "aw"

raised = begin
  Aw.fork! { Integer("forty-two") }
rescue ArgumentError => e
  e
end
raised.message # => "invalid value for Integer(): \"forty-two\""

failed = begin
  Aw.fork! { Process.kill(:KILL, Process.pid) }
rescue Aw::ChildError => e
  e
end
failed.status.signaled? # => true
