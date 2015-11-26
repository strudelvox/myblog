module AccountHelper

  def show_alert_notice_a
    html = ""
    if flash[:notice] then
      html = <<-HTML1
        <div class="row">
            <div class="alert alert-success"> #{ flash[:notice] }</div>
        </div><div class="row"><br></div>
        HTML1
    end
    if flash[:alert] then
        html = <<-HTML2
        <div class="row">
            <div class="alert alert-danger"> #{ flash[:alert] }</div>
        </div><div class="row"><br></div>
        HTML2
    end
    html.html_safe
  end 
  
end

