<%-- See the file "LICENSE" for the full license governing this code. --%>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui"%>
<%-- LFR-6.1.0 <%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui"%> --%>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<portlet:defineObjects />
<liferay-theme:defineObjects/>
<c:set var="ns"><portlet:namespace/></c:set>

<c:if test="${not empty resolution}">
    <div class="portlet-msg-${resolution eq 'failed' ? 'error' : resolution}">
       <spring:message code="edit.save.resolution.${resolution}" />
    </div>
</c:if>

<portlet:actionURL var="savePrefsUrl" name="savePrefs" />
<form class="quiz-form" action="${savePrefsUrl}" id="${ns}form" class="quiz-portlet-form">
    <fieldset>
        <legend><spring:message code="edit.questions"/></legend>
        <ol class="tabs">
            <c:forEach items="${quizPrefs.tabs}" var="tab" varStatus="tabVs">
                <c:set var="t" value="${tabVs.index}" />
                <li>
                    <div>
                        <label><spring:message code="edit.tab.tabTitle" /></label> <input
                            class="tabInput" name="tabs[${t}].tabTitle" type="text" value="${tab.tabTitle}" />
                    </div>
                    <ol class="questions">
                        <c:forEach var="question" items="${tab.questions}" varStatus="qVs">
                            <c:set var="q" value="${qVs.index}" />
                            <li>
                                <div>
                                    <label><spring:message code="edit.question.question"/></label>
                                    <input class="questionInput" name="tabs[${t}].questions[${q}].question" type="text"
                                    value="${question.question}" />
                                </div>
                                <ol class="answers">
                                   <c:forEach var="answer" items="${question.answers}" varStatus="aVs">
                                       <c:set var="a" value="${aVs.index}"/>
                                       <li>
                                            <div>
                                                <label><spring:message code="edit.answer.answer"/></label>
                                                <input name="tabs[${t}].questions[${q}].answers[${a}].answer" type="text" 
                                                value="${answer.answer}" />
                                            </div>
                                            <div>
                                                <label><spring:message code="edit.question.answer.points"/></label>
                                                <input name="tabs[${t}].questions[${q}].answers[${a}].points" 
                                                value="${answer.points}" type="number" min="0" value="0"/>
                                            </div>
                                            <button class="quiz-remove quiz-remove-answer"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>
                                       </li>
                                   </c:forEach>
                                </ol>
                                <button class="quiz-add-answer"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.answer"/></button>
                                <button class="quiz-remove quiz-remove-question"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>
                            </li>
                        </c:forEach>
                    </ol>
                    <button class="quiz-add-question"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.question"/></button>
                    <button class="quiz-remove quiz-remove-tab"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>
                </li>
            </c:forEach>
        </ol>
        <button class="quiz-add-tab"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.tab"/></button>
    </fieldset>
    <fieldset>
        <legend><spring:message code="edit.results"/></legend>
        <ol class="results">
            <li>
            
                <div>
                    <label><spring:message code="edit.result.bound"/></label>
                    <input disabled="disabled" name="results[0].bound" type="number" min="0" value="0"/>
                </div>
                <div>
                    <label><spring:message code="edit.result.resultGroup"/></label>
                    <select name="results[0].resultGroup">
                        <option value="GLOBAL">global</option>
                        <option value="SCOPE">scope</option>
                    </select>
                </div>
                <div>
                    <label><spring:message code="edit.result.resultArticleId"/></label>
                    <input class="article-input" name="results[0].resultArticleId"/>
                </div>
                <div>
                    <label><spring:message code="edit.result.resultTemplateId"/></label>
                    <input class="article-input" name="results[0].resultTemplateId"/>
                </div>
                <button class="quiz-remove quiz-remove-result"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>
            </li>
        </ol>
        <button class="quiz-remove quiz-add-result"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.result"/></button>
    </fieldset>
    <fieldset>
        <legend><spring:message code="edit.labels"/></legend>
        <div>
            <label for="${ns}quiz-edit-summary-tab-title"><spring:message code="edit.summary.tab.title"/></label>
            <input id="${ns}quiz-edit-summary-tab-title" name="summaryTabTitle" value="${quizPrefs.summaryTabTitle}"></value>
        </div>
            <label for="${ns}quiz-edit-label-next"><spring:message code="edit.label.next"/></label>
            <input id="${ns}quiz-edit-summary-next" name="nextLabel" value="${quizPrefs.nextLabel}"></value>
        <div>
            <label for="${ns}quiz-edit-label-prev"><spring:message code="edit.label.prev"/></label>
            <input id="${ns}quiz-edit-summary-prev" name="prevLabel" value="${quizPrefs.prevLabel}"></value>
        </div>
        <div>
            <label for="${ns}quiz-edit-label-submit"><spring:message code="edit.label.submit"/></label>
            <input id="${ns}quiz-edit-summary-submit" name="submitLabel" value="${quizPrefs.submitLabel}"></value>
        </div>
    </fieldset>
        
    <input type="submit" value="<spring:message code="edit.save" />"/>
