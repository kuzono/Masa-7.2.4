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
<cfoutput>
<cfif isdefined('rc.contentBean')>
	<cfparam name="stats" default="#rc.contentBean.getStats()#">
	<cfset isLocked=$.siteConfig('hasLockableNodes') and len(stats.getLockID()) and stats.getLockType() eq 'node'>
	<cfset isLockedBySomeoneElse=isLocked and stats.getLockID() neq session.mura.userid>
</cfif>

<cfset rc.originalfuseaction=listLast(request.action,".")>
<cfset rc.originalcircuit=listFirst(listLast(request.action,":"),".")>
<div class="nav-module-specific btn-group">
	<cfif rc.compactDisplay eq 'true' and not rc.$.useLayoutManager()>
		<a class="btn" onclick="history.go(-1);"><i class="mi-arrow-circle-left"></i>  #application.rbFactory.getKeyValue(session.rb,'collections.back')#</a>
	</cfif>

	<cfswitch expression="#rc.moduleid#">
		<cfcase value="00000000000000000000000000000000003,00000000000000000000000000000000004,00000000000000000000000000000000099">
			<cfswitch expression="#rc.originalfuseaction#">
				<cfcase value="list">
					<cfif rc.perm neq 'none'>
						<cfif rc.moduleid eq "00000000000000000000000000000000003">
							<a class="btn" href="./?muraAction=cArch.edit&type=Component&contentid=&topid=#esapiEncode('url',rc.topid)#&parentid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#"><i class="mi-plus-circle"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.addcomponent')#</a>
						<cfelseif rc.moduleid neq "00000000000000000000000000000000099">
							<a class="btn" href="./?muraAction=cArch.edit&type=Form&contentid=&topid=#esapiEncode('url',rc.topid)#&parentid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&formType=builder"><i class="mi-plus-circle"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.addformwithbuilder')#</a>
							<cfif application.configBean.getValue('allowSimpleHTMLForms')>
							<a class="btn" href="./?muraAction=cArch.edit&type=Form&contentid=&topid=#esapiEncode('url',rc.topid)#&parentid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&formType=editor"><i class="mi-plus-circle"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.addformwitheditor')#</a>
							</cfif>
						</cfif>
						<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
							<a class="btn <cfif rc.originalfuseaction eq "main"> active</cfif>" href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.moduleid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> Permissions</a>
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="datamanager">
				<a class="btn" href="./?muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&topid=#esapiEncode('url',rc.moduleid)#&parentid=#esapiEncode('url',rc.moduleid)#&moduleid=#esapiEncode('url',rc.moduleid)#"><i class="mi-arrow-circle-left"></i>
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtoforms')#
					</a>
				<a class="btn" href="./?muraAction=cArch.hist&contentid=#esapiEncode('url',rc.contentid)#&type=Form&parentid=00000000000000000000000000000000004&topid=00000000000000000000000000000000004&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=00000000000000000000000000000000004"><i class="mi-history"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.versionhistory')#</a>
				<cfif rc.action neq ''>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.managedate')#" href="./?muraAction=cArch.datamanager&contentid=#esapiEncode('url',rc.contentid)#&type=Form&topid=00000000000000000000000000000000004&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004"><i class="mi-wrench"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.managedata')#</a>
				</cfif>
				<cfif rc.perm eq 'editor' and not isLockedBySomeoneElse>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.editdisplay')#" href="./?muraAction=cArch.datamanager&contentid=#esapiEncode('url',rc.contentid)#&type=Form&action=display&topid=00000000000000000000000000000000004&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004"><i class="mi-pencil"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.editdisplay')#</a>
				<a class="btn" title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.delete')#" href="./?muraAction=cArch.update&contentid=#esapiEncode('url',rc.contentid)#&type=Form&action=deleteall&topid=00000000000000000000000000000000004&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000004&parentid=00000000000000000000000000000000004#rc.$.renderCSRFTokens(context=rc.contentid & 'deleteall',format='url')#" onClick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deleteformconfirm'))#',this.href)"><i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deleteform')#</a>
				</cfif>
				<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
					<a class="btn" href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.contentid)#&type=Form&parentid=00000000000000000000000000000000004&topid=00000000000000000000000000000000004&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000004&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.permissions')#</a>
				</cfif>
			</cfcase>
				<cfcase value="edit,update">
					<cfset started=false>
					<cfif rc.compactDisplay neq 'true'>
					<cfset started=true>
					<a class="btn" href="./?muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&topid=#esapiEncode('url',rc.moduleid)#&parentid=#esapiEncode('url',rc.moduleid)#&moduleid=#esapiEncode('url',rc.moduleid)#"><i class="mi-arrow-circle-left"></i>
					<cfif rc.moduleid eq "00000000000000000000000000000000003">
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocomponents')#
					<cfelseif rc.moduleid eq "00000000000000000000000000000000099">
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtovariations')#
					<cfelse>
						#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtoforms')#
					</cfif>
					</a>
					</cfif>
					<cfif rc.contentBean.exists()>
						<cfswitch expression="#rc.type#">
						<cfcase value="Form">
							<cfif listFind(session.mura.memberships,'S2IsPrivate')>
							<cfset started=true>
							<a class="btn" href="./?muraAction=cArch.datamanager&contentid=#esapiEncode('url',rc.contentid)#&siteid=#esapiEncode('url',rc.siteid)#&topid=#esapiEncode('url',rc.topid)#&moduleid=#esapiEncode('url',rc.moduleid)#&type=Form&parentid=#esapiEncode('url',rc.moduleid)#"><i class="mi-wrench"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.managedata")#</a></li>
							</cfif>
						</cfcase>
						</cfswitch>
						<cfif rc.contentBean.exists()>
						<cfif started>
						<div class="btn-group">
						</cfif>
							  <a class="btn dropdown-toggle" data-toggle="dropdown" href="##">
							    <i class="mi-cogs"></i> Actions
							    <span class="caret"></span>
							  </a>
					 	 <ul class="dropdown-menu">
					 	 <cfif rc.type eq 'Variation'>
					 	 	<li><a  onclick="return preview('#rc.contentBean.getRemoteURL()#?previewid=#rc.contentBean.getContentHistID()#');" href="##"><i class="mi-eye"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewversion")#</a></li>
					 	 </cfif>
						 <li><a href="./?muraAction=cArch.hist&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)#"><i class="mi-history"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#</a></li>
						<li><a href="./?muraAction=cArch.audit&contentid=#esapiEncode('url',rc.contentid)#&contenthistid=#rc.contentBean.getContentHistID()#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)#"><i class="mi-sitemap"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.audittrail")#</a></li>
						<cfif rc.compactDisplay neq 'true' and rc.contentBean.getactive()lt 1 and (rc.perm neq 'none' and application.configBean.getPurgeDrafts() or $.currentUser().isSuperUser() or $.currentUser().isAdminUser()) and not isLockedBySomeoneElse>
							<li><a href="./?muraAction=cArch.update&contenthistid=#esapiEncode('url',rc.contenthistid)#&action=delete&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&return=#esapiEncode('url',rc.return)##rc.$.renderCSRFTokens(context=rc.contenthistid & 'delete',format='url')#" onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversionconfirm"))#',this.href)"><i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversion")#</a></li>
						</cfif>
						<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
							<li><a href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a></li>
						</cfif>
						<cfif rc.deletable and not isLockedBySomeoneElse>
							<li><a href="./?muraAction=cArch.update&action=deleteall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)##rc.$.renderCSRFTokens(context=rc.contentid & 'deleteall',format='url')#"
							<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>><i class="mi-trash"></i>  #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#</a></li>
						</cfif>
						<cfif rc.contentBean.get('type') eq 'Form' and !rc.contentBean.get('isNew')>
							<li><a href="./?muraAction=cForm.export&contentid=#esapiEncode('url',rc.contentid)#"><i class="mi-save"></i>  #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.exportnode"))#</a></li>
							<li><a href="./?muraAction=cForm.importform"><i class="mi-upload"></i>  #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.importnode"))#</a></li>
						</cfif>
						<cfif rc.contentBean.get('type') eq 'Component' and !rc.contentBean.get('isNew')>
							<li><a href="./?muraAction=cArch.exportcomponent&contentid=#esapiEncode('url',rc.contentid)#"><i class="mi-save"></i>  #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.exportnode"))#</a></li>
							<li><a href="./?muraAction=cArch.importcomponent"><i class="mi-upload"></i>  #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.importnode"))#</a></li>
						</cfif>
						</ul>
						<cfif started>
						</div>
						</cfif>

						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="hist,audit">
					<a class="btn" href="./?muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&topid=#esapiEncode('url',rc.moduleid)#&parentid=#esapiEncode('url',rc.moduleid)#&moduleid=#esapiEncode('url',rc.moduleid)#"><i class="mi-arrow-circle-left"></i>
						<cfif rc.moduleid eq "00000000000000000000000000000000003">
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocomponents')#
						<cfelseif rc.moduleid eq "00000000000000000000000000000000099">
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtovariations')#
						<cfelse>
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtoforms')#
						</cfif>
					</a>
					<cfif rc.contentBean.exists()>
					<div class="btn-group">
						  <a class="btn dropdown-toggle" data-toggle="dropdown" href="##">
							<i class="mi-cogs"></i> Actions
							<span class="caret"></span>
						  </a>
					  <ul class="dropdown-menu drop-right">


					<cfswitch expression="#rc.type#">
					<cfcase value="Form">
						<cfif listFind(session.mura.memberships,'S2IsPrivate')>
						<li><a href="./?muraAction=cArch.datamanager&contentid=#esapiEncode('url',rc.contentid)#&siteid=#esapiEncode('url',rc.siteid)#&topid=#esapiEncode('url',rc.topid)#&moduleid=#esapiEncode('url',rc.moduleid)#&type=Form&parentid=#esapiEncode('url',rc.moduleid)#"><i class="mi-wrench"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.managedata")#</a></li>
						</cfif>
					</cfcase>
					</cfswitch>
					<cfif rc.originalfuseaction eq 'hist'>
						<!--- Clear Version History --->
						<cfif (rc.perm neq 'none' and application.configBean.getPurgeDrafts() or (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))) and not isLockedBySomeoneElse>
							<li>
								<a href="./?muraAction=cArch.update&action=deletehistall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)##rc.$.renderCSRFTokens(context=rc.contentid & 'deletehistall',format='url')#" onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistoryconfirm'))#',this.href)">
									<i class="mi-eraser"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistory')#
								</a>
							</li>
						</cfif>
						<!--- /Clear Version History --->
					<cfelse>
						<li><a href="./?muraAction=cArch.hist&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)#"><i class="mi-history"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#</a></li>
					</cfif>
					<cfif rc.deletable and not isLockedBySomeoneElse>
						<li>
							<a href="./?muraAction=cArch.update&action=deleteall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)##rc.$.renderCSRFTokens(context=rc.contentid & 'deleteall',format='url')#"
								<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>>
								<i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#
							</a>
						</li>
					</cfif>
					<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
						<li><a href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a></li>
					</cfif>
					</ul>
					</div>
					</cfif>
				</cfcase>
			</cfswitch>
		</cfcase>
	<cfdefaultcase>
		<cfswitch expression="#rc.originalfuseaction#">
			<cfcase value="edit,update">
