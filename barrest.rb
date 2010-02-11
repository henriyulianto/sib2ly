# This file is part of SIB2LY    Copyright 2010 Kirill Sidorov
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class BarRest < NoteRest
  attr_accessor :real_duration, :texts
  def initialize
    super
    @position = 0
    @texts = []
    @real_duration = @duration
  end

  def initialize_from_xml(xml)
    super(xml)
    parent_bar = xml.parent
    @duration = parent_bar["Length"].to_i
    @position = 0
    @real_duration = @duration
  end

  def BarRest.new_from_xml(xml)
    br = BarRest.new
    br.initialize_from_xml(xml)
    br
  end

  def is_rest?
    true
  end

  def to_ly
    s = ""
#        if @prev and (@prev.bar != @bar)
#      s << " | % #{@bar.number}\n"
#    end
    
    s << voice_mode_to_ly

		#   s << " " if !@texts.empty? # What is the meaning of this?
    f = @duration.gcd(1024);
    s << grace_to_ly
    if voice > 1 or @hidden
      s << "s1*"
    else
      s << "R1*"
    end
    s << (@duration/f).to_s + "/" + (1024/f).to_s;
    @texts.each{|text| s << text.to_ly}
#    if @ends_transposition
#			s << "}} "
#		end
    s
  end
end
