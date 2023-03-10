<!---
	
This file is part of Masa CMS. Masa CMS is based on Mura CMS, and adopts the  
same licensing model. It is, therefore, licensed under the Gnu General Public License 
version 2 only, (GPLv2) subject to the same special exception that appears in the licensing 
notice set out below. That exception is also granted by the copyright holders of Masa CMS 
also applies to this file and Masa CMS in general. 

This file has been modified from the original version received from Mura CMS. The 
change was made on: 2021-07-27
Although this file is based on Mura™ CMS, Masa CMS is not associated with the copyright 
holders or developers of Mura™CMS, and the use of the terms Mura™ and Mura™CMS are retained 
only to ensure software compatibility, and compliance with the terms of the GPLv2 and 
the exception set out below. That use is not intended to suggest any commercial relationship 
or endorsement of Mura™CMS by Masa CMS or its developers, copyright holders or sponsors or visa versa. 

If you want an original copy of Mura™ CMS please go to murasoftware.com .  
For more information about the unaffiliated Masa CMS, please go to masacms.com  

Masa CMS is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by 
the Free Software Foundation, Version 2 of the License. 
Masa CMS is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
GNU General Public License for more details. 

You should have received a copy of the GNU General Public License 
along with Masa CMS. If not, see <http://www.gnu.org/licenses/>. 

The original complete licensing notice from the Mura CMS version of this file is as 
follows: 

This file is part of Mura CMS.

	Mura CMS is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, Version 2 of the License.

	Mura CMS is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

	Linking Mura CMS statically or dynamically with other modules constitutes
	the preparation of a derivative work based on Mura CMS. Thus, the terms
	and conditions of the GNU General Public License version 2 ("GPL") cover
	the entire combined work.

	However, as a special exception, the copyright holders of Mura CMS grant
	you permission to combine Mura CMS with programs or libraries that are
	released under the GNU Lesser General Public License version 2.1.

	In addition, as a special exception, the copyright holders of Mura CMS
	grant you permission to combine Mura CMS with independent software modules
	(plugins, themes and bundles), and to distribute these plugins, themes and
	bundles without Mura CMS under the license of your choice, provided that
	you follow these specific guidelines:

	Your custom code

	• Must not alter any default objects in the Mura CMS database and
	• May not alter the default display of the Mura CMS logo within Mura CMS and
	• Must not alter any files in the following directories:

		/admin/
		/tasks/
		/config/
		/core/mura/
		/Application.cfc
		/index.cfm
		/MuraProxy.cfc

	You may copy and distribute Mura CMS with a plug-in, theme or bundle that
	meets the above guidelines as a combined work under the terms of GPL for
	Mura CMS, provided that you include the source code of that other code when
	and as the GNU GPL requires distribution of source code.

	For clarity, if you create a modified version of Mura CMS, you are not
	obligated to grant this special exception for your modified version; it is
	your choice whether to do so, or to make such modified version available
	under the GNU General Public License version 2 without this exception.  You
	may, if you choose, apply this exception to your own modified versions of
	Mura CMS.
--->
<cfset local = {} />
<cfset variables.fbManager = $.getBean('formBuilderManager') />

<cfset pageIndex = $.event('pageindex') />

<cfparam name="arguments.isNested" default="false">
<cfparam name="arguments.prefix" default="">

<cfif not isNumeric( pageIndex )>
	<cfset pageIndex = 1 />
</cfif>

<cfset local.frmID		= "frm" & replace(arguments.formID,"-","","ALL") />
<cfset local.frmID		= "frm" & replace(arguments.formID,"-","","ALL") />

<cfset local.prefix		= "" />

<cfif arguments.isNested>
	<cfset local.nestedForm		= $.getBean('content').loadBy( contentID=arguments.formid,siteid=session.siteid ) />
	<cfset arguments.formJSON	= local.nestedForm.getBody() />
	<cfset local.frm			= variables.fbManager.renderFormJSON( arguments.formJSON ) />
	<cfset local.prefix			= arguments.prefix />
<cfelse>
	<cfset local.frm			= variables.fbManager.renderFormJSON( arguments.formJSON ) />
</cfif>

<cfif len(local.prefix)>
	<cfset local.prefix = local.prefix & "_">
</cfif>

<cfset local.frmForm		= local.frm.form />
<cfset local.frmData		= local.frm.datasets />
<cfif not structKeyExists(local.frm.form,"formattributes")>
	<cfset local.frm.form.formattributes = structNew() />
