package practicework.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import static org.hamcrest.core.Is.is;

public class ReserveConfirmPage {
    private final WebDriver driver;
    private final By price = By.id("price");
    private final By dateFrom = By.id("datefrom");
    private final By dateTo = By.id("dateto");
    private final By daysCount = By.id("dayscount");
    // Edited
    private final By person = By.id("hc");
    private final By breakfast = By.id("bf_order");
    private final By kanko_hiru = By.id("plan_a_order");
    private final By kanko_toku = By.id("plan_b_order");
    private final By guestname = By.id("gname");

        
    public ReserveConfirmPage(WebDriver driver) {
        this.driver = driver;
    }
    
    public String getPrice() {
        return driver.findElement(price).getText();
    }
    
    public String getDateFrom() {
        return driver.findElement(dateFrom).getText();
    }

    public String getDateTo() {
        return driver.findElement(dateTo).getText();
    }
    
    public String getDaysCount() {
        return driver.findElement(daysCount).getText();
    }

    public String getPerson() {
        return driver.findElement(person).getText();
    }

    public String getBreakfast() {
        return driver.findElement(breakfast).getText();
    }

    public boolean existsKankoHiru() {
        return driver.findElements(kanko_hiru).size() > 0;
    }

    public String getKankoHiru() {
        return driver.findElement(kanko_hiru).getText();
    }

    public boolean existsKankoToku() {
        return driver.findElements(kanko_toku).size() > 0;
    }

    public String getKankoToku() {
        return driver.findElement(kanko_toku).getText();
}

    public String getGuestname() {
        return driver.findElement(guestname).getText();
    }

    public String getDateNew(){
        return driver.findElement(By.id("datePick")).getAttribute("value");
    }

    public String getTermNew() {
        return driver.findElement(By.id("reserve_term")).getAttribute("value");
    }

    public String getBreakfastNew() {
        return driver.findElement(By.id("breakfast_on")).getAttribute("value");
    }

    public boolean getPlanANew() {
        return driver.findElement(By.id("plan_a")).isSelected();
    }

    public boolean getPlanBBew() {
        return driver.findElement(By.id("plan_b")).isSelected();
    }

    public String getNameNew() {
        return driver.findElement(By.id("guestname")).getAttribute("value");
    }

}
