import subprocess

def install_package(package_name, python_exec_path):
    """安装指定的Python包到特定的Python解释器环境。

    参数:
        package_name (str): 要安装的包的名称。
        python_exec_path (str): 要使用的Python解释器的完整路径。
    """
    # 确保路径的字符串格式正确
    python_exec_path = python_exec_path.strip('"')
    # 构造pip安装命令
    command = [python_exec_path, "-m", "pip", "install", package_name]
    try:
        # 调用命令安装包
        subprocess.check_call(command)
        print(f"'{package_name}' package installed successfully using '{python_exec_path}'.")
    except subprocess.CalledProcessError as e:
        print(f"Failed to install '{package_name}' package using '{python_exec_path}'. Error: {e}")
    except FileNotFoundError as e:
        print(f"Python interpreter not found at '{python_exec_path}'. Error: {e}")
# 用户输入
if __name__ == "__main__":
    python_exec_path = input("Enter the path to the Python interpreter (include python.exe): ").strip()
    package_name = input("Enter the name of the package to install: ").strip()
    install_package(package_name, python_exec_path)