</form>

<%-- TODO LFR-6.1.0 <liferay-util:body-bottom> --%>
<liferay-util:html-bottom>
<script type="text/javascript">

resultTemplate = '\
<li>\
    <div>\
        <label><spring:message code="edit.result.bound"/></label>\
        <input name="%name%.bound" type="number" min="1" value="1"/>\
    </div>\
    <div>\
        <label><spring:message code="edit.result.resultGroup"/></label>\
        <select name="%name%.resultGroup">\
            <option value="GLOBAL">global</option>\
            <option value="SCOPE">scope</option>\
        </select>\
    </div>\
    <div>\
        <label><spring:message code="edit.result.resultArticleId"/></label>\
        <input class="article-input" name="%name%.resultArticleId"/>\
    </div>\
    <div>\
        <label><spring:message code="edit.result.resultTemplateId"/></label>\
        <input class="article-input" name="%name%.resultTemplateId"></input>\
    </div>\
    <button class="quiz-remove quiz-remove-result"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>\
</li>\
    ';

tabTemplate = '\
<li class="tab">\
  <div>\
    <label><spring:message code="edit.tab.tabTitle"/></label>\
    <input class="tabInput" name="%name%.tabTitle" type="text"/>\
  </div>\
  <ol class="questions"></ol>\
  <button class="quiz-add-question"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.question"/></button>\
  <button class="quiz-remove quiz-remove-tab"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>\
</li>\
';

questionTemplate = '\
<li class="question">\
  <div>\
    <label><spring:message code="edit.question.question"/></label>\
    <input class="questionInput" name="%name%.question" type="text"/>\
  </div>\
  <ol class="answers"></ol>\
  <button class="quiz-add-answer"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/add.png"> <spring:message code="edit.add.answer"/></button>\
  <button class="quiz-remove quiz-remove-question"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>\
</li>\
';

answerTemplate = '\
<li>\
    <div>\
        <label><spring:message code="edit.answer.answer"/></label>\
        <input name="%name%.answer" type="text" />\
    </div>\
    <div>\
        <label><spring:message code="edit.question.answer.points"/></label>\
        <input name="%name%.points"  type="number" min="0" value="0"/>\
    </div>\
    <button class="quiz-remove quiz-remove-answer"><img class="btn-img" alt="" src="/html/themes/control_panel/images/common/delete.png"></button>\
</li>';



reorderAnswers = function($answersOl) {
    $answersOl.children().each(function(i,li) {
        $(li).children("div").children("input").each(function(j,input){
            var $input = $(input);
            $input.attr("name",$input.attr("name").replace(/answers.\d./,"answers["+i+"]"));
        })
    })
}

reorderQuestions = function($questionsOl) {
    $questionsOl.children().each(function(i,li) {
        $(li).find("input").each(function(j,input){
            var $input = $(input);
            $input.attr("name",$input.attr("name").replace(/questions.\d./,"questions["+i+"]"));
        })
    })
}

