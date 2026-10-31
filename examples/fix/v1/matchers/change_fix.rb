require "fix"

COUNTER = Struct.new(:count).new(0)

Clicker = Data.define(:counter) do
  def click = counter.count += 1
  def look = counter.count
end

Fix :Clicker do
  on :click do
    it MUST change(COUNTER, :count).by(1)
  end

  on :click do
    it MUST change(COUNTER, :count).from(0).to(1)
  end

  on :look do
    it MUST change(COUNTER, :count).by_at_least(1)
  end
end

exit(Fix[:Clicker].test { Clicker.new(COUNTER) })