<!--- 				<a class="btn" href="./?muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000000"><i class="mi-arrow-circle-left"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#</a>
 --->
				<cfif rc.contentid neq "">
				<div class="btn-group">
					  <a class="btn dropdown-toggle" data-toggle="dropdown" href="##">
					    <i class="mi-cogs"></i> Actions
					    <span class="caret"></span>
					  </a>
					  <ul class="dropdown-menu drop-right">
				<cfif (rc.contentBean.getfilename() neq '' or rc.contentid eq '00000000000000000000000000000000001')>
					<cfswitch expression="#rc.type#">
					<cfcase value="Page,Folder,Calendar,Gallery,Link">
						<li><a href="##" onclick="return preview('#rc.contentBean.getURL(secure=rc.$.getBean('utility').isHTTPs(),complete=1,queryString="previewid=#rc.contentBean.getContentHistID()#")#');"><i class="mi-eye"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewversion")#</a></li>
					</cfcase>
					<cfcase value="File">
						<li><a href="##" href="##" onclick="return preview('#application.settingsManager.getSite(rc.siteid).getResourcePath(complete=1)#/index.cfm/_api/render/file/?fileID=#rc.contentBean.getFileID()#');"><i class="mi-eye"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.viewversion")#</a></li>
					</cfcase>
					</cfswitch>
				</cfif>

				<!--- Version History --->
				<li>
					<a href="./?muraAction=cArch.hist&amp;contentid=#esapiEncode('url',rc.contentid)#&amp;type=#esapiEncode('url',rc.type)#&amp;parentid=#esapiEncode('url',rc.parentid)#&amp;topid=#esapiEncode('url',rc.topid)#&amp;siteid=#esapiEncode('url',rc.siteid)#&amp;startrow=#esapiEncode('url',rc.startrow)#&amp;moduleid=#esapiEncode('url',rc.moduleid)#&amp;compactDisplay=#esapiEncode('url',rc.compactdisplay)#">
						<i class="mi-history"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#
					</a>
				</li>

				<!--- Audit Trail --->
				<li>
					<a href="./?muraAction=cArch.audit&amp;contentid=#esapiEncode('url',rc.contentid)#&amp;contenthistid=#rc.contentBean.getContentHistID()#&amp;type=#esapiEncode('url',rc.type)#&amp;parentid=#esapiEncode('url',rc.parentid)#&amp;topid=#esapiEncode('url',rc.topid)#&amp;siteid=#esapiEncode('url',rc.siteid)#&amp;startrow=#esapiEncode('url',rc.startrow)#&amp;moduleid=#esapiEncode('url',rc.moduleid)#&amp;compactDisplay=#esapiEncode('url',rc.compactdisplay)#">
						<i class="mi-sitemap"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.audittrail")#
					</a>
				</li>

				<!--- Export Node --->
				<li>
					<a href="?muraAction=cArch.export&amp;siteid=#esapiEncode('url',rc.siteid)#&amp;contentid=#esapiEncode('url',rc.contentid)#">
						<i class="mi-sign-out"></i> #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.exportnode"))#
					</a>
				</li>

				<!--- Import Node --->
				<li>
					<a href="?muraAction=cArch.import&amp;contentid=#esapiEncode('url',rc.contentid)#&amp;moduleid=#esapiEncode('url',rc.moduleid)#&amp;siteid=#esapiEncode('url',rc.siteid)#">
						<i class="mi-sign-in"></i> #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.importnode"))#
					</a>
				</li>

				<cfif rc.compactDisplay neq 'true' and rc.contentBean.getactive()lt 1 and (rc.perm neq 'none') and not isLockedBySomeoneElse>
					<li><a href="./?muraAction=cArch.update&contenthistid=#esapiEncode('url',rc.contenthistid)#&action=delete&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&return=#rc.return##rc.$.renderCSRFTokens(context=rc.contenthistid & 'delete',format='url')#" onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversionconfirm"))#',this.href)"><i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deleteversion")#</a></li>
				</cfif>

				<cfif (listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2'))>
					<li><a href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.contentid)#&type=#rc.contentBean.gettype()#&parentid=#rc.contentBean.getparentID()#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.permissions")#</a></li>
				</cfif>
				<cfif rc.deletable and not isLockedBySomeoneElse>
					<li><a href="./?muraAction=cArch.update&action=deleteall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)##rc.$.renderCSRFTokens(context=rc.contentid & 'deleteall',format='url')#"
					<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType())>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontentconfirm"))#',this.href)"</cfif>><i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.deletecontent")#</a></li>
				</cfif>
				</ul>
				</div>


			</cfif>

			</cfcase>
			<cfcase value="hist,audit">

				<a class="btn" href="./?muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000000"><i class="mi-arrow-circle-left"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#</a>
				<cfif rc.contentBean.exists()>
				<div class="btn-group">
					  <a class="btn dropdown-toggle" data-toggle="dropdown" href="##">
						<i class="mi-cogs"></i> Actions
						<span class="caret"></span>
					  </a>
				  <ul class="dropdown-menu drop-right">
				<cfif rc.originalfuseaction eq 'hist'>
					<!--- Clear Version History --->
					<cfif rc.perm neq 'none' and not isLockedBySomeoneElse>
						<li>
							<a href="./?muraAction=cArch.update&action=deletehistall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)##rc.$.renderCSRFTokens(context=rc.contentid & 'deletehistall',format='url')#" onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistoryconfirm'))#',this.href)">
								<i class="mi-eraser"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.clearversionhistory')#
							</a>
						</li>
					</cfif>
					<!--- /Clear Version History --->
				<cfelse>
					<li><a href="./?muraAction=cArch.hist&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)#"><i class="mi-history"></i> #application.rbFactory.getKeyValue(session.rb,"sitemanager.content.versionhistory")#</a></li>
				</cfif>
				<cfif rc.deletable and rc.compactDisplay neq 'true' and not isLockedBySomeoneElse>
					<li><a href="./?muraAction=cArch.update&action=deleteall&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&startrow=#esapiEncode('url',rc.startrow)#&moduleid=#esapiEncode('url',rc.moduleid)#&compactDisplay=#esapiEncode('url',rc.compactdisplay)##rc.$.renderCSRFTokens(context=rc.contentid & 'deleteall',format='url')#"
						<cfif listFindNoCase(nodeLevelList,rc.contentBean.getType()) >onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentrecursiveconfirm'),rc.contentBean.getMenutitle()))#',this.href)"<cfelse>onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontentconfirm'))#',this.href)"</cfif> ><i class="mi-trash"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.deletecontent')#</a></li>
				</cfif>
				<cfif listFind(session.mura.memberships,'Admin;#application.settingsManager.getSite(rc.siteid).getPrivateUserPoolID()#;0') or listFind(session.mura.memberships,'S2')>
					<li><a href="./?muraAction=cPerm.main&contentid=#esapiEncode('url',rc.contentid)#&type=#esapiEncode('url',rc.type)#&parentid=#esapiEncode('url',rc.parentid)#&topid=#esapiEncode('url',rc.topid)#&siteid=#esapiEncode('url',rc.siteid)#&moduleid=#esapiEncode('url',rc.moduleid)#&startrow=#esapiEncode('url',rc.startrow)#"><i class="mi-group"></i> #application.rbFactory.getKeyValue(session.rb,'sitemanager.content.permissions')#</a></li>
				</cfif>
				</ul>
				</div>
				</cfif>
			</cfcase>
			<cfcase value="imagedetails,multiFileUpload">
				<cfif isdefined('rc.contentBean')>
					<cfif rc.compactdisplay neq 'true'>
						<!--- Back to Content --->
						<a class="btn" href="#rc.contentBean.getEditURL(compactDisplay=rc.compactDisplay)#">
							<i class="mi-arrow-circle-left"></i>
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtocontent')#
						</a>
						<!--- Back To Site Manager --->
						<cfif listFindNoCase(session.mura.memberships,'S2IsPrivate;#rc.siteid#') or listFindNoCase(session.mura.memberships,'S2')>
							<a class="btn" href="./?&muraAction=cArch.list&siteid=#esapiEncode('url',rc.siteid)#&moduleid=00000000000000000000000000000000000">
								<i class="mi-list-alt"></i>
								#application.rbFactory.getKeyValue(session.rb,'sitemanager.backtositemanager')#
							</a>
						</cfif>
					<cfelse>
						<!--- View Content --->
						<cfscript>
							viewContentURL = StructKeyExists(rc, 'homeid') && Len(rc.homeid)
								? application.contentManager.getActiveContent(rc.homeid, rc.siteid).getURL()
								: rc.contentBean.getURL();
						</cfscript>
						<a class="btn" href="##" onclick="frontEndProxy.post({cmd:'setLocation',location:'#esapiEncode('javascript', viewContentURL)#'}); return false;">
							<i class="mi-globe"></i>
							#application.rbFactory.getKeyValue(session.rb,'sitemanager.viewcontent')#
						</a>
					</cfif>
				<cfelseif rc.compactDisplay eq 'false'>
					<!--- Back --->
					<a class="btn" href="##" title="#esapiEncode('html_attr',application.rbFactory.getKeyValue(session.rb,'sitemanager.back'))#" onclick="window.history.back(); return false;"><i class="mi-arrow-circle-left"></i> #esapiEncode('html',application.rbFactory.getKeyValue(session.rb,'sitemanager.back'))#</a>
				</cfif>
			</cfcase>
		</cfswitch>
	</cfdefaultcase>
	</cfswitch>
	<cfif isDefined('rc.contentBean')>
		<cfif not listFindNoCase("Form,Component",rc.contentBean.getType())>
		#$.renderEvent('onContentSecondaryNavRender')#
			#$.renderEvent('onBase#rc.contentBean.getSubType()#SecondaryNavRender')#
		</cfif>
		#$.renderEvent('on#rc.contentBean.getType()#SecondaryNavRender')#
		#$.renderEvent('on#rc.contentBean.getType()##rc.contentBean.getSubType()#SecondaryNavRender')#
	</cfif>
</div>
</cfoutput>
