Phonebook
==========

This application works on `'rails', '4.1.1'`
`ruby version 2.1.0`

Web and json compatible at the same time, being a Rails application.

Phonebook is an application that allows you to add Singaporian mobile numbers(starting with 89 and are 7 digits long) along with the name.

Phone numbers should be unique, no two entries can have same phone numbers.

You are allowed to download the text file having each row as comma seperated having name and phone number.

User can add new list items or edit or delete them from the same page as no redirection is required being an Ajaxified application.


## Upload Phonebook Instructions
It should be in same format as you can download using 'Download Phonebook' link.

### For updating existing contact
If you want to update existing contact, you will need to update name/phone values in the row. Keep in mind that you should not change value that is enclosed by round brackets.

e.g. (21), Robert, 89574125

You can update `Robert` and `89574125`, not `(21)` which is unique identifier.

### For adding new contact
Here you need to add new row to your `.txt` file. You should leave round brackets blank like `()`, its mandatory. Add name and phone number saparated by comma.

e.g. (), Gorge, 89651325
