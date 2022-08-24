# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Workplace.create!([
        {
                name: "CÔNG TY CỔ PHẦN CÔNG NGHỆ FLEXCORE",
                address: "05 Tuy Lý Vương, Phường Vỹ Dạ, Thành Phố Huế, Tỉnh Thừa Thiên - Huế",
                tax_code: "3301.684.091",
                description:
	                %{
                                This Webpage is built by Flexcore. 
                                To access to your company's site, please contact our admins as soon as possible. Thank you!
	                }.squish,
                slug: "cong-ty-co-phan-cong-nghe-flexcore"
        },
        {
                name: "CÔNG TY TNHH DP-TBYT BẢO MINH",
                address: "Thôn Chiết Bi, Phường Phú Thượng, Thành phố Huế, Tỉnh Thừa Thiên Huế",
                tax_code: "3301.633.273",
                description:
	                %{
                                This is BM's Data.
	                }.squish,
                slug: "cong-ty-tnhh-dp-tbyt-bao-minh"
        }
])

user = User.new(
        email: "nkhphuc@gmail.com",
        password: "Qwer#1234",
        name: "Nguyễn Khoa Hoàng Phúc",
        username: "nkhphuc",
        workplace_id: 1
)
user.confirmed_at = Time.now
user.save

user = User.new(
        email: "phuc@gmail.com",
        password: "Qwer#1234",
        name: "Hoàng Phúc",
        username: "phuc",
        workplace_id: 2
)
user.confirmed_at = Time.now
user.save

AdminUser.create!(email: "nkhphuc@gmail.com", password: "Qwer#1234") if Rails.env.development?

Drug.create!([
        {
                registration_no: "VD-27956-17",
                name: "Keygestan 100"
        },
        {
                registration_no: "VN-21777-19",
                name: "Bacterocin Oint"
        }
])