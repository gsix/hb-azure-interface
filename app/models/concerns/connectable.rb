module Connectable
  def hubstaff_status
    hubstaff_id.present? ? 'connected' : 'not_connected'
  end

  def hubstaff_connected?
    hubstaff_status == 'connected'
  end

  def azure_status
    if self.is_a? Project
      azure_hooks_created? ? 'connected' : 'not_connected'
    else
      azure_id.present?? 'connected' : 'not_connected'
    end
  end

  def azure_connected?
    azure_status == 'connected'
  end
end
