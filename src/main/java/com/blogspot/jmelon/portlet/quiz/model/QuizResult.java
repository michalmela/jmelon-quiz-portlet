package com.blogspot.jmelon.portlet.quiz.model;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizResult {

	private int bound;
	private String resultGroup;
	private String resultArticleId;
	private String resultTemplateId;

	public String getResultArticleId() {
    	return resultArticleId;
    }

	public void setResultArticleId(String resultArticleId) {
    	this.resultArticleId = resultArticleId;
    }

	/**
	 * Either "SCOPE" or "GLOBAL", indicating to which company the result article and template belongs
	 * @return
	 */
	public String getResultGroup() {
    	return resultGroup;
    }

	public void setResultGroup(String resultGroup) {
    	this.resultGroup = resultGroup;
    }

	public String getResultTemplateId() {
    	return resultTemplateId;
    }

	public void setResultTemplateId(String resultTemplateId) {
    	this.resultTemplateId = resultTemplateId;
    }

	public int getBound() {
	    return bound;
    }

	public void setBound(int bound) {
	    this.bound = bound;
    }

	@Override
    public String toString() {
	    StringBuilder builder = new StringBuilder();
	    builder.append("QuizResult [bound=").append(bound).append(", resultGroup=").append(resultGroup)
	            .append(", resultArticleId=").append(resultArticleId).append(", resultTemplateId=")
	            .append(resultTemplateId).append("]");
	    return builder.toString();
    }
	
}
