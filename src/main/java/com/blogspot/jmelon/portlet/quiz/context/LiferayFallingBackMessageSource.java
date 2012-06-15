package com.blogspot.jmelon.portlet.quiz.context;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import org.springframework.context.support.ResourceBundleMessageSource;
import com.liferay.portal.kernel.language.LanguageUtil;

/**
 * A ResourceBundleMessageSource which falls back to Liferay's {@link com.liferay.portal.kernel.language.LanguageUtil LanguateUtil} as a
 * last resort if couldn't resolve message for given key
 * 
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class LiferayFallingBackMessageSource extends ResourceBundleMessageSource {
	
	@Override
	protected MessageFormat getMessageFormat(ResourceBundle bundle, String code, Locale locale)
	        throws MissingResourceException {
		MessageFormat messageFormat = super.getMessageFormat(bundle, code, locale);
		if (messageFormat == null) {
			String msg = LanguageUtil.get(locale, code);
			if (msg != null) {
				messageFormat = createMessageFormat(msg, locale);
			}
		}
	    return messageFormat;
	}
	
	@Override
	protected String resolveCodeWithoutArguments(String code, Locale locale) {
		String resolved = super.resolveCodeWithoutArguments(code, locale);
		if (resolved == null) {
			resolved = LanguageUtil.get(locale, code);
		}
		return resolved;
	}
}