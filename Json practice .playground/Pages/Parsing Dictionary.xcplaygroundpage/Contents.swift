import UIKit

// PARSING DICTIONARY

// convert json into data

let json = """
{
 "results": [
   {
     "firstName": "John",
     "lastName": "Appleseed"
   },
  {
    "firstName": "Alex",
    "lastName": "Paul"
  }
 ]
}
""".data(using: .utf8)!

//MARK:- CREATE MODEL

// Codable : Decode and Encode
// Decode: converts json data
// Encode: coverts to json data (post)

struct ResultsWrapper: Decodable {
    let results : [Contact]
}

struct Contact: Decodable {
    let firstName: String
    let lastName: String
}

//MARK:- DECODE

do {
    let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
    let contacts = dictionary.results // array of contacts
    dump(contacts)
} catch {
    print("decoding error: \(error)")
}

/*
 2 elements
  ▿ __lldb_expr_1.Contact
    - firstName: "John"
    - lastName: "Appleseed"
  ▿ __lldb_expr_1.Contact
    - firstName: "Alex"
    - lastName: "Paul"
 */
