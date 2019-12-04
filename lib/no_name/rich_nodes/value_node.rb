module NoName
  module RichNodes
    class ValueNode < GenericNode
      attr_reader :value

      def initialize(value, *args)
        super(value, *args)
        @value = value
      end

      def type
        :value
      end

      private

      def raw_children
        []
      end
    end
  end
end
