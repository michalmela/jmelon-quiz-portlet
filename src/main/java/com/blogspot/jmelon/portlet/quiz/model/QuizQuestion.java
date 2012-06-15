package com.blogspot.jmelon.portlet.quiz.model;

import java.util.List;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizQuestion {

	private String question;
	private List<QuizAnswer> answers;

	public String getQuestion() {
	    return question;
    }

	public void setQuestion(String question) {
	    this.question = question;
    }

	public List<QuizAnswer> getAnswers() {
	    return answers;
    }

	public void setAnswers(List<QuizAnswer> answers) {
	    this.answers = answers;
    }

	@Override
    public String toString() {
	    StringBuilder builder = new StringBuilder();
	    builder.append("QuizQuestion [question=").append(question).append(", answers=").append(answers).append("]");
	    return builder.toString();
    }
	
}
