# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionChartSize03 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_chart_size03
    @xlsx = 'chart_size01.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet
    chart     = workbook.add_chart(:type => 'column', :embedded => 1)

    # For testing, copy the randomly generated axis ids in the target xlsx file.
    chart.instance_variable_set(:@axis_ids, [61355904, 61365248])

    data = [
            [1, 2, 3,  4,  5],
            [2, 4, 6,  8, 10],
            [3, 6, 9, 12, 15]
           ]

    worksheet.write('A1', data)

    chart.add_series(:values => '=Sheet1!$A$1:$A$5')
    chart.add_series(:values => '=Sheet1!$B$1:$B$5')
    chart.add_series(:values => '=Sheet1!$C$1:$C$5')

    worksheet.insert_chart('E9', chart, 0, 0, 1.066666666, 1.11111111)

    workbook.close
    compare_xlsx_for_regression(File.join(@regression_output, @xlsx), @xlsx)
  end
end
