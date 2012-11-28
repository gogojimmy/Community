#encoding: utf-8
user = User.new(email: 'admin@admin.com', password: '0975519929', role: 'system', name: '系統管理員', pid: '12345678', phone: '0975519929', created_by: 1)
user.save(validate: false)
