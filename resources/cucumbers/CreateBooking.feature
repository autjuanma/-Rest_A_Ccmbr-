Feature: New booking 

  Background: 
    Given she has access to the endpoint "/booking"

  Scenario Outline: To create new booking using cucumber Data Table
    When she creates a booking
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    Then she should receive a response code of 200
    And she validates the booking data
    And she validates the response against the JSON schema "create-booking-sch.json"

    Examples: 
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Alice     | Smith    |       1500 | true        | 2022-01-10 | 2022-01-20 | Lunch           |
      | Bob       | Johnson  |       3000 | false       | 2022-02-15 | 2022-03-25 | Brunch          |

  Scenario Outline: To create new booking using JSON data
    When she creates a booking using the data identified by "<objectKey>" from the JSON file "<jsonFile>"
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "create-booking-sch.json"

    Examples: 
      | objectKey      | jsonFile          |
      | createBooking1 | booking-data.json |
      | createBooking2 | booking-data.json |