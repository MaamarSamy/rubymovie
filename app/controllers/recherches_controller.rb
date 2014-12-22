class RecherchesController < ApplicationController
  before_action :set_recherch, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @recherches = Recherche.all
    respond_with(@recherches)
  end

  def show
    respond_with(@recherch)
  end

  def new
    @recherch = Recherche.new
    respond_with(@recherch)
  end

  def edit
  end

  def create
    @recherch = Recherche.new(recherche_params)
    @recherch.save
    respond_with(@recherch)
  end

  def update
    @recherch.update(recherche_params)
    respond_with(@recherch)
  end

  def destroy
    @recherch.destroy
    respond_with(@recherch)
  end

  private
    def set_recherch
      @recherch = Recherche.find(params[:id])
    end

    def recherch_params
      params[:recherch]
    end
end
