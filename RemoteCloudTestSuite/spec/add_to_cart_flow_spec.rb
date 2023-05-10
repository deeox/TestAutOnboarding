describe 'AddToCart Steps' do
  before(:each) do
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @vars = {}

    @driver.get('https://bstackdemo.com/')
  end

  after(:each) do
    @driver.quit
  end

  it 'should add product to cart' do
    @wait.until { @driver.find_element(:css, '.shelf-item').displayed? }
    @wait.until { @driver.find_element(:css, '.shelf-item').displayed? }
    product_to_buy = @driver.find_element(:css, '#\31 > .shelf-item__title').text
    @wait.until { @driver.find_element(:css, '#\31 > .shelf-item__buy-btn') }.click
    product_added_to_cart = @wait.until do
      tmp_element = @driver.find_element(:css, '.shelf-item__details > .title')
      tmp_element if tmp_element.displayed?
    end
    expect(product_to_buy).to eq(product_added_to_cart.text)
    expect(@driver.find_elements(:css, '.buy-btn').length).to eq(1)
  end
end
