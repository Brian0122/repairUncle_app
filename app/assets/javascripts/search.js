// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
  //enableSelectBoxes();
  var geocoder;
  var map;

  $('div #address a').click(function(){
    var mapString = $(this).attr("href");
    window.open(mapString);
    return false;
    //map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  });

  
  
  $('#test').html($('#test').text())
  
  $(".multiselect").multiselect2side({'search': 'Search: ',
    moveOptions: false,
    autoSort: true,
    autoSortAvailable: true
  });
  //$(".multiselect").multiselect({
  //});
  //initialize();
  //codeAddress('台北市光復南路102號');
  $( "#accordion" ).accordion();
  $('#model').selectbox();
  $('#model').selectbox('disable');  

  $("#make").selectbox({
    onOpen: function (inst) {
        //console.log("open", inst);
    },
    onClose: function (inst) {
        //console.log("close", inst);
    },
    onChange: function (val, inst) {
        var promptStr = '<select name="model_id" id="model"><option>- Select Model -</option></select>';
        var $makeOption = $(this).val();

        if ($makeOption =='') {
            $('#model_span').html(promptStr);
            $('#model').selectbox();
            $('#model').selectbox('disable');
            $('#repairField').val('');
            $('#repairField').attr('disabled',true);
            $('#queryBtn').attr('disabled',true);
        }
        else{
            $('#model').attr('disabled',false);
            $('#repairField').attr('disabled',false);
            $('#queryBtn').attr('disabled',false);
        $.ajax({
            type: "GET",
            url:"/search/queryModelByMakeId",
            data:{'make_id':$(this).val()},
            dataType:"text",
            success: function(responseData){
                $('#model_span').html(responseData);
                $('#model').selectbox();
            }
        });
    }
    },
    effect: "slide"
  });
  
  /*
  $( "#accordion" ).accordion();
  var promptStr = "<option>- Select Model -</option>";
  $('#make').change(function() {
        var $makeOption = $(this).val();
        if ($makeOption =='') {
            $('#model').html(promptStr);
            $('#model').attr('disabled',true);
            $('#repair').val('');
            $('#repair').attr('disabled',true);
            $('#queryBtn').attr('disabled',true);
        }
        else{
            $('#model').attr('disabled',false);
            $('#repair').attr('disabled',false);
            $('#queryBtn').attr('disabled',false);

            $.ajax({
            type:"GET",
            url:"/search/queryModelByMakeId",
            data:{'make_id':$(this).val()},
            dataType:"text",
            success: function(responseData){
                $('#model').html(responseData);
            }
        });
        }
        
  });*/
  
});

function initialize(){
  //geocoder = new google.maps.Geocoder();
  var myOptions = {
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  };
        
  //GEOCODER
  geocoder = new google.maps.Geocoder();
            
}
 
function codeAddress(address) { 
    //var sAddress = "台北市光復南路102號"
    geocoder.geocode( { 'address': address}, function(results, status) { 
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });
        }
        else{
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}
function enableSelectBoxes(){
    $('div.selectBox').each(function(){
        $(this).children('span.selected').html($(this).children('div.selectOptions').children('span.selectOption:first').html());
        $(this).attr('value',$(this).children('div.selectOptions').children('span.selectOption:first').attr('value'));
        $(this).children('span.selected,span.selectArrow').click(function(){
            if($(this).parent().children('div.selectOptions').css('display') == 'none'){
                $(this).parent().children('div.selectOptions').css('display','block');
            }
            else
            {
                $(this).parent().children('div.selectOptions').css('display','none');
            }       
        });
        $(this).find('span.selectOption').click(function(){
            $(this).parent().css('display','none');
            $(this).closest('div.selectBox').attr('value',$(this).attr('value'));
            $(this).parent().siblings('span.selected').html($(this).html());   
        });
    });
}
