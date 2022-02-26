// Sử dụng phương thức getter và setter
class Thing {
    _size = 0;
    
    get size(): number {
        return this._size;
    }
    set(value: string | number | boolean) { // Cách set một dữ liệu với các kiểu dữ liệu khác nhau
        let num = Number(value)
        // Kiểm tra nếu là NaN thì set giá trị là 0
        if (!Number.isFinite(num)) {
            this._size = 0
            return;
        }

        this._size = num;
    }
}

// Cách define một Dictionary class
class DictClass {
    [s: string]: boolean | ((s: string) => boolean);

    check(s: string) {
        return this[s] as boolean
    }
}

// Cách sử dụng interface
interface Pingable {
    ping(): void;
}

interface Checkable {
    check(name: string): boolean;
}

interface A {
    x: number; // Require value
    y?: number; // Optional value
}

class Abstract implements Pingable, Checkable, A {
    x = 10;

    ping(): void {
        console.log("Ping!");
    }

    check(name: string): boolean {
        return name.toLowerCase() === "ok";
    }

    desc(): string {
        return "This is Abstract log"
    }
}

class Sonar extends Abstract {
    // Không thể Override một hàm có tên giống với base class nhưng khác input: ping(name: string) do name là require
    // Nhưng có thể sử dụng input là một optional như: ping(name?: string)
    ping(api?: string, host?: string) {
        if (api === undefined || host === undefined) {
            return super.ping();
        }

        console.log(`Sonar ping ${host}${api} `);
    }

    desc(): string {
        return "This is Sonar log";
    }
}

function inherritMain(): number {
    const thing = new Thing();
    thing.set(false);
    console.log(thing.size);

    const dictClass = new DictClass();
    dictClass["key"] = true;
    console.log(dictClass.check("key"));

    const sonar = new Sonar();
    sonar.ping();
    sonar.ping("/v1/userInfor", "http://sampleAPI");
    console.log(sonar.check("ok"));

    let abstractValue: Abstract = new Sonar();
    console.log(abstractValue.desc());
    
    return 1;
}

inherritMain();