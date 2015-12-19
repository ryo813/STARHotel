package introwork;

import core.ChromeDriverTest;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.io.File;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

/**
 * 入門課題その7:「表示された値のチェックをしてみよう」
 */
public class IntroWork7Test extends ChromeDriverTest {
    @Test
    public void testGetAndCheckText() throws Exception {
        File html = new File("introwork/introWork7.html");
        String url = html.toURI().toString();
        driver.get(url);
        
        // TODO 以下を削除して、代わりにプルダウンを選択する処理を記述してください
        //Thread.sleep(8000);
        // TODO ここまで削除してください
        WebElement element = driver.findElement(By.id("total"));
        //System.out.println(element.getText());
        assertThat(element.getText(), is("9000"));
    }
}
