# Hướng dẫn cài đặt Cassandra trên windows 10

Link tham khảo:

- https://phoenixnap.com/kb/install-cassandra-on-windows

- https://www.youtube.com/watch?v=hJxlkHafYsQ

## Step 1: Install Java 8 on Windows
1. Truy cập website chính thức của Oracle và tải xuống [Oracle JDK 8](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html) sau đó cài đặt.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/java-jdk-8-download-windows-x64-version.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/start-jdk-8-installation-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/java-8-windows-jdk-cassandra.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/java-jdk-8-successful-install-windows-cassandra.png)

## Step 2: Configure Environment Variables for Java 8
1. This PC > Properties.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/this-pc-properties-install-java-8-cassandra-windows.png)

2. Chọn Advanced system settings.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/advanced-system-settings-java-8-cassandra.png)

3. Click vào Environment Variables button.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/system-properties-enviormnet-variables-java-cassandra-windows.png)

4. Chọn New trong System Variable.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-new-system-variable-windows-java-cassandra.png)

5. Thêm vào JAVA_HOME. Chọn tới folder java sdk hiện tại.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/browse-for-java-8-folder-add-envirnment-variable.png)

6. Vào đến theo đường dẫn **This PC > Local Disk C: > Program Files > Java > jdk1.8.0_251**

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/new-enviornment-variable-added-java-8-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/java-home-variable-system-variable-added-windows.png)

## Step 2: Install and Configure Python 2.7 on Windows
1. Truy cập trang tải xuống [bản chính thức của Python](https://www.python.org/downloads/release/python-2718/) (chọn phiên bản Windows x64).

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/select-python-windows-x64-version-executable.png)

2. Tiến hành cài đặt theo các bước default cho đến khi kết thúc.

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/python-2.7-installation-windows-cassandra.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/select-python-installation-directory-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/select-python-installation-options-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/python-2.7-finish-installation-windows.png)

3. Cấu hình Python 2.7 trên Windows

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/this-pc-properties-install-java-8-cassandra-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/advanced-system-settings-java-8-cassandra.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/system-properties-enviormnet-variables-java-cassandra-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/edit-path-variable-python-2.7.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-new-python-2.7-variable-path-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-python-2.7-variable-path-enviornment.png)

## Step 3: Download and Set Up Apache Cassandra
1. Truy cập trang tải xuống [bản chính thức của Cassandra](https://cassandra.apache.org/download/)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/download-latest-cassandra-version-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/apache-download-mirror-link-windows.png)

2. Giải nén và coppy vào  **"C:\Cassandra\"**

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/content-of-untarred-cassandra-windows-folder.png)

3. Cấu hình Environment Variables cho Cassandra

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/this-pc-properties-install-java-8-cassandra-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/advanced-system-settings-java-8-cassandra.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/system-properties-enviormnet-variables-java-cassandra-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-new-system-variable-windows-java-cassandra.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/cassandra-add-enviornment-variable-windows.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/edit-path-variable-python-2.7.png)

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/add-cassandra-bin-folder-path-system-variable.png)

## Step 4: Thay đổi đường dẫn JAVA_HOME trong Cassandra

1. Tìm đến file **"C:\Cassandra\apache-cassandra-3.11.11\bin\cassandra.bat"** 

![](https://i.ibb.co/wJJ7jKc/111.png)

2. Thêm vào **"set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_301"

![](https://i.ibb.co/C54MmJ1/222.png)

3. Tìm đến file **"C:\Cassandra\apache-cassandra-3.11.11\bin\nodetool.bat"** 

![](https://i.ibb.co/CwwhLyb/333.png)

4. Thêm vào **"set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_301"**

![](https://i.ibb.co/272Rhf2/443.png)

5. Mở **Windows PowerShell** chạy lệnh "Set-ExecutionPolicy Unrestricted"

![](https://i.ibb.co/3WPPDr5/555.png)

6. Kiểm tra lại nếu hiển thị bên dưới là OK.

![](https://i.ibb.co/L614W9L/666.png)

7. Cài đặt **vcredist_x64**

Link download [vcredist_x64.exe](https://www.microsoft.com/en-us/download/confirmation.aspx?id=26999)

8. Mở file `C:\apache-cassandra-3.11.11\conf\cassandra-env.ps1`

Tìm đến comment line bên dưới:

`$env:JVM_OPTS = "$env:JVM_OPTS -Djava.library.path=""$env:CASSANDRA_HOME\lib\sigar-bin"""`

![](https://github.com/techbasevietnam/Shopping-research/blob/main/Resources/cassandra-env.PNG?raw=true)

## Step 5: Start Cassandra from Windows CMD

1. Mở CMD của windows chạy lệnh **cassandra**

2. Sau đó chạy lệnh **cqlsh** 

![](https://phoenixnap.com/kb/wp-content/uploads/2021/04/cqlsh-shell-cassandra-cmd-windows-access.png)

### Lỗi thường gặp
**..\jna-95947831\jna9155308117105926958.dll: Can't find dependent libraries**
- Download và cài đặt [Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package MFC Security Update](https://www.microsoft.com/en-us/download/details.aspx?id=26999)
- Sau khi cài đặt xong thử chạy lại cassandra. Follow [video hướng dẫn này](https://www.youtube.com/watch?v=hJxlkHafYsQ&t=598s) 