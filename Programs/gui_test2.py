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
import Tkinter as tk
from PIL import Image, ImageTk
# 自作の書き込みメソッド
from tools import generateCode


def changeImageDown(event):
    if cnt < len(tags) -1:
        image = createImage("down")
        label.configure(image=image)
        label.image = image
    else:
        print "これ以上 down 出来ません"


def changeImageUp(event):
    if cnt > 0:
        image = createImage("up")
        label.configure(image=image)
        label.image = image
    else:
        print "これ以上 up 出来ません"

# 最初の画像
def createFirstImage():
    # read image with opencv
    img = cv2.imread(cap_name)
    # Rearrange the color channel
    b,g,r = cv2.split(img)
    img = cv2.merge((r,g,b))
    # Convert the Image object into a TkPhoto object
    im = Image.fromarray(img)
    imgtk = ImageTk.PhotoImage(image=im)
    return imgtk

# OpenCV で加工した画像を生成する
def createImage(direction):
    global cnt  # カウントをグローバル変数で扱う
    # cnt の番号を増やす
    if direction == "down":
        cnt += 1
    else:
        cnt -= 1
    # read image with opencv
    img = cv2.imread(cap_name)
    color = (255, 0, 0) #赤
    pos_a = tuple([x[cnt],y[cnt]])
    pos_b = tuple([x[cnt]+width[cnt], y[cnt]+height[cnt]])
    cv2.rectangle(img, pos_a, pos_b, color, thickness=2)
    # Rearrange the color channel
    b,g,r = cv2.split(img)
    img = cv2.merge((r,g,b))
    # Convert the Image object into a TkPhoto object
    im = Image.fromarray(img)
    imgtk = ImageTk.PhotoImage(image=im)
    return imgtk

# キャプチャ画像の表示用のラベル
def labelImg(label, cap_name):
    # Put it in the display window
    image = createFirstImage()
    label.configure(image=image)
    label.image = image
    label.pack()

# キャプチャ画像切り替え用ボタン
def btnImgDown():
    Button = tk.Button(text=u'Down')
    Button.bind("<Button-1>",changeImageDown)
    Button.pack()

# キャプチャ画像切り替え用ボタン
def btnImgUp():
    Button = tk.Button(text=u'Up')
    Button.bind("<Button-1>",changeImageUp)
    Button.pack()

# 終了用のボタン
def btnFn():
    b = tk.Button(text=u'終了', command=goQuit)
    b.pack()

# 終了の関数
def goout():
    print u'終了'
    exit()

def goQuit():
    root.quit()

# 入力用のフォーム
def formInput():
    global EditInput
    LabelInput = tk.Label(text=u'Input:')
    LabelInput.pack()
    EditInput = tk.Entry(width=10)
    EditInput.pack()

# 変数名フォーム
def formVariable():
    global EditVariable
    LabelInput = tk.Label(text=u'Variable:')
    LabelInput.pack()
    EditVariable = tk.Entry(width=10)
    EditVariable.pack()

# コメントフォーム
def formComment():
    global EditComment
    LabelInput = tk.Label(text=u'Comment:')
    LabelInput.pack()
    EditComment = tk.Entry(width=10)
    EditComment.pack()

# Formの値を確定するボタン
def btnForm():
    button1 = tk.Button(root, text=u'入力の確定',width=30)
    button1.bind("<Button-1>",checkForm)
    button1.pack()

# 入力情報の確定
def checkForm(event):
    global inputdata  # 入力の確定後の値がこの中に入る
    # 値の取得
    comment   = EditComment.get()  # コメントフォームの内容を取得する
    variable  = EditVariable.get()  # 変数フォームの内容を取得する
    inputform = EditInput.get()  # 入力フォームの内容を取得する
    inputdata.append([tags[cnt], comment, variable, inputform])
    # 値の削除
    EditComment.delete(0, tk.END)
    EditVariable.delete(0, tk.END)
    EditInput.delete(0, tk.END)


"""
  定数の宣言
"""

url = 'file:///Users/Ryosuke/Desktop/SHIFT/programs/introWork1.html'
cap_name = "cap.jpg"
btn_up   = 63232
btn_down = 63233
btn_enter = 13
cnt = -1


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
  GUI による描画
"""

inputdata = []

# Tkinter の root を宣言
root = tk.Tk()
# キャプチャ画像表示用のラベル
label = tk.Label(root)
labelImg(label, cap_name)
# キャプチャ画像切り替え用ボタン
btnImgDown()
btnImgUp()
# 入力用のフォーム
formComment()
formVariable()
formInput()
# 入力フォームの値を抽出
btnForm()
# 終了用のボタン
btnFn()

# Tkinter の Main roop
root.mainloop()

print inputdata

"""
  Java コードの生成処理
"""
url_samp = "introwork/introWork1.html"

ind = "        "

# Webドライバーの設定関連
text  = ind + "File html = new File(\"" + url_samp + "\");\n"
text += ind + "String url = html.toURI().toString();\n"
text += ind + "// 指定したURLのWebページに移動\n"
text += ind + "driver.get(url);\n\n"
# Web Element の操作
for i in range(len(inputdata)):
    # 値の抽出
    tagname  = inputdata[i][0]
    comment  = inputdata[i][1]
    variable = inputdata[i][2]
    data     = inputdata[i][3]
    # コメント
    text += ind + "// " + comment + "\n"
    # ObjectPage用
    text += ind + "private final By " + variable + " = By.id(\"" + tagname + "\");\n"
    text += ind + "driver.findElement(" + variable + ").clear();\n"
    text += ind + "driver.findElement(" + variable + ").sendKeys(\"" + data + "\");\n"

# 与えられたスクリプトをもとに Java のコードを生成
generateCode(text)