namespace :pirates do
  desc "Automaticall closes tasks"
  task :autoclose => :environment do
    admin = User.find_by_id(1)
    checkstates = [24, 25] # Done and Won't Do
    closestate = 5 #Closed
    trackers = [13, 16]
    days = 30

    checkstates.each do |checkstate|
      trackers.each do |tracker|
        Issue.find(:all, :conditions => ["status_id = ? and tracker_id = ? and updated_on < ?", checkstate, tracker, (DateTime.now - days)]).each do |issue|
          journal = Journal.new
          journal.user = admin
          journal.journalized_type = "Issue"
          journal.journalized_id = issue.id
          journal.notes = "Automatically closed after #{days} days"
          journal.save

          jdetail = JournalDetail.new
          jdetail.journal_id = journal.id
          jdetail. property = "attr"
          jdetail.prop_key = "status_id"
          jdetail.old_value = issue.status_id.to_s
          jdetail.value = closestate.to_s
          jdetail.save

          issue.status_id = closestate
          issue.save
        end
      end
    end

    puts "Autoclose done"
  end
  
  desc "Automatically moves task out of the new state"
  task :autostart => :environment do
    admin = User.find_by_id(1)

    checkstate = 1 # New
    trackers = { 13 => 23, 16 => 23 }
    days = 3

    trackers.each do | tracker, nextstate |
      Issue.find(:all, :conditions => ["status_id = ? and tracker_id = ? and updated_on < ?", checkstate, tracker, (DateTime.now - days)]).each do |issue|
        journal = Journal.new
        journal.user = admin
        journal.journalized_type = "Issue"
        journal.journalized_id = issue.id
        journal.notes = "Automatically changed from new state after #{days} days"
        journal.save

        jdetail = JournalDetail.new
        jdetail.journal_id = journal.id
        jdetail. property = "attr"
        jdetail.prop_key = "status_id"
        jdetail.old_value = issue.status_id.to_s
        jdetail.value = nextstate.to_s
        jdetail.save

        issue.status_id = nextstate
        issue.save
      end
    end

    puts "Autostart"
  end
end