</cfif>
<cfif not structKeyExists(local.frm.form.formattributes,"class")>
	<cfset local.frm.form.formattributes.class = "" />
</cfif>
<cfset local.attributes		= local.frm.form.formattributes />
<cfset local.frmFields		= local.frmForm.fields />
<cfset local.dataset		= "" />
<cfset local.isMultipart	= false />

<!--- start with fieldsets closed --->
<cfset request.fieldsetopen = false />

<cfif not StructKeyExists(local.frmForm,"pages")>
	<cfset local.frmForm.pages = ArrayNew(1) />
	<cfset local.frmForm.pages[1] = local.aFieldOrder />
</cfif>

<cfset local.aFieldOrder = local.frmForm.pages[pageIndex] />

<cfset local.frmFieldContents = "" />
<cfset local.pageCount = ArrayLen(local.frmForm.pages) />

<script>

$(function() {
	self = this;
<cfoutput>
	currentpage = #pageIndex#;
	pagecount = #local.pageCount#;
</cfoutput>

	if(Mura.formdata == undefined) {
		Mura.formdata = {};
	}

<cfoutput>
	if(Mura.formdata['#arguments.formID#'] == undefined) {
		Mura.formdata['#arguments.formID#'] = {};
	}
</cfoutput>

	leRenderPaging(<cfoutput>'#local.frmID#','#arguments.formID#',currentpage</cfoutput> );

	Mura("#btn-next").click( function() {
		leChangePage( <cfoutput>'#local.frmID#','#arguments.formID#'</cfoutput>,currentpage+1 );
	});

	Mura("#btn-back").click( function() {
		leChangePage( <cfoutput>'#local.frmID#','#arguments.formID#'</cfoutput>,currentpage-1 );
	});

	Mura("#btn-submit").click( function() {
		processFields(<cfoutput>'#local.frmID#','#arguments.formID#'</cfoutput>);
	});

});

	function leChangePage( formDiv,formid,pageIndex ) {
		var multi = {};
		var formdata = Mura.formdata[formid];
		var forminputs = {};

		$("#"+formDiv+" :input").each( function() {

			if( $(this).is(':checkbox') ) {
				if ( multi[$(this).attr('name')] == undefined  || forminputs[$(this).attr('name')] == undefined ) {
					multi[$(this).attr('name')] = [];
					delete formdata[$(this).attr('name')];
					forminputs[$(this).attr('name')] = true;
				}

				if( $(this).is(':checked') ) {
					multi[$(this).attr('name')].push( $(this).val() );
				}
			}
			else if( $(this).is(':radio')) {
				if($(this).is(':checked') )
					formdata[ $(this).attr('name') ] = $(this).val();
			}
			else {
				if( $(this).attr('name') != 'linkservid' )
					formdata[ $(this).attr('name') ] = $(this).val();
			}

		});

		for(var i in multi) {
			console.log('go');
			console.log(multi[i]);
			formdata[ i ] = multi[ i ].join(',');
		}

		Mura.formdata[formid] = formdata;

		Mura( "[data-objectid='" + formid +  "']" ).attr('data-pageIndex',pageIndex);
		Mura.processObject( Mura( "[data-objectid='" + formid +  "']" ) );
	}

	function leRenderPaging(formDiv,formid,pageIndex) {
		self = this;
		var formdata = Mura.formdata[formid];

		Mura("#" + formDiv + " #btn-next").hide();
		Mura("#" + formDiv + " #btn-back").hide();
		Mura("#" + formDiv + " #btn-submit").hide();

		if(self.pagecount == 1) {
			self.pagecount("#" + formDiv + " #btn-next").hide();
			Mura("#" + formDiv + " #btn-back").hide();
			Mura("#" + formDiv + " #btn-submit").show();
		}
		else {
			if(self.pagecount == 1) {
				Mura("#" + formDiv + " #btn-next").show();
			} else {

				if (pageIndex > 1) {
					Mura("#" + formDiv + " #btn-back").show();
				}

				if(pageIndex < self.pagecount) {
					Mura("#" + formDiv + " #btn-next").show();
				}
				else {
					Mura("#" + formDiv + " #btn-submit").show();
				}
			}
		}

		$("#"+formDiv+" :input").each( function() {

			if( formdata[ $(this).attr('name') ] != undefined) {
				if ($(this).is(':checkbox') && formdata[$(this).attr('name')].indexOf($(this).val()) > -1) {
					$(this).prop('checked', 'checked');
				}
				else if ( $(this).is(':radio') && $(this).val() == formdata[$(this).attr('name')]) {
					$(this).prop('checked', 'checked');
				}
				else if (!$(this).is(':checkbox') && !$(this).is(':radio')){
					$(this).val(formdata[$(this).attr('name')]);
				}
			}
		});
	}

	function processFields(formDiv,formid) {

		var formdata = Mura.formdata[formid];
		console.log('go');

		$("#"+formDiv).submit();
	}