reorderTabs = function($tabsOl) {
    $tabsOl.children().each(function(i,li) {
        $(li).find("input").each(function(j,input){
            var $input = $(input);
            $input.attr("name",$input.attr("name").replace(/tabs.\d./,"tabs["+i+"]"));
        })
    })
}

reorderResults = function($tabsOl) {
    $tabsOl.children().each(function(i,li) {
        $(li).find("input").each(function(j,input){
            var $input = $(input);
            $input.attr("name",$input.attr("name").replace(/results.\d./,"results["+i+"]"));
        })
    })
}

addAnswerClick = function() {
    event.preventDefault();
    var $this = $(this);
    var index = $this.siblings(".answers").children().size();
    var name = $this.siblings("div").children("input").attr("name").replace(/\.question$/,"") + ".answers[" + index + "]";
    $(answerTemplate.replace(/%name%/g,name)).appendTo($this.siblings(".answers"));
}

addQuestionClick = function() {
    event.preventDefault();
    var $this = $(this);
    var index = $this.siblings(".questions").children().size();
    var name = $this.siblings("div").children("input").attr("name").replace(/\.tabTitle$/,"") + ".questions[" + index + "]";
    $(questionTemplate.replace(/%name%/g,name)).appendTo($this.siblings(".questions"));
}

addTabClick = function() {
    event.preventDefault();
    var $this = $(this);
    var index = $this.siblings(".tabs").children().size();
    var name = "tabs[" + index + "]";
    $(tabTemplate.replace(/%name%/g,name)).appendTo($this.siblings(".tabs"));
}

addResultClick = function() {
    event.preventDefault();
    var $this = $(this);
    var index = $this.siblings(".results").children().size();
    var name = "results[" + index + "]";
    $(resultTemplate.replace(/%name%/g,name)).appendTo($this.siblings(".results"));
}

AUI().ready(
        function() {
//          $(".portlet-layout-lol").droppable({
//                drop: function() { alert('dropped'); }
//             });

// AUI().use('dd-drop', function(Y) {
//     var drop = new A.DD.Drop({
//         node: '.portlet-layout-lol'
//     });
// });

            $(".quiz-add-answer").live("click",addAnswerClick);
            $(".quiz-add-question").live("click",addQuestionClick);
            $(".quiz-add-tab").live("click",addTabClick);
            $(".quiz-add-result").live("click",addResultClick);
            
            $(".quiz-remove").live("mouseenter",function(event){
                $(this).parent().addClass("danger");
            })
            $(".quiz-remove").live("mouseleave",function(event){
                $(this).parent().removeClass("danger");
            })
            
            $(".quiz-remove-answer").live("click",function(event) {
                event.preventDefault();
                var $ol = $(this).parent().parent();
                $(this).parent().remove();
                reorderAnswers($ol);
            });
            
            $(".quiz-remove-question").live("click",function(event) {
                event.preventDefault();
                var $ol = $(this).parent().parent();
                $(this).parent().remove();
                reorderQuestions($ol);
            });

            $(".quiz-remove-tab").live("click",function(event) {
                event.preventDefault();
                var $ol = $(this).parent().parent();
                $(this).parent().remove();
                reorderTabs($ol);
            });
            $(".quiz-remove-result").live("click",function(event) {
                event.preventDefault();
                var $ol = $(this).parent().parent();
                $(this).parent().remove();
                reorderResults($ol);
            });
            
            $(".quiz-form").on("submit",function(e){
                event.preventDefault();
                var url = "<portlet:resourceURL  id="savePrefs"></portlet:resourceURL>";  
                
                jQuery.ajax({ <%-- sends form as json viable for unmarshalling with jackson mapper --%>
                    url: url, 
                    type: 'POST', 
                    dataType: 'json', 
                    data: JSON.stringify( form2js("${ns}form"),".",false,null), 
                    contentType: 'application/json', 
                    success: function(data) { 
                        alert(JSON.stringify(data));
                    } 
                });
                
                alert(JSON.stringify( form2js("${ns}form",".",false,null) ));
//                 alert(JSON.stringify( $("#${ns}form").toObject({mode:"all"}), null, '\t' ));
            });
        }
    );
    
    
    
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