let showCadSystem = function(){
    $('#police-cad').show();
    $('#input-plate').focus();
    $("html").show();
    isCadSystemShowed = true;
}

let hideCadSystem = function(){
    $('#police-cad').hide();
    $("html").hide();
    isCadSystemShowed = false;
}

document.addEventListener("DOMContentLoaded", () => {
    $("html").hide();
});

document.onkeydown = function (data) {
    if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
        $.post('http://esx_yisus_tabletpolicia/escape');
    }
};

$(document).on('click','.civ-back', function (ev) {
    $('.civilian-details .inputfield').empty();
    $('.civilian-details').hide(300);
    $('.resultinner').show(300);
});

$(function() {
    window.addEventListener('message', function(event) {

        if (event.data.civilianresults){
            $('.tbody-result-users').remove();
            $('.all-found-users').append($('<tbody class="tbody-result-users">'));
            event.data.civilianresults.forEach(function(user){
                $('.tbody-result-users').append($('<tr>').on('click', function(){
                    showExtraUserData(user);
                })
                    .append($('<td>').text(user['firstname']))
                    .append($('<td>').text(user['lastname']))
                    .append($('<td>').text(user['sex']))
                    .append($('<td>').text(user['dateofbirth'])));
            })
        }

        if (event.data.crresults){
           createTableCr(event.data.crresults);
        }
        /*else {
            $('#criminal-records tbody').html('');
        }*/

        if(event.data.note_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_yisus_tabletpolicia/get-note', playerid );

            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('Nota eliminada.');
            setTimeout(function(){
                noteMessage.empty();
            },2000);


        }
        if(event.data.note_not_deleted){
            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('El borrado de la nota falló.');
            setTimeout(function(){
                noteMessage.empty();
            },2000);
        }

        if(event.data.cr_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_yisus_tabletpolicia/get-cr', playerid );

            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('Registro eliminado.');
            setTimeout(function(){
                crMessage.empty();
            },2000);


        }

        if(event.data.bolo_not_deleted){
            boloMessage = $('.error-bolo');
            boloMessage.empty();
            boloMessage.text('La eliminación solicitada falló.');
            setTimeout(function(){
                boloMessage.empty();
            },2000);
        }

        if(event.data.bolo_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_yisus_tabletpolicia/get-bolos' );
            boloMessage = $('.bolo-message');
            boloMessage.empty();
            boloMessage.text('El búsqueda fue eliminado.');
            setTimeout(function(){
                boloMessage.empty();
            },2000);

        }


        if(event.data.cr_not_deleted){
            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('La eliminación del registro falló.');
            setTimeout(function(){
                crMessage.empty();
            },2000);
        }

        if (event.data.noteResults){
            createNoteTable(event.data.noteResults);
        }

        if (event.data.licenseResults){
            createTableLicense(event.data.licenseResults);
        }

        if (event.data.showBolos){
            createBoloTable(event.data.showBolos);
        }
        else {
            $('.police-cad-bolos tbody').html('');
        }

        if (event.data.plate){
            $('#plate').empty().append(event.data.plate);
            $('#model').empty().append(event.data.model);
            $('#firstname').empty().append(event.data.firstname);
            $('#lastname').empty().append(event.data.lastname);
        }

        if(event.data.showCadSystem === true){
            showCadSystem();
        }

        if(event.data.showCadSystem === false){
            hideCadSystem();
        }

    });

    document.onkeydown = function (data) {
        if ((data.which == 13)){
            searchPlate();
        }

        if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
            $.post('http://esx_yisus_tabletpolicia/escape');
            hideCadSystem();
        }
    };

    $(document).on('click','#search-for-plate',function(event){
        searchPlate();
    });

    $(document).on('click','.police-cad-close',function(event){
        $.post('http://esx_yisus_tabletpolicia/escape');
        hideCadSystem();
    });

    $(document).on('click','.civ-back', function (ev) {
        $('.resultinner').show(300);
    });

    $(document).on('click','.add-cr', function (ev) {
        $('.modal-add-record').show(300);
        $(".modal-add-note").hide(400);
    });

    $(document).on('click','.add-bolo', function (ev) {
        $('.modal-add-bolos').show(300);
    });

    $(document).on('click','#save-criminal-record', function (ev) {
        if($('#cr-reason').val().length > 2){
            addCR();
            $('.modal-add-record').hide(400);

            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_yisus_tabletpolicia/get-cr', playerid );
        }else{
            $('.error-cr').text('Please fill in the fields');
        }
    });

    $(document).on('click','.add-note', function (ev) {
        $('.modal-add-note').show(300);
        ($('#note-title').val(''));
        ($('#note-content').val(''));
        $(".modal-add-record").hide(400);
    });


    $(document).on('click','.delete_note' ,function () {
        note = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_yisus_tabletpolicia/delete_note', note);
    });

    $(document).on('click','.delete_cr' ,function () {
        cr = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_yisus_tabletpolicia/delete_cr', cr);
    });


    $(document).on('click','#save-note', function (ev) {
        if($('#note-title').val().length > 1 && $('#note-content').val().length > 1){
            addNote();
            $('.modal-add-note').hide(400);
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            $.post('http://esx_yisus_tabletpolicia/get-note', playerid );
        }else{
            $('.error-note').text('Por favor, rellena los campos.');
        }
    });

    $(document).on('click','#save-bolos', function (ev) {
        bolo = JSON.stringify({
            name: $('#input-bolos-gender').val(),
            lastname: $('#input-bolos-height').val(),
            apperance: $('#input-bolos-age').val(),
            type_of_crime: $('#input-bolos-type-of-crime').val(),
            fine: $('#input-bolos-note').val()
        });

        $.post('http://esx_yisus_tabletpolicia/add-bolo', bolo);
        $('.modal-add-bolos').hide(300);
    });

    $(document).on('click','.delete_bolo' ,function () {
        bolo = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_yisus_tabletpolicia/delete-bolo', bolo);
    });


    $(document).on('click','#search-for-civilian',function(event){
        searchPlayer();
    });

    function searchPlate(){
        plate = JSON.stringify({ plate: $('#input-plate').val() });
        $.post('http://esx_yisus_tabletpolicia/search-plate', plate);
    }

    function addCR(){
        criminalRecord = JSON.stringify({ reason: $('#cr-reason').val(), fine: $('#cr-fine').val(), time: $('#cr-time').val(), playerid: $('#cr-playerid').val() });
        $.post('http://esx_yisus_tabletpolicia/add-cr', criminalRecord);
    }

    function addNote(){
        note = JSON.stringify({ content: $('#note-content').val(), title: $('#note-title').val(), playerid: $('#cr-playerid').val()});
        $.post('http://esx_yisus_tabletpolicia/add-note', note);
    }

    $(document).on('click', '.police-cad-menu li', function () {
        var id = $(this).data('id');
        $('.active').removeClass('active');
        $(this).addClass('active');

        hidePlateChecker();

        if($(this).data('id') == 'plate-checker'){
            showPlateChecker();
        }
        
        if ( id == 'bolos'){
            $.post('http://esx_yisus_tabletpolicia/get-bolos');
        }

        $('.page').hide();
        $('#'+id).show();
        $('input').focus();
    });
});

