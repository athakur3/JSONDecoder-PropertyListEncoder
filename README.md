# JSONDecoder-PropertyListEncoder

---
 Creating Codable Model (eg.)
---

```
struct Person: Codable {
    var name: String
    var age: Int
    var work_Location: String
}
```

--- 
Reading from a json file
---

-
Get File
-

```
guard let file = Bundle.main.path(forResource: "Data", ofType: "json") else {return}
```

-
Read data and decode json data to model type. Then encode to data using PlistEncoder and save to user defaults
-

```
do {
    // Read json data from file
    let data = try Data(contentsOf: URL(fileURLWithPath:  file), options: .mappedIfSafe)
 
    // Decode the json data into person (our model)
    let person = try JSONDecoder().decode(Person.self, from: data)
 
    print(person) // Person(name: "Jacob", age: 25, work_Location: "California")
 
    let encodedData = try PropertyListEncoder().encode(person) // Encode data using property list encodeer
 
    UserDefaults.standard.setValue(encodedData, forKey: "personData")// save data to user defaults
 
} catch let error {
    print(error)
}
```

--
Fetching Codable model back from user default
---

```
do {
    let person = try PropertyListDecoder().decode(Person.self, from: UserDefaults.standard.data(forKey: "personData")!)
    print("Encoded person ", person) // Encoded person  Person(name: "Jacob", age: 25, work_Location: "California")
} catch let error {
    print(error)
}
```
