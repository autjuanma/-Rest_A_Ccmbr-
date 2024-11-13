package com.devaura.qa.runners;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(plugin = { "pretty:target/cucumber/cucumber.txt",
		"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:", "html:target/cucumber/report",
		"json:target/cucumber/cucumber.json",
		"com.devaura.qa.utils.TestListener" }, features = "resources/cucumbers/update.feature", glue = "com.devaura.qa.definitions", 
		monochrome = true, tags = "@upd-booking-dt"
// , dryRun = true // Use this to check for undefined steps without executing
// tests
// , publish = true // Use this to publish the report online
)
public class UpdateRunner {
}