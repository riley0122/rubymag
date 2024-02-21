# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.
require "magister/types/classroom.rb"
require "magister/types/subject.rb"
require "magister/types/teacher.rb"

# This class describes a Class as it would appear in the schedule in magister.
# MagClass instead of Class becasue ruby got confused with class
class MagClass
    # Returns a new instance of MagClass.
    # @param rawParsed [Hash] The raw data, yet it has already been parsed (like with JSON.parse)
    # @since 1.1.0
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

    # Gets a summary of the object.
    # Overwrites default function.
    # @return [String] object summary
    # @since 1.1.0
    def inspect
        "#<#{self.class}:0x#{object_id} @id=#{@id}, @description=#{@description}, @subjects[0]=#{@subjects[0].inspect}, @teachers[0]=#{@teachers[0].inspect}, @location=#{@location}>"
    end

    # getters

    # The ID of the class
    # @return [Integer] the id
    # @since 1.1.0
    def id
        @id
    end
    # The time the class starts
    # @return [String] the date formatted in ISO 8601
    # @since 1.1.0
    def classStart
        @classStart
    end
    # @see classStart
    # @since 1.1.0
    def startTime
        @classStart
    end
    # The time the class ends
    # @return [String] the ending date formatted in ISO 8601
    # @since 1.1.0
    def classEndInclusive
        @classEndInclusive
    end
    # @see classEndInclusive
    # @since 1.1.0
    def endTime
        @classEndInclusive
    end
    # If the class lasts the whole day
    # @return [Boolean]
    # @since 1.1.0
    def wholeDay
        @wholeDay
    end
    # The description of the class formatted like
    # a - b - c.
    # where a is a short version of the classes name.
    # where b is the short code of the teachers name.
    # where c is the class/group the class belongs to.
    # @return [String] a - b - c
    # @since 1.1.0
    def description
        @description
    end
    # The location where the class is
    # @note reccommended to use the +classrooms+ property instead
    # @return [String] the location
    # @see classrooms
    # @since 1.1.0
    def location
        @location
    end
    # The content of the class.
    # @return [String, nil] the content
    # @note This is stuff like homework or test descriptions.
    # @since 1.1.0
    def content
        @content
    end
    # A remark (opmerking) added to the class
    # @return [String, nil] the remark
    # @note This is diffrent form the +note+
    # @see note
    # @since 1.1.0
    def remark
        @remark
    end
    # A note (aantekening) added to the class
    # @return [String, nil] the note
    # @note This is diffrent from +remark+
    # @see remark
    # @since 1.1.0
    def note
        @note
    end
    # If it is marked as finished
    # @note this has been set by the user, not by the teacher or anyone else.
    # @return [Boolean]
    # @since 1.1.0
    def finished
        @finished
    end
    # If the class repeats
    # @note Currently we are not certain what every status means.
    # @return [Integer] the status
    # @since 1.1.0
    def repeatStatus
        @repeatStatus
    end
    # |?| How it repeats
    # @note We do not have info on what this property does/means
    # @return [?]
    # @since 1.1.0
    def repeat
        @repeat
    end
    # What subjects are in this class
    # @return [Array<Subject>] The subjects
    # @since 1.1.0
    def subjects
        @subjects
    end
    # What teachers are giving this class
    # @return [Array<Teacher>] The teachers
    # @since 1.1.0
    def teachers
        @teachers
    end
    # What classrooms this class is given in
    # @return [Array<ClassRoom>] The classrooms
    # @since 1.1.0
    def classrooms
        @classrooms
    end
    # If the class has any attachments
    # @return [Boolean] has attachments
    # @see attachments
    # @since 1.1.0
    def hasAttachments
        @hasAttachments
    end
    # The attachments that are attached
    # @note Unsure yet what type the attachments will be
    # @return [?, nil]
    # @since 1.1.0
    def attachments
        @attachments
    end

    # |?| What kind of content it has
    # @note We do not have info on what this property does/means
    # @return [?]
    # @since 1.1.0
    def infoType
        @infoType
    end
    # |?| if the class is cancelled etc?
    # @note We do not have info on what this property does/means
    # @return [Integer]
    # @since 1.1.0
    def status
        @status
    end
    # |?|
    # @note We do not have info on what this property does/means
    # @return [?]
    # @since 1.1.0
    def type
        @type
    end
    # |?|
    # @note We do not have info on what this property does/means
    # @return [?]
    # @since 1.1.0
    def subtype
        @subtype
    end
    # |?| Wether or not the class has online attendance
    # @note We do not have info on what this property does/means
    # @return [Boolean]
    # @since 1.1.0
    def isOnline
        @isOnline
    end
    # |?|
    # @note We do not have info on what this property does/means
    # @return [Integer]
    # @since 1.1.0
    def viewType
        @viewType
    end
    # |?|
    # @note We do not have info on what this property does/means
    # @return [?]
    # @since 1.1.0
    def assignmentId
        @assignmentId
    end
    # |?|
    # @note We do not have info on what this property does/means
    # @return [?, nil]
    # @since 1.1.0
    def groups
        @groups
    end
end