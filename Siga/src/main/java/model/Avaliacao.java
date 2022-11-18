package model;

public class Avaliacao {

	private int ra;
	private String tipo;
	
	public int getRa() {
		return ra;
	}
	public void setRa(int ra) {
		this.ra = ra;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	@Override
	public String toString() {
		return "Avaliacao [ra=" + ra + ", tipo=" + tipo + "]";
	}
	
}
