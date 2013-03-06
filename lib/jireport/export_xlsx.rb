require 'axlsx'
require 'pp'

module JiReport
  class ExportXlsx

    STYLE_CONFIG = {
      alignment: {
        alignment: {
          horizontal: :center,
          vertical: :center,
          wrap_text: true
        }
      },
      data_alignment: {
        alignment: {
          horizontal: :left,
          vertical: :center,
          wrap_text: true
        }
      },
      header_color: {
        bg_color: 'fefe98',
        b: true,
        locked: true,
        border: { style: :thin, color: '00'}
      },
      username_color: {
        fg_color: 'ff0000',
        b: true,
        locked: true
      }
    }

    def initialize(metadata, data)
      metadata.each do |sheet_meta|
        next unless sheet_meta[:columns]

        workbook.add_worksheet(name: sheet_meta[:title]) do |s|
          # generate header
          row_data = sheet_meta[:columns].map {|c| c[:header] || c[:source].last.to_s }
          col_widths = sheet_meta[:columns].map {|c| c[:width] || :ignore }
          s.add_row(row_data, {height: 25, style: header_style, widths: col_widths})
          
          # fill the data
          username_meth = sheet_meta[:columns].find {|c| cs = c[:source]; cs && cs.first.equal?(:user) }[:source].last
          issue_meths = sheet_meta[:columns].find_all {|c| cs = c[:source]; cs && cs.first.equal?(:issue) }.map do |cfg|
            cfg[:source].last
          end

          data.each do |user, issues|
            user_data = [user.send(username_meth)]
            user_styles = [username_style]
            if sheet_meta[:no_data]
              sheet_meta[:columns].each do |c|
                next if c[:header] == "Name" # there is already username
                user_data << c[:value] || ""
                user_styles << nil # we don't want to style other cells
              end
            end
            s.add_row user_data, { style: user_styles, widths: col_widths }

            unless sheet_meta[:no_data]
              issues.each do |issue|
                s.add_row(["", "", issue_meths.map {|method| issue.send(method) }].flatten,
                          { style: data_style, widths: col_widths })
              end

              s.add_row [] # add empty row
            end
          end
        end
      end
    end

    def save(file_path)
      package.serialize file_path
    end

    private
    def package
      @package ||= Axlsx::Package.new
    end

    def workbook
      package.workbook
    end

    def add_style(*args)
      workbook.styles.add_style(*args)
    end
    
    def header_style
      @header_style ||= add_style(STYLE_CONFIG[:header_color].merge(STYLE_CONFIG[:alignment]))
    end

    def username_style
      @username_style ||= add_style(STYLE_CONFIG[:username_color])
    end

    def data_style
      @data_style ||= add_style(STYLE_CONFIG[:data_alignment])
    end
  end
end
