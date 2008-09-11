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

require "singleton"

# load all charsets
Dir[File.dirname(__FILE__) + '/sets/*.rb'].each do |file|
  require file
end

module Iconv
	class CharsetRegister
		include Singleton
		attr_reader :charsets

		def initialize
			@charsets = []
		end

		def register(charset)
			@charsets << charset
		end

		def unregister(charset)
			@charsets.delete charset
		end

		def find(name)
			#puts "DEBUG: #{@charsets.select { |c| c.name == name }[0]}"
			@charsets.select { |c| c.name == name }[0]
		end
	end

	class Charset
		attr_reader :name, :set

		def initialize(name, set)
			@name = name
			@set = set

			CharsetRegister.instance.register(self)
		end

		def convert_to_this(other_charset, data)
			return nil if data == nil
			new_str = ""
			data.each_byte do |x|
				found = other_charset.set[@set.index(x)]
				#raise "RIconv: IllegalSequence '#{data}'" if found > 255
				if ( found > 255 )
					new_str += "#"
				else
					new_str += found.chr
				end
			end

			return new_str
		end

		def convert_from_this(other_charset, data)
			other_charset.convert_to_this(self, data)
		end

		def to_s
			"#[#{@name} Charset:#{object_id}]"
		end
	end

	def self.init()
    methods = Iconv::CharSets.public_methods.select { |m| m =~ /^init.*/}
    methods.each { |method_name| Iconv::CharSets.send(method_name) }
	end
end

# load all charsets
Iconv::init()
