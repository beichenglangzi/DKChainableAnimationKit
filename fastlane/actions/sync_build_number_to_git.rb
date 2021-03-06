module Fastlane
  module Actions
    module SharedValues
      BUILD_NUMBER = :BUILD_NUMBER
    end
    class SyncBuildNumberToGitAction < Action
      def self.is_git?
        Actions.sh 'git rev-parse HEAD'
        return true
      rescue
        return false
      end
        
      def self.run(params)
        if is_git?
          command = 'git rev-list HEAD --count'
        else
          raise "Not in a git repository."
        end
      build_number = (Actions.sh command).strip
      Fastlane::Actions::IncrementBuildNumberAction.run(build_number: build_number)
      Actions.lane_context[SharedValues::BUILD_NUMBER] = build_number
      end

      def self.output
        [
          ['BUILD_NUMBER', 'The new build number']
        ]
      end
    end
  end
end

