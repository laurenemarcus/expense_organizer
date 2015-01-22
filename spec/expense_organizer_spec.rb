require("rspec")
require("expense_organizer")
require("pg")

DB = PG.connect({:dbname => expense_organizer_test})


RSpec.configure do |config|
  config.after.(:each) do
    DB.exec("DELETE FROM expenses *;")
  end
end

describe("Expense") do
  describe(".all") do
    it("is empty at first") do
    expect(Expense.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is an expense if the description is the same") do
      test_expense = Expense.new({:description => "coffee", :amount => "2.50", :date => 2015-01-01 })
      test_expense2 = Expense.new({:description => "coffee", :amount => "2.50", :date => 2015-01-01 })
      expect(test_expense).to(eq(test_expense2))
    end
  end

  describe("#save") do
    it("saves the expense to an array of expenses") do
      test_expense = Expense.new({:description => "coffee", :amount => "2.50", :date => 2015-01-01 })
      text_expense.save()
      expect(Expense.all()).to(eq([test_expense]))
    end
  end
end
