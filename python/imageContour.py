import cv2
import matplotlib.pyplot as plt

# image read
img = cv2.imread("../letters/p_mare/P.jpg")
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# grayscale image
gray = cv2.cvtColor(img.copy(), cv2.COLOR_BGR2GRAY)
# detect the contour
ret, thresh = cv2.threshold(gray, 125, 255, 0)
contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

# draw the contour
copy_img = img.copy()
cv2.drawContours(copy_img, contours, -1, (0, 0, 255), 2)

# Save x coordinates into figureX.txt and y coordinates into figureY.txt
with open('../letters/p_mare/P_X.txt', 'w') as file_x, open('../letters/p_mare/P_Y.txt', 'w') as file_y:
    for contour in contours:
        for point in contour:
            x, y = point[0]
            file_x.write(str(x) + '\n')
            file_y.write(str(y) + '\n')

titles = ['original', 'contours']
imgs = [img, copy_img]
for i in range(2):
    plt.subplot(1, 2, i + 1)
    plt.xticks([])
    plt.yticks([])
    plt.title(titles[i])
    plt.imshow(imgs[i])

plt.savefig('../letters/p_mare/image_contour_P.jpg', format='jpg')
plt.show()
