#encoding: utf-8
User.create!(email: 'admin@admin.com', password: '0975519929', name: '系統管理員', pid: '12345678', phone: '0975519929')

%w(A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 C1 C2 D1 D2 E1 E2 F1 F2 G1 G2 H1 H2 I1 I2 J1 J2 K1 K2).each do |building|
  Building.create(name: building, created_by: 1)
end

Account.create(name: '現金', created_by: 1)

TransactionType.create(name: '管理費收入', self_type: '收入', description: '住戶管理費收入')
