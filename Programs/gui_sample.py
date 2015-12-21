# -*- coding: utf-8 -*-
import Tkinter as tk

def goout():
    print u'終了'
    exit()

#
# ボタンが押されるとここが呼び出される
#
def DisplayValue(event):
    value = EditBox.get()  # 入力フォームの内容を取得する
    print value

# チェックボタンのチェック状況を取得
def check(event):
    global Val1
    text = ""
    if Val1.get() == True:
        text += "項目1はチェックされています\n"
    else:
        text += "項目1はチェックされていません\n"
    print text

# root の設定
root = tk.Tk()
root.title(u"Software Title")
root.geometry("400x300")

#ラベル
Static1 = tk.Label(text=u'test')
# Static1 = tk.Label(text=u'test', foreground='#ff0000', background='#ffaacc')
# Static1.place(x=150, y=228)
Static1.pack()

#エントリー
EditBox = tk.Entry(width=10)
# EditBox.insert(Tkinter.END,"挿入する文字列")  # 最初から文字列を代入
EditBox.pack()


#ボタン
Button = tk.Button(text=u'ボタンです')
Button.bind("<Button-1>",DisplayValue)
Button.pack()

# チェックボックス
Val1 = tk.BooleanVar()
Val1.set(True)
CheckBox = tk.Checkbutton(text="チェック", variable=Val1)
CheckBox.pack()
# チェックボックスのチェック
button1 = tk.Button(root, text=u'チェックの取得',width=30)
button1.bind("<Button-1>",check)
button1.pack()


# フレームの設定
frame = tk.Frame(root,bg='',bd=10)
#
b = tk.Button(frame, text=u'終了', command=goout)
b.pack()
# #
# b2 = tk.Button(frame, text=u'終了', command=goout)
# b2.pack()
# #
frame.pack(fill='both',expand=1)
root.mainloop()