import Foundation

extension Double {
	/// The upper limit of the `Double` type.
	public static var max : Double {
		return DBL_MAX
	}
}

#if os(Linux)
	public let DBL_MAX: Double = 1.7976931348623157e+308
#endif
