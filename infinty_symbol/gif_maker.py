import glob
from PIL import Image
import subprocess
def make_gif(frame_folder):
    try:
        increase_memory()
        # print(glob.glob(f"{frame_folder}/*.jpg"))
        frames = [Image.open(image) for image in glob.glob(f"{frame_folder}/*.jpg")]
        frame_one = frames[0]
        frame_one.save("infinity_frame.gif", format="GIF", append_images=frames,
                   save_all=True, duration=33.33, loop=0)
    finally:
        decrease_memory()

# def number_files(frame_folder):
#     bashCommand = "ls {}".format(frame_folder)
#     process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
#     output, error = process.communicate()
#     print(output)

#     return output

def increase_memory():
    # file_increases = number_files(frame_folder)
    bashCommand = "ulimit -n 2048"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()
    print(output)

def decrease_memory():
    bashCommand = "ulimit -n 256"
    process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
    output, error = process.communicate()


    
if __name__ == "__main__":
    make_gif("/Users/ericevje/Documents/Processing/infinty_symbol")