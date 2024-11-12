package com.devaura.qa.definitions;

import static com.devaura.qa.utils.DeserializedResponse.deserializedResponse;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.IOException;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.devaura.qa.models.BkDetailsDto;
import com.devaura.qa.utils.DeserializedResponse;
import com.devaura.qa.utils.JsonReader;
import com.devaura.qa.utils.PropertiesFileReader;
import com.devaura.qa.utils.TestContext;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;

public class UpdateDf {
	private TestContext context;
	private static final Logger LOG = LogManager.getLogger(UpdateDf.class);

	public UpdateDf(TestContext context) {
		this.context = context;
	}

	@When("she creates a auth token")
	public void userCreatesAAuthTokenWithCredential() {
		String user = PropertiesFileReader.getProperty("usr.tokn");
		String psswd = PropertiesFileReader.getProperty("psswd.tokn");
		JSONObject credentials = new JSONObject();
		credentials.put("username", user);
		credentials.put("password", psswd);
		context.response = context.requestSetup().body(credentials.toString()).when()
				.post(context.session.get("endpoint").toString());
		String token = context.response.path("token");
		LOG.info("Auth Token: " + token);
		context.session.put("token", "token=" + token);
	}

	@When("sends request to retrieve the booking IDs")
	public void userMakesARequestToViewBookingIDs() {
		context.response = context.requestSetup().when().get(context.session.get("endpoint").toString());
		int bookingID = context.response.getBody().jsonPath().getInt("[0].bookingid");
		LOG.info("Booking ID: " + bookingID);
		assertNotNull("Booking ID not found!", bookingID);
		context.session.put("bookingID", bookingID);
	}

	@When("she updates the booking details")
	public void userUpdatesABooking(DataTable dataTable) throws IOException {
		Map<String, String> bookingData = dataTable.asMaps().get(0);
		JSONObject bookingBody = new JSONObject();
		bookingBody.put("firstname", bookingData.get("firstname"));
		bookingBody.put("lastname", bookingData.get("lastname"));
		bookingBody.put("totalprice", Integer.valueOf(bookingData.get("totalprice")));
		bookingBody.put("depositpaid", Boolean.valueOf(bookingData.get("depositpaid")));
		JSONObject bookingDates = new JSONObject();
		bookingDates.put("checkin", (bookingData.get("checkin")));
		bookingDates.put("checkout", (bookingData.get("checkout")));
		bookingBody.put("bookingdates", bookingDates);
		bookingBody.put("additionalneeds", bookingData.get("additionalneeds"));

		context.response = context.requestSetup().header("Cookie", context.session.get("token").toString())
				.pathParam("bookingID", context.session.get("bookingID")).body(bookingBody.toString()).when()
				.put(context.session.get("endpoint") + "/{bookingID}");

		BkDetailsDto bookingDetailsDTO = DeserializedResponse.deserializedResponse(context.response,
				BkDetailsDto.class);
		assertNotNull("Booking not created", bookingDetailsDTO);

	}

	@When("user updates the booking details using data {string} from JSON file {string}")
	@When("updates the booking details using the data identified by {string} from the JSON file named {string} .")
	public void userUpdatesTheBookingDetailsUsingDataFromJSONFile(String objectKey, String jsonFile) throws IOException {
		context.response = context.requestSetup().header("Cookie", context.session.get("token").toString())
				.pathParam("bookingID", context.session.get("bookingID"))
				.body(JsonReader.getRequestBody(jsonFile, objectKey)).when()
				.put(context.session.get("endpoint") + "/{bookingID}");

		BkDetailsDto bookingDetailsDTO = deserializedResponse(context.response, BkDetailsDto.class);
		assertNotNull("Booking not created", bookingDetailsDTO);

	}

	@When("user makes a request to update first name {string} & Last name {string}")
	public void userMakesARequestToUpdateFirstNameLastName(String firstName, String lastName) throws IOException {
		JSONObject body = new JSONObject();
		body.put("firstname", firstName);
		body.put("lastname", lastName);

		context.response = context.requestSetup().header("Cookie", context.session.get("token").toString())
				.pathParam("bookingID", context.session.get("bookingID")).body(body.toString()).when()
				.patch(context.session.get("endpoint") + "/{bookingID}");

		BkDetailsDto bookingDetailsDTO = DeserializedResponse.deserializedResponse(context.response,
				BkDetailsDto.class);
		assertNotNull("Booking not created", bookingDetailsDTO);
		assertEquals("First Name did not match", firstName, bookingDetailsDTO.getFirstname());
		assertEquals("Last Name did not match", lastName, bookingDetailsDTO.getLastname());
	}
}
