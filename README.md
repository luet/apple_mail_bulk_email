Sends bulk email using Apple Mail with an email list in a CSV file.

Change:
- The email:
  - subject.
  - text of the email.
- Use `%NAME%`.
- The recipient list file name. `set csvData to read "./email_list.csv"` .

Notes:
- Remember to be connected on luet@princeton.edu
- There should be no new line at the end of the csv file
- Remove "undo send" from Mail
- In Mail preferences, Composing >> Sending >> Undo send delay.
- Test using a test recipients list.

