import Foundation
import SwiftData

@Model
class Log {
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

    init(
        timestamp: Date,
        mood: Mood? = nil,
        symptoms: Symptoms? = nil,
        sexAndSexDrive: SexAndSexDrive? = nil,
        vaginalDischarge: VaginalDischarge? = nil,
        ovulationTest: OvulationTest? = nil,
        pregnancyTest: PregnancyTest? = nil,
        oralContraceptiveStatus: OralContraceptiveStatus? = nil,
        physicalActivity: PhysicalActivity? = nil,
        digestionAndStool: DigestionAndStool? = nil,
        other: Other? = nil
    ) {
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

struct LogDTO: Codable, Identifiable {
    var id: UUID = UUID()
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
}

extension Log {
    func toDTO() -> LogDTO {
        LogDTO(
            timestamp: timestamp,
            mood: mood,
            symptoms: symptoms,
            sexAndSexDrive: sexAndSexDrive,
            vaginalDischarge: vaginalDischarge,
            ovulationTest: ovulationTest,
            pregnancyTest: pregnancyTest,
            oralContraceptiveStatus: oralContraceptiveStatus,
            physicalActivity: physicalActivity,
            digestionAndStool: digestionAndStool,
            other: other
        )
    }
}

extension LogDTO {
    func toModel() -> Log {
        Log(
            timestamp: timestamp,
            mood: mood,
            symptoms: symptoms,
            sexAndSexDrive: sexAndSexDrive,
            vaginalDischarge: vaginalDischarge,
            ovulationTest: ovulationTest,
            pregnancyTest: pregnancyTest,
            oralContraceptiveStatus: oralContraceptiveStatus,
            physicalActivity: physicalActivity,
            digestionAndStool: digestionAndStool,
            other: other
        )
    }
}
