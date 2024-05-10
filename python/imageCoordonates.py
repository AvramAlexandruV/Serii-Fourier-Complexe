import cv2
import matplotlib.pyplot as plt
import numpy as np

# image read
img = cv2.imread("../letters/z_mare/Z.jpg")
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# apply grayscale
gray = cv2.cvtColor(img.copy(), cv2.COLOR_BGR2GRAY)

# detect the contour
ret, thresh = cv2.threshold(gray, 125, 255, 0)
contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

# extract contour coordinates
contour_coordinates = []
for contour in contours:
    for point in contour:
        x, y = point[0]
        contour_coordinates.append((x, y))

print(contour_coordinates)

# plot contour coordinates
contour_coordinates = np.array(contour_coordinates)
plt.scatter(contour_coordinates[:, 0], contour_coordinates[:, 1], color='red', s=5)
plt.title('Contour Coordinates')
plt.xlabel('X')
plt.ylabel('Y')
plt.gca().invert_yaxis()  # Invert Y-axis to match image coordinates (origin at top-left)
plt.savefig('../letters/z_mare/contour_coordinates_plot.jpg', format='jpg')
plt.show()
