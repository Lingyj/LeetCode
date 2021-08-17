//
//  No_5.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/17.
//

import Foundation

// TODO: 看下swift range用法
class LongestPalindromicSubstring {
    static func test() -> Void {
//        let string = "babad";
        let string = getRandomStringWithLength(length: 40, letter: getRandomLetter2);
        print(string);
        excuteAndPrint(string: string, excuteFunc: func1(string:));
    }
    
    static func excuteAndPrint(string : String, excuteFunc: (String) -> (String)) {
        let date : NSDate = NSDate();
        let rs = excuteFunc(string);
        let duration = NSDate().timeIntervalSince(date as Date) * 1000;
        let durationStr = String(format: "%.3f", duration);
        print("result:\(rs), duration:\(durationStr)");
    }
    
    static func func1(string : String) -> String {
        let letters = Array(string).map(String.init);
        
        var start = 0;
        var maxLength = 0;
        
        for i in 0..<letters.count {
            let range1 = getMaxRange(letters: letters, left: i, right: i);
            let range2 = getMaxRange(letters: letters, left: i, right: i+1);
            let range = (range1.1 > range2.1) ? range1 : range2;
            if (range.1 > maxLength) {
                start = range.0;
                maxLength = range.1;
            }
        }
        
        let subLetter = letters[start..<start+maxLength];
        return subLetter.joined();
    }
    
    // 从中心(最小回文)开始，向两边扩散
    static func getMaxRange(letters: [String], left: Int, right: Int) -> (Int, Int) {
        var start = left;
        var end = right;
        
        while (start >= 0 && end < letters.count && letters[start] == letters[end]) {
            start-=1;
            end+=1;
        }
        
        return (start + 1, end - start - 1);
    }
}
