Author.destroy_all
Title.destroy_all
Section.destroy_all

author_file  = File.join(File.dirname(__FILE__), 'data', 'authors.txt')
author_lines = File.read(author_file).split("\n")
author_rows  = author_lines.map { |l| l.split "\t" }

author_rows.each do |row|
  putc ','
  data = JSON.parse(row[4])
  begin
    a = Author.new(name: data['personal_name'] || data['name'],
                  olid: data['key'])
    if (bio = data['bio'] && data['bio']['value'])
      a.bio = bio
    end
    a.save!
  rescue ActiveRecord::RecordNotUnique
    # duplicate records OK
    putc 'x'
  rescue
    puts data
    raise $!
  end
end

=begin
open library: works.txt format
0: /type/work
2: /works/OL15380945W
3: 2
4: 2014-03-02T14:11:27.357481
5: {"title":         "book title",
    "created":       {"type":  "/type/datetime",
                      "value": "2010-09-23T23:47:44.499949"},
    "last_modified": {"type":  "/type/datetime",
                      "value": "2014-03-02T14:11:27.357481"},
    "latest_revision": 2,
    "key": "/works/OLIDW",
    "authors":       [{"type":   {"key": "/type/author_role"},
                       "author": {"key": "/authors/OL6924809A"}}],
    "author":        {"key": "/authors/OLIDA"},
    "type":          {"key": "/type/work"},
    "subjects":      ["things", "stuff"],
    "revision": 2}
=end

title_file  = File.join(File.dirname(__FILE__), 'data', 'works.txt')
title_lines = File.read(title_file).split("\n")
title_rows  = title_lines.map { |l| l.split "\t" }

title_rows.each do |row|
  putc '.'
  data = JSON.parse(row[4])
  begin
    t = Title.create!(title: data['title'],
                      olid:  data['key'])

    # authors
    if data.has_key?('authors')
      data['authors'].each do |a|
        author = Author.find_by(olid: a['author']['key'])
        t.authors << author if author
      end
    end

    if data.has_key?('author')
      author = Author.find_by(olid: data['author']['key'])
      t.authors << author if author

      # note -- we don't create new authors here because
      # we don't have enough information
    end

    # subjects
    if data.has_key?('subjects')
      subjects = data['subjects']
      subjects.each do |raw_name|
        section_name = raw_name.titleize
        s = Section.find_by(name: section_name) || Section.create!(name: section_name)
        t.sections << s
      end
    end
  rescue ActiveRecord::RecordNotUnique
    # duplicate records OK
    putc 'x'
  rescue
    puts data
    raise $!
  end
end
