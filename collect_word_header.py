import os
from docx import Document


def change_header_in_word_files(folder_path):
    # 获取文件夹中所有的word文件
    word_files = [f for f in os.listdir(folder_path) if f.endswith('.docx')]

    for file_name in word_files:
        file_path = os.path.join(folder_path, file_name)
        doc = Document(file_path)

        # 遍历文档中的段落
        for section in doc.sections:
            header = section.header
            for paragraph in header.paragraphs:
                # 检查段落中是否包含指定关键字
                if '授课班级：' in paragraph.text:
                    # 如果找到关键字，则替换后续内容
                    index = paragraph.text.index('授课班级：') + len('授课班级：')
                    paragraph.text = paragraph.text[:index] + '123456'

        # 保存修改后的文档
        doc.save(file_path)


# 调用函数并传入文件夹路径
change_header_in_word_files('D:/05_download')
