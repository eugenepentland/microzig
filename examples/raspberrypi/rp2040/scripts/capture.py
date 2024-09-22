import cv2

# Open the first camera (0 usually refers to the default camera)
camera = cv2.VideoCapture(0)

if not camera.isOpened():
    print("Could not open camera")
    exit()

# Read a frame from the camera
ret, frame = camera.read()

# Check if the frame was captured successfully
if ret:
    # Display the captured image
    cv2.imshow('Captured Image', frame)

    # Save the captured image to a file
    cv2.imwrite('captured_image.jpg', frame)

    # Wait for any key press
    cv2.waitKey(0)
else:
    print("Failed to capture image")

# Release the camera and close all OpenCV windows
camera.release()
cv2.destroyAllWindows()
