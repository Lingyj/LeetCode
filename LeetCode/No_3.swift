//
//  No_3.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/6.
//

import Foundation

class LongestSubstring {
    static func test() -> Void {
//        let str = "abcabcbb";
//        let str = "bbbbb";
        let str = "pwwkew";
//        let str = "";
        excuteAndPrint(str, excuteFunc: func1(_:))
    }
    
    static func excuteAndPrint(_ str : String, excuteFunc: (String) -> (String)) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(str);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }

    // 整体思路
    // 示例: pwwkew
    // 从0开始匹配最大字符串，如果遇到重复字符，则从重复字符开始重新匹配
    // 开始匹配 -> 匹配到pw -> 遇到第二个w -> 从第二个w开始重新匹配 -> 匹配到wke -> 遇到第三个w -> 无更大匹配
    // 字符串分割结果 pw|wke|w
    static func func1(_ str :String) -> String {
        // 字典，缓存最后一个字符的index
        var dict = [Character : Int]()
        // 字符串长度
        var length = 0;
        // 记录新字符串起始的偏移
        var offset = 0;
        // 最大字符串的未字符位置
        var end = 0;

        for (i, word) in str.enumerated() {
            let lastIndex = dict[word];
            
            if (lastIndex != nil) {
                if (i - lastIndex! > length) {
                    length = i - offset;
                    end = i;
                }
                offset = i;
            } else {
                if (i - offset > length) {
                    length = i - offset;
                    end = i;
                }
            }
            
            dict[word] = i;
        }

        // 截取子字符串 [swift字符串比oc难用很多:(]
        let endIndex = str.index(str.startIndex, offsetBy: end);
        let startIndex = str.index(endIndex, offsetBy: -length);
        let range = startIndex..<endIndex
        return str.substring(with: range);
    }
}
