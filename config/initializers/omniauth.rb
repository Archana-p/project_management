Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'j3BLX8TWsmJPczTUSTkARTQNu', '9VD8bJOnARGx532f8uVEQCZvu0F3uGxBQkMwhE08vsIfqgJY1Y'
  provider :facebook, '877247325653402', '003873a2fc747408e770ebfc69c1dc29'
end