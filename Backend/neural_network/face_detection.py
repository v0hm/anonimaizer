from matplotlib import pyplot
from matplotlib.patches import *
from mtcnn.mtcnn import MTCNN


class FaceDetector:
    def __init__(self, filename):
        self.filename = filename

        self.pixels = pyplot.imread(filename)

        self.detector = MTCNN()
        self.faces = self.detector.detect_faces(self.pixels)

    def get_faces_coordinates(self):
        return self.faces

    def draw_faces(self):
        pyplot.imshow(self.pixels)
        image_context = pyplot.gca()

        for face in self.faces:
            # Face rectangles
            x, y, width, height = face["box"]
            face_rectangle = Rectangle((x, y), width, height, fill=False, color="red")
            image_context.add_patch(face_rectangle)

            # Face keypoints
            for key, value in face["keypoints"].items():
                keypoint = Circle(value, radius=2, color="red")
                image_context.add_patch(keypoint)

        pyplot.savefig(self.filename)
        pyplot.close()
