from Tkinter import *
import Image, ImageDraw, ImageTk
import numpy as np
import cnn

canvas_width = 300
canvas_height = 300

root = Tk()
root.title("Brain")
root.resizable(1,1)

x1=None
y1=None

img = Image.new("L", (canvas_width, canvas_height), (0))
img_draw = ImageDraw.Draw(img)

brain = cnn.brain("good.hdf5")

def point(event):
    global x1
    global y1
    x2=event.x
    y2=event.y
    if x1 != None:
        c.create_line(x1, y1, x2, y2, width=15, fill="white")
        c.create_oval(x2-7, y2-7, x2+7, y2+7, fill="white", outline="white")
        img_draw.line([x1, y1, x2, y2], width=15, fill=(255))
        img_draw.ellipse([x2-7, y2-7, x2+7, y2+7], fill=(255), outline=(255))
    x1=x2
    y1=y2

def release(event):
    global x1
    global y1
    global img
    global brain
    global w
    x1=None
    y1=None
    a = np.array(img.resize((28, 28)))
    a = np.reshape(a, (1, 1, 28, 28))
    c = brain.predict_classes(a)
    w.config(text="%s" % c[0])

def clear(event):
    global c
    global w
    global img
    global img_draw
    c.create_rectangle(0, 0, canvas_width, canvas_height, fill="black", outline="black")
    img = Image.new("L", (canvas_width, canvas_height), (0))
    img_draw = ImageDraw.Draw(img)
    w.config(text="")

v = Label(root, text="Write a digit on the black canvas. Clear with right-click.", font=("Helvetica", 8))
v.pack()

c = Canvas(root, bg="black", width=canvas_width, height=canvas_height)
c.configure(cursor="crosshair")
c.pack()
c.bind("<B1-Motion>", point)
c.bind("<ButtonRelease-1>", release)
c.bind("<Button-3>", clear)

w = Label(root, text="", font=("Helvetica", 72))
w.pack()

root.mainloop()
