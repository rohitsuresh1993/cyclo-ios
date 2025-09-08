import SwiftUI

struct PeriodLogView: View {
    @State private var selectedStartDate: Date?
    @State private var selectedEndDate: Date?
    @State private var currentMonth = Date()
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header with month navigation
                HStack {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text(dateFormatter.string(from: currentMonth))
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                // Calendar Grid
                VStack(spacing: 0) {
                    // Day headers
                    HStack {
                        ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                            Text(day)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Calendar days
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                        ForEach(daysInMonth, id: \.self) { date in
                            DayView(
                                date: date,
                                isSelected: isDateSelected(date),
                                isInRange: isDateInRange(date),
                                isCurrentMonth: calendar.isDate(date, equalTo: currentMonth, toGranularity: .month),
                                isToday: calendar.isDateInToday(date)
                            ) {
                                selectDate(date)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Selected range display
                if let startDate = selectedStartDate, let endDate = selectedEndDate {
                    VStack(spacing: 8) {
                        Text("Selected Period Range")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Start Date")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatDate(startDate))
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("End Date")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatDate(endDate))
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 16) {
                    Button("Clear Selection") {
                        clearSelection()
                    }
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("Log Period") {
                        logPeriod()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(selectedStartDate != nil && selectedEndDate != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .disabled(selectedStartDate == nil || selectedEndDate == nil)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Period Log")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Calendar Logic
    
    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth) else {
            return []
        }
        
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        var days: [Date] = []
        
        // Add empty cells for days before the first day of the month
        for _ in 1..<firstWeekday {
            days.append(Date.distantPast)
        }
        
        // Add days of the month
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        
        return days
    }
    
    private func isDateSelected(_ date: Date) -> Bool {
        guard let startDate = selectedStartDate, let endDate = selectedEndDate else {
            return date == selectedStartDate || date == selectedEndDate
        }
        return date == startDate || date == endDate
    }
    
    private func isDateInRange(_ date: Date) -> Bool {
        guard let startDate = selectedStartDate, let endDate = selectedEndDate else {
            return false
        }
        return date >= startDate && date <= endDate
    }
    
    private func selectDate(_ date: Date) {
        if date == Date.distantPast { return }
        
        if selectedStartDate == nil {
            selectedStartDate = date
        } else if selectedEndDate == nil {
            if date >= selectedStartDate! {
                selectedEndDate = date
            } else {
                selectedEndDate = selectedStartDate
                selectedStartDate = date
            }
        } else {
            // Reset selection
            selectedStartDate = date
            selectedEndDate = nil
        }
    }
    
    private func previousMonth() {
        if let newMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    private func nextMonth() {
        if let newMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    private func clearSelection() {
        selectedStartDate = nil
        selectedEndDate = nil
    }
    
    private func logPeriod() {
        guard let startDate = selectedStartDate, let endDate = selectedEndDate else { return }
        
        // TODO: Implement period logging logic
        print("Logging period from \(formatDate(startDate)) to \(formatDate(endDate))")
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// MARK: - Day View Component

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let isInRange: Bool
    let isCurrentMonth: Bool
    let isToday: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(dayFormatter.string(from: date))
                .font(.system(size: 16, weight: isToday ? .bold : .medium))
                .foregroundColor(textColor)
                .frame(width: 40, height: 40)
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .disabled(date == Date.distantPast)
    }
    
    private var textColor: Color {
        if date == Date.distantPast {
            return .clear
        } else if isSelected {
            return .white
        } else if isInRange {
            return .blue
        } else if !isCurrentMonth {
            return .secondary
        } else if isToday {
            return .white
        } else {
            return .primary
        }
    }
    
    private var backgroundColor: Color {
        if date == Date.distantPast {
            return .clear
        } else if isSelected {
            return .blue
        } else if isInRange {
            return .blue.opacity(0.2)
        } else if isToday {
            return .blue.opacity(0.3)
        } else {
            return .clear
        }
    }
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
}

// MARK: - Preview

struct PeriodLogView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Default state
            PeriodLogView()
                .previewDisplayName("Default")
            
            // Dark mode
            PeriodLogView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
            
            // Different device sizes
            PeriodLogView()
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("iPhone SE")
        }
    }
}
