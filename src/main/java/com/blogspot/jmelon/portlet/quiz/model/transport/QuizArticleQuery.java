package com.blogspot.jmelon.portlet.quiz.model.transport;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizArticleQuery {
	private String articleId;
	private String group;
	public String getArticleId() {
	    return articleId;
    }
	public void setArticleId(String articleId) {
	    this.articleId = articleId;
    }
	public String getGroup() {
	    return group;
    }
	public void setGroup(String group) {
	    this.group = group;
    }
	@Override
    public String toString() {
	    StringBuilder builder = new StringBuilder();
	    builder.append("QuizArticleQuery [articleId=").append(articleId).append(", group=").append(group).append("]");
	    return builder.toString();
    }
}
