# -*- coding: utf-8 -*-

def generateCode(text):

    """
      ユーザーが入力した値を実際に反映させてみる
    """
    fw = open("test.java","w")

    # 最初の設定ファイルをここに書く

    fw.write("package introwork;\n")
    fw.write("\n")
    fw.write("import java.io.File;\n")
    fw.write("\n")
    fw.write("import org.apache.commons.lang3.SystemUtils;\n")
    fw.write("import org.junit.After;\n")
    fw.write("import org.junit.Before;\n")
    fw.write("import org.junit.Test;\n")
    fw.write("import org.openqa.selenium.By;\n")
    fw.write("import org.openqa.selenium.WebDriver;\n")
    fw.write("import org.openqa.selenium.WebElement;\n")
    fw.write("import org.openqa.selenium.chrome.ChromeDriver;\n")
    fw.write("\n")
    fw.write("/**\n")
    fw.write(" * 入門課題その1:「動かしてみよう、Selenium」\n")
    fw.write(" */\n")
    fw.write("public class IntroWork1Test {\n")
    fw.write("    private WebDriver driver;\n")
    fw.write("\n")
    fw.write("    private String chromeDriverPath() {\n")
    fw.write("        String path;\n")
    fw.write("        if (SystemUtils.IS_OS_MAC || SystemUtils.IS_OS_MAC_OSX) {\n")
    fw.write("            path = \"chromedriver/mac/chromedriver\"; // Mac環境の場合\n")
    fw.write("        } else {\n")
    fw.write("            path = \"chromedriver/win/chromedriver.exe\"; // fw.write(\"Windows環境の場合\n")
    fw.write("        }\n")
    fw.write("        File file = new File(path);\n")
    fw.write("        return file.getAbsolutePath();\n")
    fw.write("    }\n")
    fw.write("\n")
    fw.write("    @Before\n")
    fw.write("    public void setUp() {\n")
    fw.write("        System.setProperty(\"webdriver.chrome.driver\", chromeDriverPath());\n")
    fw.write("        driver = new ChromeDriver();\n")
    fw.write("    }\n")
    fw.write("\n")
    fw.write("    @After\n")
    fw.write("    public void tearDown() {\n")
    fw.write("        driver.quit();\n")
    fw.write("    }\n")
    fw.write("\n")
    fw.write("    /**\n")
    fw.write("     * メインとなるテスト処理。\n")
    fw.write("     * JUnitは、「@Test」がついたメソッドをテストメソッドとして実行する。\n")
    fw.write("     */\n")
    fw.write("    @Test\n")
    fw.write("    public void testLoginSuccess() throws Exception {\n")
    fw.write("\n")
    fw.write("        /* ---------- 【ここからがユーザー入力のスクリプト】 ---------- */\n\n")

    ## ここからオリジナルの要素を追加する

    fw.write(text)

    ## ここまでオリジナルの要素
    fw.write("\n        /* ---------- 【ここまでがユーザー入力のスクリプト】 ---------- */\n")
    fw.write("    }\n")
    fw.write("}\n")
    fw.close()