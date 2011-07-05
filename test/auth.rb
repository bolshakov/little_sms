module Auth
  def self.included(other)
    other.class_eval do
      def auth
        [:"acc-4fe53b2b", :"OZkgGZ7g"]
      end
    end
  end
end

