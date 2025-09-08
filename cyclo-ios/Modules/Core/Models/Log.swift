import Foundation
import SwiftData

@Model
class Log: Codable, Identifiable {
    var timestamp: Date
    var mood: Mood?
    var symptoms: Symptoms?
    var sexAndSexDrive: SexAndSexDrive?
    var vaginalDischarge: VaginalDischarge?
    var ovulationTest: OvulationTest?
    var pregnancyTest: PregnancyTest?
    var oralContraceptiveStatus: OralContraceptiveStatus?
    var physicalActivity: PhysicalActivity?
    var digestionAndStool: DigestionAndStool?
    var other: Other?

    init(timestamp: Date, mood: Mood?, symptoms: Symptoms?, sexAndSexDrive: SexAndSexDrive?, vaginalDischarge: VaginalDischarge?, ovulationTest: OvulationTest?, pregnancyTest: PregnancyTest?, oralContraceptiveStatus: OralContraceptiveStatus?, physicalActivity: PhysicalActivity?, digestionAndStool: DigestionAndStool?, other: Other?, periodEvent: PeriodEvent?, date: Date?) {
        self.timestamp = timestamp
        self.mood = mood
        self.symptoms = symptoms
        self.sexAndSexDrive = sexAndSexDrive
        self.vaginalDischarge = vaginalDischarge
        self.ovulationTest = ovulationTest
        self.pregnancyTest = pregnancyTest
        self.oralContraceptiveStatus = oralContraceptiveStatus
        self.physicalActivity = physicalActivity
        self.digestionAndStool = digestionAndStool
        self.other = other
    }
}