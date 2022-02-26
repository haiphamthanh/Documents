# Tìm hiểu các syntax java căn bản

1. Kiểu Java optional

   ```java
   // Khai báo
   Optional<String> empty = Optional.empty();
   Optional<String> sampleValue = Optional.of("sampleValue");
   Optional<String> sample1 = Optional.of(null); // nếu giá trị trong of bằng null sẽ bị lỗi
   
   // T get(): Nếu như có giá trị trong Optional này, nó sẽ trả về giá trị đó, ngược lại sẽ ném ra NoSuchElementException nếu như đối tượng rỗng.
   sampleValue.get() // Trả về sampleValue
   empty.get() // Exception in... java.util.NoSuchElementException: No value present
   
   // Kiểm tra
   
   // Force thành requỉe
   ```

2. Kiểu mảng trong Java

```
UserActionHistory userActionHistory = userResources
  .user()
  .userActionHistory()
  .orElse(
  UserActionHistory
  .generate(
    userResources.orderHistoryResponseFuture().get(),
    userResources.viewHistoryResponseFuture().get(),
    userResources.optionalModuleParameter(),
    timeProxy)
  .orElse(new UserActionHistory(List.of()))
)
```

3. Phương thức map
4. Phương thức flatmap
5. Stream là gì? Cách thức Stream
6. Cách dùng Comparator (Phương thức so sánh và sắp xếp)
7. Một số lưu ý:
   * Sử dụng orElse và orElseGet

// Optional
itemType = Optional.of(history.itemType)
emptyValue = Optional.empty()

// Map
// Flatmap
// Get optional
// Stream value  (Hình như là chỉ sử dụng cho list)
// Stream và sắp xếp mảng thro điểm lớn nhất
// Stream theo đối tượng con và so sánh với thuộc tính trong đối tượng con đó
Comparator.comparingDouble(<Class>:score)