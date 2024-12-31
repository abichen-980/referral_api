json.total_pages @referrals.total_pages
json.current_page @referrals.current_page
json.referrals @referrals, partial: "referral", as: :referral
