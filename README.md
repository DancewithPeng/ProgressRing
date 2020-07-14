# DPProgressRing

[TOC]

进度环控件，用于表示进度

可定制的功能属性有：

- **maximum**：最大值
- **minimum**：最小值
- **progress**：进度
- **isClockwise**：是否顺时针
- **startAngleOffset**：环的开始角度的偏移

可定制的外观属性有：

- **width**：环的宽度
- **progressColor**：进度环的颜色
- **placeholderColor**：占位环的颜色
- **cap**：环的帽檐

## 导入

```ruby
pod 'DPProgressRing', '~> 1.0.0'
```



## 使用

```swift
let ring = ProgressRing(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
ring.progress = 0.4
```

如果需要动画，使用以下方法进行更新进度

```swift
ring.setProgress(0.4, animated: true)
```



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

