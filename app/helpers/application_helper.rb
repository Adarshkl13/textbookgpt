module ApplicationHelper
    def mobile_device?
      browser.device.mobile?
    end
end
