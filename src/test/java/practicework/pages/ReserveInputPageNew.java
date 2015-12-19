package practicework.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

public class ReserveInputPageNew {
    private final WebDriver driver;

    private final By reserveDay = By.id("datePick");
    private final By reserveTerm = By.id("reserve_term");

    private final By reserveYear = By.id("reserve_year");
    private final By reserveMonth = By.id("reserve_month");

    private final By goToNext = By.id("agree_and_goto_next");
    private final By reservePerson = By.id("headcount");
    private final By breakfast_on = By.id("breakfast_on");
    private final By breakfast_off = By.id("breakfast_off");
    private final By kanko_hiru = By.id("plan_a");
    private final By kanko_toku = By.id("plan_b");
    private final By guestname = By.id("guestname");
    private final By commit = By.id("commit");


    public ReserveInputPageNew(WebDriver driver) {
        this.driver = driver;
    }

    private void setReserveYear(String value) {
        WebElement element = driver.findElement(reserveYear);
        element.clear();
        element.sendKeys(value);
    }

    private void setReserveMonth(String value) {
        WebElement element = driver.findElement(reserveMonth);
        element.clear();
        element.sendKeys(value);
    }

    private void setReserveDay(String value) {
        WebElement element = driver.findElement(reserveDay);
        element.clear();
        element.sendKeys(value);
    }

    public void setReserveDate(String year, String month, String day) {
        WebElement element = driver.findElement(reserveDay);
        element.clear();
        element.sendKeys(year + "/" + month + "/" + day);
        element.sendKeys(Keys.RETURN);
    }

    public void setReserveTerm(String value) {
        WebElement element = driver.findElement(reserveTerm);
        Select select = new Select(element);
        select.selectByValue(value);
    }

    public ReserveConfirmPage goToNext() {
        driver.findElement(goToNext).click();
        return new ReserveConfirmPage(driver);
    }

    public ReserveConfirmPage goToFinish() {
        driver.findElement(commit).click();
        return new ReserveConfirmPage(driver);
    }

    public void setReservePerson(String value) {
        WebElement element = driver.findElement(reservePerson);
        Select select = new Select(element);
        select.selectByValue(value);
    }

    public void setBreakfast(boolean on) {
        if (on) {
            driver.findElement(breakfast_on).click(); // 朝食バイキングあり
        } else {
            driver.findElement(breakfast_off).click();
        }
    }

    public void setKankoHiru(boolean checked) {
        WebElement element = driver.findElement(kanko_hiru);  // 昼からチェックインプラン
        if (element.isSelected() != checked) {
            element.click();
        }
    }

    public void setKankoToku(boolean checked) {
        WebElement element = driver.findElement(kanko_toku);  // 昼からチェックインプラン
        if (element.isSelected() != checked) {
            element.click();
        }
    }

    public void setName(String value) {
        WebElement gname = driver.findElement(guestname);
        gname.clear();
        gname.sendKeys(value);
    }

}
