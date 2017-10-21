class TicketsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tickets = Ticket.order(plate: :asc).all
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.new
    @ticket.plate = ticket_params[:plate]
    @ticket.vtype = ticket_params[:vtype]
    @ticket.init = DateTime.now

    if @ticket.save
      flash[:success] = "Ticket created successfully"
      redirect_to tickets_path
    else
      render 'new'
    end
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.plate = ticket_params[:plate]
    @ticket.vtype = ticket_params[:vtype]
    if @ticket.save
      flash[:success] = "Ticket updated successfully"
      redirect_to ticket_path(@ticket)
    else
      render 'edit'
    end
  end

  def bill
    @ticket = Ticket.find(params[:id])
  end

  def payment
    @ticket = Ticket.find(params[:id])
    @ticket.exit = DateTime.now
    @ticket.price = calc_price
    if @ticket.save
      flash[:success] = "Ticket Charged. $$$$$$$ :D"
      redirect_to bill_path(@ticket)
    else
      flash[:error] = "Oooops!!! Something went wrong, monkeys on the way...."
      redirect_to ticket_path(@ticket)
    end
  end

  private

  def calc_price
    (((@ticket.exit.to_i - @ticket.init.to_i)) * 90).to_i
  end

  def ticket_params
    params.require(:ticket).permit(:plate,:vtype)
  end

end
