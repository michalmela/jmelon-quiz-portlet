package com.blogspot.jmelon.portlet.quiz.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;

import javax.portlet.PortletPreferences;
import javax.portlet.ReadOnlyException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.portlet.ValidatorException;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

import com.blogspot.jmelon.portlet.quiz.model.QuizPrefs;
import com.blogspot.jmelon.portlet.quiz.model.transport.QuizArticleQuery;
import com.blogspot.jmelon.portlet.quiz.util.QuizPortletUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil;
import com.liferay.portlet.journal.service.JournalTemplateLocalServiceUtil;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
@Controller
@RequestMapping("EDIT")
public class QuizEditController {

	private static final Logger LOGGER = LoggerFactory.getLogger(QuizEditController.class);

	private static final String BLANK = "";
	// keys
	private static final String TITLE = "title";
	private static final String TEMPLATES = "templates";
	//
	private static final String RESOLUTION = "resolution";
	private static final String SUCCESS = "success";
	private static final String FAILED = "failed";
	//
	private static final String SCOPE = "SCOPE";
	private static final String GLOBAL = "GLOBAL";
	//
	private static final String QUIZ_PREFS = "quizPrefs";
	// views
	private static final String JSON_VIEW = "jsonView";
	private static final String EDIT_JSP = "quiz/edit";
	
	@Autowired
	MessageSource messageSource;

	@RequestMapping
	public String view(RenderRequest request, RenderResponse response, Model model) throws JsonParseException, JsonMappingException, IOException {
		if(!model.containsAttribute(QUIZ_PREFS)) {
			PortletPreferences portletPrefs = request.getPreferences();
			String prefsJson = portletPrefs.getValue(QUIZ_PREFS, BLANK);
			LOGGER.debug("Marshalled quiz portlet prefs: {}", prefsJson);
			
			if(StringUtils.hasText(prefsJson)) {				
				QuizPrefs quizPrefs = new ObjectMapper().readValue(prefsJson, QuizPrefs.class);
				model.addAttribute(QUIZ_PREFS, quizPrefs);
				LOGGER.debug("Unmarshalled quiz portlet prefs: {}",quizPrefs);
			} else {
				LOGGER.debug("No prefs set for quiz portlet at {}", ((ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY)).getURLCurrent());
			}
		} else {
			LOGGER.debug("Prefs seem already set");
		}
		

		return EDIT_JSP;
	}

	
	@ResourceMapping("savePrefs")
	public String savePrefs(ResourceRequest request, ResourceResponse response, Model model) throws UnsupportedEncodingException, IOException, ReadOnlyException {
		BufferedReader requestReader = request.getReader();
		String prefsJson = QuizPortletUtil.convertReaderToString(requestReader);
		
		PortletPreferences portletPrefs = request.getPreferences();
		portletPrefs.setValue(QUIZ_PREFS, prefsJson);
		
		try {
	        portletPrefs.store(); // Preferences validator set in portlet.xml will validate it now
	        model.addAttribute(RESOLUTION,SUCCESS);
        } catch (ValidatorException e) {
	        LOGGER.error("Quiz portlet preferences could not be validated.",e);
	        model.addAttribute(RESOLUTION,FAILED);
	        
	        Enumeration<String> failedKeys = e.getFailedKeys();
			while(failedKeys.hasMoreElements()) {
				String key = failedKeys.nextElement();
				messageSource.getMessage(key, null, key, request.getLocale());
	        }
        }
		return "jsonView";
	}
	
	@ResourceMapping("checkArticle")
	public ModelAndView checkArticle(ResourceRequest request, ResourceResponse response, ModelAndView mav,
	        @RequestBody QuizArticleQuery query) {
		mav.setView(JSON_VIEW);
		ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);

		try {
			long groupId;
			if (GLOBAL.equals(query.getGroup())) {
				groupId = themeDisplay.getCompanyGroupId();
			} else if (SCOPE.equals(query.getGroup())) {
				groupId = themeDisplay.getScopeGroupId();
			} else {
				throw new PortalException("Unknown group");
			}
			
			JournalArticle article = JournalArticleLocalServiceUtil.getArticle(groupId, query.getArticleId());
			mav.addObject(TITLE, article.getTitle());
			mav.addObject(TEMPLATES,JournalTemplateLocalServiceUtil.getStructureTemplates(groupId, article.getStructureId()));
			mav.addObject(RESOLUTION,SUCCESS);
		} catch (PortalException e) {
			mav.addObject(RESOLUTION, FAILED);
			LOGGER.error("Couldn't get templates for query: {}", query);
		} catch (SystemException e) {
			mav.addObject(RESOLUTION, FAILED);
			LOGGER.error("Couldn't get templates for query: {}", query);
		}

		return mav;
	}
}