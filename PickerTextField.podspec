Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.name         = "PickerTextField"
  s.version      = "1.2.2"
  s.summary      = "A simple wrapper for UITextField that can pick data provided by the data source."

  s.description  = "PickerTextField wrap the UITextField by replace its inputView and inputAccessory
      with a UIPickerView and a UIToolbar. PickerTextField also remember what's selected."


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Nestarneal" => "nestarneal@gmail.com" }
  s.homepage           = "https://github.com/Nestarneal/PickerTextField"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "9.3"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/Nestarneal/PickerTextField.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  s.source_files  = "PickerTextField", "PickerTextField/**/*.{h,m,swift}"

  s.swift_version = '4.0'
end
