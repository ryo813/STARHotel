package practicework;

import core.ChromeDriverTest;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import practicework.pages.ReserveInputPage;
import practicework.pages.ReserveConfirmPage;

import java.io.File;
import java.util.concurrent.TimeUnit;

import static org.hamcrest.core.Is.is;

public class PracticeWork5Test extends ChromeDriverTest {
    @Before
    public void setUp() {
        super.setUp();
        // ページ遷移の際に少し待機するため
        driver.manage().timeouts().implicitlyWait(500, TimeUnit.MILLISECONDS);
    }
    
    @Test
    public void testCheckInitialScreen() {
        File html = new File("reserveApp_Renewal/index.html");
        String url = html.toURI().toString();
        driver.get(url);

        // ページ情報の取得用クラス
        ReserveConfirmPage inputPage = new ReserveConfirmPage(driver);

        // 宿泊日の初期値
        Assert.assertThat(inputPage.getDateNew(), is("2015/12/19"));
        // 宿泊日数の初期値
        Assert.assertThat(inputPage.getTermNew(), is("1"));
        // 朝食バイキングの初期値
        Assert.assertThat(inputPage.getBreakfastNew(), is("on"));
        // 観光プランAの初期値
        Assert.assertThat(inputPage.getPlanANew(), is(false));
        // 観光プランBの初期値
        Assert.assertThat(inputPage.getPlanBBew(), is(false));
        // 名前の初期値
        Assert.assertThat(inputPage.getNameNew(), is(""));
    }
}
