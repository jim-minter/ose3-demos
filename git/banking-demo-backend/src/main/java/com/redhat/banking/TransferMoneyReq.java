package com.redhat.banking;

public class TransferMoneyReq {
	private int fromid;
	private int payee;
	private double amount;
	
	public int getFromid() {
		return fromid;
	}
	public void setFromid(int fromid) {
		this.fromid = fromid;
	}
	public int getPayee() {
		return payee;
	}
	public void setPayee(int payee) {
		this.payee = payee;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
}
