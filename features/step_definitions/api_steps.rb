When /^I add an incident report to the database$/ do

end

Then /^I can retrieve the incident from the database$/ do

end

When /^I add (\d+) incident reports to the database$/ do |num_inc|

end

Then /^I can retrieve all (\d+) incident reports from the database$/ do

end

Then /^The incident report entry is returned$/ do

end


Then /^I receive the error message "[^"s]*"$/ do |error_msg|

end

When /^I add an incident with inappropriate (.*) value$/ do |bad_param|

end

When /^I attempt to add an incident with extraneous data do$/ do

end
