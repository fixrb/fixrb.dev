require "fix"

class Price
  def initialize(amount, rate: 0)
    @amount = amount
    @rate = rate
  end

  def total = @amount - (@amount * @rate / 100)
end

Fix :Price do
  let(:amount) { 100 }
  let(:rate) { 0 }

  on :total do
    it MUST eq 100

    with rate: 20 do
      it MUST eq 80
    end
  end

  with amount: 50, rate: 10 do
    on :total do
      it MUST eq 45
    end
  end
end

exit(Fix[:Price].test { Price.new(amount, rate:) })
