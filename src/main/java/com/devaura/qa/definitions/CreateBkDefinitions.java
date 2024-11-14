package com.devaura.qa.definitions;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.IOException;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.devaura.qa.models.BkDTO;
import com.devaura.qa.utils.DeserializedResponse;
import com.devaura.qa.utils.JsonReader;
import com.devaura.qa.utils.TestContext;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.module.jsv.JsonSchemaValidator;

public class CreateBkDefinitions {

	private static final Logger LOG = LogManager.getLogger(CreateBkDefinitions.class);
	private static final String SCHEMA_FILE_PATH = "resources/data/";

	private static final String BOOKING_ID_MISSING_MSG = "Booking ID missing";
	private static final String FIRST_NAME_MISMATCH_MSG = "First Name did not match";
	private static final String LAST_NAME_MISMATCH_MSG = "Last Name did not match";
	private static final String TOTAL_PRICE_MISMATCH_MSG = "Total Price did not match";
	private static final String DEPOSIT_PAID_MISMATCH_MSG = "Deposit Paid did not match";
	private static final String ADDITIONAL_NEEDS_MISMATCH_MSG = "Additional Needs did not match";
	private static final String CHECK_IN_DATE_MISMATCH_MSG = "Check in Date did not match";
	private static final String CHECK_OUT_DATE_MISMATCH_MSG = "Check out Date did not match";

	private TestContext context;

	public CreateBkDefinitions(TestContext context) {
		this.context = context;
	}

	@Given("she has access to the endpoint {string}")
	public void userHasAccessToEndpoint(String endpoint) {
		context.session.put("endpoint", endpoint);
	}

	@Then("she should receive a response code of {int}")
	public void userShouldGetTheResponseCode(Integer statusCode) {
		assertEquals(Long.valueOf(statusCode), Long.valueOf(context.response.getStatusCode()));
	}

	@When("she creates a booking")
	public void userCreatesABooking(DataTable dataTable) throws IOException {
		Map<String, String> bookingData = dataTable.asMaps().get(0);
		JSONObject bookingBody = createBookingBody(bookingData);
		context.response = context.requestSetup().body(bookingBody.toString()).when()
				.post(context.session.get("endpoint").toString());
		BkDTO bookingDTO = DeserializedResponse.deserializedResponse(context.response, BkDTO.class);
		assertNotNull("Booking not created", bookingDTO);
		LOG.info("Newly created booking ID: " + bookingDTO.getBookingid());
		context.session.put("bookingID", bookingDTO.getBookingid());
		context.session.put("bookingData", bookingData);
		context.session.put("bookingDTO", bookingDTO);
	}

	private JSONObject createBookingBody(Map<String, String> bookingData) {
		JSONObject bookingBody = new JSONObject();
		bookingBody.put("firstname", bookingData.get("firstname"));
		bookingBody.put("lastname", bookingData.get("lastname"));
		bookingBody.put("totalprice", Integer.valueOf(bookingData.get("totalprice")));
		bookingBody.put("depositpaid", Boolean.valueOf(bookingData.get("depositpaid")));

		JSONObject bookingDates = new JSONObject();
		bookingDates.put("checkin", bookingData.get("checkin"));
		bookingDates.put("checkout", bookingData.get("checkout"));

		bookingBody.put("bookingdates", bookingDates);
		bookingBody.put("additionalneeds", bookingData.get("additionalneeds"));

		return bookingBody;
	}

	@Then("she validates the booking data")
	public void userValidatesBookingData() {
		@SuppressWarnings("unchecked")
		Map<String, String> bookingData = context.getSessionData("bookingData", Map.class);
		BkDTO bookingDTO = context.getSessionData("bookingDTO", BkDTO.class);

		validateBookingData(new JSONObject(bookingData), bookingDTO);
	}

	private void validateBookingData(JSONObject bookingData, BkDTO bookingDTO) {
		LOG.info(bookingData);
		assertNotNull(BOOKING_ID_MISSING_MSG, bookingDTO.getBookingid());
		assertEquals(FIRST_NAME_MISMATCH_MSG, bookingData.get("firstname"), bookingDTO.getBooking().getFirstname());
		assertEquals(LAST_NAME_MISMATCH_MSG, bookingData.get("lastname"), bookingDTO.getBooking().getLastname());
		assertEquals(TOTAL_PRICE_MISMATCH_MSG, bookingData.get("totalprice"), bookingDTO.getBooking().getTotalprice());
		assertEquals(DEPOSIT_PAID_MISMATCH_MSG, bookingData.get("depositpaid"),
				bookingDTO.getBooking().getDepositpaid());
		assertEquals(ADDITIONAL_NEEDS_MISMATCH_MSG, bookingData.get("additionalneeds"),
				bookingDTO.getBooking().getAdditionalneeds());
		assertEquals(CHECK_IN_DATE_MISMATCH_MSG, bookingData.get("checkin"),
				bookingDTO.getBooking().getBookingdates().getCheckin());
		assertEquals(CHECK_OUT_DATE_MISMATCH_MSG, bookingData.get("checkout"),
				bookingDTO.getBooking().getBookingdates().getCheckout());
	}

	@Then("she validates the response against the JSON schema {string}")
	public void userValidatesResponseWithJSONSchema(String jsonFileName) {
		context.response.then().assertThat()
				.body(JsonSchemaValidator.matchesJsonSchemaInClasspath(SCHEMA_FILE_PATH + jsonFileName));
		LOG.info("Successfully Validated schema from " + jsonFileName);
	}

	@When("she creates a booking using the data identified by {string} from the JSON file {string}")
	public void userCreatesABookingUsingDataFromJSONFile(String dataKey, String jsonFile) throws IOException {
		context.response = context.requestSetup().body(JsonReader.getRequestBody(jsonFile, dataKey)).when()
				.post(context.session.get("endpoint").toString());
		BkDTO bookingDTO = DeserializedResponse.deserializedResponse(context.response, BkDTO.class);
		assertNotNull("Booking not created", bookingDTO);
		LOG.info("Newly created booking ID: " + bookingDTO.getBookingid());
		context.session.put("bookingID", bookingDTO.getBookingid());
	}
}
