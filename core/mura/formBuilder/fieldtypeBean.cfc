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
<cfcomponent displayname="fieldtypeBean" output="false"  extends="mura.cfobject" hint="This provides fieldtypeBean functionality">
	<cfproperty name="FieldTypeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Label" type="string" default="" required="true" maxlength="45" />
	<cfproperty name="RbLabel" type="string" default="" maxlength="35" />
	<cfproperty name="Fieldtype" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="Bean" type="string" default="" required="true" maxlength="50" />
	<cfproperty name="IsData" type="boolean" default="0" required="true" />
	<cfproperty name="IsLong" type="boolean" default="0" required="true" />
	<cfproperty name="IsMultiselect" type="boolean" default="0" required="true" />
	<cfproperty name="ModuleID" type="uuid" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="Displaytype" type="string" default="field" required="true" maxlength="25" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" returntype="fieldtypeBean" output="false">

		<cfargument name="FieldTypeID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Label" type="string" required="false" default="" />
		<cfargument name="RbLabel" type="string" required="false" default="" />
		<cfargument name="Fieldtype" type="string" required="false" default="" />
		<cfargument name="Bean" type="string" required="false" default="" />
		<cfargument name="IsData" type="boolean" required="false" default="0" />
		<cfargument name="IsLong" type="boolean" required="false" default="0" />
		<cfargument name="IsMultiselect" type="boolean" required="false" default="0" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="Displaytype" type="string" required="false" default="field" />


		<cfset setFieldTypeID( arguments.FieldTypeID ) />
		<cfset setLabel( arguments.Label ) />
		<cfset setRbLabel( arguments.RbLabel ) />
		<cfset setFieldtype( arguments.Fieldtype ) />
		<cfset setBean( arguments.Bean ) />
		<cfset setIsData( arguments.IsData ) />
		<cfset setIsLong( arguments.IsLong ) />
		<cfset setIsMultiselect( arguments.IsMultiselect ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setDisplaytype( arguments.Displaytype ) />

		<cfreturn this />
	</cffunction>

	<cffunction name="setAllValues" returntype="FieldtypeBean" output="false">
		<cfargument name="values" type="struct" required="yes"/>
		<cfset variables.instance = arguments.values />
		<cfreturn this />
	</cffunction>
	<cffunction name="getAllValues" returntype="struct" output="false">
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setFieldTypeID" output="false">
		<cfargument name="FieldTypeID" type="uuid" required="true" />
		<cfset variables.instance['fieldtypeid'] = arguments.FieldTypeID />
	</cffunction>
	<cffunction name="getFieldTypeID" returntype="uuid" output="false">
		<cfreturn variables.instance.FieldTypeID />
	</cffunction>

	<cffunction name="setLabel" output="false">
		<cfargument name="Label" type="string" required="true" />
		<cfset variables.instance['label'] = arguments.Label />
	</cffunction>
	<cffunction name="getLabel" output="false">
		<cfreturn variables.instance.Label />
	</cffunction>

	<cffunction name="setRbLabel" output="false">
		<cfargument name="RbLabel" type="string" required="true" />
		<cfset variables.instance['rblabel'] = arguments.RbLabel />
	</cffunction>
	<cffunction name="getRbLabel" output="false">
		<cfreturn variables.instance.RbLabel />
	</cffunction>

	<cffunction name="setFieldtype" output="false">
		<cfargument name="Fieldtype" type="string" required="true" />
		<cfset variables.instance['fieldtype'] = arguments.Fieldtype />
	</cffunction>
	<cffunction name="getFieldtype" output="false">
		<cfreturn variables.instance.Fieldtype />
	</cffunction>

	<cffunction name="setBean" output="false">
		<cfargument name="Bean" type="string" required="true" />
		<cfset variables.instance['bean'] = arguments.Bean />
	</cffunction>
	<cffunction name="getBean" output="false">
		<cfreturn variables.instance.Bean />
	</cffunction>

	<cffunction name="setIsData" output="false">
		<cfargument name="IsData" type="boolean" required="true" />
		<cfset variables.instance['isdata'] = arguments.IsData />
	</cffunction>
	<cffunction name="getIsData" returntype="boolean" output="false">
		<cfreturn variables.instance.IsData />
	</cffunction>

	<cffunction name="setIsLong" output="false">
		<cfargument name="IsLong" type="boolean" required="true" />
		<cfset variables.instance['islong'] = arguments.IsLong />
	</cffunction>
	<cffunction name="getIsLong" returntype="boolean" output="false">
		<cfreturn variables.instance.IsLong />
	</cffunction>

	<cffunction name="setIsMultiSelect" output="false">
		<cfargument name="IsMultiSelect" type="boolean" required="true" />
		<cfset variables.instance['IsMultiSelect'] = arguments.IsMultiSelect />
	</cffunction>
	<cffunction name="getIsMultiSelect" returntype="boolean" output="false">
		<cfreturn variables.instance.IsMultiSelect />
	</cffunction>

	<cffunction name="setModuleID" output="false">
		<cfargument name="ModuleID" type="string" required="true" />
		<cfset variables.instance['moduleid'] = arguments.ModuleID />
	</cffunction>
	<cffunction name="getModuleID" output="false">
		<cfreturn variables.instance.ModuleID />
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

	<cffunction name="setDisplaytype" output="false">
		<cfargument name="Displaytype" type="string" required="true" />
		<cfset variables.instance['displaytype'] = arguments.Displaytype />
	</cffunction>
	<cffunction name="getDisplaytype" output="false">
		<cfreturn variables.instance.Displaytype />
	</cffunction>
</cfcomponent>
