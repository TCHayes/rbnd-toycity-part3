class Product
	attr_reader :title
	attr_reader :price
	attr_reader :stock

 
    @@products = []

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]
        add_to_products
    end
 
    def self.all
        @@products
    end

    def self.find_by_title(title)
        @@products.find {|product| product.title == title}
    end

    def in_stock?
        if self.stock > 0
            true
        else
            false
        end
    end    

    def self.in_stock
        @@products.find_all { |product| product.in_stock? == true}
    end

    private

    def add_to_products
        if @@products.to_s.include? self.title
            raise DuplicateProductError.new, "#{self.title} already exists."
        else
            @@products << self
        end
    end
end