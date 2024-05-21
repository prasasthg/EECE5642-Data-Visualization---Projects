from PIL import Image
from tensorflow.keras.preprocessing.image import img_to_array

def preprocess_image(img_path, label):
    image = Image.open(img_path)
    image = image.resize((224, 224))
    image = img_to_array(image)
    image = image / 255.0  # Normalize pixel values
    return image, label