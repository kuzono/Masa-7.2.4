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
the preparation of a derivative work based on Mura CMS. Thus, the terms and
conditions of the GNU General Public License version 2 (GPL) cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with programs or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with independent software modules that communicate with Mura CMS solely
through modules packaged as Mura CMS plugins and deployed through the Mura CMS plugin installation API,
provided that these modules (a) may only modify the /plugins/ directory through the Mura CMS
plugin installation API, (b) must not alter any default objects in the Mura CMS database
and (c) must not alter any files in the following directories except in cases where the code contains
a separately distributed license.

/admin/
	/core/
	/Application.cfc
	/index.cfm

You may copy and distribute such a combined work under the terms of GPL for Mura CMS, provided that you include
the source code of that other code when and as the GNU GPL requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception
for your modified version; it is your choice whether to do so, or to make such modified version available under
the GNU General Public License version 2 without this exception. You may, if you choose, apply this exception
to your own modified versions of Mura CMS.
--->
<cfcomponent displayname="DatasetBean" output="false" extends="mura.cfobject" hint="This provides dataSetBean functionality">
	<cfproperty name="DatasetID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ParentID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Name" type="string" default="" maxlength="150" />
	<cfproperty name="SortColumn" type="string" default="orderby" required="true" maxlength="12" />
	<cfproperty name="SortDirection" type="string" default="asc" required="true" maxlength="4" />
	<cfproperty name="SortType" type="string" default="" maxlength="10" />
	<cfproperty name="IsGlobal" type="boolean" default="0" required="true" />
	<cfproperty name="IsSorted" type="boolean" default="0" required="true" />
	<cfproperty name="IsLocked" type="boolean" default="0" required="true" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="SourceType" type="string" default="" maxlength="50" />
	<cfproperty name="Source" type="string" default="" maxlength="250" />
	<cfproperty name="DefaultID" type="string" default="" required="false" maxlength="35" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />

	<cfproperty name="Model" type="Struct" default="" required="true" />
	<cfproperty name="DataRecords" type="Struct" default="" required="true" />
	<cfproperty name="DataRecordOrder" type="Array" default="" required="true" />
	<cfproperty name="IsSortChanged" type="boolean" default="0" required="true" />
	<cfproperty name="DeletedRecords" type="Struct" default="" required="false" />

	<cfset variables.instance 			= StructNew() />
	<cfset variables.DataRecordChecked	= false />

	<!--- INIT --->
	<cffunction name="init" returntype="DatasetBean" output="false">

		<cfargument name="DatasetID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="SortColumn" type="string" required="false" default="orderby" />
		<cfargument name="SortDirection" type="string" required="false" default="asc" />
		<cfargument name="SortType" type="string" required="false" default="" />
		<cfargument name="IsGlobal" type="boolean" required="false" default="0" />
		<cfargument name="IsSorted" type="boolean" required="false" default="0" />
		<cfargument name="IsLocked" type="boolean" required="false" default="0" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="SourceType" type="string" required="false" default="" />
		<cfargument name="Source" type="string" required="false" default="" />
		<cfargument name="DefaultID" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />

		<cfargument name="Model" type="Struct" required="false" default="#StructNew()#" />
		<cfargument name="DataRecords" type="Struct" required="false" default="#StructNew()#" />
		<cfargument name="DataRecordOrder" type="Array" required="false" default="#ArrayNew(1)#" />
		<cfargument name="IsSortChanged" type="boolean" required="false" default="0" />
		<cfargument name="DeletedRecords" type="Struct" required="false" default="#StructNew()#" />

		<cfset super.init( argumentcollection=arguments ) />


		<cfset setDatasetID( arguments.DatasetID ) />
		<cfset setParentID( arguments.ParentID ) />
		<cfset setName( arguments.Name ) />
		<cfset setSortColumn( arguments.SortColumn ) />
		<cfset setSortDirection( arguments.SortDirection ) />
		<cfset setSortType( arguments.SortType ) />
		<cfset setIsGlobal( arguments.IsGlobal ) />
		<cfset setIsSorted( arguments.IsSorted ) />
		<cfset setIsLocked( arguments.IsLocked ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setSourceType( arguments.SourceType ) />
		<cfset setSource( arguments.Source ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />

		<cfset setModel( arguments.Model ) />
		<cfset setDataRecords( arguments.DataRecords ) />
		<cfset setDataRecordOrder( arguments.DataRecordOrder ) />
		<cfset setIsSortChanged( arguments.IsSortChanged ) />
		<cfset setDeletedRecords( arguments.DeletedRecords ) />

		<cfreturn this />
	</cffunction>

	<cffunction name="setAllValues" returntype="DatasetBean" output="false">
		<cfargument name="AllValues" type="struct" required="yes"/>
		<cfset variables.instance = arguments.AllValues />
		<cfreturn this />
	</cffunction>
	<cffunction name="getAllValues" returntype="struct" output="false">
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setDatasetID" output="false">
		<cfargument name="DatasetID" type="uuid" required="true" />
		<cfset variables.instance['datasetid'] = arguments.DatasetID />
	</cffunction>
	<cffunction name="getDatasetID" returntype="uuid" output="false">
		<cfreturn variables.instance.DatasetID />
	</cffunction>

	<cffunction name="setParentID" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance['parentid'] = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>

	<cffunction name="setName" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setSortColumn" output="false">
		<cfargument name="SortColumn" type="string" required="true" />
		<cfset variables.instance['sortcolumn'] = arguments.SortColumn />
	</cffunction>
	<cffunction name="getSortColumn" output="false">
		<cfreturn variables.instance.SortColumn />
	</cffunction>

	<cffunction name="setSortDirection" output="false">
		<cfargument name="SortDirection" type="string" required="true" />
		<cfset variables.instance['sortdirection'] = arguments.SortDirection />
	</cffunction>
	<cffunction name="getSortDirection" output="false">
		<cfreturn variables.instance.SortDirection />
	</cffunction>

	<cffunction name="setSortType" output="false">
		<cfargument name="SortType" type="string" required="true" />
		<cfset variables.instance['sorttype'] = arguments.SortType />
	</cffunction>
	<cffunction name="getSortType" output="false">
		<cfreturn variables.instance.SortType />
	</cffunction>

	<cffunction name="setIsGlobal" output="false">
		<cfargument name="IsGlobal" type="boolean" required="true" />
		<cfset variables.instance['isglobal'] = arguments.IsGlobal />
	</cffunction>
	<cffunction name="getIsGlobal" returntype="boolean" output="false">
		<cfreturn variables.instance.IsGlobal />
	</cffunction>

	<cffunction name="setIsSorted" output="false">
		<cfargument name="IsSorted" type="boolean" required="true" />
		<cfset variables.instance['issorted'] = arguments.IsSorted />
	</cffunction>
	<cffunction name="getIsSorted" returntype="boolean" output="false">
		<cfreturn variables.instance.IsSorted />
	</cffunction>

	<cffunction name="setIsLocked" output="false">
		<cfargument name="IsLocked" type="boolean" required="true" />
		<cfset variables.instance['islocked'] = arguments.IsLocked />
	</cffunction>
	<cffunction name="getIsLocked" returntype="boolean" output="false">
		<cfreturn variables.instance.IsLocked />
	</cffunction>

	<cffunction name="setIsActive" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>

	<cffunction name="setSourceType" output="false">
		<cfargument name="SourceType" type="string" required="true" />
		<cfset variables.instance['sourcetype'] = arguments.SourceType />
	</cffunction>
	<cffunction name="getSourceType" output="false">
		<cfreturn variables.instance.SourceType />
	</cffunction>

	<cffunction name="setSource" output="false">
		<cfargument name="Source" type="string" required="true" />
		<cfset variables.instance['source'] = arguments.Source />
	</cffunction>
	<cffunction name="getSource" output="false">
		<cfreturn variables.instance.Source />
	</cffunction>

	<cffunction name="setDefaultID" output="false">
		<cfargument name="DefaultID" type="string" required="true" />
		<cfset variables.instance['defaultid'] = arguments.DefaultID />
	</cffunction>
	<cffunction name="getDefaultID" output="false">
		<cfreturn variables.instance.DefaultID />
	</cffunction>

	<cffunction name="setSiteID" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>

	<cffunction name="setRemoteID" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>

	<cffunction name="setDateCreate" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>

	<cffunction name="setDateLastUpdate" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>

	<cffunction name="setModel" output="false">
		<cfargument name="Model" type="Struct" required="true" />
		<cfset variables.instance['model'] = arguments.Model />
	</cffunction>
	<cffunction name="getModel" returntype="Struct" output="false">
		<cfreturn variables.instance.Model />
	</cffunction>

	<cffunction name="setDataRecords" output="false">
		<cfargument name="DataRecords" type="struct" required="true" />
		<cfset variables.instance['datarecords'] = arguments.DataRecords />
	</cffunction>
	<cffunction name="getDataRecords" returntype="struct" output="false">
		<cfreturn variables.instance.DataRecords />
	</cffunction>
	<cffunction name="getDataRecord" output="false">
		<cfargument name="DataRecordID" type="struct" required="true" />

		<cfif StructKeyExists( variables.instance.DataRecords,arguments.DataRecordID )>
			<cfreturn variables.instance.DataRecords[arguments.DataRecordID] />
		</cfif>

		<cfreturn false />
	</cffunction>

	<cffunction name="setDataRecordOrder" output="false">
		<cfargument name="DataRecordOrder" type="Array" required="true" />
		<cfset variables.instance['datarecordorder'] = arguments.DataRecordOrder />
	</cffunction>
	<cffunction name="getDataRecordOrder" returntype="Array" output="false">
		<cfreturn variables.instance.DataRecordOrder />
	</cffunction>

	<cffunction name="setIsSortChanged" output="false">
		<cfargument name="IsSortChanged" type="boolean" required="true" />
		<cfset variables.instance['issortchanged'] = arguments.IsSortChanged />
	</cffunction>
	<cffunction name="getIsSortChanged" returntype="boolean" output="false">
		<cfreturn variables.instance.IsSortChanged />
	</cffunction>

	<cffunction name="setDeletedRecords" output="false">
		<cfargument name="DeletedRecords" type="struct" required="true" />
		<cfset variables.instance['deletedrecords'] = arguments.DeletedRecords />
	</cffunction>
	<cffunction name="getDeletedRecords" returntype="struct" output="false">
		<cfreturn variables.instance.DeletedRecords />
	</cffunction>
</cfcomponent>
