# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

RecordingSearcheable.create_index!(force: true)

admin = User.new(
  first_name: "Alexey",
  last_name: "Gorlanov",
  role: 1,
  status: 1,
  notifications: 0,
  message: "",
  email: "strudelvox@gmail.com",
  password: "12345678",
  password_confirmation: "12345678",
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil,
  sign_in_count: 0,
  current_sign_in_at: nil,
  last_sign_in_at: nil,
  current_sign_in_ip: nil,
  last_sign_in_ip: nil,
  confirmation_token: nil,
  confirmed_at: nil,
  confirmation_sent_at: nil,
  unconfirmed_email: nil)
admin.skip_confirmation!
admin.profile_image = File.open('app/assets/images/testimonial2.jpg')
admin.save!
admin.confirm!

user = User.new(
  first_name: "Alexander",
  last_name: "Sergeev",
  role: 0,
  status: 1,
  notifications: 0,
  message: "",
  email: "aserg1977@gmail.com",
  password: "12345678",
  password_confirmation: "12345678",
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil,
  sign_in_count: 0,
  current_sign_in_at: nil,
  last_sign_in_at: nil,
  current_sign_in_ip: nil,
  last_sign_in_ip: nil,
  confirmation_token: nil,
  confirmed_at: nil,
  confirmation_sent_at: nil,
  unconfirmed_email: nil)
user.skip_confirmation!
user.profile_image = File.open('app/assets/images/testimonial3.jpg')
user.save!
user.confirm!

user_banned = User.new(
  first_name: "Ivan",
  last_name: "Ivanov",
  role: 0,
  status: 0,
  notifications: 1,
  message: "Banned. Ban reason: User must love putin in each his post!",
  email: "gas200@mail.ru",
  password: "12345678",
  password_confirmation: "12345678",
  reset_password_token: nil,
  reset_password_sent_at: nil,
  remember_created_at: nil,
  sign_in_count: 0,
  current_sign_in_at: nil,
  last_sign_in_at: nil,
  current_sign_in_ip: nil,
  last_sign_in_ip: nil,
  confirmation_token: nil,
  confirmed_at: nil,
  confirmation_sent_at: nil,
  unconfirmed_email: nil)
user_banned.skip_confirmation!
user_banned.profile_image = File.open('app/assets/images/testimonial4.jpg')
user_banned.save!
user_banned.confirm!

r1 = Recording.create( user_id: admin.id,
                    rec_header: "A brief history of climate science",
                    rec_teaser: "By Ed Hawkins, University of Reading. Climate change is often seen as a recent phenomenon, but its roots are actually far older — the stuff that is currently happening is beyond my understanding.
Some people say design is about solving problems. Obviously designers solve problems but so do dentists. Design is about cultural invention.",
                    rec_text: "",
                    rec_approved: 1 )

r2 = Recording.create( user_id: user.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=ruser.id",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=ruser.id",
                    rec_text: "",
                    rec_approved: 1 )
r3 = Recording.create( user_id: user.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=r3",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=r3",
                    rec_text: "",
                    rec_approved: 1 )
r4 = Recording.create( user_id: user.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=r4",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=r4",
                    rec_text: "",
                    rec_approved: 1 )
r5 = Recording.create( user_id: user.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=r5",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=r5",
                    rec_text: "",
                    rec_approved: 0 )
r6 = Recording.create( user_id: user.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=r6",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=r6",
                    rec_text: "",
                    rec_approved: 0,
                    created_at: DateTime.strptime("09/14/2009 8:00","%m/%d/%Y %H:%M") )
r7 = Recording.create( user_id: user_banned.id,
                    rec_header: "I've my Radeon HD 7990 stolen from the parcel=r7",
                    rec_teaser: "Damn card was stolen during the send. I have no fucking idea who did this: damned ukrainian fucks or someother niggas
                     who are the \"post workers\" or they just stucking around the boxes=r7",
                    rec_text: "",
                    rec_approved: 0 )

c1 = Comment.create( user_id: user.id,
                    recording_id: r1.id,
                    c_text: "Wow, we're all be dead!")

c2 = Comment.create( user_id: user_banned.id,
                    recording_id: r1.id,
                    c_text: "Poshli vse nahui! Gryaz!")

c3 = Comment.create( user_id: admin.id,
                    recording_id: r2.id,
                    c_text: "Last time it is a trend: I've lost the motherboard a year ago, it was sent to a damn canadian jude!")


