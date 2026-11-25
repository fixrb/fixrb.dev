require "fix"

class Counter
  attr_reader :count

  def initialize(start) = @count = start
  def increment = tap { @count += 1 }
end

Fix :Counter do
  let(:start) { 0 }

  on :count do
    it MUST eq 0
  end

  on :increment do
    on :count do
      it MUST eq 1
    end
  end

  with start: 5 do
    on :count do
      it MUST eq 5
    end
  end
end

exit(Fix[:Counter].test { Counter.new(start) })
