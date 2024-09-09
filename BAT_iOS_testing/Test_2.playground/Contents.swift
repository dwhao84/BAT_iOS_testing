import UIKit

// 定義得獎的資料結構
struct Prize {
    let name: String
    let count: Int
    let probability: Double
}

// 定義獎品和其對應的機率
let prizes = [
    Prize(name: "1獎", count: 1, probability: 0.001),
    Prize(name: "2獎", count: 1, probability: 0.023),
    Prize(name: "3獎", count: 2, probability: 0.13),
    Prize(name: "4獎", count: 5, probability: 0.18),
    Prize(name: "5獎", count: 11, probability: 0.25)
]

// 抽獎函數，直接返回結果列表
func drawPrizes(prizes: [Prize]) -> [String] {
    var results: [String] = []
    
    for prize in prizes {
        // 對每個獎品根據數量進行抽取，直到數量達標
        for _ in 0..<prize.count {
            results.append(prize.name)
        }
    }
    
    // 隨機打亂結果列表
    return results.shuffled()
}

// 抽獎結果
let drawResults = drawPrizes(prizes: prizes)

// 輸出抽獎結果
for (index, result) in drawResults.enumerated() {
    print("第 \(index + 1) 次抽獎結果：\(result)")
}
