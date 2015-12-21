# -*- coding: utf-8 -*-

# opencv
import cv2
import Tkinter as tk
from PIL import Image, ImageTk


def goout():
    print u'終了'
    exit()

def changeImage(event):
    caps = "cap2.jpg"
    image = createImage(caps)
    label.image = image

def createImage(cap_name):
    # read image with opencv
    img = cv2.imread(cap_name)
    # Rearrange the color channel
    b,g,r = cv2.split(img)
    img = cv2.merge((r,g,b))
    # Convert the Image object into a TkPhoto object
    im = Image.fromarray(img)
    imgtk = ImageTk.PhotoImage(image=im)
    return imgtk


cap_name = "cap.jpg"

# A root window for displaying objects
root = tk.Tk()
# フレームの設定
frame = tk.Frame(root,bg='',bd=10)

# Put it in the display window
label = tk.Label(root)
image = createImage(cap_name)
label.configure(image=image)
label.pack()


# キャプチャ画像切り替え用ボタン
Button = tk.Button(text=u'画像を切り替える')
Button.bind("<Button-1>",changeImage)
Button.pack()

# 終了用のボタン
b = tk.Button(frame, text=u'終了', command=goout)
b.pack()

frame.pack(fill='both',expand=1)

root.mainloop()