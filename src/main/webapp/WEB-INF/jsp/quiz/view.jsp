<%-- See the file "LICENSE" for the full license governing this code. --%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<c:choose>
    <c:when test="${not empty prefs.nextLabel}">
        <c:set var="nextLabel">${prefs.nextLabel}</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="nextLabel"><spring:message code="view.next" /></c:set>
    </c:otherwise>
</c:choose>

<div class="quiz">
    <%-- Headers --%>
    <div class="quiz-tab-headers">
        <c:forEach var="tab" items="${prefs.tabs}" varStatus="tabVs">
            <h5
                class="quiz-tab-header${tabVs.index eq 0 ? ' quiz-tab-header-selected' : ''}">${tab.tabTitle}</h5>
        </c:forEach>
        <c:choose>
            <c:when test="${empty prefs.summaryTabTitle}">
                <h5 class="quiz-tab-header">
                    <spring:message code="view.summary" />
                </h5>
            </c:when>
            <c:otherwise>
                <h5 class="quiz-tab-header">${prefs.summaryTabTitle}</h5>
            </c:otherwise>
        </c:choose>
    </div>
    
    <form class="quiz-form" id="${ns}quiz-form">
    
        <div class="quiz-tab-body">
            <div class="quiz-tab-contents">
                <%-- Contents --%>
                <c:forEach var="tab" items="${prefs.tabs}" varStatus="tabVs">
                    <%-- Questions --%>
                    <div
                        class="quiz-tab-content${tabVs.index eq 0 ? ' quiz-tab-content-selected' : ''}"
                        id="${ns}quiz-tab-content_${tabVs.index}">
                        <c:forEach var="question" items="${tab.questions}" varStatus="qVs">
    
                            <div class="quiz-question">
                                <h3><span>${question.question}</span></h3>
                                <%-- Answers --%>
                                <c:forEach var="answer" items="${question.answers}"
                                    varStatus="ansVs">
                                    <c:set var="answerId">t${tabVs.index}_q${qVs.index}_a${ansVs.index}</c:set>
                                    <div>
                                        <input type="radio" value="${ansVs.index}" class="quiz-answer-input"
                                            name="tabs[${tabVs.index}].questions[${qVs.index}].answer"
                                            id="${answerId}" /> <label for="${answerId}">${answer.answer}</label>
                                    </div>
                                </c:forEach>
                            </div>
    
                        </c:forEach>
                    </div>
                </c:forEach>
                <div class="quiz-tab-content quiz-summary-content"></div>
            </div>
            <div class="quiz-buttons">
                <button style="display:none" class="quiz-btn-prev">
                    <div class="quiz-btn-img quiz-btn-img-prev"></div>
                    <spring:message code="view.prev" />
                </button>
                <button style="display:none" class="quiz-btn-reset">
                    <div class="quiz-btn-img quiz-btn-img-reset"></div>
                    <spring:message code="view.reset" />
                </button>
                <button ${fn:length(prefs.tabs) == 1 ? 'style="display:none"' : ''} disabled="disabled" class="quiz-btn-next">
                    ${nextLabel}
                    <div class="quiz-btn-img quiz-btn-img-next"></div>
                </button>
                <button ${fn:length(prefs.tabs) > 1 ? 'style="display:none"' : ''} class="quiz-btn-submit">
                    <spring:message code="view.submit" />
                    <div class="quiz-btn-img quiz-btn-img-submit"></div>
                </button>
            </div>
        </div>
    
    </form>
</div>


<liferay-util:html-bottom>
<%-- LFR-6.1.0 <liferay-util:body-bottom> --%>
    <script type="text/javascript">
    
AUI().ready(function() {
          $(".quiz-btn-reset").on("click",quizResetClick);
          $(".quiz-btn-prev").on("click",quizPrevClick);
          $(".quiz-btn-next").on("click",quizNextClick);
          $(".quiz-btn-submit").on("click",quizSubmitClick);
          $(".quiz-answer-input").on("change",quizInputChange);
          $(".quiz-tab-header").on("click",quizTabClick);
})
quizInputChange = function() {
    var cur = $(".quiz-tab-content-selected");
    var curIndex = cur.index();
    if(isTabAnswered(cur)) {
        $(".quiz-btn-next").removeAttr('disabled');
        $(".quiz-btn-submit").removeAttr('disabled');
        var $selTabHead = $(".quiz-tab-header-selected");
        if (!$selTabHead.hasClass("quiz-tab-header-filled")) {
            $selTabHead.addClass("quiz-tab-header-filled");
        }
    }
}

