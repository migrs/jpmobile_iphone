module ActionView
  class PathSet

    # hook ActionView::PathSet#find_template
    def find_template(original_template_path, format = nil, html_fallback = true) #:nodoc:
      if controller and controller.kind_of?(ActionController::Base) and (controller.request.mobile? or controller.request.iphone?)
        return original_template_path if original_template_path.respond_to?(:render)
        template_path = original_template_path.sub(/^\//, '')

        template_candidates = mobile_template_candidates(controller) if controller.request.mobile?
        template_candidates = ["iphone"] if controller.request.iphone?
        format_postfix      = format ? ".#{format}" : ""

        each do |load_path|
          template_candidates.each do |template_postfix|
            if template = load_path["#{template_path}_#{template_postfix}#{format_postfix}"]
              return template
            end
          end
        end
      end

      return find_template_without_jpmobile(original_template_path, format, html_fallback)
    end
  end
end
