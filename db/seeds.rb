# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# categorization table
FileType.create([{ name: "Image" }, { name: "Other" }])
Role.create([{ role_name: "Registered User" }, { role_name: "Admin User" }, { role_name: "Super Admin User" }])
BlacklistStatus.create([{ name: "Normal" }, {name: "Blocked" }, {name: "Blacklisted" }])
Geofence.create([{ name: "geofence_name_1" },{ name: "geofence_name_2" },{ name: "geofence_name_3" }])
Location.create([{ country: "Chile", region: "Santiago"}, {country: "Chile", region: "Las condes"}, {country: "Chile", region: "Metropolitana"}, ])

# object
## some registered users
User.create( role_id: 0, location_id: 0, geofence_id: nil, username: "cefunck", email: "registered_cefunck@miuandes.com", password: "password" )
User.create( role_id: 0, location_id: 0, geofence_id: nil, username: "mfdiaz1", email: "registered_mfdiaz1@miuandes.com", password: "password" )
## some admin users
User.create( role_id: 1, location_id: 0, geofence_id: 0, username: "cefunck", email: "admin_cefunck@miuandes.com", password: "password" )
User.create( role_id: 1, location_id: 0, geofence_id: 0, username: "mfdiaz1", email: "admin_mfdiaz1@miuandes.com", password: "password" )
## some super admin users
User.create( role_id: 2, location_id: 0, geofence_id: 0, username: "cefunck", email: "super_admin_cefunck@miuandes.com", password: "password" )
User.create( role_id: 2, location_id: 0, geofence_id: 0, username: "mfdiaz1", email: "super_admin_mfdiaz1@miuandes.com", password: "password" )
## some user user profiles
UserProfile.create( user_id: 0, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
UserProfile.create( user_id: 1, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
UserProfile.create( user_id: 2, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
UserProfile.create( user_id: 3, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
UserProfile.create( user_id: 4, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
UserProfile.create( user_id: 5, picture_path: "path_to_the_picture_in_server", biography: "biography content" )
## some posts
Post.create( user_id: 0, location_id: 0, title: "title of post", description: "posts content", gps_coordinate: "coordenates", resolved: false, open: true )
Post.create( user_id: 1, location_id: 0, title: "title of post", description: "posts content", gps_coordinate: "coordenates", resolved: false, open: false )
Post.create( user_id: 2, location_id: 0, title: "title of post", description: "posts content", gps_coordinate: "coordenates", resolved: true, open: false )
## some comments
Comment.create( user_id: 0, post_id: 0, parent_comment_id: nil, content: "comment content" )
Comment.create( user_id: 0, post_id: 0, parent_comment_id: nil, content: "comment content" )
Comment.create( user_id: 0, post_id: 0, parent_comment_id: nil, content: "comment content" )
## some blacklist records
BlacklistRecord.create( user_id: 0, blacklist_status_id: 0 )
BlacklistRecord.create( user_id: 1, blacklist_status_id: 0 )
BlacklistRecord.create( user_id: 2, blacklist_status_id: 0 )
## some dumpster records
DumpsteredPost.create( post_id: 0 )
DumpsteredPost.create( post_id: 1 )
DumpsteredPost.create( post_id: 2 )

# jointables
Vote.create( users_id: 0, post_id: 0, up: true )
PostFollow.create( user_id: 0, post_id: 0 )
PostReport.create( user_id: 0, post_id: 0 )
PostShare.create( user_id: 0, post_id: 0 )
PostAttachment.create( post_id: 0, file_type_id: 0, file_path: "path_to_the_file_in_server" )
GeofencesLocation.create( geofence_id: 0, location_id: 0 )
