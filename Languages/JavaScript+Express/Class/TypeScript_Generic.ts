interface Behavior {
    fly(): void;
}

class Cat implements Behavior {
    fly() {
        console.log("Can't be fly");
    }
}

class BlackCat {
    delegate: Behavior;
    fly() {
        this.delegate.fly()
    }
}

class Box<T> {
    contents: T;
    // static defaultValue: T; // Lưu ý không sử dụng generic cho static
    constructor(contents: T) {
        this.contents = contents;
    }

    log() {
        console.log(this.contents);
    }
}

function GenericMain(): number {
    const sample = new Box<string>("hello world");
    sample.log();
    
    const cat: Behavior = new Cat();
    cat.fly();
    
    // Use delegate
    const blackCat = new BlackCat();
    blackCat.delegate = cat
    blackCat.fly();

    return 1;
}

GenericMain();