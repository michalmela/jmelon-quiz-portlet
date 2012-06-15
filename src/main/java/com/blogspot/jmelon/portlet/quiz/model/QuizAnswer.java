package com.blogspot.jmelon.portlet.quiz.model;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizAnswer {

	private String answer;
	private int points;
	
	public int getPoints() {
	    return points;
    }
	public void setPoints(int points) {
	    this.points = points;
    }
	public String getAnswer() {
	    return answer;
    }
	public void setAnswer(String answer) {
	    this.answer = answer;
    }
	
	@Override
    public String toString() {
	    StringBuilder builder = new StringBuilder();
	    builder.append("QuizAnswer [answer=").append(answer).append(", points=").append(points).append("]");
	    return builder.toString();
    }
	
}
