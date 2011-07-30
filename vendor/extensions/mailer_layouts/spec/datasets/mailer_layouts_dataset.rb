class MailerLayoutsDataset < Dataset::Base
  uses :layouts

  def load
    create_layout "email", :content_type => "text/html", :content => %{
Normal email layout:
<r:content />
    }
    create_layout "custom", :content_type => "text/html", :content => %{
Custom email layout:
<r:content />
    }
    create_layout "plain", :content_type => "text/plain", :content => %{
Plain text email layout:
<r:content />
    }
    
  end
end