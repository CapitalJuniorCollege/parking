class Ticket < ApplicationRecord

  MAX_TICKETS = 10


  before_validation :upcase_plate_and_vtype

  validates :plate, format: { with: /\A[A-Z]{3}[0-9]{3}\z/ , message: ". You are a bad Monkey, format must be AAA000"}
  validates :vtype, length: { minimum: 4, maximum: 20 }

  validate :check_number_of_tickets, on: :create
  validate :plates_without_repeating



  private

  def plates_without_repeating
    tickets = Ticket.where(id: self.id, exit: nil)
    if tickets.any?
      if tickets.to_a.keep_if{ |t| t.id != self.id}.any?
        self.errors.add(:open_ticket, "This monkey already has an open ticket. Close the ticket first")
      end
    end
  end

  def check_number_of_tickets
    if Ticket.where.not(exit: nil).count > MAX_TICKETS
      self.errors.add(:availability, "Too many monkeys. We Are full bby!")
    end
  end

  def upcase_plate_and_vtype
    self.plate = self.plate.upcase if !self.plate.blank?
    self.vtype = self.vtype.upcase if !self.vtype.blank?
  end

end
