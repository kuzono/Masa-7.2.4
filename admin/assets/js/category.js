/* 
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
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
	GNU General Public License for more details. 

	You should have received a copy of the GNU General Public License 
	along with Mura CMS.  If not, see <http://www.gnu.org/licenses/>. 

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
	 /tasks/
	 /config/
	 /core/mura/
	 /Application.cfc
	 /index.cfm
	 /MuraProxy.cfc
	
	You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
	under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
	requires distribution of source code.
	
	For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
	modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
	version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS. */


//  DHTML Menu for Site Summary
var categoryManager = {
	DHTML: (document.getElementById || document.all || document.layers),
	lastid: "",

	getObj: function(name) {
		if(document.getElementById) {
			this.obj = document.getElementById(name);
			this.style = document.getElementById(name).style;
		} else if(document.all) {
			this.obj = document.all[name];
			this.style = document.all[name].style;
		} else if(document.layers) {
			this.obj = document.layers[name];
			this.style = document.layers[name];
		}
	},

	showMenu: function(id, obj, parentid, siteid) {

		if(window.innerHeight) {
			var posTop = window.pageYOffset
		} else if(document.documentElement && document.documentElement.scrollTop) {
			var posTop = document.documentElement.scrollTop
		} else if(document.body) {
			var posTop = document.body.scrollTop
		}

		if(window.innerWidth) {
			var posLeft = window.pageXOffset
		} else if(document.documentElement && document.documentElement.scrollLeft) {
			var posLeft = document.documentElement.scrollLeft
		} else if(document.body) {
			var posLeft = document.body.scrollLeft
		}

		var xPos = this.findPosX(obj);
		var yPos = this.findPosY(obj);

		xPos = xPos - 10;

		document.getElementById(id).style.top = yPos + "px";
		document.getElementById(id).style.left = xPos + "px";
		$('#' + id).removeClass('hide');

		document.getElementById('newCategoryLink').href = './?muraAction=cCategory.edit&parentid=' + parentid + '&siteid=' + siteid;

	// append action links
		var actionLinks = obj.parentNode.parentNode.getElementsByClassName("actions")[0].getElementsByTagName("ul")[0].getElementsByTagName("li");
		var optionList = document.getElementById('newCategoryOptions');
		// remove old links
		var oldLinks = optionList.getElementsByClassName("li-action");
		var l;
		while ((l = oldLinks[0])) {
			l.parentNode.removeChild(l);
		}
		// create new links
		var newPage = document.getElementById('newPage');
	  for (var i = 0; i < actionLinks.length; i++ ) {
        if(actionLinks[i].className.indexOf('disabled') < 0){
	        var item = document.createElement("li");
	        item.innerHTML = actionLinks[i].innerHTML;
	        var link = item.getElementsByTagName("a")[0];
	        var titleStr = link.getAttribute("title");
	        item.className = 'li-action ' + titleStr.toLowerCase();
	        link.removeAttribute("title");
	        link.innerHTML = link.innerHTML + titleStr;
	        if(titleStr.toLowerCase() == 'edit'){
	        	optionList.insertBefore(item, newPage.nextSibling);
	        } else {
        		optionList.appendChild(item);
	        }
        }
    }


		if(this.lastid != "" && this.lastid != id) {
			this.hideMenu(this.lastid);
		}

//		this.navTimer = setTimeout('categoryManager.hideMenu(categoryManager.lastid);', 6000);
		this.lastid = id;
	},

	findPosX: function(obj) {
		var curleft = 0;
		if(obj.offsetParent) {
			while(obj.offsetParent) {
				curleft += obj.offsetLeft
				obj = obj.offsetParent;
			}
		} else if(obj.x) curleft += obj.x;
		return curleft;
	},

	findPosY: function(obj) {
		var curtop = 0;
		if(obj.offsetParent) {
			while(obj.offsetParent) {
				curtop += obj.offsetTop
				obj = obj.offsetParent;
			}
		} else if(obj.y) curtop += obj.y;
		return curtop;
	},


	keepMenu: function(id) {
//		this.navTimer = setTimeout('categoryManager.hideMenu(categoryManager.lastid);', 6000);
		$('#' + id).removeClass('hide');
	},

	hideMenu: function(id) {
//		if(this.navTimer != null) clearTimeout(this.navTimer);
		$('#' + id).addClass('hide');
	}
}