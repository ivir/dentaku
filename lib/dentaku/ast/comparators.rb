require_relative './operation'

module Dentaku
  module AST
    class Comparator < Operation
      def self.precedence
        5
      end

      def type
        :logical
      end

      private

      def cast(value, prefer_integer=true)
        v = BigDecimal.new(value, Float::DIG+1)
        v = v.to_i if prefer_integer && v.frac.zero?
        v
      end

    end

    class LessThan < Comparator
      def value(context={})
        cast(left.value(context)) < cast(right.value(context))
      end
    end

    class LessThanOrEqual < Comparator
      def value(context={})
        cast(left.value(context)) <= cast(right.value(context))
      end
    end

    class GreaterThan < Comparator
      def value(context={})
        cast(left.value(context)) > cast(right.value(context))
      end
    end

    class GreaterThanOrEqual < Comparator
      def value(context={})
        cast(left.value(context)) >= cast(right.value(context))
      end
    end

    class NotEqual < Comparator
      def value(context={})
        cast(left.value(context)) != cast(right.value(context))
      end
    end

    class Equal < Comparator
      def value(context={})
        cast(left.value(context)) == cast(right.value(context))
      end
    end
  end
end
