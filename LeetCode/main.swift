//
//  main.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/6.
//

import Foundation

print("Hello, World!")

// 截取子字符串
var str = "hello, world!  telephone =12345"
let startIndex = str.startIndex
let endIndex = str.index(str.endIndex, offsetBy: -5)
let range = startIndex..<endIndex  // 注意 这里不能包含endIndex  不然会报错 Cannot convert value of type 'ClosedRange<String.Index>'  to expected argument type 'Range<String.Index>'
let subStr = str.substring(with: range)
print(subStr)


TwoNum.test();
AddTwoNumbers.test();
LongestSubstring.test();
MidianOfTwoSortedArrays.test();
LongestPalindromicSubstring.test();
