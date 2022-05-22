from matplotlib import pyplot
from mtcnn.mtcnn import MTCNN
from PIL import Image, ImageDraw

class FaceDetector:
    def __init__(self, filename, result_filename):
        self.filename = filename
        self.resultFilename = result_filename
        
        self.pixels = pyplot.imread(filename)

        self.detector = MTCNN()
        self.faces = self.detector.detect_faces(self.pixels)

    def get_faces_coordinates(self):
        return self.faces
    
    def draw_faces(self):
        for face in self.faces:
            img = Image.open(self.filename)
            idraw = ImageDraw.Draw(img)

            for key, value in face["keypoints"].items():
                x, y, width, height = face["box"]
                idraw.rectangle((x, y, x + width, y + height), fill = None, outline = "red")
                
                x, y = value
                r = 2
                idraw.ellipse((x - r, y - r, x + r, y + r), fill = "red", outline = "red")
                
            img.save(self.resultFilename)
            img.close()