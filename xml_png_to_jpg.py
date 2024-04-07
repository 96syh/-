import os
from xml.etree import ElementTree as ET

# 指定包含XML文件的目录
directory = 'D:/vscode-language/creat_python/yolo3-pytorch-master/VOCdevkit/VOC2007/Annotations'

# 遍历目录下的所有文件
for filename in os.listdir(directory):
    if filename.endswith(".xml"):
        # 构造完整的文件路径
        filepath = os.path.join(directory, filename)

        # 解析XML文件
        tree = ET.parse(filepath)
        root = tree.getroot()

        # 查找所有的<filename>标签
        for filename_tag in root.iter('filename'):
            # 如果文本以.png结尾，则替换为.jpg
            if filename_tag.text.endswith(".png"):
                filename_tag.text = filename_tag.text.replace('.png', '.jpg')

        # 保存修改后的XML文件
        tree.write(filepath)

# 表示处理完成
print("所有指定的XML文件中的.png已替换为.jpg。")
