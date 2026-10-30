require "fix"

class Account
  def initialize(balance)
    @balance = balance
  end

  attr_reader :balance

  def withdraw(amount)
    raise ArgumentError, "insufficient funds" if amount > balance

    @balance -= amount
  end
end

Fix :Account do
  on :balance do
    it MUST eq 100
    it MUST eq 200
    it SHOULD eq 200
  end

  on :currency do
    it MAY eq "EUR"
  end

  on :withdraw, 500 do
    it MUST eq(-400)
  end
end

Fix[:Account].test { Account.new(100) } # => false
