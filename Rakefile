REPOSITORY = "tamaxyo/tamaxyo.github.io"
MASTER_REPOSITORY = if ENV['GH_TOKEN']
                      "https://$GH_TOKEN@github.com/#{REPOSITORY}.git"
                    else
                      "git@github.com:#{REPOSITORY}.git"
                    end

PUBLISH_BRANCH = "master"
DEST_DIR = "build"

def initialize_repository(repository, branch)
  require 'fileutils'
    
  FileUtils::mkdir_p(DEST_DIR)

  if Dir["#{DEST_DIR}/.git"].empty?
    FileUtils.rm_rf DEST_DIR
    system "git clone --quiet #{repository} #{DEST_DIR} 2> /dev/null"
  end

  Dir.chdir DEST_DIR do
    system("git checkout #{branch}") || sh("git checkout --orphan #{branch}")
  end
end

def update_repository(branch)
  Dir.chdir DEST_DIR do
    sh 'git fetch origin'
    system("git reset --hard origin/#{branch}") ||
      system("git checkout #{branch}") ||
      sh("git checkout -b #{branch}")
  end
end

def build
  sh 'bundle exec middleman build'
end

def clean
  require 'fileutils'

  Dir.glob("#{DEST_DIR}/*").each do |file|
    FileUtils.rm_rf file
  end
end

def push_to_gh_pages(repository, branch)
  sh "cp .travis.yml #{DEST_DIR}" # avoid test on travis
  
  sha1, _ = `git log -n 1 --oneline`.strip.split(' ')
  Dir.chdir DEST_DIR do
    sh 'git add -A'
    sh "git commit -m 'Update with #{sha1}'"
    system "git push --quiet #{repository} #{branch} 2> /dev/null"
  end
end

desc 'Setup origin repository for GitHub pages'
task :setup do
  initialize_repository MASTER_REPOSITORY, PUBLISH_BRANCH
  update_repository PUBLISH_BRANCH
end

desc 'Clean built files'
task :clean do
  clean
end

desc 'Build sites'
task :build do
  build
end

desc 'Push to GitHub Pages'
task :push do
  push_to_gh_pages MASTER_REPOSITORY, PUBLISH_BRANCH
end

desc 'Build and Push to GitHub Pages'
task :publish => [:clean, :setup, :build, :push]
