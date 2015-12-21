# -*- coding: utf-8 -*-

# 通常のスクレイピング
import urllib2
import lxml.html
from bs4 import BeautifulSoup as bs
# JavaScript対策のスクレイピング
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
import time
import re
# opencv
import cv2
# 自作の書き込みメソッド
from tools import generateCode

url = 'file:///Users/Ryosuke/Desktop/SHIFT/introWork1.html'
cap_name = "cap.jpg"
btn_up   = 63232
btn_down = 63233
btn_enter = 13

"""
  HTML 要素から必要な部分を抽出するz
"""

html = urllib2.urlopen(url)
docs = bs(html,"lxml")
tmp = docs.find("input", attrs={"id": "user_name"})

driver = webdriver.Firefox()
driver.get(url)

# input 要素を全て抽出する
inp = docs.find_all("input")
ninp = len(inp)  # 見つかった数
# id タグの中身を抽出して，座標や大きさを取得しておく
tags = []
x = []
y = []
width = []
height = []
for i in range(len(inp)):
  # 正規表現を使ってタグを抽出
  ptn = re.compile(r"id=\"\w*\"")
  tmp = str(inp[i])
  tmp  = ptn.search(tmp).group()
  tag = tmp[4:len(tmp)-1]
  tags.append( tag )
  # タグから座標やサイズを取得
  elem = driver.find_element_by_id(tag)
  x.append( elem.location['x'] )
  y.append( elem.location['y'] )
  width.append( elem.size['width'] )
  height.append( elem.size['height'] )

# スクリーンキャプチャの保存
driver.save_screenshot(cap_name)
driver.quit()


"""
  抽出した部分に対応するタグに焦点を当てる
"""

# OpenCV で画像の読み込み
img = cv2.imread(cap_name)
color = (255, 0, 0) #赤
i = 0
dic = []
while True:
  img = cv2.imread(cap_name)
  pos_a = tuple([x[i],y[i]])
  pos_b = tuple([x[i]+width[i],y[i]+height[i]])
  cv2.rectangle(img, pos_a, pos_b, color, thickness=2)
  cv2.imshow('original',img)

  # GUI により場合分け
  tmp = cv2.waitKey()
  if tmp == btn_enter:
    text = raw_input()
    dic.append([tags[i], text])
  elif tmp == btn_down:
    i += 1
  elif tmp == btn_up:
    i -= 1

  # 終了条件
  if i < 0 or i > len(tags)-1:
    break
print tags
print dic


"""
  ユーザーが入力した値を実際に反映させてみる
"""
# ちょっと与えておこう
url_samp = "introwork/introWork1.html"
comment = [ "// コメント１", "// コメント２" ]
ind = "        "

# Webドライバーの設定関連
text  = ind + "File html = new File(\"" + url_samp + "\");\n"
text += ind + "String url = html.toURI().toString();\n"
text += ind + "// 指定したURLのWebページに移動\n"
text += ind + "driver.get(url);\n\n"
# Web Element の操作
for i in range(len(dic)):
  text += ind + comment[i] + "\n"
  text += ind + "driver.findElement(By.id(\"" + dic[i][0] + "\")).clear();\n"
  text += ind + "driver.findElement(By.id(\"" + dic[i][0] + "\")).sendKeys(\"" + dic[i][1] + "\");\n"

# 与えられたスクリプトをもとに Java のコードを生成
generateCode(text)