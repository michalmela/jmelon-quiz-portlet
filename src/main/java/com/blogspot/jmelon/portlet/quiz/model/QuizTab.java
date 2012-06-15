package com.blogspot.jmelon.portlet.quiz.model;

import java.util.List;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizTab {

	private String tabTitle;
	private List<QuizQuestion> questions;	

	public List<QuizQuestion> getQuestions() {
	    return questions;
    }

	public void setQuestions(List<QuizQuestion> questions) {
	    this.questions = questions;
    }

	public String getTabTitle() {
	    return tabTitle;
    }

	public void setTabTitle(String tabTitle) {
	    this.tabTitle = tabTitle;
    }

	@Override
    public String toString() {
	    StringBuilder builder = new StringBuilder();
	    builder.append("QuizTab [tabTitle=").append(tabTitle).append(", questions=").append(questions).append("]");
	    return builder.toString();
    }
	
}
