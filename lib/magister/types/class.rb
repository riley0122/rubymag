# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require "magister/types/classroom.rb"
require "magister/types/subject.rb"
require "magister/types/teacher.rb"

# MagClass instead of Class becasue ruby got confused with class
class MagClass
    def initialize(rawParsed)
        @id                 = rawParsed["Id"]
        @classStart         = rawParsed["Start"]
        @classEndInclusive  = rawParsed["Einde"]
        @wholeDay           = rawParsed["DuurtHeleDag"]
        @description        = rawParsed["Omschrijving"]
        # I dont know why location is here when theres also classrooms
        @location           = rawParsed["Lokatie"]
        @content            = rawParsed["Inhoud"]
        @remark             = rawParsed["Opmerking"]
        @note               = rawParsed["Aantekening"]
        @finished           = rawParsed["Afgerond"]
        @repeatStatus       = rawParsed["HerhaalStatus"]
        @repeat             = rawParsed["Herhaling"]

        @subjects           = Array.new
        rawParsed["Vakken"].each do |subject|
            @subjects.push Subject.new(subject)
        end

        @teachers           = Array.new
        rawParsed["Docenten"].each do |teacher|
            @teachers.push Teacher.new(teacher)
        end

        @classrooms         = Array.new
        rawParsed["Lokalen"].each do |classRoom|
            @classrooms.push ClassRoom.new(classRoom)
        end

        @hasAttachments     = rawParsed["HeeftBijlagen"]
        @attachments        = rawParsed["Bijlagen"]

        # I dont know what these values do
        @infoType           = rawParsed["InfoType"]         # I think what kind of content like homework/test
        @status             = rawParsed["Status"]           # I think the status as in cancelled
        @type               = rawParsed["Type"]
        @subtype            = rawParsed["SubType"]
        @isOnline           = rawParsed["IsOnlineDeelname"] # Wether there is a way to participate online?
        @viewType           = rawParsed["WeergaveType"]
        @assignmentId       = rawParsed["OpdrachtId"]
        @groups             = rawParsed["Groepen"]
    end

    def inspect
        "#<#{self.class}:0x#{object_id} @id=#{@id}, @description=#{@description}, @subjects[0]=#{@subjects[0].inspect}, @teachers[0]=#{@teachers[0].inspect}, @location=#{@location}>"
    end

    # getters
    def id
        @id
    end
    def classStart
        @classStart
    end
    def startTime
        @classStart
    end
    def classEndInclusive
        @classEndInclusive
    end
    def endTime
        @classEndInclusive
    end
    def wholeDay
        @wholeDay
    end
    def description
        @description
    end
    def location
        @location
    end
    def content
        @content
    end
    def remark
        @remark
    end
    def note
        @note
    end
    def finished
        @finished
    end
    def repeatStatus
        @repeatStatus
    end
    def repeat
        @repeat
    end
    def subjects
        @subjects
    end
    def teachers
        @teachers
    end
    def classrooms
        @classrooms
    end
    def hasAttachments
        @hasAttachments
    end
    def attachments
        @attachments
    end
    def infoType
        @infoType
    end
    def status
        @status
    end
    def type
        @type
    end
    def subtype
        @subtype
    end
    def usOnline
        @isOnline
    end
    def viewType
        @viewType
    end
    def assignmentId
        @assignmentId
    end
    def groups
        @groups
    end
end