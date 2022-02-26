# Kiến thức về các biến môi trường (Environment Variables)

**Mục đích.** Bản thân hệ điều hành cũng như một chương trình phần mềm vậy, Các phần mềm đang chạy trên hệ điều hành cũng giống như những chức năng **"function"**. Ta hình dung, khi mỗi **"function"** chạy đều cần các đầu vào được gọi là **Input**. Do đó, các biến môi trường được hình thành cũng giống như vậy. Chia làm 2 loại, biến tạm + biến vĩnh viễn.

**Cách khởi tạo.** mỗi hệ điều hành sẽ có một nơi lưu trữ biến môi trường ở các nơi khác nhau (hình bên dưới). Syntax để khởi tạo cũng giống như ta lập trình bình thường. 

* Ví dụ: khi ta muốn tạo một biến ta sẽ sử dụng cú pháp: `export PATH=~/Desktop`. Trong đó, **PATH** là tên biến và **~/Desktop** là giá trị. 

**Nhận xét.** Các bạn thường thấy các giá trị trong biến môi trường thông thường là các đường dẫn đúng không? 

* Vì mỗi khi chương trình khởi chạy, các giá trị **Input** của chương trình đó chỉ đơn giản là các chương trình hỗ trợ và ta cần chỉ ra các đường dẫn này nằm ở đâu. 
* Thông thường, các chương trình sẽ sử dụng các tên biến của **HỆ THỐNG**. Đây là các tên thường được dùng ví dụ: JAVA_HOME, PATH... để tìm kiếm chương trình hỗ trợ. 
* Do đó, với một số chương trình đặc biệt cần phải có sự hỗ trợ đặc biệt từ các phần mềm với các version khác nhau (ví dụ như jdk11, jdk16...) thì ta cần phải cài đặt sự hỗ trợ đó. Sau khi cài đặt xong, ta còn phải thêm đường dẫn gói package mới cài xong đó vào biến môi trường để phần mêm đang chạy có thể dựa vào đó mới tìm được phần mềm hỗ trợ cho mình.

# Setting up Environment Variables in Mac OS

As I am getting used to MAC OS instead of Windows, I felt the need to make myself fully understood how to manage environment variables in MAC.

## 1. Check the current environment variable settings.

you can list up by command “printenv” in the console.

![image-20210807221843230](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807221843230.png)

if you want to check a specific environment variable, you can do check it with command “echo $variable_name”

![image-20210807221927818](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807221927818.png)

PATH variable setting

## 2. Set an Environment Variable — temporary or permanent

you can set an environment variable for the temporary or permanent use. It depends on the case, if you need a variable for just one time, you can set it up using terminal. Otherwise, you can have it permanently in Bash Shell Startup Script with “Export” command.

**1) Temporary Setting**

![image-20210807222021532](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222021532.png)

Set a temporary environment variable using export command

And then close the terminal and open another one to check out if the set variable has disappeared or not.

![image-20210807222100318](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222100318.png)

Temporary Variable is gone now.

**2) Permanent Setting**

For permanent setting, you need to understand where to put the “export” script. Where here means Bash Shell Startup Script like **/etc/profile, ~/.bash_profile, ~/.bashrc**.

For system-wide operations, it should be in **/etc/profile**,

For user based operations, it should be in **~/.bash_profile**,

For non-login interactive shells, it should be in **~/.bashrc**.

(For better understanding, you better check out this: [Unix Introduction — Shell](https://medium.com/@youngstone89/unix-introduction-shell-980212852897))

But the convention above doesn’t exactly apply to MAC OS. In Unix/Linux for the interactive login shells, ./bash_profile opens only at the first time in logging in and /.bashrc gets loaded thereafter. But MAC OS only loads ./bash_profile even after the first terminal.

For experiment, I am going to add a test directory to the PATH environment variable. Using “export” command, the PATH variable is going to hold the newly added directory.

![image-20210807222130987](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222130987.png)

Editing **.bash_profile** file with nano editor.

![image-20210807222157118](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222157118.png)

![image-20210807222211533](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222211533.png)

Once refresh environment variable with “source” command, the current shell can locate the new directory for executable binary files.

![image-20210807222240384](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222240384.png)

![image-20210807222303257](/Users/haikaito/Library/Application Support/typora-user-images/image-20210807222303257.png)

After removing export line in **.bash_profile**, then source it, and reopen the terminal.

In the end, I have successfully practiced permanent setting. This is going to be useful for any development environment setting hereafter.

Thanks!

## Tham khảo

1. https://youngstone89.medium.com/setting-up-environment-variables-in-mac-os-28e5941c771c
