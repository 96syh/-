from PIL import Image
import os

# 指定包含PNG图片的目录
directory = '/path/to/your/png/images'

# 遍历目录下的所有文件
for filename in os.listdir(directory):
    if filename.endswith(".png"):
        # 构造完整的文件路径
        filepath = os.path.join(directory, filename)
        # 打开图片文件
        img = Image.open(filepath)
        # 定义新的文件名，将扩展名改为.jpg
        new_filename = os.path.splitext(filename)[0] + '.jpg'
        # 以JPG格式保存图片
        img.convert('RGB').save(os.path.join(directory, new_filename))
        # 如果需要，可以选择删除原始的PNG文件
        # os.remove(filepath)

# 表示转换完成
print("所有PNG图片已转换为JPG格式。")
