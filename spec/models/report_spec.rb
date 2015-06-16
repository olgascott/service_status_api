require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "validations" do
    context "#status" do

      it "should allow to create a report with status up" do
        report = Report.new(status: 'up')
        expect(report.save).to eq true
      end

      it "should allow to create a report with status down" do
        report = Report.new(status: 'down')
        expect(report.save).to eq true
      end

      it "should allow to create a report with status nil" do
        report = Report.new(message: 'no status here')
        expect(report.save).to eq true
      end

      it "should not allow to create a report with status being a random string" do
        report = Report.new(status: 'something else')
        expect(report.save).to eq false
      end

    end
  end

  describe "scopes" do
    context "#for_the_frontpage" do

      it "should not return reports without a message" do
        Report.create(status: 'up')
        report_with_message = Report.create(message: 'test')

        expect(Report.for_the_frontpage).to eq [report_with_message]
      end

      it "should return reports in correct order" do
        earliest_report = Report.create(message: 'test')
        latest_report   = Report.create(message: 'test2')

        expect(Report.for_the_frontpage).to eq [latest_report, earliest_report]
      end

      it "should not return more then 10 reports" do
        12.times do
          Report.create(message: 'test')
        end
        expect(Report.for_the_frontpage.length).to eq 10
      end

    end
  end

  describe "methods" do
    context "#get_current_status" do

      it "should return the latest status" do
        Report.create(status: 'up', message: 'test')
        Report.create(status: 'down', message: 'test2')

        expect(Report.get_current_status).to eq "down"
      end

      it "should return the latest status if latest report doesn't have status" do
        Report.create(status: 'up', message: 'test')
        Report.create(message: 'test2')

        expect(Report.get_current_status).to eq "up"
      end

    end
  end
end
