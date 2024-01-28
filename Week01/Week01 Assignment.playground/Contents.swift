import Foundation

let sonnet : String =
"""
Shall I compare thee to a summer ’s day?
Thou art more lovely and more temperate:
Rough winds do shake the darling buds of May,
And summer ’s lease hath all too short a date;
Sometime too hot the eye of heaven shines,
And often is his gold complexion dimm'd;
And every fair from fair sometime declines,
By chance or nature ’s changing course untrimm'd;
But thy eternal summer shall not fade,
Nor lose possession of that fair thou ow’st;
Nor shall death brag thou wander’st in his shade,
When in eternal lines to time thou grow’st:
So long as men can breathe or eyes can see,
So long lives this, and this gives life to thee .
"""

let words : [String : Array<String>] = ["shall": ["🤔","😕","🧐","😑","😶","😒","🤨","😞","🤷‍♂️"], "i":["🙋‍♂️", "🙋‍♀️", "👤"], "thee":["🙋‍♂️", "🙋‍♀️", "👤"],"thou":["🙋‍♂️", "🙋‍♀️", "👤"], "summer":["☀️","🌴","🍦","🏖️","🍹"], "art":["🎨","🖼️","🎭"], "winds":["💨","🌬️","🍃","🌪️","🌀","🌬️","🌫️"], "buds":["🌸","🌷","🌹","🌼","🌻", "🌺"], "date":["📅","🕰️","📆","⏳","🗓️"]]

func conversion(_ sonnet : String, _ words : [String : [String]]) -> String {
    var lines : [String] = sonnet.components(separatedBy: "\n")
    var word = [[String]]()
    for i in lines {
        word.append(i.components(separatedBy: " "))
    }
    
    for x in 0..<word.count {
        for i in 0..<word[x].count {
            if words.keys.contains(word[x][i].lowercased()) {
                var emojiNum = words[word[x][i].lowercased()]?.count ?? 0
                var emoji = words[word[x][i].lowercased()]?[Int.random(in: 0..<emojiNum)]
                word[x][i] = emoji ?? word[x][i]
            }
        }
        
        lines[x] = word[x].joined(separator: " ")
    }
    
    var wholeText = lines.joined(separator: "\n")
    
    return wholeText
}

func frame(_ frameCount : Int) -> String {
    var frameLine : String = ""
    
    for i in 0...(frameCount - 1) {
        frameLine += "❤️"
    }
    return frameLine
}

print(frame(21))
print(conversion(sonnet, words))
print(frame(21))
