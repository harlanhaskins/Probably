import Foundation

extension Double {
	/// The lower limit of the `Double` type.
	public static var min : Double {
		return DBL_MIN
	}

	/// The upper limit of the `Double` type.
	public static var max : Double {
		return DBL_MAX
	}
}

#if os(Linux)
	public let DBL_MAX: Double = 1.7976931348623157e+308
	public let DBL_MIN: Double = 2.2250738585072014e-308
#endif
