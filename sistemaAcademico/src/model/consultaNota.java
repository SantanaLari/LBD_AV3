package model;

public class consultaNota {
	
	private Aluno ra_aluno;
	private Aluno nome_aluno;
	private Double nota1;
	private Double nota2;
	private Double nota3;
	private Double nota4;
	private Double exame;
	private Double media_final;
	private String situacao;
	private Disciplina nome_disciplina;
	
	public Disciplina getNome_disciplina() {
		return nome_disciplina;
	}
	public void setNome_disciplina(Disciplina nome_disciplina) {
		this.nome_disciplina = nome_disciplina;
	}
	public Aluno getRa_aluno() {
		return ra_aluno;
	}
	public void setRa_aluno(Aluno ra_aluno) {
		this.ra_aluno = ra_aluno;
	}
	public Aluno getNome_aluno() {
		return nome_aluno;
	}
	public void setNome_aluno(Aluno nome_aluno) {
		this.nome_aluno = nome_aluno;
	}
	public Double getNota1() {
		return nota1;
	}
	public void setNota1(Double nota1) {
		this.nota1 = nota1;
	}
	public Double getNota2() {
		return nota2;
	}
	public void setNota2(Double nota2) {
		this.nota2 = nota2;
	}
	public Double getNota3() {
		return nota3;
	}
	public void setNota3(Double nota3) {
		this.nota3 = nota3;
	}
	public Double getNota4() {
		return nota4;
	}
	public void setNota4(Double nota4) {
		this.nota4 = nota4;
	}
	public Double getExame() {
		return exame;
	}
	public void setExame(Double exame) {
		this.exame = exame;
	}
	public Double getMedia_final() {
		return media_final;
	}
	public void setMedia_final(Double media_final) {
		this.media_final = media_final;
	}
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
/*	@Override
	public String toString() {
		return "consultaNota [ra_aluno=" + ra_aluno + ", nome_aluno=" + nome_aluno + ", nota1=" + nota1 + ", nota2="
				+ nota2 + ", nota3=" + nota3 + ", nota4=" + nota4 + ", exame=" + exame + ", media_final=" + media_final
				+ ", situacao=" + situacao + "]";
	}*/
	@Override
	public String toString() {
		return "consultaNota [ra_aluno=" + ra_aluno + ", nome_aluno=" + nome_aluno + ", nota1=" + nota1 + ", nota2="
				+ nota2 + ", nota3=" + nota3 + ", nota4=" + nota4 + ", exame=" + exame + ", media_final=" + media_final
				+ ", situacao=" + situacao + ", nome_disciplina=" + nome_disciplina + "]";
	}
	
	
	
}
