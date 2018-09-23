require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox

Given(/^Navigate to google$/) do
  driver.navigate.to "https://www.google.ru"
end

When(/^Search for the word Ruby$/) do
  driver.find_element(:id, 'lst-ib').send_keys("Ruby")
  driver.find_element(:xpath, "//input[@value='Поиск в Google']").click
end

Then(/^Find title of article in wikipedia about Ruby$/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  begin 
    element = wait.until { driver.find_element(:xpath => "//h3/a[contains(@href,'wiki')]") }
	expect(element.text).to eq('Ruby — Википедия')
  ensure
    driver.quit
  end
end