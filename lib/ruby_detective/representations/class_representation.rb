module RubyDetective
  module Representations
    class ClassRepresentation
      attr_reader :namespace, :file_path, :inheritance_class_name, :constant_references, :dependencies, :dependents, :lines_of_code

      def initialize(namespace, inheritance_class_name: nil, file_path:, constant_references:, first_line:, last_line:)
        @file_path = file_path
        @namespace = namespace
        @inheritance_class_name = inheritance_class_name
        @constant_references = constant_references
        @dependencies = []
        @dependents = []
        @first_line = first_line
        @last_line = last_line
        @lines_of_code = last_line - first_line + 1
      end

      def name
        namespace.last
      end

      def full_name
        namespace.join("::")
      end

      def register_dependencies(dependencies)
        @dependencies += dependencies
      end

      def register_dependents(dependents)
        @dependents += dependents
      end

      def merge_information(duplicates)
        inheritances = duplicates.map(&:inheritance_class_name).flatten + [@inheritance_class_name]
        constants = duplicates.map(&:constant_references).flatten + @constant_references
        dependencies = duplicates.map(&:dependencies).flatten + @dependencies
        lines_of_code = duplicates.sum(&:lines_of_code) + @lines_of_code

        @inheritance_class_name = inheritances.compact.first
        @constant_references = constants.uniq
        @dependencies = dependencies.uniq
        @lines_of_code = lines_of_code
      end

      private
      attr_reader :first_line, :last_line
    end
  end
end
