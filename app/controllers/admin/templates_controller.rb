class Admin::TemplatesController < Admin::AuthController
  def index
    render action: :index, locals: { templates: templates }
  end

  def new
    render action: :new, locals: { template: current_site.templates.new }
  end

  def create
    current_site.templates.new(permitted_params).tap do |template|
      if template.save
        redirect_to admin_templates_path, notice: 'Template created'
      else
        render action: :new, locals: { template: template }
      end
    end
  end

  def edit
    render action: :edit, locals: { template: template }
  end

  def update
    if template.update_attributes(permitted_params)
      redirect_to admin_templates_path, notice: 'Template updated'
    else
      render action: :edit, locals: { template: template }
    end
  end

  def destroy
    if template.destroy
      flash[:notice] = 'Template successfully removed.'
    else
      flash[:error] = 'Template could not be removed at this time.'
    end
    redirect_to admin_templates_path
  end

  private

  def templates
    @templates ||= current_site.templates.all
  end

  def template
    @template ||= current_site.templates.find(params[:id])
  end

  def permitted_params
    params.require(:template).permit(:name, :description, :filename, :metadata_raw)
  end
end
