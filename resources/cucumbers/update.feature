Feature: To update a booking in restful-booker

  Background: create an auth token
    Given she has access to the endpoint "/auth"
    When she creates a auth token
    Then she should receive a response code of 200

  @upd-booking-dt
  Scenario Outline: To update a booking using cucumber Data Table
    Given she has access to the endpoint "/booking"
    When sends request to retrieve the booking IDs
    And she updates the booking details
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "json-booking-schema.json"

    Examples: 
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Mickey    | Mouse    |      10000 | true        | 2021-05-15 | 2021-06-11 | Breakfast       |
      | Tasmanian | Devil    |       2006 | false       | 2021-06-01 | 2021-07-10 | Dinner          |

  @upd-booking-json
  Scenario Outline: To update a booking using JSON data
    Given she has access to the endpoint "/booking"
    When sends request to retrieve the booking IDs
    And updates the booking details using the data identified by "<objKey>" from the JSON file named "<jsonFile>" .
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "update-object-file.json"

    Examples: 
      | objKey           | jsonFile                |
      | upd-booking-0001 | update-object-file.json |
      | upd-booking-0002 | update-object-file.json |
      | upd-booking-0003 | update-object-file.json |
      | upd-booking-0004 | update-object-file.json |
      | upd-booking-0005 | update-object-file.json |
      | upd-booking-0006 | update-object-file.json |

  @partial-update
  Scenario: To partially update a booking
    Given she has access to the endpoint "/booking"
    When sends request to retrieve the booking IDs
    And makes a request to update the first name to "Mickey" and the last name to "Mouse"
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "update-object-file.json"
