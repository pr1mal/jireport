require 'axlsx'

module JiReport
  module ExportXlsx
    def self.generate(file_path, metadata, data)
      p = Axlsx::Package.new
      w = p.workbook

      metadata.each do |sheet_meta|
        next unless sheet_meta[:columns]

        w.add_worksheet(name: sheet_meta[:title]) do |s|
          # generate header
          # TODO apply styles (color, column width, etc)
          s.add_row sheet_meta[:columns].map {|c| c[:header] || c[:source].last.to_s }

          # fill the data
          username_meth = sheet_meta[:columns].find {|c| cs = c[:source]; cs && cs.first.equal?(:user) }[:source].last
          issue_meths = sheet_meta[:columns].find_all {|c| cs = c[:source]; cs && cs.first.equal?(:issue) }.map do |cfg|
            cfg[:source].last
          end

          data.each do |user, issues|
            s.add_row [user.send(username_meth)]

            issues.map do |issue|
              s.add_row ["", "", issue_meths.map {|method| issue.send(method) }].flatten
            end

            s.add_row [] # add empty row
          end
        end
      end
      p.serialize file_path
    end
  end
end
