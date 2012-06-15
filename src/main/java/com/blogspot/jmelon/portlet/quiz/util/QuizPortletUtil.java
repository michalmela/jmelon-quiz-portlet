package com.blogspot.jmelon.portlet.quiz.util;

import java.io.IOException;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;

/**
 * See the file "LICENSE" for the full license governing this code.
 * @author <a href="jmelon.blogspot.com">Michał Mela</a>
 */
public class QuizPortletUtil {

    public static String convertReaderToString(Reader re) throws IOException {
        if (re != null) {
            Writer writer = new StringWriter();
 
            char[] buffer = new char[1024];
            try {
                int n;
                while ((n = re.read(buffer)) != -1) {
                    writer.write(buffer, 0, n);
                }
            } finally {
                re.close();
            }
            return writer.toString();
        } else {        
            return "";
        }
    }
	
}
