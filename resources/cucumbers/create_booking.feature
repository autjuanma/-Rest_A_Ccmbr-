Feature: New booking

  Background: 
    Given she has access to the endpoint "/booking"

  @create
  Scenario Outline: To create new booking using cucumber Data Table
    When she creates a booking
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    Then she should receive a response code of 200
    And she validates the json schema using the next file "json-booking-schema.json"

    Examples: 
      | firstname | lastname    | totalprice | depositpaid | checkin    | checkout   | additionalneeds            |
      | John      | Doe         |       1200 | true        | 2021-05-05 | 2021-05-15 | Breakfast                  |
      | Ranma     | Saotome     |       1500 | true        | 2022-01-10 | 2022-01-20 | Martial Arts               |
      | Akane     | Tendo       |       3000 | false       | 2022-02-15 | 2022-03-25 | Cooking                    |
      | Ryoga     | Hibiki      |       2500 | true        | 2022-03-01 | 2022-03-15 | Lost Adventures            |
      | Shampoo   | Cat         |       3200 | false       | 2022-04-10 | 2022-04-20 | Noodles                    |
      | happosai  | Master      |       1800 | true        | 2022-05-05 | 2022-05-15 | Love Pursuit               |
      | Genma     | Saotome     |       2000 | false       | 2022-06-01 | 2022-06-10 | Training                   |
      | Soun      | Tendo       |       1600 | true        | 2022-07-20 | 2022-07-30 | Family Honor               |
      | Nabiki    | Tendo       |       2200 | false       | 2022-08-15 | 2022-08-25 | Business                   |
      | Kasumi    | Tendo       |       2800 | true        | 2022-09-05 | 2022-09-15 | Housekeeping               |
      | Kuno      | Tatewaki    |       1900 | false       | 2022-10-10 | 2022-10-20 | Duel Challenges            |
      | Ryouga    | Hibiki      |       2700 | true        | 2022-11-01 | 2022-11-10 | Adventure                  |
      | Akane     | Tendo       |       3000 | false       | 2022-12-15 | 2022-12-25 | Cooking                    |
      | John      | Doe         |       1200 | true        | 2021-05-05 | 2021-05-15 | Breakfast                  |
      | Ranma     | Saotome     |       1500 | false       | 2022-01-10 | 2022-01-20 | Martial Arts               |
      | Ada       | Lovelace    |       1800 | true        | 2023-01-01 | 2023-01-10 | Computer Science           |
      | Alan      | Turing      |       2000 | false       | 2023-02-01 | 2023-02-10 | Coding Workshop            |
      | Grace     | Hopper      |       2200 | true        | 2023-03-01 | 2023-03-10 | AI Seminar                 |
      | Tim       | Berners-Lee |       2100 | true        | 2023-04-01 | 2023-04-10 | Web Development            |
      | Linus     | Torvalds    |       2300 | false       | 2023-05-01 | 2023-05-10 | Open Source Tools          |
      | Steve     | Jobs        |       2500 | true        | 2023-06-01 | 2023-06-10 | Innovation Session         |
      | Bill      | Gates       |       2400 | false       | 2023-07-01 | 2023-07-10 | Philanthropy Talk          |
      | Elon      | Musk        |       2600 | true        | 2023-08-01 | 2023-08-10 | Space Technology           |
      | Mark      | Zuckerberg  |       2700 | true        | 2023-09-01 | 2023-09-10 | Social Media Trends        |
      | Jeff      | Bezos       |       2800 | false       | 2023-10-01 | 2023-10-10 | E-commerce Insights        |
      | Sheryl    | Sandberg    |       2900 | true        | 2023-11-01 | 2023-11-10 | Leadership Workshop        |
      | Sundar    | Pichai      |       3000 | false       | 2023-12-01 | 2023-12-10 | Cloud Computing            |
      | Satya     | Nadella     |       3100 | true        | 2024-01-01 | 2024-01-10 | Digital Transformation     |
      | Susan     | Wojcicki    |       3200 | true        | 2024-02-01 | 2024-02-10 | Video Content Trends       |
      | Marissa   | Mayer       |       3300 | false       | 2024-03-01 | 2024-03-10 | UX Design Workshop         |
      | Jack      | Dorsey      |       3400 | true        | 2024-04-01 | 2024-04-10 | Microblogging Insights     |
      | Eric      | Schmidt     |       3500 | false       | 2024-05-01 | 2024-05-10 | Technology Trends          |
      | Larry     | Page        |       3600 | true        | 2024-06-01 | 2024-06-10 | Search Engine Optimization |
      | Sergey    | Brin        |       3700 | false       | 2024-07-01 | 2024-07-10 | Data Science Workshop      |
      | Angela    | Ahrendts    |       3800 | true        | 2024-08-01 | 2024-08-10 | Retail Technology          |
      | Tim       | Cook        |       3900 | false       | 2024-09-01 | 2024-09-10 | Product Design             |
      | Brian     | Chesky      |       4000 | true        | 2024-10-01 | 2024-10-10 | Travel Tech Insights       |
      | Ben       | Horowitz    |       4100 | true        | 2024-11-01 | 2024-11-10 | Venture Capital Talk       |

  @createJson
  Scenario Outline: To create new booking using JSON data
    When she creates a booking using the data identified by "<objectKey>" from the JSON file "<jsonFile>"
    Then she should receive a response code of 200
    And she validates the json schema using the next file "json-booking-schema.json"

    Examples: 
      | objectKey          | jsonFile                     |
      | create-booking0001 | create-booking-data-vol.json |
      | create-booking0002 | create-booking-data-vol.json |
      | create-booking0003 | create-booking-data-vol.json |
      | create-booking0004 | create-booking-data-vol.json |
      | create-booking0005 | create-booking-data-vol.json |
      | create-booking0006 | create-booking-data-vol.json |
      | create-booking0007 | create-booking-data-vol.json |
      | create-booking0008 | create-booking-data-vol.json |
      | create-booking0009 | create-booking-data-vol.json |
      | create-booking0010 | create-booking-data-vol.json |
      | create-booking0011 | create-booking-data-vol.json |
      | create-booking0012 | create-booking-data-vol.json |
      | create-booking0013 | create-booking-data-vol.json |
      | create-booking0014 | create-booking-data-vol.json |
      | create-booking0015 | create-booking-data-vol.json |
      | create-booking0016 | create-booking-data-vol.json |
      | create-booking0017 | create-booking-data-vol.json |
      | create-booking0018 | create-booking-data-vol.json |
      | create-booking0019 | create-booking-data-vol.json |
      | create-booking0020 | create-booking-data-vol.json |
      | create-booking0021 | create-booking-data-vol.json |
      | create-booking0022 | create-booking-data-vol.json |
      | create-booking0023 | create-booking-data-vol.json |
      | create-booking0024 | create-booking-data-vol.json |
      | create-booking0025 | create-booking-data-vol.json |
      | create-booking0026 | create-booking-data-vol.json |
      | create-booking0027 | create-booking-data-vol.json |
      | create-booking0028 | create-booking-data-vol.json |
      | create-booking0029 | create-booking-data-vol.json |
      | create-booking0030 | create-booking-data-vol.json |
      | create-booking0031 | create-booking-data-vol.json |
      | create-booking0032 | create-booking-data-vol.json |
      | create-booking0033 | create-booking-data-vol.json |
      | create-booking0034 | create-booking-data-vol.json |
      | create-booking0035 | create-booking-data-vol.json |
      | create-booking0036 | create-booking-data-vol.json |
      | create-booking0037 | create-booking-data-vol.json |
      | create-booking0038 | create-booking-data-vol.json |
      | create-booking0039 | create-booking-data-vol.json |
      | create-booking0040 | create-booking-data-vol.json |
      | create-booking0041 | create-booking-data-vol.json |
      | create-booking0042 | create-booking-data-vol.json |
      | create-booking0043 | create-booking-data-vol.json |
      | create-booking0044 | create-booking-data-vol.json |
      | create-booking0045 | create-booking-data-vol.json |
      | create-booking0046 | create-booking-data-vol.json |
      | create-booking0047 | create-booking-data-vol.json |
      | create-booking0048 | create-booking-data-vol.json |
      | create-booking0049 | create-booking-data-vol.json |
      | create-booking0050 | create-booking-data-vol.json |
