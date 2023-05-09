require 'selenium-webdriver'
require 'json'

describe 'AddToCart Steps' do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @vars = {}

    @driver.get('https://bstackdemo.com/')
    @driver.manage.window.resize_to(1920, 984)
  end

  after(:each) do
    @driver.quit
  end

  it 'should add product to cart' do
    @wait.until { @driver.find_element(:css, '.shelf-item') }
    product_to_buy = @driver.find_element(:css, '#\31 > .shelf-item__title').text
    @wait.until { @driver.find_element(:css, '#\31 > .shelf-item__buy-btn') }.click
    product_added_to_cart = @driver.find_element(:css, '.shelf-item__details > .title').text
    expect(product_to_buy).to eq(product_added_to_cart)
    expect(@driver.find_elements(:css, '.buy-btn').length).to eq(1)
  end
end
