module Structures
  class Income < Structure

      #   it is transactionable and comes from sales of a products or services
      #   it is the transaction should add all the way up to the root income
      #   transactionable should accomodate various types budget, monthly, annual
      def self.model_name
         Structure.model_name
      end


  end
end
