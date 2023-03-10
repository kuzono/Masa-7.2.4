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

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

	/admin/
	/core/
	/Application.cfc
	/index.cfm

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfset tabLabelList=listAppend(tabLabelList,application.rbFactory.getKeyValue(session.rb,"sitemanager.content.tabs.listdisplayoptions"))/>
<cfset tabList=listAppend(tabList,"tabListDisplayOptions")>
<cfoutput>
<div id="tabListDisplayOptions" class="tab-pane">

	<!-- block -->
	<div class="block block-bordered">
		<!-- block header -->
	  <div class="block-header">
			<h3 class="block-title">List Display Options</h3>
	  </div>
	  <!-- /block header -->
		
		<!-- block content -->
		<div class="block-content">

 <span id="extendset-container-tablistdisplayoptionstop" class="extendset-container"></span>

					<div class="mura-control-group">
			      	<label>#application.rbFactory.getKeyValue(session.rb,'collections.imagesize')#</label>
							<select name="imageSize" data-displayobjectparam="imageSize" onchange="if(this.value=='custom'){jQuery('##feedCustomImageOptions').fadeIn('fast')}else{jQuery('##feedCustomImageOptions').hide();jQuery('##feedCustomImageOptions').find(':input').val('AUTO');}">
							<cfloop list="Small,Medium,Large" index="i">
								<option value="#lcase(i)#"<cfif i eq rc.contentBean.getImageSize()> selected</cfif>>#I#</option>
							</cfloop>
					
							<cfset imageSizes=application.settingsManager.getSite(rc.siteid).getCustomImageSizeIterator()>
													
							<cfloop condition="imageSizes.hasNext()">
								<cfset image=imageSizes.next()>
								<option value="#lcase(image.getName())#"<cfif image.getName() eq rc.contentBean.getImageSize()> selected</cfif>>#esapiEncode('html',image.getName())#</option>
							</cfloop>
								<option value="custom"<cfif "custom" eq rc.contentBean.getImageSize()> selected</cfif>>Custom</option>
						</select>
					</div>
			
						<div id="feedCustomImageOptions" class="mura-control-group half"<cfif rc.contentBean.getImageSize() neq "custom"> style="display:none"</cfif>>
						      <label>#application.rbFactory.getKeyValue(session.rb,'collections.imagewidth')#
				      </label>
								<input name="imageWidth" data-displayobjectparam="imageWidth" type="text" value="#rc.contentBean.getImageWidth()#" />
						      <label>#application.rbFactory.getKeyValue(session.rb,'collections.imageheight')#</label>
						      	<input name="imageHeight" data-displayobjectparam="imageHeight" type="text" value="#rc.contentBean.getImageHeight()#" />
						</div>

						<div class="mura-control-group" id="availableFields">
					      	<label>
								<span class="half">Available Fields</span> <span class="half">Selected Fields</span>
					</label>
					
							<div id="sortableFields">
						<p class="dragMsg">
									<span class="dragFrom half">Drag Fields from Here&hellip;</span><span class="half">&hellip;and Drop Them Here.</span>
						</p>							
					
						<cfset displayList=rc.contentBean.getDisplayList()>
						<cfset availableList=rc.contentBean.getAvailableDisplayList()>		
						<ul id="contentAvailableListSort" class="contentDisplayListSortOptions">
							<cfloop list="#availableList#" index="i">
								<li class="ui-state-default">#trim(i)#</li>
							</cfloop>
						</ul>
											
						<ul id="contentDisplayListSort" class="contentDisplayListSortOptions">
							<cfloop list="#displayList#" index="i">
								<li class="ui-state-highlight">#trim(i)#</li>
							</cfloop>
						</ul>
									
						<input type="hidden" id="contentDisplayList" value="#displayList#" name="displayList"/>
						
						<script>
							//Removed from jQuery(document).ready() because it would not fire in ie7 frontend editing.
							siteManager.setContentDisplayListSort();
						</script>
					</div>
			    </div>

						<div class="mura-control-group">
					      <label>#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.recordsperpage')#</label> 
					      <select name="nextN" class="dropdown">
					<cfloop list="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,50,100" index="r">
						<option value="#r#" <cfif r eq rc.contentBean.getNextN()>selected</cfif>>#r#</option>
					</cfloop>
					</select>
				</div>
   

	<span id="extendset-container-listdisplayoptions" class="extendset-container"></span>
	<span id="extendset-container-tablistdisplayoptionsbottom" class="extendset-container"></span>
	 
		</div> <!--- /.block-content --->
	</div> <!--- /.block --->		
</div> <!--- /.tab-pane --->
</cfoutput>