function showPlateChecker(){
    $('#plate-checker').show();
}
function hidePlateChecker(){
    $('#plate-checker').hide();
}

function createTableCr(crresults){
    $('#criminal-records tbody').html('');
    crresults.forEach(function(cr){
        $('#criminal-records tbody').append($('<tr>')
            .append($('<td>').text(cr['reason']))
            .append($('<td>').text(cr['fine']))
            .append($('<td>').text(cr['time']))
            .append($('<td>').text(new Date(cr['created_at']).toLocaleDateString("es-ES")))
            .append($('<td>').append($('<span class="delete_cr" data-id="'+ cr['id'] +'">').text('X'))));
    })
}

function createNoteTable(noteResults){
    $('#notes tbody').html('');
    noteResults.forEach(function(notes){
        $('#notes tbody').append($('<tr>')
            .append($('<td>').text(notes['title']))
            .append($('<td>').text(notes['content']))
            .append($('<td>').text(new Date(notes['created_at']).toLocaleDateString("es-ES")))
            .append($('<td>').append($('<span class="delete_note" data-id="'+ notes['id'] +'">').text('X')))

        );
    })
}

function createBoloTable(boloResults){
    $('.police-cad-bolos tbody').html('');
    boloResults.forEach(function(bolo){
        $('.police-cad-bolos tbody').append($('<tr>')
            .append($('<td>').text(bolo['name']))
            .append($('<td>').text(bolo['lastname']))
            .append($('<td>').text(bolo['apperance']))
            .append($('<td>').text(bolo['type_of_crime']))
            .append($('<td>').text(bolo['fine']))
            .append($('<td>').append($('<span class="delete_bolo" data-id="'+ bolo['id'] +'">').text('X')))

        );
    })
}

function createTableLicense(licenseResults){
    licenseResults.forEach(function(license){
        $('#licenses tbody').append($('<tr>')
            .append($('<td>').text(license['type'])));
    })
}

function showExtraUserData(user){
    $('#criminal-records tbody').html('');
    $('#licenses tbody').html('');
    $('.resultinner').hide(300);
    $('.civilian-details').show(300);

    $('#cr-playerid').val(user.identifier);
    $('.firstname-label').text('Nombre');
    $('.firstname').text(user.firstname);

    $('.lastname-label').text('Apellido');
    $('.lastname').text(user.lastname);

    $('.sex-label').text('Sexo');
    $('.sex').text(user.sex);

    $('.dob-label').text('Fecha de nacimiento');
    $('.dob').text(user.dateofbirth);

    $('.height-label').text('Altura');
    $('.height').text(user.height);
    $('.job-label').text('Trabajo');
    $('.job').text(user.job);

    $('.jail-label').text('¿Encarcelado?');
    $('.jail').text((user.jail ? 'Sí': 'No'));

    playerid = JSON.stringify({ playerid: user.identifier });
    $.post('http://esx_yisus_tabletpolicia/get-cr', playerid );

    $.post('http://esx_yisus_tabletpolicia/get-note', playerid );

    $.post('http://esx_yisus_tabletpolicia/get-license', playerid );

}

function searchPlayer(){
    search = JSON.stringify({ search: $('#search').val() });
    $.post('http://esx_yisus_tabletpolicia/search-players', search);
}





