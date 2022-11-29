class CardsController < ApplicationController

    layout "for_users"

    require 'credit_card_validations/string'

    def index
        @cards = Card.all
    end

    def show
        @card = Card.find(params[:number])
    end

    def new
        @card = Card.new
        @user = User.find(params[:user_id])
    end

    def create

        logger.debug "\n\n\nEntra al create\n\n\n"

        @card = Card.new

        @card.name = card_params[:name]
        @card.number = card_params[:number]
        # if card_params[:number].to_s.credit_card_brand_name != nil
        #     @card.cvv = card_params[:cvv]
        #     @card.date = card_params[:date].to_s
        #     @card.user_id = params[:user_id]
        #     @card.brand = card_params[:number].to_s.credit_card_brand_name

        #     logger.debug "\n\n\nAsigna\n\n\n"

        #     if @card.save

        #         logger.debug "\n\n\nGuardado\n\n\n"

        #         redirect_to "/wallets/#{params[:user_id]}"
        #     else

        #         logger.debug "\n\n\nNo guardado\n\n\n"

        #         redirect_to "/wallets/#{params[:user_id]}"
        #     end
        # else
        #     @card.errors.add(:base, "Número de tarjeta inválido")
        #     @wallet = Wallet.find_by(user_id: params[:user_id])
        #     @cards = Card.all
        #     render "/cards/new"
        # end

        if Card.where(user_id: params[:user_id]).find_by(number: card_params[:number]) != nil
            @card.errors.add(:base, "Ya tienes una tarjeta con ese número")
            @wallet = Wallet.find_by(user_id: params[:user_id])
            @cards = Card.all
            render "/cards/new"
        else
            if card_params[:number].to_s.credit_card_brand_name != nil
                @card.cvv = card_params[:cvv]
                @card.date = card_params[:date].to_s
                @card.user_id = params[:user_id]
                @card.brand = card_params[:number].to_s.credit_card_brand_name

                logger.debug "\n\n\nAsigna\n\n\n"

                if @card.save

                    logger.debug "\n\n\nGuardado\n\n\n"

                    redirect_to "/wallets/#{params[:user_id]}"
                else

                    logger.debug "\n\n\nNo guardado\n\n\n"

                    redirect_to "/wallets/#{params[:user_id]}"
                end
            else
                @card.errors.add(:base, "Número de tarjeta inválido")
                @wallet = Wallet.find_by(user_id: params[:user_id])
                @cards = Card.all
                render "/cards/new"
            end
        end


        # if card_params[:number].to_s.credit_card_brand_name = nil
        #     @card.errors.add(:base, "Número de tarjeta inválido")
        #     @wallet = Wallet.find_by(user_id: params[:user_id])
        #     @cards = Card.all
        #     render "/cards/new"
        # else
        #     if Card.find_by(user_id: params[:user_id]).find_by(number: card_params[:number]) != nil
        #         @card.errors.add(:base, "Ya tienes una tarjeta con ese número")
        #         @wallet = Wallet.find_by(user_id: params[:user_id])
        #         @cards = Card.all
        #         render "/cards/new"
        #     else
        #         @card.cvv = card_params[:cvv]
        #         @card.date = card_params[:date].to_s
        #         @card.user_id = params[:user_id]
        #         @card.brand = card_params[:number].to_s.credit_card_brand_name

        #         logger.debug "\n\n\nAsigna\n\n\n"

        #         if @card.save

        #             logger.debug "\n\n\nGuardado\n\n\n"

        #             redirect_to "/wallets/#{params[:user_id]}"
        #         else

        #             logger.debug "\n\n\nNo guardado\n\n\n"

        #             redirect_to "/wallets/#{params[:user_id]}"
        #         end
        #     end
        # end
    end

    def card_params
        params.require(:card).permit(:name, :number, :cvv, :date)
    end
end