require 'selenium-webdriver'
require 'json'

describe 'Checkout Steps' do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @vars = {}

    @driver.get('https://bstackdemo.com/')
    @driver.manage.window.resize_to(1920, 984)
    login_with_demouser
    sleep 2
    add_to_cart
    sleep 2
  end

  after(:each) do
    @driver.quit
  end

  it 'should checkout with valid details' do
    @wait.until { @driver.find_element(:css, '.buy-btn') }.click
    @wait.until { @driver.find_elements(:css, '.checkout-form') }
    @driver.find_element(:id, 'firstNameInput').send_keys('abc')
    @driver.find_element(:id, 'lastNameInput').send_keys('abc')
    @driver.find_element(:id, 'addressLine1Input').send_keys('abc')
    @driver.find_element(:id, 'provinceInput').send_keys('abc')
    @driver.find_element(:id, 'postCodeInput').send_keys('123456')
    @driver.find_element(:id, 'checkout-shipping-continue').click
    expect(@wait.until { @driver.find_element(:id, 'confirmation-message').text }).to eq('Your Order has been successfully placed.')
  end

  def login_with_demouser
    @driver.find_element(:id, 'signin').click
    @wait.until { @driver.find_elements(:id, 'login-btn') }
    @wait.until { @driver.find_element(:id, 'react-select-2-input') }
    @driver.find_element(:id, 'react-select-2-input').send_keys('demouser', :enter)
    @driver.find_element(:id, 'react-select-3-input').send_keys('testingisfun99', :enter)
    @driver.find_element(:id, 'login-btn').click
    expect(@wait.until { @driver.find_element(:css, '.username').text }).to eq('demouser')
    expect(@driver.find_elements(:id, 'logout').length).to be > 0
  end

  def add_to_cart
    @wait.until { @driver.find_element(:css, '.shelf-item') }
    product_to_buy = @driver.find_element(:css, '#\31 > .shelf-item__title').text
    @wait.until { @driver.find_element(:css, '#\31 > .shelf-item__buy-btn') }.click
    sleep 2
    product_added_to_cart = @wait.until { @driver.find_element(:css, '.shelf-item__details > .title') }.text
    expect(product_to_buy).to eq(product_added_to_cart)
    expect(@driver.find_elements(:css, '.buy-btn').length).to eq(1)
  end
end
