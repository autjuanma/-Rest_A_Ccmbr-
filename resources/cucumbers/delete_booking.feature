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
    And she validates the json schema using the next file "json-booking-schema.json"
    And she updates the booking details
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    And she should receive a response code of 200
    And she validates the json schema using the next file "booking-details-schema.json"
    And sends request to retrieve the booking IDs
    And she should receive a response code of 200
    And performs to booking delete request with mecanims basic auth
    And she should receive a response code of 201

    Examples: 
      | firstname   | lastname  | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | John        | Doe       |       1200 | true        | 2021-05-05 | 2021-05-15 | Breakfast       |
      | Mickey      | Mouse     |      10000 | true        | 2021-05-15 | 2021-06-11 | Breakfast       |
      | Tasmanian   | Devil     |       2006 | false       | 2021-06-01 | 2021-07-10 | Dinner          |
      | Mickey      | Mouse     |      10000 | true        | 2021-05-15 | 2021-06-11 | Breakfast       |
      | Tasmanian   | Devil     |       2006 | false       | 2021-06-01 | 2021-07-10 | Dinner          |
      | John        | Smith     |      10001 | true        | 2021-01-15 | 2021-02-11 | Breakfast       |
      | Jane        | Doe       |      20002 | false       | 2021-02-01 | 2021-03-10 | Dinner          |
      | Michael     | Johnson   |      30003 | true        | 2021-03-05 | 2021-04-12 | Lunch           |
      | Emily       | Davis     |      40004 | false       | 2021-04-15 | 2021-05-20 | Breakfast       |
      | David       | Wilson    |      50005 | true        | 2021-05-25 | 2021-06-30 | Dinner          |
      | Sarah       | Brown     |      60006 | false       | 2021-06-01 | 2021-07-10 | Lunch           |
      | Robert      | Miller    |      70007 | true        | 2021-07-12 | 2021-08-15 | Breakfast       |
      | Jessica     | Taylor    |      80008 | false       | 2021-08-20 | 2021-09-22 | Dinner          |
      | William     | Anderson  |      90009 | true        | 2021-09-05 | 2021-10-10 | Lunch           |
      | Linda       | Thomas    |      10010 | false       | 2021-10-11 | 2021-11-15 | Breakfast       |
      | Charles     | Jackson   |      11011 | true        | 2021-11-16 | 2021-12-20 | Dinner          |
      | Patricia    | White     |      12012 | false       | 2021-12-21 | 2022-01-25 | Lunch           |
      | Daniel      | Harris    |      13013 | true        | 2022-01-26 | 2022-02-28 | Breakfast       |
      | Barbara     | Martin    |      14014 | false       | 2022-03-01 | 2022-04-05 | Dinner          |
      | Matthew     | Thompson  |      15015 | true        | 2022-04-06 | 2022-05-10 | Lunch           |
      | Elizabeth   | Garcia    |      16016 | false       | 2022-05-11 | 2022-06-15 | Breakfast       |
      | Anthony     | Martinez  |      17017 | true        | 2022-06-16 | 2022-07-20 | Dinner          |
      | Jennifer    | Robinson  |      18018 | false       | 2022-07-21 | 2022-08-25 | Lunch           |
      | Joseph      | Clark     |      19019 | true        | 2022-08-26 | 2022-09-30 | Breakfast       |
      | Susan       | Rodriguez |      20020 | false       | 2022-10-01 | 2022-11-05 | Dinner          |
      | Christopher | Lewis     |      21021 | true        | 2022-11-06 | 2022-12-10 | Lunch           |
      | Karen       | Lee       |      22022 | false       | 2022-12-11 | 2023-01-15 | Breakfast       |
      | Kevin       | Walker    |      23023 | true        | 2023-01-16 | 2023-02-20 | Dinner          |
      | Nancy       | Hall      |      24024 | false       | 2023-02-21 | 2023-03-27 | Lunch           |
      | Brian       | Allen     |      25025 | true        | 2023-03-28 | 2023-04-30 | Breakfast       |
      | Lisa        | Young     |      26026 | false       | 2023-05-01 | 2023-06-05 | Dinner          |
      | Ronald      | King      |      27027 | true        | 2023-06-06 | 2023-07-10 | Lunch           |
      | Angela      | Wright    |      28028 | false       | 2023-07-11 | 2023-08-15 | Breakfast       |
      | Steven      | Scott     |      29029 | true        | 2023-08-16 | 2023-09-20 | Dinner          |
      | Michelle    | Green     |      30030 | false       | 2023-09-21 | 2023-10-25 | Lunch           |
      | Edward      | Adams     |      31031 | true        | 2023-10-26 | 2023-11-30 | Breakfast       |
      | Karen       | Baker     |      32032 | false       | 2023-11-01 | 2023-12-05 | Dinner          |
      | Thomas      | Gonzalez  |      33033 | true        | 2023-12-06 | 2024-01-10 | Lunch           |
      | Laura       | Nelson    |      34034 | false       | 2024-01-11 | 2024-02-15 | Breakfast       |
      | Charles     | Carter    |      35035 | true        | 2024-02-16 | 2024-03-22 | Dinner          |
      | Jennifer    | Mitchell  |      36036 | false       | 2024-03-23 | 2024-04-28 | Lunch           |
      | Matthew     | Perez     |      37037 | true        | 2024-04-29 | 2024-06-03 | Breakfast       |
      | Barbara     | Roberts   |      38038 | false       | 2024-06-04 | 2024-07-10 | Dinner          |
      | John        | Turner    |      39039 | true        | 2024-07-11 | 2024-08-15 | Lunch           |
      | Sarah       | Phillips  |      40040 | false       | 2024-08-16 | 2024-09-20 | Breakfast       |
      | David       | Campbell  |      41041 | true        | 2024-09-21 | 2024-10-25 | Dinner          |
      | Emily       | Parker    |      42042 | false       | 2024-10-26 | 2024-11-30 | Lunch           |
      | Robert      | Evans     |      43043 | true        | 2024-11-01 | 2024-12-05 | Breakfast       |
      | Laura       | Edwards   |      44044 | false       | 2024-12-06 | 2025-01-10 | Dinner          |
      | William     | Collins   |      45045 | true        | 2025-01-11 | 2025-02-15 | Lunch           |
      | Jessica     | Stewart   |      46046 | false       | 2025-02-16 | 2025-03-22 | Breakfast       |
      | Michelle    | Morris    |      48048 | false       | 2025-04-29 | 2025-06-03 | Lunch           |
      | Daniel      | Rogers    |      49049 | true        | 2025-06-04 | 2025-07-10 | Breakfast       |
      | Nancy       | Reed      |      50050 | false       | 2025-07-11 | 2025-08-15 | Dinner          |
