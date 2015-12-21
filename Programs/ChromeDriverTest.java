package core;

import org.junit.Before;
import util.ChromeDriverUtility;

/**
 * Created by kenichiro_ota on 2014/04/21.
 */
public class ChromeDriverTest extends WebDriverTest {
    @Before
    public void setUp() {
        driver = ChromeDriverUtility.getChromeDriver();
    }
}
