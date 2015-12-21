package introwork;

import java.io.File;

import org.apache.commons.lang3.SystemUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

/**
 * 入門課題その1:「動かしてみよう、Selenium」
 */
public class IntroWork1Test {
    private WebDriver driver;

    private String chromeDriverPath() {
        String path;
        if (SystemUtils.IS_OS_MAC || SystemUtils.IS_OS_MAC_OSX) {
            path = "chromedriver/mac/chromedriver"; // Mac環境の場合
        } else {
            path = "chromedriver/win/chromedriver.exe"; // fw.write("Windows環境の場合
        }
        File file = new File(path);
        return file.getAbsolutePath();
    }

    @Before
    public void setUp() {
        System.setProperty("webdriver.chrome.driver", chromeDriverPath());
        driver = new ChromeDriver();
    }

    @After
    public void tearDown() {
        driver.quit();
    }

    /**
     * メインとなるテスト処理。
     * JUnitは、「@Test」がついたメソッドをテストメソッドとして実行する。
     */
    @Test
    public void testLoginSuccess() throws Exception {

        /* ---------- 【ここからがユーザー入力のスクリプト】 ---------- */

        File html = new File("introwork/introWork1.html");
        String url = html.toURI().toString();
        // 指定したURLのWebページに移動
        driver.get(url);

        // comcom
        private final By name = By.id("user_name");
        driver.findElement(name).clear();
        driver.findElement(name).sendKeys("ryosuke");
        // comcomcomc
        private final By pass = By.id("password");
        driver.findElement(pass).clear();
        driver.findElement(pass).sendKeys("passdayo");

        /* ---------- 【ここまでがユーザー入力のスクリプト】 ---------- */
    }
}
