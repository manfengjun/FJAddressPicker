Pod::Spec.new do|s|
  s.name="FJAddressPicker"
  s.version="1.0.0"
  s.summary="仿京东实现地址选择器，方便快捷"
  s.homepage="https://github.com/manfengjun/FJAddressPicker"
  s.license={:type=>"MIT",:file=>"LICENSE"}
  s.author={"manfengjun"=>"chinafengjun@gmail.com"}
  s.platform=:ios,"8.0"
  s.source={:git=>"https://github.com/manfengjun/FJAddressPicker.git",:tag=> s.version }
  s.source_files="FJAddressPicker/*.{swift}"
  s.requires_arc= true
  
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'FMDB', '~> 2.7.2'
 end

