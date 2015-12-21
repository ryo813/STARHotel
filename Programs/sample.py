# -*- coding: utf-8 -*-
from tools import generateCode

url_samp = "introwork/introWork1.html"
tag1  = "user_name"
text1 = "ryosuke"
comment1 = "// コメント１"
tag2  = "password"
text2 = "pass"
comment2 = "// コメント２"
ind = "        "

text  = ind + "File html = new File(\"" + url_samp + "\");\n"
text += ind + "String url = html.toURI().toString();\n"
text += ind + "// 指定したURLのWebページに移動\n"
text += ind + "driver.get(url);\n\n"
text += ind + comment1 + "\n"
text += ind + "driver.findElement(By.id(\"" + tag1 + "\")).clear();\n"
text += ind + "driver.findElement(By.id(\"" + tag1 + "\")).sendKeys(\"" + text1 + "\");\n"
text += ind + comment2 + "\n"
text += ind + "driver.findElement(By.id(\"" + tag2 + "\")).clear();\n"
text += ind + "driver.findElement(By.id(\"" + tag2 + "\")).sendKeys(\"" + text2 + "\");\n"

generateCode(text)