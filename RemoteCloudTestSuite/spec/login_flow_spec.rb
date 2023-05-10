describe 'Login Steps' do
  before(:each) do
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    @vars = {}

    @driver.get('https://bstackdemo.com/')
  end

  after(:each) do
    @driver.quit
  end

  it 'should login with demouser' do
    @driver.find_element(:id, 'signin').click
    @wait.until { @driver.find_elements(:id, 'login-btn') }
    @wait.until { @driver.find_element(:id, 'react-select-2-input') }
    @driver.find_element(:id, 'react-select-2-input').send_keys('demouser', :enter)
    @driver.find_element(:id, 'react-select-3-input').send_keys('testingisfun99', :enter)
    @driver.find_element(:id, 'login-btn').click
    expect(@wait.until { @driver.find_element(:css, '.username').text }).to eq('demouser')
    elements = @driver.find_elements(:id, 'logout')
    expect(elements.length).to be > 0
  end

  it 'should not login without entering username' do
    @driver.find_element(:id, 'signin').click
    @wait.until { @driver.find_elements(:id, 'login-btn') }
    @wait.until { @driver.find_element(:id, 'react-select-2-input') }
    @driver.find_element(:id, 'react-select-3-input').send_keys('testingisfun99', :enter)
    @driver.find_element(:id, 'login-btn').click
    error_message_element = @wait.until { @driver.find_element(:css, '.api-error') }
    expect(error_message_element.text).to eq('Invalid Username')
  end

  it 'should not login without entering password' do
    @driver.find_element(:id, 'signin').click
    @wait.until { @driver.find_elements(:id, 'login-btn') }
    @wait.until { @driver.find_element(:id, 'react-select-2-input') }
    @driver.find_element(:id, 'react-select-2-input').send_keys('demouser', :enter)
    @driver.find_element(:id, 'login-btn').click
    error_message_element = @wait.until { @driver.find_element(:css, '.api-error') }
    expect(error_message_element.text).to eq('Invalid Password')
  end
end
