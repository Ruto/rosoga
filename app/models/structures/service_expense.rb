module Structures
    class ServiceExpense < Structure
      #this sorts out routing issues for subclassing
      def self.model_name
         Structure.model_name
      end

    end
end
