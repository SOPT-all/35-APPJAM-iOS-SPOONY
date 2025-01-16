//
//  Report.swift
//  Spoony-iOS
//
//  Created by 최주리 on 1/16/25.
//

import SwiftUI

enum ReportType: String, CaseIterable {
    case commercial = "영리 목적/ 홍보성 후기"
    case abusiveLanguage = "욕설/인신공격"
    case illegalInformation = "불법정보"
    case personalInformationExposure = "개인정보노출"
    case spam = "도배"
    case others = "기타"
}

struct Report: View {
    @State private var selectedReport: ReportType = .commercial
    @State private var text: String = ""
    @State private var errorState: TextEditorErrorState = .noError
    @State private var isDisabled: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            //TODO: 변경 예정
            CustomNavigationBar(style: .primary, title: "신고하기") {
                
            }
            Divider()
            
            reportTitle
            reportDescription
            
            SpoonyButton(
                style: .secondary,
                size: .xlarge,
                title: "신고하기",
                disabled: $isDisabled
            ) {
                
            }
            .padding(.top, errorState == .noError ? 12 : 20)
            .padding(.bottom, 20)
        }
        .frame(maxHeight: .infinity)
        .onTapGesture {
            if errorState == .maximumInputError(style: .report) {
                errorState = .noError
            }
        }
        .onChange(of: errorState) {
            if errorState == .minimumInputError(style: .report) {
                isDisabled = true
            } else {
                isDisabled = false
            }
            
            if errorState == .maximumInputError(style: .report) {
                isDisabled = true
            }
        }
    }
    
    private func radioButton(report: ReportType, isSelected: Bool) -> some View {
        HStack(spacing: 12) {
            Image(isSelected ? .icRadioOnGray900 : .icRadioOffGray400)
            
            Text(report.rawValue)
                .font(.body1m)
                .foregroundStyle(.gray900)
            
            Spacer()
        }
        .frame(height: 42.adjustedH)
    }
}

extension Report {
    private var reportTitle: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("후기를 신고하는 이유가 무엇인가요?")
                .font(.body1sb)
                .foregroundStyle(.spoonBlack)
                .padding(.bottom, 12)
            
            ForEach(ReportType.allCases, id: \.self) { report in
                radioButton(
                    report: report,
                    isSelected: selectedReport == report
                )
                    .onTapGesture {
                        selectedReport = report
                        if errorState == .maximumInputError(style: .report) {
                            errorState = .noError
                        }
                    }
            }
        }
        .padding(.top, 31)
        .padding(.horizontal, 20)
    }
    
    private var reportDescription: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("자세한 내용을 적어주세요")
                .font(.body1sb)
                .foregroundStyle(.spoonBlack)
                .padding(.bottom, 12.adjustedH)
            
            SpoonyTextEditor(
                errorState: $errorState,
                text: $text,
                style: .report,
                placeholder: "내용을 자세히 적어주시면 신고에 도움이 돼요"
            )
            
            HStack(alignment: .top, spacing: 10) {
                Image(.icErrorGray300)
                
                Text("스푸니는 철저한 광고 제한 정책과 모니터링을 실시하고 있어요. 부적절한 후기 작성자를 발견하면, '수저 뺏기'로 그들의 수저를 빼앗아 주세요!")
                    .font(.caption1m)
                    .foregroundStyle(.gray400)
            }
            .padding(10)
            .background(.gray0, in: RoundedRectangle(cornerRadius: 8))
            .padding(.top, 8)
        }
        .padding(.top, 32)
        .padding(.horizontal, 20)
    }
}

#Preview {
    Report()
}
