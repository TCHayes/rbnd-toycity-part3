class Transaction
	attr_reader :id
	attr_reader :product
	attr_reader :customer

	@@count = 0
	@@transactions = []
	@@returned_transactions = [] #Keeps record of returned transactions

	def initialize(customer, product)
		if product.in_stock?
			@@count = @@count + 1
			@id = @@count
			@product = product
			@customer = customer
			product.reduce_stock
			@@transactions << self
		else
			raise OutOfStockError.new, "#{product.title} is out of stock."
		end
	end

	def self.find(id)
		@@transactions.find {|transaction| transaction.id == id}
	end

	def self.find_by_customer(customer) #Used to find all transactions by given customer
		@@transactions.find_all {|transaction| transaction.customer.name == customer}
	end

	def self.all
		@@transactions
	end

	def self.returned(id) #Used to return items
		returned_transaction = Transaction.find(id)
		@@returned_transactions << @@transactions.delete(returned_transaction)
		returned_transaction.product.increase_stock
	end
end