</script>

<cfsavecontent variable="frmFieldContents">
<cfoutput>

<cfloop from="1" to="#ArrayLen(local.aFieldOrder)#" index="iix">
	<cfif StructKeyExists(local.frmFields,local.aFieldOrder[iix])>
		<cfset local.field = local.frmFields[local.aFieldOrder[iix]] />
		<!---<cfif iiX eq 1 and field.fieldtype.fieldtype neq "section">
			<ol>
		</cfif>--->
		<cfif local.field.fieldtype.isdata eq 1 and len(local.field.datasetid)>
			<cfset local.dataset = variables.fbManager.processDataset( variables.$,local.frmData[local.field.datasetid] ) />
		</cfif>
		<cfif local.field.fieldtype.fieldtype eq "file">
			<cfset local.isMultipart = true />
		</cfif>
		<cfif local.field.fieldtype.fieldtype eq "hidden">
		#variables.$.dspObject_Include(thefile='/formbuilder/fields/dsp_#local.field.fieldtype.fieldtype#.cfm',
			field=local.field,
			dataset=local.dataset,
			prefix=local.prefix,
			objectparams=objectparams
			)#
		<cfelseif local.field.fieldtype.fieldtype neq "section">
			<div class="mura-form-#local.field.fieldtype.fieldtype#<cfif local.field.isrequired> req</cfif> #this.formBuilderFieldWrapperClass#<cfif structKeyExists(local.field,'wrappercssclass')> #local.field.wrappercssclass#</cfif>">
			#variables.$.dspObject_Include(thefile='/formbuilder/fields/dsp_#local.field.fieldtype.fieldtype#.cfm',
				field=local.field,
				dataset=local.dataset,
				prefix=local.prefix,
			objectparams=objectparams
				)#
			</div>
		<cfelseif local.field.fieldtype.fieldtype eq "section">
			<!---<cfif iiX neq 1>
				</ol>
			</cfif>--->
			#variables.$.dspObject_Include(thefile='/formbuilder/fields/dsp_#local.field.fieldtype.fieldtype#.cfm',
				field=local.field,
				dataset=local.dataset,
				prefix=local.prefix,
			objectparams=objectparams
				)#
			<!---<ol>--->
		<cfelse>
		#variables.$.dspObject_Include(thefile='/formbuilder/fields/dsp_#local.field.fieldtype.fieldtype#.cfm',
			field=local.field,
			dataset=local.dataset,
			prefix=local.prefix,
			objectparams=objectparams
			)#
		</cfif>
		<!---#$.dspObject_Include('formbuilder/fields/dsp_#field.fieldtype.fieldtype#.cfm')#--->
	<cfelse>
		<!---<cfthrow data-message="ERROR 9000: Field Missing: #aFieldOrder[iiX]#">--->
	</cfif>
</cfloop>

<cfif request.fieldsetopen eq true></fieldset><cfset request.fieldsetopen = false /></cfif>
<!---</ol>--->
</cfoutput>
</cfsavecontent>
<cfset local.frmFieldContents = frmFieldContents />
<cfoutput>
<cfif not arguments.isNested>


<form id="#local.frmID#" onsubmit="return false;" class="<cfif structKeyExists(local.attributes,"class") and len(local.attributes.class)>#local.attributes.class# </cfif>mura-form-builder" method="post"<cfif local.isMultipart>enctype="multipart/form-data"</cfif>>
</cfif>
	#local.frmFieldContents#
<cfif not arguments.isNested>
	<cfif local.pageCount eq pageIndex>
	#variables.$.dspObject_Include(thefile='/form/dsp_form_protect.cfm')#
	</cfif>
	<div class="#this.formBuilderButtonWrapperClass#"><br>
	<button type="button" class="btn" id="btn-next">Next</button>
	<button type="button" class="btn" id="btn-back">Back</button>
	<div class="#this.formBuilderButtonWrapperClass#"><br><button type="button" class="btn" id="btn-submit">#$.rbKey('form.submit')#</button></div>
	</div>
</form>

</cfif>
</cfoutput>
