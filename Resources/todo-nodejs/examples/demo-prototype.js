function Persion (name, password) {
    this.name = name
    this.password = password
  }
  
  Persion.prototype.getName = function() {
    return this.name
  }
  
  Persion.prototype.getPassword = function() {
    return this.password
  }
  
  Persion.prototype.getLevel = function() {
    return this.level
  }
  
  Persion.prototype.level = "admin"
  
  function User(name) {
    this.name = name
  }
  User.prototype = new Persion()
  
  const persion = new Persion("ti", "12233")
  const user = new User("nam", "46474")
  
  console.log(user.getName())