Redmine::Plugin.register :mm_hooks do
  name 'Mm Hooks plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


  settings :default => {
    'mm_url' => 'https://mm.cameros.fr',
    'mm_key' => '',
    'rm_url' => 'https://projects.cameros.fr',
    'obs_user' => '',
    'obs_priorities' => [],
    'obs_trackers' => [],
    'obs_statuses' => []
  },
  :partial => 'settings/mm_hooks_settings'
end