quizTabClick = function(event) {
    $this = $(this);
    var newIndex = $(this).index();
    if (!$this.hasClass("quiz-tab-header-selected")
            && (newIndex == 0 || $this.prev().hasClass("quiz-tab-header-filled"))
            && !isQuizSubmitted()) {
        if (newIndex == $this.parent().children().size()-1) {
            submitQuiz();
        } else {            
            var cur = $(".quiz-tab-content-selected");
            var curIndex = cur.index();
            selectQuizTab(cur,newIndex);
        }
    }
}

quizResetClick = function(event) {
    event.preventDefault();
    var cur = $(".quiz-tab-content-selected");
    selectQuizTab(cur,0);
    
    var $tabs = $(".quiz-tab-headers").children();
    var allTabs = $tabs.size();
    
    $(".quiz-btn-reset").hide();
    if (allTabs > 2) {
        $(".quiz-btn-next").show();
    } else {
        $(".quiz-btn-submit").show();    
    }
    $(".quiz-tab-header-filled").removeClass("quiz-tab-header-filled");
    $(".quiz-answer-input").removeAttr("checked");
}

quizPrevClick = function(event) {
    event.preventDefault();
    var cur = $(".quiz-tab-content-selected");
    var curIndex = cur.index();
    if(curIndex > 0) {
        var newIndex = curIndex-1;  
        selectQuizTab(cur,newIndex);
    }
}
quizSubmitClick = function(event) {
    event.preventDefault();
    var $tabs = $(".quiz-tab-headers").children();
    var allTabs = $tabs.size();
    
    if ($($tabs.get(allTabs-2)).hasClass("quiz-tab-header-filled")) {
        submitQuiz();
    }
}
submitQuiz = function() {
    var $quiz = $(".quiz");
    $quiz.addClass("lfr-configurator-visibility");
    
    var answers = new Array();
    $(".quiz-answer-input:checked").each(function(i,e){
        answers.push($(e).val());
    });
    
    var url = "<portlet:resourceURL  id="submitQuiz"></portlet:resourceURL>";
    jQuery.ajax({ <%-- sends form as json viable for unmarshalling with jackson mapper --%>
         url: url, 
         type: 'POST', 
         dataType: 'json', 
         data: "answers="+answers, 
//          contentType: 'application/json', 
         success: function(data) { 
             $(".quiz-summary-content").html(data.content);
             
             var cur = $(".quiz-tab-content-selected");
             var allTabs = cur.parent().children().size();
             selectQuizTab(cur,allTabs-1);
             
             <%-- TODO: error handling             alert(JSON.stringify(data));  --%>
             $quiz.removeClass("lfr-configurator-visibility");

             $(".quiz-btn-reset").show();
             $(".quiz-btn-prev").hide();
             $(".quiz-btn-next").hide();
             $(".quiz-btn-submit").hide();
             
         }
    });
}
quizNextClick = function(event) {
    event.preventDefault();
    var cur = $(".quiz-tab-content-selected");
    var curIndex = cur.index();
    var allTabs = cur.parent().children().size();  
    
    if ( isTabAnswered(cur) <%-- check if all questions has been answered on this tab --%>
            && curIndex < allTabs-2) { <%-- check if this tab is not the last questions tab --%>
        var newIndex = curIndex+1;
        selectQuizTab(cur,newIndex);
    }
}
selectQuizTab = function(cur,newIndex) {
    cur.removeClass("quiz-tab-content-selected");
    var newContent = $(cur.parent().children().get(newIndex));
    newContent.addClass("quiz-tab-content-selected");
    $(".quiz-tab-header-selected").removeClass("quiz-tab-header-selected");
    
    var allTabs = cur.parent().children().size();
    var newTab = $($(".quiz-tab-headers").children().get(newIndex));
    newTab.addClass("quiz-tab-header-selected");
    
    if (isTabAnswered(newContent)) {
        $(".quiz-btn-next").removeAttr('disabled');
        $(".quiz-btn-submit").removeAttr('disabled');
    } else {
        $(".quiz-btn-next").attr('disabled', '');
        $(".quiz-btn-submit").attr('disabled', '');
    }
    

    if (newIndex == 0) {
        $(".quiz-btn-prev").hide();
    } else {
        $(".quiz-btn-prev").show();
    }
    if (newIndex == allTabs-2) {
        $(".quiz-btn-submit").show();
        $(".quiz-btn-next").hide();
    } else {
        $(".quiz-btn-submit").hide();
        $(".quiz-btn-next").show();
    }
}
isTabAnswered = function(tab) {
    var allQuestions = tab.find(".quiz-question").size();
    return allQuestions == tab.find("input:checked").size();
}       
isQuizSubmitted = function() {
    var cur = $(".quiz-tab-content-selected");
    var allTabs = cur.parent().children().size();
    return cur.index() == allTabs-1;
}

