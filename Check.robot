*** Settings ***


Library       Selenium2Library


*** Variables ***
${Main}								https://te2.paygpay.com/
${SEARCHFORM_SEARCH}				search
${BUTTON_FOR_LOGIN}			    	submit
${ADMIN_HOST}						https://te2.paygpay.com
${ELEMENT_FOR_SEARCH_ID}			xpath=//table/tbody/tr[2]/td/div[2]/table[1]/tbody/tr/td/div/div[2]/form/a[1]
${SEARCHFORM_SEARCH_GO}				xpath=//table/tbody/tr[2]/td/div/table[2]/tbody/tr[3]/td[2]/table/tbody/tr[2]/td[4]/a
${LOGIN}							balashov
${LOGIN_PASS}						12345679
${FIRST_ADD_IN_CASHDESK}			xpath=//div[@id='current_details_data']//span[.='Add']
${SECOND_ADD_IN_CASHDESK}			xpath=//div[@id='mini_card_add']//span[.='Add']
${TERMINAL_ID}						426799
${SEARCH_PARAMETERS_ELEMENT}		xpath=//form[@id='searchForm']/select//option[1]
	#option[i]={Club ID,Club Name,User Login,ID terminal,GPM code,Terminal(by login),Ternimal(by player name,Terminal(by player add,informations))}
${TEXT_FROM_CLUB_ID}				xpath=/html/body/table/tbody/tr[2]/td/div/table[2]/tbody/tr[3]/td[2]/table/tbody/tr[2]/td[3]/a
${MANAGE}							xpath=//a[@class='first_tab']//span[.='Manage']
${MANAGE_CLUB}						xpath=//li[@class='current']//span[.='Club']
${MANAGE_CLUB_OPTIONS}				xpath=//li[@class='current']//span[.='Options']
${SAVE_IN_OPTION_CLUB}				submit
${FIRTS_ADD_TIME_IN_TERMINAL}		xpath=//div[@id='current_details_data']//span[.='Change']
${SECOND_ADD_TIME_IN_TERMINAL}		xpath=//div[@id='internet_time_update']//span[.='Change']
${CLOSE_CASHDESK_BOX}				xpath=//div[5]/div[1]/a/span
${INNER_TIME}						xpath=//span[@id="detail_internettime"]
${CASHDESK_BOX}						xpath=//div[@id="login_${TERMINAL_ID}"]
${REMOVE_TIME_CASHDESK}				xpath=//div[@id="current_details_data"]/table/tbody/tr[2]/td[2]/div[1]/span
${REMOVE_TIME_OK}					xpath=/html/body/div[4]/div[3]/div/button[1]/span
${INFO_BLOCK_IN_INFO_TERMINAL}  	xpath=//div[@id="edit-additional-info-block"]/form/label[${NUMBER}]/input
${NUMBER}							2
	#label[i]={Enter user First and Last names,Enter email,Additional info,Memo field}


*** Keywords ***

Search Club
	[Arguments]				${Club}
    Input Text 			 	${SEARCHFORM_SEARCH}  ${Club}
	Click Element			${SEARCH_PARAMETERS_ELEMENT}
    Click Element   	 	${ELEMENT_FOR_SEARCH_ID}
	Sleep 	2s
	Click Element 			${SEARCHFORM_SEARCH_GO}
	Location Should Be 		${ADMIN_HOST}/admin/?gh_id=${ClubID}
	
Login in admin
	Open Browser  ${Main}  firefox
    Maximize Browser Window
    Input Text 	 			login_name  	${LOGIN}
    Input Text 	 			login_pass  	${LOGIN_PASS}
	Click Button   		 	${BUTTON_FOR_LOGIN}

Choose the CashDesk
	Click Element 			xpath=//table/tbody/tr[2]/td/div/div/ul/li[2]/a/span 
	Click Element			xpath=//ul[@id='parent_level']/li[2]/ul/li[5]/a/span 

Add in CashDesk
	[Arguments]				${ADD_CASH_IN_TERMINAL}
	Click Element			${CASHDESK_BOX}	
    Click Element			${FIRST_ADD_IN_CASHDESK}
	Input Text				detail_add	${ADD_CASH_IN_TERMINAL}
	Click Element 			${SECOND_ADD_IN_CASHDESK}
	Click Element			${CLOSE_CASHDESK_BOX}
	
Z
	[Arguments]				${SLEEP}
	Sleep					${SLEEP}
	
Denomination	
	[Arguments]				${DENOMINATION}
	Click Element			${DENOMINATION}
	
Add time in CashDesk
	[Arguments]				${TIME_ADD}
	Click Element			${CASHDESK_BOX}	
    Click Element			${FIRTS_ADD_TIME_IN_TERMINAL}	
	Input Text				internet_time_input	${TIME_ADD}
	Click Element			${SECOND_ADD_TIME_IN_TERMINAL}
	Z						3
	Click Element			${CLOSE_CASHDESK_BOX}
	
Remove time from CashDesk
	Click Element			${CASHDESK_BOX}	
	Click Element			${REMOVE_TIME_CASHDESK}
	Click Element			${REMOVE_TIME_OK}
	Z						3
	Click Element			${CLOSE_CASHDESK_BOX}
	
Check Time in Cashdesk
	[Arguments]				${EQUALS}	
	Click Element			${CASHDESK_BOX}
	${time_result}=  		Get Text  	    ${INNER_TIME}
	Should Be True			${time_result} == ${EQUALS}
	Click Element			${CLOSE_CASHDESK_BOX}
	Location Should Be		${ADMIN_HOST}/admin/cashdesk.php?gh_id=${ClubID}
	
InfoBlock in terminal	
	[Arguments]				${NUMBER},${INFO}
	${INFO_BLOCK}  			${INFO_BLOCK_IN_INFO_TERMINAL}
	Input Text				${INFO_BLOCK}		${INFO}
	
	
