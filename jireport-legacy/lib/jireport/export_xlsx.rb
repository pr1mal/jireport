require 'axlsx'
require 'pp'

module JiReport
  class ExportXlsx
    def initialize(metadata, data)
      metadata.each do |sheet_meta|
        next unless sheet_meta[:columns]

        workbook.add_worksheet(name: sheet_meta[:title]) do |s|
          # generate header
          row_data = sheet_meta[:columns].map {|c| c[:header] || c[:source].last.to_s }
          col_widths = sheet_meta[:columns].map {|c| c[:width] || :ignore }
          s.add_row(row_data, {height: 25, style: header_style(sheet_meta[:style]), widths: col_widths})
          
          # fill the data
          username_meth = sheet_meta[:columns].find {|c| cs = c[:source]; cs && cs.first.equal?(:user) }[:source].last
          issue_meths = sheet_meta[:columns].find_all {|c| cs = c[:source]; cs && cs.first.equal?(:issue) }.map do |cfg|
            cfg[:source].last
          end

          data.each do |user, issues|
            user_data = [user.send(username_meth)]
            user_styles = [username_style(sheet_meta[:style])]
            if sheet_meta[:no_data]
              sheet_meta[:columns].each do |c|
                next if c[:header] == "Name" # there is already username
                user_data << c[:value] || ""
                user_styles << nil # we don't want to style other cells
              end
            elsif style_has_keys?(sheet_meta[:style][:username_color], :full_row) # apply style to the whole row, not just one cell
              sheet_meta[:columns].each do |c|
                next if c[:header] == "Name" # there is already username
                user_data << ""
              end
              user_styles = user_styles.first
            end
            s.add_row user_data, { style: user_styles, widths: col_widths }

            unless sheet_meta[:no_data]
              issues.each do |issue|
                s.add_row(["", "", issue_meths.map {|method| issue.send(method) }].flatten,
                          { style: data_style(sheet_meta[:style]), widths: col_widths })
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
    
    def header_style(style)
      return nil unless style_has_keys?(style, :header_color, :header_alignment)
      add_style((style[:header_color] || {}).merge(style[:header_alignment] || {}))
    end

    def username_style(style)
      return nil unless style_has_keys?(style, :username_color)
      add_style(style[:username_color])
    end

    def data_style(style)
      return nil unless style_has_keys?(style, :data_alignment)
      add_style(style[:data_alignment])
    end

    def style_has_keys?(style, *keys)
      return false unless (style and style.is_a?(Hash) and keys)
      return !(keys.find {|k| style.has_key?(k) }.nil?)
    end
  end
end
