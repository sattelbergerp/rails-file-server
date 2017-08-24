# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class CommentGenerator
  def initialize
    @r = Random.new
    @count = 0
    @max = 1000
    @user = User.first
    @file = UploadedFile.first
  end

  def genComment(parent=nil)
    while @r.rand(2)!=0||parent==nil
      text = BetterLorem.w(@r.rand(100)+20, true, false)
      comment = Comment.create(uploaded_file: @file, user: @user, parent: parent, content: text, score: (@r.rand(10000)-5000))
      genComment(comment)
      percent = (100.0/@max*@count).to_i
      print "\r#{percent}%" if percent != @percent
      @percent = percent
      @count+=1
      return if @count > @max
    end
  end
end

CommentGenerator.new.genComment()
puts ""
