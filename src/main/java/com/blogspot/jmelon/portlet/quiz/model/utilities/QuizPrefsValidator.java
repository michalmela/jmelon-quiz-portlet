package com.blogspot.jmelon.portlet.quiz.model.utilities;

import java.util.Arrays;

import javax.portlet.PortletPreferences;
import javax.portlet.PreferencesValidator;
import javax.portlet.ValidatorException;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.ObjectMapper;

import com.blogspot.jmelon.portlet.quiz.model.QuizPrefs;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizPrefsValidator implements PreferencesValidator {

//	private static final Logger LOGGER = LoggerFactory.getLogger(QuizPrefsValidator.class); // not used right now

	@Override
	public void validate(PortletPreferences preferences) throws ValidatorException {
		try {
			QuizPrefs prefs = new ObjectMapper().readValue(preferences.getValue("quizPrefs", ""), QuizPrefs.class);

			if (prefs.getResults().isEmpty()) { throw new ValidatorException(
			        "At least one result with a 0 lower bound must exist", Arrays.asList("results")); }

		} catch (JsonParseException e) {
			throw new ValidatorException(
			        "Quiz portlet preferences could not be parsed as valid json", e,
			        Arrays.asList("exception.parse.json"));
		} catch (Exception e) {
			throw new ValidatorException(
			        "Quiz portlet preferences could not be validated because exception was thrown", e,
			        Arrays.asList("quizPrefs"));
		}
	}
}
