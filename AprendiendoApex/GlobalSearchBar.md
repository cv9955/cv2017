# Global Search Bar
Agrega TextBox en el menu superior, (preparado para agregar mas de uno)

#### reemplazar **VALOR** por tipo de busqueda

## 1 - Create a placeholder navigation bar entry
Go to your Application --> Shared Components --> Navigation Bar list --> "Desktop Navigation Bar"
Crear un nuevo **List Entry** 

```
Sequence: 1
Image/Class: fa-cube navbar-**VALOR**
List Entry Label: &nbsp;
Target type: URL
URL Target: javascript:document.getElementById('P0_SEARCH-**VALOR**').focus();
```

## 2 - Create a region and text item on global page (page 0) 
Go to your global page (usually page 0) and create a new region and a text field. Choose a position there other regions are not disrupted...
```
Region:
Position: Footer
Title: Global Search
Template: Blank with Attributes

Item:
Position: Item position of region
Name: P0_SEARCH_**VALOR**
Type: Text Field
Submit when Enter pressed: Yes
(Label) Template: Hidden
Width: 10 characters
(Advanced) CSS Classes: navbar-search
```

## 3 - Subir Archivo [GlobalSearchBar.js](GlobalSearchBar.js) (moving the item to navbar and adding some nice animations)
Shared Components --> Static Application Files --> Upload File
Code:
```javascript
// move element to navbar
function moveItem2Navbar(pItem) {
  var element = $('#P0_SEARCH_' + pItem).detach();
  $('.navbar-' + pItem).append(element);
}

// fade out animation
function fadeOutItem(pItem, pWidth, pTime) {
  $('#P0_SEARCH_' + pItem).animate({
    width: pWidth,
    backgroundColor: "#fff",
    color: "#000"
  }, pTime);
}

// fade in animation
function fadeInItem(pItem, pWidth, pTime) {
  $('#P0_SEARCH_' + pItem).animate({
    width: pWidth,
    backgroundColor: "transparent",
    color: "#fff"
  }, pTime);
}

// set inititial attributes
function initSearchItem(pItem,pText) {
	moveItem2Navbar(pItem);
	$s('P0_SEARCH_' + pItem, pText);

	// on focus fade out
	$('#P0_SEARCH_'+ pItem).focus(function() {
		$s('P0_SEARCH_' + pItem, '');
		fadeOutItem(pItem, 80, 300);
	});

	// on focosout fade in
	$('#P0_SEARCH_' + pItem).focusout(function() {
		$s('P0_SEARCH_' + pItem , pText);
		fadeInItem(pItem , 50, 300);
	});
}
```
## 4 - Hacer Referencia Global al archivo 
Shared Components --> User Interfaces --> Edit Desktop
```
(JavaScript) File URLs: #APP_IMAGES#js/GlobalSearchBar.js
```

## 5 - Create a "onload" DA on global page 
Go to your global page (usually page 0) and create a new Dynamic Action (page load) using the code below:
```
Name: globalSearch
Event: Page Load
True Action: Execute JavaScript
Fire On Page Load: Yes
```

Code:
```javascript
initSearchItem('**VALOR**','Etiqueta');
```

## 6 - Add some CSS to UT theme roller
Run your application and open UT Theme Roller from developer bar. Under Custom CSS part add this:

```
.navbar-search {
  width: 50px;
  height: 25px;
  border-width: 0px;
  border-radius: 3px !important;
  background-color: transparent;
  color: #fff;
  outline-width: 0;
  margin-top: -6px;
  margin-bottom: -4px;
  margin-left: 5px;
}
.t-Header-navBar {
  margin-bottom: -5px;
}
.t-NavigationBar {
  margin-bottom: 5px;
}
```

## 7 - Create a application process for redirecting to other pages (global page branch)
Go to Your Application --> Shared Components --> Application Processes --> Create

```
Name: GLOBAL_SEARCH_PAGE_BRANCH
Process Point: On Submit: After Page Submissions - Before Computations and Validations
Type: PL/SQL Anonymous Block
Condition Type: Request = Expression 1
Expression 1: P0_SEARCH_**VALOR**
```

Code:
```language-sql
DECLARE
  l_url VARCHAR2(1000);
  --
BEGIN
  -- url
  l_url := apex_page.get_url(p_application => :app_id,
                             p_page        => '100', -- your search result page
                             p_clear_cache => '100', -- clear cache search result page
                             p_items       => 'P100_ID', -- target page search item
                             p_values      => REPLACE(:p0_search_**VALOR**,
                                                      ',',
                                                      '')); -- our page 0 search item without comma
  htp.init;
  -- redirect
  apex_util.redirect_url(l_url);
END;
```


