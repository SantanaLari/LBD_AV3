package com.fatec.av3.avaliacao_3.model;

public class Avaliacao {

	private int codigo;
	private String tipo;
	
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	@Override
	public String toString() {
		return "Avaliacao [codigo=" + codigo + ", tipo=" + tipo + "]";
	}
}
