package com.devaura.qa.runners;

import static io.cucumber.junit.CucumberOptions.SnippetType.CAMELCASE;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

/**
 * TestRunner class for executing Cucumber tests. This class configures the
 * Cucumber options for the test execution.
 */
@RunWith(Cucumber.class)
@CucumberOptions(plugin = { "pretty:target/cucumber/cucumber.txt",
		"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:", "html:target/cucumber/report",
		"json:target/cucumber/cucumber.json",
		"com.devaura.qa.utils.TestListener" }, features = "resources/cucumbers/CreateBooking.feature", glue = "com.devaura.qa.definitions", monochrome = true, snippets = CAMELCASE, tags = "@createBK"
// , dryRun = true // Use this to check for undefined steps without executing
// tests
// , publish = true // Use this to publish the report online
)
public class TestRunner {
}