# frozen_string_literal: true

RSpec.describe Monday::Resources::Me, :vcr do
  describe ".query" do
    subject(:response) { client.me.query(select: select) }

    let(:select) do
      %w[
        id
        name
        email
        url
        account
        birthday
        country_code
        created_at
        current_language
        join_date
        enabled
        is_admin
        is_guest
        is_pending
        is_verified
        is_view_only
        last_activity
        location
        mobile_phone
        phone
        photo_original
        photo_small
        photo_thumb
        photo_thumb_small
        photo_tiny
        sign_up_product_kind
        teams
        time_zone_identifier
        title
        utc_hours_diff
      ]
    end

    context "when client is not authenticated" do
      let(:client) { invalid_client }

      it "raises Monday::AuthorizationError error" do
        expect { response }.to raise_error(Monday::AuthorizationError)
      end
    end

    context "when client is authenticated" do
      let(:client) { valid_client }

      it "returns 200 status" do
        expect(response.status).to eq(200)
      end

      it "returns the body with user details" do
        expect(response.body["data"]["me"]).to match(
          hash_including("id", "name", "email", "url")
        )
      end

      context "when a field that doesn't exist on me is requested" do
        let(:select) { ["invalid_field"] }

        it "raises Monday::Error error" do
          expect { response }.to raise_error(Monday::Error)
        end
      end
    end
  end
end
