#! /usr/bin/env ruby
# -------------------------------------------------------------------------------
# This program is property of NorthgateArinso. Usage or any kind of distribution
# is not permitted unless written permission is granted.
#
# Copyright (c) 2014 NorthgateArinso International
#
#
# sapdetect class - Detect SAP system parameters
#
# Versions:
#		v0.1 - Initial version
#
#
# -------------------------------------------------------------------------------
# This class detect current SID, sap instance directory, java stack and database parameters
#

#note: some systems have sap 

#
# Just a enum type for the system type
#
module Systemtype
	j2ee = "j2ee"
	r3 = "r3"
	oracle = "oracle"
end

#
# Class sap service, 
# contains the priority, the type and the sid of the service.
class SapService
def priotity
	@priority
end
def type
	@type
end
def sid
	@sid
end
def instance
	@instance
end
def listener_name
	@listener_name
end
def oracle_home
	@oracle_home
end

def initialize(type,sid,instance)
	@sid = sid
	@type = type
	@instance = instance
end

def parseline(line)
# example of line from sapservice
# LD_LIBRARY_PATH=/usr/sap/EDM/DVEBMGS00/exe:$LD_LIBRARY_PATH
nline = line.delete('LD_LIBRARY_PATH')
puts "Line after execution " + nline
#	splitted = line.split('/')
#	splitted.each do |spl|
#		case 
end
end

#
# Main class
# Contains a list of SapServices
# 
class SapDetect
#import SapService

# System ID
def systemID
	@systemID
end
#profile file
def profile
@profile = "/usr/sap/#{@systemID}/SYS/profile/DEFAULT.PFL"
end
def sapservice
@sapservice
end
def hostname
	@hostname
end

def initialize
# obtain systemID from environment variables:
 @systemID = ENV['SAPSYSTEMNAME']
 @hostname = ENV['HOST']
 @profile = "/usr/sap/#{@systemID}/SYS/profile/DEFAULT.PFL"

 @sapservice = "/usr/sap/sapservices"
#puts "System name: #{@systemID}"
#puts "Profile: #{@profile}"
#puts "Sap services: #{@sapservice}"
end





#
# Parse the sapservice file
#

def readsapconf
	#raise IOError, "File #{@sapservice} does not exists", unless (File.exist?(@sapservice) == false)
	#end
#	if 
#	puts "File #{@sapservice} exists, checking content"
	lines = File.open(@sapservice).read
	lines.each_line do |line|
	
	subline = line.split(";")
	sps = SapService.new("","","")
	
	subline.each do |sbl|
	puts "Complete line " + sbl
	sps.parseline(subline)
	end
	
	end
	
	
	
#	else
	
end

def configure
	cfg = ParseConfig.new(@profile)
	saplocalhost = cfg['SAPLOCALHOST']
	sapglobalhost = cfg['SAPGLOBALHOST']
	sapdbhost = cfg['SAPDBHOST']
	sapj2ee = cfg['j2ee/dbhost']
	# check: if SAPLOCALHOST  is nil but SAPGLOBALHOST == HOSTNAME then
	# this server is standalone, and the central instance is this server.
	if(saplocalhost == nil)
	centralInstance =   (hostname == sapglobalhost)
	else
	centralInstance =   (saplocalhost == sapglobalhost)
	end
	
	#DB checks
	# is db being executed on this system?
	#
	#if(sapdbhost != nil)
		database = ( hostname == sapdbhost)
	#else
	
	#end
	
	# J2ee checks
	java = ( sapj2ee == hostname)
	
	


	 
	
#	puts "Sap localhost: " 
	puts "Sap global host: #{sapglobalhost} " 
	puts "Is central instance: #{centralInstance}" 
	puts "Has a database? #{database}"
	puts "j2ee ? #{java}"
	self.readsapconf
		
		
#		srv = ParseConfig.new(@sapservice)
#		list = srv['LD_LIBRARY_PATH']
#		puts list
#		list.each do |line|
#		puts line
#		puts "Next line"
#		end
	
end

end


