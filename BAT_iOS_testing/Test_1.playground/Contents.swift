import UIKit

/*
 數列求和
 要求： 編寫一個函數，計算以下數列的和：1+2-3+4-5+6+...±N
 N 為正整數，將在面試現場提供。
 程式運行時間不得超過 2 秒，且不會造成系統當機。
 */

func calculateTheSum(upTo N: Int) -> Int {
    var sum = 0
    
    for i in 1...N {
        if i % 2 == 0 {
            sum += i  // 偶數直接加
        } else {
            sum -= i  // 基數相減
        }
    }
    
    return sum
}

// 測試函數
let result = calculateTheSum(upTo: 1000)
print("數列的和為：\(result)")
