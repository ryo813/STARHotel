package introwork;

import core.ChromeDriverTest;
import org.junit.Test;

import java.io.File;

/**
 * 入門課題その2:「クリックしてみよう」
 */
public class IntroWork2Test extends ChromeDriverTest {
   @Test
    public void test() throws Exception {
        File html = new File("introwork/introWork2.html");
        String url = "file:///" + html.getAbsolutePath();
        driver.get(url);
        
        // TODO 以下を削除して、代わりにOKボタンをクリックする処理を記述してください
        Thread.sleep(8000);
        // TODO ここまで削除してください
    }
}