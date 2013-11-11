Feature: Products
	In order to catalogue all my products
	As a products-collector
	I want to be able to add products to my catalogue
	
	Scenario: Add a product to my catalogue
		Given I am on the homepage
		When I enter valid product details
		And submit the form
		Then I should see the product title