<%--
 * Copyright (c) 2010 Maxim Vasiliev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @author Maxim Vasiliev
 * Date: 09.09.2010
 * Time: 19:02:33
 *--%> 
var form2js = (function()
        {
            "use strict";

            /**
             * Returns form values represented as Javascript object
             * "name" attribute defines structure of resulting object
             *
             * @param rootNode {Element|String} root form element (or it's id) or array of root elements
             * @param delimiter {String} structure parts delimiter defaults to '.'
             * @param skipEmpty {Boolean} should skip empty text values, defaults to true
             * @param nodeCallback {Function} custom function to get node value
             * @param useIdIfEmptyName {Boolean} if true value of id attribute of field will be used if name of field is empty
             */
            function form2js(rootNode, delimiter, skipEmpty, nodeCallback, useIdIfEmptyName)
            {
                if (typeof skipEmpty == 'undefined' || skipEmpty == null) skipEmpty = true;
                if (typeof delimiter == 'undefined' || delimiter == null) delimiter = '.';
                if (arguments.length < 5) useIdIfEmptyName = false;

                rootNode = typeof rootNode == 'string' ? document.getElementById(rootNode) : rootNode;

                var formValues = [],
                    currNode,
                    i = 0;

                /* If rootNode is array - combine values */
                if (rootNode.constructor == Array || (typeof NodeList != "undefined" && rootNode.constructor == NodeList))
                {
                    while(currNode = rootNode[i++])
                    {
                        formValues = formValues.concat(getFormValues(currNode, nodeCallback, useIdIfEmptyName));
                    }
                }
                else
                {
                    formValues = getFormValues(rootNode, nodeCallback, useIdIfEmptyName);
                }

                return processNameValues(formValues, skipEmpty, delimiter);
            }

            /**
             * Processes collection of { name: 'name', value: 'value' } objects.
             * @param nameValues
             * @param skipEmpty if true skips elements with value == '' or value == null
             * @param delimiter
             */
            function processNameValues(nameValues, skipEmpty, delimiter)
            {
                var result = {},
                    arrays = {},
                    i, j, k, l,
                    value,
                    nameParts,
                    currResult,
                    arrNameFull,
                    arrName,
                    arrIdx,
                    namePart,
                    name,
                    _nameParts;

                for (i = 0; i < nameValues.length; i++)
                {
                    value = nameValues[i].value;

                    if (skipEmpty && (value === '' || value === null)) continue;

                    name = nameValues[i].name;
                    _nameParts = name.split(delimiter);
                    nameParts = [];
                    currResult = result;
                    arrNameFull = '';

                    for(j = 0; j < _nameParts.length; j++)
                    {
                        namePart = _nameParts[j].split('][');
                        if (namePart.length > 1)
                        {
                            for(k = 0; k < namePart.length; k++)
                            {
                                if (k == 0)
                                {
                                    namePart[k] = namePart[k] + ']';
                                }
                                else if (k == namePart.length - 1)
                                {
                                    namePart[k] = '[' + namePart[k];
                                }
                                else
                                {
                                    namePart[k] = '[' + namePart[k] + ']';
                                }

                                arrIdx = namePart[k].match(/([a-z_]+)?\[([a-z_][a-z0-9_]+?)\]/i);
                                if (arrIdx)
                                {
                                    for(l = 1; l < arrIdx.length; l++)
                                    {
                                        if (arrIdx[l]) nameParts.push(arrIdx[l]);
                                    }
                                }
                                else{
                                    nameParts.push(namePart[k]);
                                }
                            }
                        }
                        else
                            nameParts = nameParts.concat(namePart);
                    }

                    for (j = 0; j < nameParts.length; j++)
                    {
                        namePart = nameParts[j];

                        if (namePart.indexOf('[]') > -1 && j == nameParts.length - 1)
                        {
                            arrName = namePart.substr(0, namePart.indexOf('['));
                            arrNameFull += arrName;

                            if (!currResult[arrName]) currResult[arrName] = [];
                            currResult[arrName].push(value);
                        }
                        else if (namePart.indexOf('[') > -1)
                        {
                            arrName = namePart.substr(0, namePart.indexOf('['));
                            arrIdx = namePart.replace(/(^([a-z_]+)?\[)|(\]$)/gi, '');

                            /* Unique array name */
                            arrNameFull += '_' + arrName + '_' + arrIdx;

                            /*
                             * Because arrIdx in field name can be not zero-based and step can be
                             * other than 1, we can't use them in target array directly.
                             * Instead we're making a hash where key is arrIdx and value is a reference to
                             * added array element
                             */

                            if (!arrays[arrNameFull]) arrays[arrNameFull] = {};
                            if (arrName != '' && !currResult[arrName]) currResult[arrName] = [];

                            if (j == nameParts.length - 1)
                            {
                                if (arrName == '')
                                {
                                    currResult.push(value);
                                    arrays[arrNameFull][arrIdx] = currResult[currResult.length - 1];
                                }
                                else
                                {
                                    currResult[arrName].push(value);
                                    arrays[arrNameFull][arrIdx] = currResult[arrName][currResult[arrName].length - 1];
                                }
                            }
                            else
                            {
                                if (!arrays[arrNameFull][arrIdx])
                                {
                                    if ((/^[a-z_]+\[?/i).test(nameParts[j+1])) currResult[arrName].push({});
                                    else currResult[arrName].push([]);

                                    arrays[arrNameFull][arrIdx] = currResult[arrName][currResult[arrName].length - 1];
                                }
                            }

                            currResult = arrays[arrNameFull][arrIdx];
                        }
                        else
                        {
                            arrNameFull += namePart;

                            if (j < nameParts.length - 1) /* Not the last part of name - means object */
                            {
                                if (!currResult[namePart]) currResult[namePart] = {};
                                currResult = currResult[namePart];
                            }
                            else
                            {
                                currResult[namePart] = value;
                            }
                        }
                    }
                }

                return result;
            }

            function getFormValues(rootNode, nodeCallback, useIdIfEmptyName)
            {
                var result = extractNodeValues(rootNode, nodeCallback, useIdIfEmptyName);
                return result.length > 0 ? result : getSubFormValues(rootNode, nodeCallback, useIdIfEmptyName);
            }

            function getSubFormValues(rootNode, nodeCallback, useIdIfEmptyName)
            {
                var result = [],
                    currentNode = rootNode.firstChild;

                while (currentNode)
                {
                    result = result.concat(extractNodeValues(currentNode, nodeCallback, useIdIfEmptyName));
                    currentNode = currentNode.nextSibling;
                }

                return result;
            }

            function extractNodeValues(node, nodeCallback, useIdIfEmptyName) {
                var callbackResult, fieldValue, result, fieldName = getFieldName(node, useIdIfEmptyName);

                callbackResult = nodeCallback && nodeCallback(node);

                if (callbackResult && callbackResult.name) {
                    result = [callbackResult];
                }
                else if (fieldName != '' && node.nodeName.match(/INPUT|TEXTAREA/i)) {
                    fieldValue = getFieldValue(node);
                    result = [ { name: fieldName, value: fieldValue} ];
                }
                else if (fieldName != '' && node.nodeName.match(/SELECT/i)) {
                    fieldValue = getFieldValue(node);
                    result = [ { name: fieldName.replace(/\[\]$/, ''), value: fieldValue } ];
                }
                else {
                    result = getSubFormValues(node, nodeCallback, useIdIfEmptyName);
                }

                return result;
            }

            function getFieldName(node, useIdIfEmptyName)
            {
                if (node.name && node.name != '') return node.name;
                else if (useIdIfEmptyName && node.id && node.id != '') return node.id;
                else return '';
            }


            function getFieldValue(fieldNode)
            {
                if (fieldNode.disabled) return null;

                switch (fieldNode.nodeName) {
                    case 'INPUT':
                    case 'TEXTAREA':
                        switch (fieldNode.type.toLowerCase()) {
                            case 'radio':
                            case 'checkbox':
                                if (fieldNode.checked && fieldNode.value === "true") return true;
                                if (!fieldNode.checked && fieldNode.value === "true") return false;
                                if (fieldNode.checked) return fieldNode.value;
                                break;

                            case 'button':
                            case 'reset':
                            case 'submit':
                            case 'image':
                                return '';
                                break;

                            default:
                                return fieldNode.value;
                                break;
                        }
                        break;

                    case 'SELECT':
                        return getSelectedOptionValue(fieldNode);
                        break;

                    default:
                        break;
                }

                return null;
            }

            function getSelectedOptionValue(selectNode)
            {
                var multiple = selectNode.multiple,
                    result = [],
                    options,
                    i, l;

                if (!multiple) return selectNode.value;

                for (options = selectNode.getElementsByTagName("option"), i = 0, l = options.length; i < l; i++)
                {
                    if (options[i].selected) result.push(options[i].value);
                }

                return result;
            }

            return form2js;

        })();
    </script>
</liferay-util:html-bottom>