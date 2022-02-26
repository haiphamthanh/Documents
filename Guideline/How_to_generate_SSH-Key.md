Hướng dẫn cài đặt

```bash
# 1. Generate SSH key
$ ssh-keygen -t ed25519 -C "<email>"

# 2. Check created SSH key
$ ls C:/Users/ASUS/.ssh

# 3 To copy value of public key
  	# Solution 1: Use bash to copy value of public key
  	$ $ clip < ~/.ssh/id_ed25519.pub
  
 		# Solution 2: Open folder and Open xxx.pub
    $ alias open="explorer.exe"
    $ open "C:\\Users\\ASUS\\.ssh\\"
 
 # 4. Paste to Github SSH setting
		# (File ~/.ssh/id_ed25519.pub) or (/c/Users/ASUS/.ssh/id_ed25519)
	
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
```

Hướng dẫn sử dụng git

```bash
# Clone source by ssh link url
$ git clone git@ssh....

# Fetch branch from origin
$ git fetch origin <branch name>

# Check all local branchs
$ git branch -v

# Check all remotes in use
$ git remote -v
```



Hướng dẫn cài đặt intelliJ

* Cài đặt format
* Cài đặt fix lỗi font

Hướng dẫn cài đặt các plugin trong visual code

* Cài đặt các plugin cần thiết



Liệt kê một số link cần thiết cho việc lập trình

* Link hướng dẫn chung
  * Springboot:
  * JS(Node):

* Link IF tổng:
  * Springboot: 
* Link IF riêng từng module (Sample):
  * Springboot:
  * JS(Node):
* Link Github
  * Springboot:
  * JS(Node):
* Link spec confirmation:
* Link checklist
  * Springboot:
  * JS(Node):
* Link sample pull request
  * Springboot:
  * JS(Node):