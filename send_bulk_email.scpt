#@osa-lang:AppleScript
property secsBetweenMails : 5 -- seconds
property csvHasHeaders : true
-- Notes:
-- Remember to be connected on luet@princeton.edu
-- There should be no new line at the end of the csv file
-- Remove "undo send" from Mail
-- Change the text of the email

property mailSubject : "Princeton University RSE Summer Fellow: Application Update"
property mailBody : "Dear %NAME%,

Thank you for your application to the Princeton University Research Software Engineering Summer Fellows Program. We received numerous impressive and highly qualified applications, which we carefully reviewed and considered. However, we regret to inform you that we cannot offer you a place in this year’s RSE fellows program.

The selection process was highly competitive, and while we are unable to offer you a fellowship, we encourage you to continue pursuing your interest in research software engineering and consider applying to this and similar programs in the future.

We appreciate your interest in the RSE Summer Fellows program and wish you the best in future endeavors.

Best regards,
David
"
property senderAddress : "luet@princeton.edu"

-- Alternatively, you can read the CSV data from a file:
set csvData to read "./email_list.csv"

set countSent to 0

set csvEntries to paragraphs of csvData

-- display dialog (csvData)
set n to count csvEntries
set n to n - 2
-- display dialog ("n=" & n)
if csvHasHeaders then
	set startAt to 2
else
	set startAt to 1
end if
-- display dialog "startAt" & startAt

repeat with i from startAt to ((count csvEntries) - 1)
	set {theName, theEmail} to parseCsvEntry(csvEntries's item i)
	-- display dialog (theName)
	set theBody to replaceName(mailBody, theName)

	tell application "Mail"
		set theNewMessage to make new outgoing message with properties {subject:mailSubject, content:theBody, visible:true}
		tell theNewMessage
			make new to recipient at end of to recipients with properties {address:theEmail}
			set sender to senderAddress
			send
		end tell
	end tell

	delay secsBetweenMails
	set countSent to countSent + 1
end repeat

display dialog ((countSent as string) & " emails sent.")

-- Parse a CSV entry into first name and email address
on parseCsvEntry(csvEntry)
	set {theName, emailAddress} to splitText(csvEntry, ",")
	return {theName, emailAddress}
end parseCsvEntry

-- Helper function to split text based on a delimiter
on splitText(textToSplit, delimiter)
	set AppleScript's text item delimiters to delimiter
	set textItems to text items of textToSplit
	set AppleScript's text item delimiters to ""
	return textItems
end splitText

-- Replace occurrences of %NAME% with the specified name
on replaceName(mailBody, theName)
	set searchPattern to "%NAME%"
	set replacementText to theName
	set AppleScript's text item delimiters to searchPattern
	set textItems to text items of mailBody
	set AppleScript's text item delimiters to replacementText
	set updatedBody to textItems as text
	set AppleScript's text item delimiters to ""
	return updatedBody
end replaceName