class ChargesController < ApplicationController
    
    def create
        @user = current_user
        
        #creates a stripe customer object, for associating with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
            
        # Where the real magic happens / payment being made
        charge = Stripe::Charge.create(
            customer: customer.id, # Note -- this is NOT the user_id in your app
            amount: 15_00,
            description: "Upgrade to premium - #{current_user.email}",
            currency: 'usd'
        )
        
        @user.update_attributes(role: 'premium')
        
        flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
        redirect_to wikis_path # or wherever you want
        
        # Stripe will send back CardErrors, with friendly messages when something goes wrong.
        # This 'rescue block' catches and displays those errors.
        rescue Stripe::CardError => e
            flash[:alert] = e.message
            redirect_to new_charge_path
    end
    
    def new
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            amount: 15_00,
            description: "Premium Membership - #{current_user.email}"
        }
    end
    
    private
    def upgrade_user_role
        @user.role = 'premium'
    end
end    
