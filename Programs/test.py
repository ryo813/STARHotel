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

url = 'file:///Users/Ryosuke/Desktop/SHIFT/introWork1.html'

"""
  HTML 要素から必要な部分を抽出する
"""

html = urllib2.urlopen(url)
docs = bs(html,"lxml")
tmp = docs.find("input", attrs={"id": "user_name"})


# input 要素を全て抽出する
inp = docs.find_all("input")
ninp = len(inp)  # 見つかった数
# id タグの中身を抽出する
for i in range(len(inp)):
  ptn = re.compile(r"id=\"\w*\"")
  tmp = str(inp[i])
  aa  = ptn.search(tmp).group()
  print aa[4:len(aa)-1]


"""
  抽出した部分に対応するタグに焦点を当てる
"""

tag = "user_name"
driver = webdriver.Firefox()
driver.get(url)

elem = driver.find_element_by_id(tag)
x = elem.location['x']
y = elem.location['y']
width = elem.size['width']
height = elem.size['height']

driver.save_screenshot("a.jpg")

"""
  OpenCV を使って描画
"""
img = cv2.imread("a.jpg")
color = (255, 0, 0) #赤
cv2.rectangle(img, tuple([x,y]),tuple([x+width,y+height]), color, thickness=2)
cv2.imshow('original',img)
cv2.waitKey()
cv2.rectangle(img, tuple([x,y]),tuple([x+width,y+height]), (0,0,255), thickness=2)
cv2.imshow('original',img)
cv2.waitKey()
driver.quit()


"""
elem.send_keys("abc")
off_x = int(elem.size["width"]) / 2
off_y = int(elem.size["height"]) / 2

actions = ActionChains(driver)
actions.move_to_element(elem)
actions.move_by_offset(x - off_x, y - off_y)
actions.click()
actions.move_to_element(elem)
actions.perform()



# time.sleep(20)
# driver.quit()

"""