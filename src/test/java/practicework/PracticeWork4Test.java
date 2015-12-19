package practicework;

import core.ChromeDriverTest;
import org.junit.Before;
import org.junit.Test;
import practicework.pages.ReserveConfirmPage;
import practicework.pages.ReserveInputPageNew;

import java.io.File;
import java.util.concurrent.TimeUnit;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

public class PracticeWork4Test extends ChromeDriverTest {
    @Before
    public void setUp() {
        super.setUp();
        // ページ遷移の際に少し待機するため
        driver.manage().timeouts().implicitlyWait(500, TimeUnit.MILLISECONDS);
    }

    @Test
    public void testReserveWith1Member() {
        File html = new File("reserveApp_Renewal/index.html");
        String url = html.toURI().toString();
        driver.get(url);

        // 1ページ目入力画面
        ReserveInputPageNew inputPage = new ReserveInputPageNew(driver);
        inputPage.setReserveDate("2015", "12", "26");  // TODO 明日以降直近の土曜日に変更してください
        inputPage.setReserveTerm("1");
        // TODO 残りの処理を記述してください
        inputPage.setReservePerson("9");
        inputPage.setBreakfast(true);
        inputPage.setKankoHiru(true);
        inputPage.setKankoToku(true);
        inputPage.setName("a");

        
        // TODO 残りの処理を記述してください
        
        ReserveConfirmPage confirmPage = inputPage.goToNext();
        
        // 2ページ目入力画面
        assertThat(confirmPage.getPrice(), is("105750"));
        assertThat(confirmPage.getDateFrom(), is("2015年12月26日")); // TODO 変更してください
        assertThat(confirmPage.getDateTo(), is("2015年12月27日")); // TODO 変更してください
        assertThat(confirmPage.getDaysCount(), is("1"));

        // TODO 残りの処理を記述してください
        assertThat(confirmPage.getPerson(), is("9"));
        assertThat(confirmPage.getBreakfast(), is("あり"));
        if (confirmPage.existsKankoHiru()) {
            assertThat(confirmPage.getKankoHiru(), is("昼からチェックインプラン"));
        }
        if (confirmPage.existsKankoToku()) {
            assertThat(confirmPage.getKankoToku(), is("お得な観光プラン"));
        }
        assertThat(confirmPage.getGuestname(), is("a"));

        // 最終ページへ遷移
        ReserveConfirmPage finishPage = inputPage.goToFinish();
    }
}
