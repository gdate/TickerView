# TickerView

TickerView is a versatile text animation scroller library for iOS that allows text to smoothly scroll from right to left with automatic visibility management. It optimizes text size based on the label's height and provides an easy way to customize text content and view sizes.

![Demo](demo.gif)

## Features

- Text that goes off-screen is automatically hidden.
- When all text is hidden, it resets to the initial position and the animation restarts.
- Text size is optimized based on the label's height.
- Users can set the text and start/stop the animation.
- If the text width exceeds the scrollView's width, the text animates within the scrollable area.

## Installation

You can install TickerView using Swift Package Manager or manually integrate the TickerView library into your project by including the source files.

## Usage

### Import

To use TickerView in your Swift project, import the TickerView module in your Swift file:

```swift
import TickerView
```

### Basic Usage

1. In your xib or storyboard, add a UIView and set its class to "TickerView."
   
2. Display the Attributes Inspector.
   - Set the animationDuration: Enter the duration of the animation in seconds in the animationDuration field.
   - Turn on useTextAutoSizing: Enable the useTextAutoSizing checkbox to automatically set the maximum text width based on the TickerView's size.
   - Set the textSize: Enter the text size in points in the textSize field.
   - Set the textColor: Use the textColor field to set the color of the text.
  
3. Create an outlet for the TickerView in your view controller and customize its properties programmatically.
     
4. Set the text content for the TickerView

```swift
tickerView.setText("TickerView")
```

4. Start the animation

```swift
tickerView.startAnimation()
```

5. Optionally, stop the animation at any time.

```swift
tickerView.stopAnimation()
```

## Documentation (Under Construction)

## License

TickerView is available under the MIT license. See the [LICENSE](LICENSE) file for more information.

## Contribute (Under Construction)
