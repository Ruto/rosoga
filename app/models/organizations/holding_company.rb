module Organizations
    class HoldingCompany < Organization
      #this sorts out routing issues for subclassing
      def self.model_name
        Organization.model_name
      end

    end
end
