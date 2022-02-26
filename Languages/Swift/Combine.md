# **Combine**

## Tổng quan





### Các thành phần của combine.

- Nếu ae đã từng làm việc với Rxswift hay reactive swift thì việc tìm hiểu combine sẽ không khó. Cơ bản thì combine hiện tại kiểu như bản rút gọn của 2 ông anh kìa nhé. 

  + Publisher : thanh niên này sẽ bắn ra 1 tín hiệu hay các gì đó.

  + Subscriber: thanh niên này sẽ nhận tín hiệu từ ông bên trên.

  + Thanh niên publisher trước khi bắn tín hiệu thì xử lí gì abc gì đó thì gọi là **operation**.

    

##  Các ví dụ về combine.

- Ví dụ 1: 

```swift
func examble1() {

        let just = Just("Hello world")
        let subscriber = just.sink(receiveCompletion: {
                print("Received completion", $0)
            }, receiveValue: {
                print("Received value", $0)
            })

        subscriber.cancel()
   }
```

ví dụ đơn giản về combine với Just.  Mình tạo ra 1 publisher (Just) và thực hiện sink kiểu bắn ra thằng này. 

receiveValue tức là nhận chuỗi này. 

receiveCompletion chỉ ra trạng thái cuối của thằng này. 

sài xong nhớ cancel nha mấy ae.

Kêt quả in ra: 

**Received value Hello world**

**Received completion finished**

- Ví dụ 2

```swift
func examble2() {
        let publisher = (1...10).publisher

        let subscriber = Subscribers.Sink<Int, Never>(receiveCompletion: { completion in
          print(completion)
        }) { value in
          print(value)
        }

        publisher.subscribe(subscriber)
  			subscriber.cancel()
    }
```

Mình khởi tạo 1 pushlisher theo 1 kiểu khác và nó gồm 1 mảng từ 1 đến 10.

Mình tạo tiếp 1 subscriber đăng kí thằng trên.

Kêt quả in ra: 

**12345678910 finish**.

Cũng đơn giản phải ko ae. 

- Ví dụ 3

  ```
  func examble2() {
          let publisher = (1...10).publisher
  
          let subscriber = Subscribers.Sink<Int, Never>(receiveCompletion: { completion in
            print(completion)
          }) { value in
            print(value)
          }
  
          publisher
          .map { $0 * 2 }
          .filter { $0 > 5 }
          .subscribe(subscriber)
          
          subscriber.cancel()
      }
  ```



Cái này đơn giản là trước khi thằng publisher bắn đi thì thực hiện các phép toán đơn giản thôi.

Kết quả in ra: 

6 8 10 12 14 16 18 20 finished






​	