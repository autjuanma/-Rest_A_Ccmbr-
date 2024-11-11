package com.devaura.qa.models;

public class BkDTO {
	private BkDetailsDto booking;

	private String bookingid;

	public BkDetailsDto getBooking() {
		return booking;
	}

	public void setBooking(BkDetailsDto booking) {
		this.booking = booking;
	}

	public String getBookingid() {
		return bookingid;
	}

	public void setBookingid(String bookingid) {
		this.bookingid = bookingid;
	}

	@Override
	public String toString() {
		return "ClassPojo [booking = " + booking + ", bookingid = " + bookingid + "]";
	}
}