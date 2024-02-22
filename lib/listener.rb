require 'httparty'

class Listener < Redmine::Hook::ViewListener
    
  include HTTParty

  # structure ticket
  # "is_private"=>"0", "tracker_id"=>"1", "subject"=>"zzzzzzzzzz", "description"=>"dzqdqz", "status_id"=>"1", "priority_id"=>"2", "assigned_to_id"=>"", "parent_issue_id"=>"", "start_date"=>"2024-02-22", "due_date"=>"", "estimated_hours"=>"", "done_ratio"=>"0", "watcher_user_ids"=>[""]
  
  def controller_issues_new_before_save(context = {})
    ticket = context[:issue]
    @shouldBeWatched = false

    # 
    if (
      Setting.plugin_mm_hooks['obs_priorities'] != nil &&
      Setting.plugin_mm_hooks['obs_priorities'].index(ticket.priority_id.to_s) != nil
    ) 
      then @shouldBeWatched = true
      else @shouldBeWatched = false
    end

    if (
      Setting.plugin_mm_hooks['obs_trackers'] != nil &&
      Setting.plugin_mm_hooks['obs_trackers'].index(ticket.tracker_id.to_s) != nil
    ) 
      then @shouldBeWatched = true
      else @shouldBeWatched = false
    end

    if (
      Setting.plugin_mm_hooks['obs_statuses'] != nil &&
      Setting.plugin_mm_hooks['obs_statuses'].index(ticket.status_id.to_s) != nil
    ) 
      then @shouldBeWatched = true
      else @shouldBeWatched = false
    end

    if (@shouldBeWatched) then
        ## set équipe technique en obs
        watchers = ticket.watcher_user_ids
        watchers.push(Setting.plugin_mm_hooks['obs_user'].to_i)
        ticket.watcher_user_ids = watchers
    end
  end

  def controller_issues_new_after_save(context = {})
      if (context[:issue].priority.id == 1)
          then
            text = "Nouvelle demande [http://localhost:8080/issues/#{context[:issue].id.to_s}](http://localhost:8080/issues/#{context[:issue].id.to_s})\Sujet : #{context[:issue].subject}"
            response = HTTParty.post(
              'http://192.168.1.10:8065/hooks/zxffgn6i9fy73c443sju7qytqe',
              body: { text: text }.to_json,
              headers: { 'Content-Type' => 'application/json' }
            )
      end
  end
end
