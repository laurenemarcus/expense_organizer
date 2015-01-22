class Expense
  attr_reader(:description, :amount, :date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)
    @id = attributes[:id]
  end


  define_singleton_method(:all) do
    expenses = []
    returned_expenses = DB.exec("SELECT * FROM expenses;")
    returned_expenses.each() do |expense|
      id = expense.fetch("id").to_i()
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_i()
      date = expense.fetch("date")
      expenses.push(Expense.new({:description => description, :amount => amount, :date=> date, :id => id}))
    end
    expenses
  end

  define_method(:==) do |expense|
    self.description().==(expense.description()).&(self.amount().==(expense.amount())).&(self.date().==(expense.date()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

end
