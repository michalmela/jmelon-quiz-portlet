package com.blogspot.jmelon.portlet.quiz.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletPreferences;
import javax.portlet.ReadOnlyException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ValidatorException;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.bind.annotation.ActionMapping;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 * @
 */
@Controller
@RequestMapping("EDIT_DEFAULTS")
public class QuizDefaultsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(QuizDefaultsController.class);

//	private static final String BLANK = "";
	//
	private static final String QUIZ_PREFS = "quizPrefs";
	// views
//	private static final String JSON_VIEW = "jsonView";
	private static final String EDIT_JSP = "quiz/edit_defaults";
	//
	private static final String RESOLUTION = "resolution";
	private static final String SUCCESS = "success";
	private static final String FAILED = "failed";
	
	@Autowired
	MessageSource messageSource;

	@RequestMapping
	public String view(RenderRequest request, RenderResponse response, Model model) throws JsonParseException,
	        JsonMappingException, IOException {
		return EDIT_JSP;
	}
	
	@ActionMapping("saveDefs")
	public void saveDefs(ActionRequest request, ActionResponse response, Model model, @RequestParam String prefs) throws UnsupportedEncodingException, IOException, ReadOnlyException {
		// QuizPrefs quizPrefs = new ObjectMapper().readValue(requestReader,QuizPrefs.class);
		
		PortletPreferences portletPrefs = request.getPreferences();
		portletPrefs.setValue(QUIZ_PREFS, prefs);
		
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
	}
}