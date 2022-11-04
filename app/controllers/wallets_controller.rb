class WalletsController < ApplicationController

    def mostrar_wallet
        @wallet = Wallet.find_by(user_id: :user_id)
    end

    def cargar_saldo 
        @wallet = Wallet.find_by(user_id: :user_id)
        @wallet.saldo = @wallet.saldo + params[:saldo].to_i
        @wallet.save
        redirect_to mostrar_saldo_path
    end

    def wallet_params
        params.require(:wallet).permit(:user_id, :saldo)
    end

end
