import UIKit

class Post {
    var author: String
    var content: String
    var likes: Int

    init(author: String, content: String, likes: Int) {
        self.author = author
        self.content = content
        self.likes = likes
    }

    func display() {
        print("\(author)'s \(content) has \(likes) likes")
    }
}

let first_post = Post(author: "Jk Rowlings", content: "Harry Potter-Half Blood", likes: 10000000)
let second_post = Post(author: "George Orwell", content: "1987", likes: 20000000)

first_post.display()
second_post.display()
