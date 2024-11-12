Feature: New booking

  Background: 
    Given she has access to the endpoint "/booking"

  Scenario Outline: To create new booking using cucumber Data Table
    When she creates a booking
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    Then she should receive a response code of 200
    And she validates the booking data
    And she validates the response against the JSON schema "json-booking-schema.json"

    Examples: 
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Ranma     | Saotome  |       1500 | true        | 2022-01-10 | 2022-01-20 | Martial Arts    |
      | Akane     | Tendo    |       3000 | false       | 2022-02-15 | 2022-03-25 | Cooking         |
      | Ryoga     | Hibiki   |       2500 | true        | 2022-03-01 | 2022-03-15 | Lost Adventures |
      | Shampoo   | Cat      |       3200 | false       | 2022-04-10 | 2022-04-20 | Noodles         |
      | Mousse    |          |       1800 | true        | 2022-05-05 | 2022-05-15 | Love Pursuit    |
      | Genma     | Saotome  |       2000 | false       | 2022-06-01 | 2022-06-10 | Training        |
      | Soun      | Tendo    |       1600 | true        | 2022-07-20 | 2022-07-30 | Family Honor    |
      | Nabiki    | Tendo    |       2200 | false       | 2022-08-15 | 2022-08-25 | Business        |
      | Kasumi    | Tendo    |       2800 | true        | 2022-09-05 | 2022-09-15 | Housekeeping    |
      | Kuno      | Tatewaki |       1900 | false       | 2022-10-10 | 2022-10-20 | Duel Challenges |
      | Ryouga    | Hibiki   |       2700 | true        | 2022-11-01 | 2022-11-10 | Adventure       |
      | Akane     | Tendo    |       3000 | false       | 2022-12-15 | 2022-12-25 | Cooking         |

  Scenario Outline: To create new booking using JSON data
    When she creates a booking using the data identified by "<objectKey>" from the JSON file "<jsonFile>"
    Then she should receive a response code of 200
    And she validates the response against the JSON schema "json-booking-schema.json"

    Examples: 
      | objectKey          | jsonFile                 |
      | create-booking0001 | create-booking-data.json |
      | create-booking0002 | create-booking-data.json |
      | create-booking0003 | create-booking-data.json |
      | create-booking0004 | create-booking-data.json |
      | create-booking0005 | create-booking-data.json |
      | create-booking0006 | create-booking-data.json |
      | create-booking0007 | create-booking-data.json |
      | create-booking0008 | create-booking-data.json |
      | create-booking0009 | create-booking-data.json |
