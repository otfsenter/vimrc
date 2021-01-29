from PIL import ImageGrab
import os

os_name = os.name
if os_name == 'nt':
    image_root = r'D:\images'
else:
    image_root = '~/images'


def write_iamge_to_local(image_path):
    if image_path:
        im = ImageGrab.grabclipboard()
        im.save(image_path, 'PNG')
    else:
        pass


def get_today():
    from datetime import datetime
    today = datetime.now()
    today_str = str(today).split(' ')[0]
    return today_str


def make_today_dir(date_today):
    today_dir = os.path.join(image_root, date_today)
    if not os.path.exists(today_dir):
        os.mkdir(today_dir)

    return today_dir


def list_today_dir(dir_today):
    name_list = []
    for dirpath, dirnames, filenames in os.walk(dir_today):
        for filename in filenames:
            name = str(filename).split('.')[0]
            name_list.append(name)

    return name_list


def get_max_image_int(image_name_list):
    image_int_list = [int(i) for i in image_name_list]

    if image_int_list:
        return max(image_int_list)
    else:
        return 0


def run():
    # 创建一个今天的文件夹
    date_today = get_today()
    dir_today = make_today_dir(date_today)

    #
    image_name_list = list_today_dir(dir_today)
    max_image_int = get_max_image_int(image_name_list)
    new_image_name = str(max_image_int + 1) + '.png'
    new_image_path = os.path.join(dir_today, new_image_name)

    write_iamge_to_local(new_image_path)

    new_image_path = str(new_image_path).replace('\\', '\\\\')

    sphinx_image = '.. image:: ' + new_image_path

    # .. image:: ./images/1.png
    return sphinx_image


global_a = run()
print(global_a)
