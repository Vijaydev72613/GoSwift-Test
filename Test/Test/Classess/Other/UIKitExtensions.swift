
import UIKit
import AVFoundation

// MARK: - UINavigationController -

extension UINavigationController {
	
	public override func shouldAutorotate() -> Bool {
		
		if let controller: AnyObject = viewControllers.last {
			return controller.shouldAutorotate()
		}
		else {
			return false
		}
		
	}
}

// MARK: - UIViewController -

extension UIViewController {
	
	func addViewControllerAsSubview(parentView : UIView, childController : UIViewController, parentController : UIViewController) {
		
		parentController.addChildViewController(childController)
		childController.view.frame = CGRectMake(0, 0, parentView.width, parentView.height)
		parentView.addSubview(childController.view)
		childController.didMoveToParentViewController(parentController)
		
	}
	
	func getViewController(controllerClass : AnyClass) -> UIViewController {
		let identifier = NSStringFromClass(controllerClass).componentsSeparatedByString(".").last! as String
		return storyboard!.instantiateViewControllerWithIdentifier(identifier) 
	}
	
	func pushViewController(controllerClass : AnyClass ,parameters : Dictionary<String , AnyObject>? = nil ,animated : Bool = true) {
		
		let viewController = getViewController(controllerClass)
		
		if parameters != nil {
			for (key ,value) in parameters! {
				viewController.setValue(value, forKey: key)
			}
		}
		
		navigationController?.pushViewController(viewController, animated: animated)
	}
    
    func popViewControllerInMainThread(animated : Bool = true) {
        dispatch_sync(dispatch_get_main_queue()) { 
            self.navigationController?.popViewControllerAnimated(animated)
        }
    }
    
    func popToRootViewControllerInMainThread(animated : Bool = true) {
        dispatch_sync(dispatch_get_main_queue()) {
            self.navigationController?.popToRootViewControllerAnimated(animated)
        }
    }
	
}

// MARK: - UIColor -

extension UIColor {
	convenience init(psRed: Int, psGreen: Int, psBlue: Int, alpha: CGFloat = 1.0) {
		assert(psRed >= 0 && psRed <= 255, "Invalid red component")
		assert(psGreen >= 0 && psGreen <= 255, "Invalid green component")
		assert(psBlue >= 0 && psBlue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(psRed) / 255.0, green: CGFloat(psGreen) / 255.0, blue: CGFloat(psBlue) / 255.0, alpha: alpha)
	}
	
	convenience init(hex: Int, alpha: CGFloat = 1.0) {
		self.init(psRed:(hex >> 16) & 0xff, psGreen:(hex >> 8) & 0xff, psBlue:hex & 0xff, alpha: alpha)
	}
	
	class func themeColor(alpha : CGFloat = 1.0) -> UIColor {
		return UIColor(hex: 0x5BB7C4, alpha: alpha)
	}
    
}

// MARK: - UIImage -

extension UIImage {
	
	func scaledProfileImage() -> UIImage {
		
		return scaledImage(CGSizeMake(200, 200))
		
	}
	
	func scaledImage(neededSize : CGSize) -> UIImage {
		
		var scaledSize = size
		let wfactor = size.width / neededSize.width
		let hfactor = size.height / neededSize.height
		
		if hfactor < 1 && wfactor < 1 {
			return self
		}
		
		let firstScaleFactor = fmax(hfactor, wfactor)
		let scaleFactor = fmax(1, firstScaleFactor)
		scaledSize.height /= scaleFactor
		scaledSize.width /= scaleFactor
		
		UIGraphicsBeginImageContextWithOptions(scaledSize, false, 1.0)
		let scaledImageRect = CGRectMake(0, 0, scaledSize.width, scaledSize.height)
		drawInRect(scaledImageRect)
		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return scaledImage
	}
	
	// MARK: - Images -
	
	class func profilePlaceholder() -> UIImage {
		return UIImage(named: "Profile-Placeholder")!
	}
    
    class func placeholderImage() -> UIImage {
        return UIImage(named: "Placeholder-Image")!
    }
    
    class func loanIcon() -> UIImage {
        return UIImage(named: "Loan_Icon")!
    }
    
}

// MARK: - UIView -

// MARK: Hidden

extension UIView {
	
	func setHidden(hidden : Bool, animated : Bool) {
		alpha = hidden ? 1.0 : 0
		self.hidden = false
		let animationDuration = (animated == true) ? 0 : 0.35
		UIView.animateWithDuration(animationDuration, animations: { () -> Void in
			self.alpha = hidden ? 0 : 1.0
			self.hidden = hidden
		})
	}
    
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(self, options: nil)[0] as? UIView
    }

}

// MARK: - Corner Radius

extension UIView {
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = true
		}
	}
}

// MARK: - Border

extension UIView {
	struct Border {
		var width: CGFloat, color: UIColor
	}
	
	var border: Border {
		get {
			return Border(width: layer.borderWidth, color: UIColor(CGColor: layer.borderColor!))
		}
		set(newBorder) {
			layer.borderColor = newBorder.color.CGColor
			layer.borderWidth = newBorder.width
		}
	}

}

