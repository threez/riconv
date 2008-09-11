#
# Copyright (c) 2008 Vincent Landgraf
#
# This file is part of the rIconv.
#
# rIconv is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# rIconv is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with rIconv. If not, see <http://www.gnu.org/licenses/>.
#

# Ruby Iconv implementation
require File.dirname(__FILE__) + "/riconv/charsets"

module Iconv
	def self.iconv(from, to, str)
		charset_register = CharsetRegister.instance

		from_o = charset_register.find(from)
		raise "RIconv: Charset #{from} (from) is unknown" if from_o == nil
		
		to_o = charset_register.find(to)
		raise "RIconv: Charset #{to} (to) is unknown" if to_o == nil
		
		[from_o.convert_from_this(to_o, str)]
	end
end
