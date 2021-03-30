#! /usr/bin/env ruby
# -------------------------------------------------------------------------------
# This program is property of NorthgateArinso. Usage or any kind of distribution
# is not permitted unless written permission is granted.
#
# Copyright (c) 2014 NorthgateArinso International
#
#
# sapctl program - Controls SAP services.
#
# Versions:
#		v0.1 - Initial version
#
#
# -------------------------------------------------------------------------------
require 'rubygems'
require 'abbrev'
require 'etc'
require 'parseconfig'
require 'open4'
require 'set'
require 'sapdetect'
require 'yaml'

#puts "Trying to create environment listing"
#system("env > env.tmp")
#puts "Set env files created"

#SVRENV = Hash.new


#File.readlines("env.tmp").each do |line|
#	values = line.split("=")
#	SVRENV[values[0]] = values[1]
#end







#sid = ENV['SAPSYSTEMNAME']

sapdetect =  SapDetect.new


#sidname = (sid != nil ? (sid) : ("Can't detect system id"))

#profile = "/usr/sap/#{@sid}/SYS/profile/DEFAULT.PFL"
#sapservices = "/usr/sap/sapservices"

puts "==========================================="
puts " AUTOCONFIG UTILITY "
puts "==========================================="
puts "Detecting SID name... " + sapdetect.systemID
puts "Profile:... "  + sapdetect.profile
puts "Sap services: " + sapdetect.sapservice

puts "Reading profile..."
sapdetect.configure




#profile = ParseConfig.new('/usr/sap/EDM/SYS/profile/DEFAULT.PFL')
#puts profile.get_params()

#puts profile.inspect

#puts  "SID: #{ENV['SAPSYSTEMNAME']} "
#puts  "INSTANCE SECUDIR: #{ENV['SECUDIR']}"
#puts "INSTANCE DIR LIST #{SVRENV['INSTANCEDIR_LIST']}"
#puts "ORACLE SID: #{ENV['ORACLE_SID']}"
#puts "ORACLE HOME: #{ENV['ORACLE_HOME']}"





