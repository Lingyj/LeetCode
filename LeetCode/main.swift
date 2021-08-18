//
//  main.swift
//  LeetCode
//
//  Created by 凌永剑 on 2021/8/6.
//

import Foundation

print("Hello, World!")

//MARK: - Test
// 截取子字符串
var str = "hello, world!  telephone =12345"
let startIndex = str.startIndex
let endIndex = str.index(str.endIndex, offsetBy: -5)
let range = startIndex..<endIndex  // 注意 这里不能包含endIndex  不然会报错 Cannot convert value of type 'ClosedRange<String.Index>'  to expected argument type 'Range<String.Index>'
let subStr = str.substring(with: range)
print(subStr)

// 对象指针
var x: Int = 20
var xPointer: UnsafeMutablePointer<Int> = .init(&x)

print("x address:", UnsafeRawPointer(&x));
print("x value:", x);
print("pointer address:", UnsafeRawPointer(&xPointer));
print("pointer reference:", xPointer);
print("pointer reference value:", xPointer.pointee);


xPointer.pointee = 420;
print("x value:", x);
print("pointer reference value:", xPointer.pointee);

x = 69;
print("x value:", x);
print("pointer reference value:", xPointer.pointee);

var date : NSDate = NSDate();

var array : [Int] = [];
print(UnsafeMutablePointer.init(&array))
print(UnsafeMutablePointer.init(&array))
print(array.capacity)
array.append(1);
print(UnsafeMutablePointer.init(&array))
print(array.capacity)
array.append(1);
print(UnsafeMutablePointer.init(&array))
print(array.capacity)
print(array.capacity)
array.append(contentsOf: [1, 1, 1]);
print(UnsafeMutablePointer.init(&array))
print(array.capacity)
array.append(contentsOf: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
print(UnsafeMutablePointer.init(&array))
print(array.capacity)

var duration = NSDate().timeIntervalSince(date as Date) * 1000;
print("duration:\(duration)")

date = NSDate();
var array2 : [Int] = Array.init();
array2.reserveCapacity(10)
print(UnsafeMutablePointer.init(&array2))
print(UnsafeMutablePointer.init(&array2))
print(array2.capacity)
array2.append(1);
print(UnsafeMutablePointer.init(&array2))
print(array2.capacity)
array2.append(1);
print(UnsafeMutablePointer.init(&array2))
print(array2.capacity)
print(array2.capacity)
array2.append(contentsOf: [1, 1, 1]);
print(UnsafeMutablePointer.init(&array2))
print(array2.capacity)
array2.append(contentsOf: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
print(UnsafeMutablePointer.init(&array2))
print(array2.capacity)

duration = NSDate().timeIntervalSince(date as Date) * 1000;
print("duration:\(duration)")


var i = 1;
var i2 = 1;
var i3 = i2;
i3 = 2;
var j : Int = Int.init(exactly: 1) ?? 0;
var k : Int = Int.init(exactly: 1.1) ?? 0;
print(UnsafeMutablePointer.init(&i))
print(UnsafeMutablePointer.init(&i2))
print(UnsafeMutablePointer.init(&i3))
print(UnsafeMutablePointer.init(&j))
print(UnsafeMutablePointer.init(&k))


let value = 12345678.magnitude;
let value1 = (-12345678).magnitude;

let d : Double = 1.0 / 3.0;
print(d.isFinite);

//MARK: - Leetcode
TwoNum.test();
AddTwoNumbers.test();
LongestSubstring.test();
MidianOfTwoSortedArrays.test();
LongestPalindromicSubstring.test();
