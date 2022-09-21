class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def create
    @kitten = Kitten.new kitten_params

    if @kitten.save
      flash[:success] = "Your new kitten is born!"
      redirect_to @kitten
    else
      flash.now[:error] = "Uh oh! Your kitten wasn't created. Try again!"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update kitten_params
      flash[:success] = "Your kitten is a changed feline!"
      redirect_to @kitten
    else
      flash.now[:error] = "You can't change your cat that way!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:success] = "You murderer!"
    redirect_to root_path, status: :see_other
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end