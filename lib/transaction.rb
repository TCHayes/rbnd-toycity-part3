class Transaction
	attr_reader :id
	attr_reader :product
	attr_reader :customer

	@@count = 0
	@@transactions = []

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

	def self.all
		@@transactions
	end

	private

end