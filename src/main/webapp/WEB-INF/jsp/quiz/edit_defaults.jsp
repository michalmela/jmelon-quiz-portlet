<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%-- LFR-6.1.0 <%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui"%> --%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet"%>
<%@ taglib uri="http://liferay.com/tld/security"
    prefix="liferay-security"%>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme"%>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui"%>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<c:set var="ns">
    <portlet:namespace />
</c:set>

<c:if test="${not empty resolution}">
    <div class="portlet-msg-${resolution eq 'failed' ? 'error' : resolution}">
       <spring:message code="defaults.save.resolution.${resolution}" />
    </div>
</c:if>

<portlet:actionURL var="saveDefsUrl" name="saveDefs" />
<form class="quiz-form" action="${saveDefsUrl}" id="${ns}form" method="post"
    class="quiz-portlet-form">
    <fieldset>
        <legend>
            <spring:message code="edit.portlet.json" />
        </legend>
        <textarea rows="10" cols="30" name="prefs">${portletPreferencesValues['quizPrefs'][0]}</textarea>
    </fieldset>
    <input type="submit" value="<spring:message code="defaults.save" />" />
</form>

