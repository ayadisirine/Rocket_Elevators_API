/**	CONTACT FORM
*************************************************** **/

$(document).ready(function() {
	$("#message-button").on("click", function(){
		var $name = $("#name").val();
		//console.log($name);
		var $email = $("#email").val();
		//console.log($email);
		var $phone = $("#phone").val();
		//console.log($phone);
		var $companyName = $("#company_name").val();
		//console.log($companyName);
		var $projectName = $("#project_name").val();
		//console.log($projectName);
		var $projectDescription = $("#project_description").val();
		//console.log($projectDescription);
		var $department = $("#department").val();
		//console.log($department);
		var $message = $("#message").val();
		//console.log($message);
		if ($name == "" || $email == "" || $phone == "" || $companyName == "" || $projectName == "" || 
		$projectDescription == "" || $message == "") {
			alert("Please fill all mandatory (*) fields before sending your message.");
		} else {
			alert("Your message was sent succesfully. Thank you. We will return to you shorly.");
			$("#name, #email, #phone, #company_name, #project_name, #project_description, #department, #message").val("");
		}
		
	});
})