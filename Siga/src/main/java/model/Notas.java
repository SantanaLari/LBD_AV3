package model;

public class Notas {

	private Aluno aluno;
	private Disciplina disciplina;
	private Avaliacao avaliacao;
	private Double nota;
	
	public Aluno getAluno() {
		return aluno;
	}
	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}
	public Disciplina getDisciplina() {
		return disciplina;
	}
	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}
	public Avaliacao getAvaliacao() {
		return avaliacao;
	}
	public void setAvaliacao(Avaliacao avaliacao) {
		this.avaliacao = avaliacao;
	}
	public Double getNota() {
		return nota;
	}
	public void setNota(Double nota) {
		this.nota = nota;
	}
	@Override
	public String toString() {
		return "Notas [aluno=" + aluno + ", disciplina=" + disciplina + ", avaliacao=" + avaliacao + ", nota=" + nota
				+ "]";
	}
	
}
