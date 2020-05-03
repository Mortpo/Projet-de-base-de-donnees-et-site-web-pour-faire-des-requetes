function initializeEvents() {
    let tabs = document.getElementsByTagName('h1');
    let buts = document.getElementsByTagName('button');

    for (let iTab = 0; iTab < tabs.length; ++iTab)
        tabs[iTab].addEventListener('click', (tabevent) => { 
            console.log(tabevent);
            activateTab(iTab);
        });

        for (let iButs = 0; iButs < buts.length; ++iButs)
        buts[iButs].addEventListener('click', (butevent) => { 
            console.log(butevent);
            activateBut(iButs);
        });
}


function activateTab(index) {

    let panels = document.getElementsByTagName('div');

    if (index >= panels.length){
        throw "activateTab Error : index out of range";
    }
    

    if(getComputedStyle(panels[index]).display == "none" ){
        panels[index].style.display = "block";

    }else
    {
        panels[index].style.display = "none";
    }


}

function activateBut(index) {

    let ps = document.getElementsByClassName('info');

    if ( index >= ps.length){
        throw "activateTab Error : index out of range";
    }
    

    if(getComputedStyle(ps[index]).display == "none" ){
        ps[index].style.display = "block";

    }else
    {
        ps[index].style.display = "none";
    }


}


initializeEvents();