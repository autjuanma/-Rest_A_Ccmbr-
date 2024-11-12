Feature: booking rm/DELETE scenarios

  Background: create an auth token
    Given she has access to the endpoint "/auth"
    When she creates a auth token
    Then she should receive a response code of 200

  @delete-by-id
  Scenario: To delete a booking
    Given she has access to the endpoint "/booking"
    When sends request to retrieve the booking IDs
    When performs to booking delete request with mecanims basic auth
    Then she should receive a response code of 201

  @regression
  Scenario Outline: Regression E2E
    Given she has access to the endpoint "/booking"
    When she creates a booking
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "json-booking-schema.json"
    And she updates the booking details
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    And she should receive a response code of 200
    And she validates the response against the JSON schema "booking-details-schema.json"
    And sends request to retrieve the booking IDs
    And she should receive a response code of 200
    And performs to booking delete request with mecanims basic auth
    And she should receive a response code of 201

    Examples: 
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | John      | Doe      |       1200 | true        | 2021-05-05 | 2021-05-15 | Breakfast       |
