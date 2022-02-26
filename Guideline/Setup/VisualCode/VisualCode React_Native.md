# Kiến thức về Cài đặt môi trường React Native

<u>*Kết quả đạt được:*</u>

- [ ] Cách cài đặt môi trường Node.js



## 1. Hướng dẫn cài đặt môi trường react-native trên hệ điều hành MAC OS

- **Bước 1**: Cài đặt Brew: Brew là trình quản lý các gói thứ viện, MACOS không tích hợp sẵn và bạn phải sử dụng terminal để cài đặt brew bằng cách chạy dòng lệnh sau.
  `{{/usr/bin/ruby -e "$(curl –fsSL https://raw.githubusercontent.com/ Homebrew/install/master/install)"}}`
- **Bước 2**: Cài đặt ![NodeJS](https://img.shields.io/badge/NodeJS-greenyellow?style=plastic&logo=Node.js):
  `brew install node`
- **Bước 3**: Cài đặt Watchman:
  `brew install watchman`
- **Bước 4**: Cài đặt react-native:
  `npm install -g react-native-cli`
- **Bước 5**: Cài đặt Xcode: truy cập App Store trên MACOS để cài đặt Xcode.
- **Bước 6** (option): Nếu bạn xây dựng ứng dụng android sử dụng hệ điều hành MACOS thì bạn cần cài đặt thêm các gói như JDK, Android Studio, Android SDK. (xem thêm phần cài đặt cho Windonws để hiểu rõ hơn.)

## 2. Cài một số plugin cần thiết

* Oh my Zsh: https://ohmyz.sh/
* Oh my Zsh Suggestion: https://github.com/zsh-users/zsh-autosuggestions
* More -plugin: https://www.youtube.com/watch?v=LEOqiyxx16c
* Cài plugin **.gitignore Generator**

## 3. Khởi tạo dự án đầu tiên

- **Bước 1**: Khởi tạo dự án: mở Terminal (cmd) sau đó gõ lệnh này vào (cd vào thư mục bạn muốn tạo dự án trước)
  `react-native init ProjectName`
- **Bước 2**: Truy cập vào dự án vừa tạo.
  `cd ProjectName`
- **Bước 3**: Chạy ứng dụng trên hệ điều hành:
  IOS: `react-native run-ios`
  Android: `react-native run-android`

## 4. Các thành phần cơ bản của dự án

Cấu trúc thư mục mà bạn nhìn thấy có thể sẽ như dưới đây (tùy version react-native hiện tại của bạn). Hình dưới đây không bao gồm một vài file bị ẩn thuộc cấu hình của react-native
[![img](https://github.com/huongnguyenvan/react-native/raw/master/images/first-project.jpg)](https://github.com/huongnguyenvan/react-native/blob/master/images/first-project.jpg)

- **Thư mục Android**: chứa toàn bộ source build ứng dụng Android. Chúng ta có thể mở thư mục Android bằng Android studio và chạy ứng dụng thay vì sử dụng dòng lệnh `react-native run-android` nhưng có thể ứng dụng sẽ không build mã javascript được và sẽ xuất hiện màn hình trắng trên điện thoại android.
- **Thư mục IOS**: chứa toàn bộ source build ứng dụng IOS. Chúng ta có thể mở file ProjectName.xcodeproj bằng Xcode để run ứng dụng IOS thay vì sử dụng dòng lệnh `react-native run-ios`. Lần đầu có thể chạy hơi lâu nhưng những lần tiếp theo sẽ nhanh hơn việc build bằng dòng lệnh.
- **Thư mục node_modules**: chứa toàn bộ các package (thư viện) cần để chạy một ứng dụng react-native.
- **File package.js**: file quản lý các package nodejs đi kèm với dự án. Nếu bạn tải các dự án demo về cần dử dụng dòng lệnh `npm install` để tải toàn bộ thư viện yêu cầu của dự án về.
- **File package-lock.js** file được general sau khi chạy cài đặt `npm install`
- **File index.js**: file đầu tiên được binding khi chạy ứng dụng. File này sẽ đăng ký một component, component này sẽ được load lên đầu tiên khi chạy, mặc định ứng dụng sẽ đăng ký component trong App.js
- **File app.json**: file config **tên ứng dụng** và **tên hiển thị**.
- **File App.js** là một component mặc định có sử dụng một số Component khác như Text, View...

## 6. Component trong React-Native

* **Component** là một thành phần cơ bản trong ứng dụng **React-native**. 
* Mọi **View, Screen** đều được kế thừa từ lớp **Component** này.

### 6.1. Vòng đời của component

[![img](https://github.com/huongnguyenvan/react-native/raw/master/images/life-circle.png)](https://github.com/huongnguyenvan/react-native/blob/master/images/life-circle.png)
*(Nguồn:: internet)*

**Các hàm được gọi trong vòng đời của Component**

- **constructor(props)** - Hàm khởi tạo component. Trong hàm này chúng ta thường dùng để khởi tạo state, binding các hàm con của component.
  Lưu ý: Không được thay đổi state bằng phương thức `this.setState()` trong hàm này.

- **componentWillMount()** - Hàm này sẽ bị loại bỏ ở phiên bản mới.

- **render()** - Đây là hàm bắt buộc có trong component. Sau khi khởi tạo hàm này được gọi để trả về các thành phần hiển thị lên màn hình.
  Hàm này sẽ được tự động gọi lại khi state hoặc props của nó thay đổi. Chỉ những component có sử dụng state hoặc props thì mới được gọi lại để render lại.

  **Lưu ý:**

  - Trong hàm này cũng không được sử dụng phương thức `this.setState()`
  - Trong hàm này không nên chạy xử lý dữ liệu nhiều để không bị lag khi render (nên xử lý dữ liệu trong componentDidMount hoặc constructor).

- **componentDidMount()** - Hàm này sẽ được gọi ngay sau khi hàm **render()** lần đầu tiên được gọi. Thông thường trong hàm này ta có thể lấy dữ liệu từ server hoặc client để render dữ liệu ra. Khi chạy đến đây thì các phần từ đã được sinh ra rồi, ta có thể tương tác với các thành phần UI.

- **componentWillReceiveProps(nextProps)** - Hàm này được gọi khi props của component được khởi tạo thay đổi.

- **shouldComponentUpdate(nextProps, nextState)** - Hàm này được gọi trước render() khi cập nhật dữ liệu. Hàm này trả về giá trị true hoặc false. Nếu false thì không gọi lại hàm render mặc định nó trả về true.

- **componentWillUpdate(nextProps, nextState)** - Hàm này được gọi ngay sau khi hàm shouldComponentUpdate() trả về true. Trong hàm này cũng không được set lại state.

- **componentDidUpdate(prevProps, prevState)** - Hàm này được gọi ngay sau hàm render() từ lần thứ 2 trở đi.

- **componentWillUnmount()** - Hàm này được gọi khi component này bị loại bỏ. Chúng ta nên thực hiện các thao tác dọn dẹp, hủy timer hoặc các tiến trình đang xử lý.