// MARK: - Shadow

extension UIView {
	
	struct Shadow {
		var shadowOpacity: Float
		
		var shadowPath: UIBezierPath?
		var shadowOffset: CGSize
		var shadowRadius: CGFloat
		var shadowColor: UIColor
		
		init(shadowOpacity: Float, shadowPath: UIBezierPath? = nil, shadowOffset: CGSize = CGSizeMake(0, -3), shadowRadius: CGFloat = 3, shadowColor: UIColor = UIColor.blackColor()) {
			self.shadowOpacity = shadowOpacity
			self.shadowPath = shadowPath
			self.shadowOffset = shadowOffset
			self.shadowRadius = shadowRadius
			self.shadowColor = shadowColor
		}
	}
	
	var shadow: Shadow {
		get {
			return Shadow (
				shadowOpacity: Float(layer.shadowRadius),
				shadowPath: UIBezierPath(CGPath: layer.shadowPath!),
				shadowOffset: layer.shadowOffset,
				shadowRadius: layer.shadowRadius,
				shadowColor: UIColor(CGColor: layer.shadowColor!)
			)
		}
		set(newShadow) {
			layer.shadowOpacity = newShadow.shadowOpacity
			layer.shadowPath = newShadow.shadowPath?.CGPath
			layer.shadowOffset = newShadow.shadowOffset
			layer.shadowRadius = newShadow.shadowRadius
			layer.shadowColor = newShadow.shadowColor.CGColor
		}
	}
}

// MARK: - Layout

extension UIView {
	
	var x: CGFloat {
		get {
			return frame.origin.x
		}
		set(newX) {
			frame.origin.x = newX
		}
	}
	
	var y: CGFloat {
		get {
			return frame.origin.y
		}
		set(newY) {
			frame.origin.y = newY
		}
	}
	
	var width: CGFloat {
		get {
			return frame.size.width
		}
		set(newWidth) {
			frame.size.width = newWidth
		}
	}
	
	var height: CGFloat {
		get {
			return frame.size.height
		}
		set(newHeight) {
			frame.size.height = newHeight
		}
	}
	
	var maxY: CGFloat {
		return frame.origin.y + frame.size.height
	}
	
	var maxX: CGFloat {
		return frame.origin.x + frame.size.width
	}
	
	var size: CGSize {
		set(newSize){
			frame.size.height = newSize.height
			frame.size.width = newSize.width
		}
		get{
			return frame.size
		}
	}
}

// MARK: - UITextField -

extension UITextField {
	
	private class PaddingView: UIView {}
	
	var leftPadding: CGFloat {
		get {
			let paddingView = leftView as? PaddingView
			return paddingView?.frame.size.width ?? 0
		}
		set {
			leftView = PaddingView(frame: CGRectMake(0, 0, newValue, 0))
			leftViewMode = .Always
		}
	}
    
    func isEmpty() -> Bool {
        if let t = text {
            return (t.characters.count == 0)
        }
        return true
    }
    
}

// MARK: - CGRect -

// MARK: - Layout

extension CGRect {
	var width: CGFloat {
		get {
			return size.width
		}
		set {
			size.width = newValue
		}
	}
	
	var height: CGFloat {
		get {
			return size.height
		}
		set {
			size.height = newValue
		}
	}
	
	var x: CGFloat {
		get {
			return origin.x
		}
		set {
			origin.x = newValue
		}
	}
	
	var y: CGFloat {
		get {
			return origin.y
		}
		set {
			origin.y = newValue
		}
	}
	
	var maxY: CGFloat {
		return origin.y + size.height
	}
	
	var maxX: CGFloat {
		return origin.x + size.width
	}
	
	var center: CGPoint {
		get {
			return CGPointMake(origin.x + width / 2, origin.y + height / 2)
		}
		set {
			origin = CGPointMake(newValue.x - width / 2, newValue.y - height / 2)
		}
	}
}

// MARK: - Convenience

extension CGRect {
	enum Region: Int {
		case None
		case TopLeft
		case TopRight
		case BottomLeft
		case BottomRight
	}
	
	func inset(x: CGFloat, _ y: CGFloat) -> CGRect {
		return CGRectInset(self, x, y)
	}
	
	func regionForPoint(point: CGPoint) -> Region {
		if point.x > center.x {
			if point.y < center.y {
				return .TopRight
			}
			else {
				return .BottomRight
			}
		}
		else {
			if point.y < center.y {
				return .TopLeft
			}
			else {
				return .BottomLeft
			}
		}
	}
}

// MARK: - CGPoint -

extension CGPoint {
	func distanceTo(point: CGPoint) -> CGFloat {
		let (x1, x2) = (x, point.x)
		let (y1, y2) = (y, point.y)
		
		return sqrt((x2 - x1 ) * (x2 - x1) + (y2 - y1) * (y2 - y1))
	}
	
	func isInRegion(region: CGRect.Region, ofRect rect: CGRect) -> Bool {
		return rect.regionForPoint(self) == region
	}
}















