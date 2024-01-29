require 'httparty'

class Listener < Redmine::Hook::ViewListener
    
  include HTTParty
  
  def controller_issues_new_before_save(context = {})
    context[:issue].watcher_user_ids = [5] # TODO mettre l'id de l'équipe technique
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
