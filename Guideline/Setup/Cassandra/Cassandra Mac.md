# Hướng dẫn cài đặt Cassandra

Link issue tham khảo: https://stackoverflow.com/questions/65502985/issue-starting-cassandra-a-fatal-error-has-been-detected-by-the-java-runtime-en

Link cho windows: https://phoenixnap.com/kb/install-cassandra-on-windows

## Kiểm tra java home

```java
/usr/libexec/java_home -V
```

## Hướng dẫn edit file để cassandra hoạt động

* Cài đặt Cassandra: brew install --cask adoptopenjdk/openjdk/adoptopenjdk8
* Kiểm tra java version: java --version
* Thêm file này vào bash.sh:  export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_275
* Tìm file "/usr/local/Cellar/cassandra/3.11.10/share/cassandra/cassandra.in.sh"
* Sửa version Java hiện tại lại thành cái version mình đang sài.

## Lệnh sử dụng Cassandra

* Start: brew services start cassandra
* Stop: brew services stop cassandra
* Kiểm tra: cqlsh

## Các lệnh hỗ trợ

* brew cask upgrade
* brew install --cask adoptopenjdk8
