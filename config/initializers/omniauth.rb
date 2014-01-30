Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '457875700984620', '702ff76aae0b67a82e73225874b8cde0'
end