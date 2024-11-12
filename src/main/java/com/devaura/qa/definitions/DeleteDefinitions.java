package com.devaura.qa.definitions;

import com.devaura.qa.utils.PropertiesFileReader;
import com.devaura.qa.utils.TestContext;

import io.cucumber.java.en.When;

public class DeleteDefinitions {

	private TestContext context;

	public DeleteDefinitions(TestContext context) {
		this.context = context;
	}

	@When("performs to booking delete request with mecanims basic auth")
	public void userMakesARequestToDeleteBookingWithBasicAuth() {

		String user = PropertiesFileReader.getProperty("usr.tokn");
		String psswd = PropertiesFileReader.getProperty("psswd.tokn");
		context.response = context.requestSetup().auth().preemptive().basic(user, psswd)
				.pathParam("bookingID", context.session.get("bookingID")).when()
				.delete(context.session.get("endpoint") + "/{bookingID}");
	}

}
