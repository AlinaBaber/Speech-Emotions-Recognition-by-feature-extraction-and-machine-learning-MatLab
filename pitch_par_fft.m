% Syntax :
% [voise,pitch] = pitch_par_fft (signal,start,finish,Fe)
%
% Grace a une fft, cette fonction retourne un boolean qui indique si le
% son est voisé ou non, et si oui, elle retourne le pic de fréquence
% principal.
% Le facteur de fiabilite n'est pas très fiable mais un peu quand meme.
%
% Critères de décisions :
% - largeur des pics (si > a un seuil c un son bruité)
% - Positionnement des pics (si on trouve des pics en très haute fréquence c pas
% voisé)
% - Espacement des pics (si un pic isolé en haute fréquence ya pas de
% probleme)
% - le nombre total de valeurs 'fortes', les sons voises ont moins de valeurs
% fortes (valeurs superieur au max du spectre / constante)
% - le rapport entre la hauteur du pic principal et les hauteurs
% secondaires
%


function [voise,pitch] = pitch_par_fft (signal,start,finish,Fe)

% multiplication du signal par une fenètre de hamming
signal_deux = signal(start:finish).*hamming(finish-start+1);
% extraction du spectre en valeur absolue
res_fft = abs(fft((signal_deux)));

size_fft = size(res_fft);
num_rows = size_fft(1,1);
rapport_precalcule = Fe / num_rows;

[a,b] = max(res_fft);
% on choisit d'emblée le pitch comme la valeur max du spectre
% le spectre commence a 1 mais ceci correspond a la fréquence nulle
% d'ou le b-1
pitch = (b-1) * rapport_precalcule;

% la fft est symétrique par rapport a Fe/2 et des fois le max est vu
% dans la partie droite, il faut recalculer le pitch en concéquence
if(pitch > Fe/2)
    pitch = Fe - pitch;
end

%plot(res_fft);
%pause

% on observe parfois pour un son non voisé de faible puissance un grand pic en zéro
% du au fenétrage, il ne faut pas le confondre avec un son voisé. 
% Comme de toute manière le pic d'un son voisé n'est pas en zéro on peut
% se permettre de couper les trois premieres valeurs
for i=1:3
        res_fft(i) = 0;
end
for i=finish-start-2:finish-start+1
        res_fft(i) = 0;
end

% on calcule la valeur de seuil par rapport au nouveau maximum du spectre
[maxium,ant_max] = max (res_fft);
% la valeur seuil est égale au max/3 mais on peut faire varier
% ce chiffre '3' pour régler la tolérance voisé/non voisé.
% Plus il est petit plus le spectre est tronqué, et plus les pics
% apparaitront fins pour le traitement suivant, et plus la décision sera
% en faveur d'un son voisé.
threshhold = maxium / 4;


% on troncque le spectre par rapport a la valeur seuil, pour éliminer
% les bruits de fonds et les parasites.
for i=1:num_rows/2
    if(res_fft(i) > threshhold)
        res_fft(i) = res_fft(i) - threshhold;
    else
        res_fft(i) = 0;
    end
end

for i=1:num_rows
    frequence(i) = i/num_rows*Fe;
end
plot(frequence,res_fft);
xlabel('frequence');
ylabel('amplitude');
title('spectre tronqué et non tronqué');
%pause;

% quelques paramètres de l'analyse
indic = 0;
largeur_pic = 0;
voise = 1;
indic_dernier_pic = 0;
nombre_pic_non_nuls = 0;



% on commence le parcours du spectre de gauche a droite
for i=1:num_rows/2
    % on trouve une valeur non nulle, on la compte
    if (res_fft(i)>0)
        nombre_pic_non_nuls = nombre_pic_non_nuls + 1;
    end
    % si cette valeur non nulle correspond a un pic en cours
    % on incrémente largeur du pic
    if (res_fft(i)>0)&&(indic==1)
        largeur_pic = largeur_pic + rapport_precalcule;
    % sinon il s'agit d'un nouveau pic et on initialise largeur de pic à
    % zero
    elseif (res_fft(i)>0)&&(indic==0)   
        indic = 1;
        largeur_pic = 0;
    % sinon on trouve un zero et qu'on était en train de regarder un pic,
    % on est tombé sur la fin du pic
    elseif (res_fft(i)==0)&&(indic==1)
        % si la largeur est trop importante (400 Hz) c'est un son non voisé
        if largeur_pic > 400
            %disp(sprintf('detection dun pic trop large pour etre un son voisé à %.1f, i=%i',(i*Fe/num_rows),i));
            %disp(sprintf('largeur pic = %.1f',largeur_pic));
            voise = 0;
            pitch = 0;
 %           break;
        end
        
        % si le pic est en trop haute fréquence (1400Hz)
        if (i*rapport_precalcule) > 1400
            % si en plus ce pic n'est pas isolé
            if (indic_dernier_pic > 0) && (indic_dernier_pic < 600)    
                %entre 300 et 600 plus c près de 300 plus ya de voisé
                %disp(sprintf('detection dun pic haute fréquence pour etre un son voisé à %.1f, i=%i, espacement=%.1f',(i*Fe/num_rows),i,indic_dernier_pic));
                voise = 0;
                pitch = 0;
    %            break;
            else
                %disp(sprintf('detection dun pic en trop hautre fréquence mais isolé !'));
            end
        end
        % on vient de rencontrer la fin d'un pic, on remets tout les états
        % a zero.
        indic = 0;
        largeur_pic = 0;
        indic_dernier_pic = 0;
    else
        indic_dernier_pic = indic_dernier_pic + rapport_precalcule;
    end
end

% Si on a pas détecté de pic trop gros mais qu'il y a néanmoins trop de
% pics non nuls on mets voisé a zero.
% Ce critère ne sert quasiment jamais. En général l'analyse précédente
% dépiste un son non voisé.
if (voise==1)&&(nombre_pic_non_nuls > 20)
    %disp(sprintf('Trop de bazard, trop de valeur positives : %i',nombre_pic_non_nuls));
    voise = 0;
    pitch = 0;
end

% si on pas trouvé un son non voisé mais que le pic de fréquence était
% quand meme en zero, alors on prends le max ailleurs
if (voise==1)&&(pitch==0)
    %disp(sprintf('Max de fréquence en 0, mais considéré comme voisé'));
    voise = 1;
    pitch = (ant_max-1) * rapport_precalcule;
    if(pitch > Fe/2)
        pitch = Fe - pitch;
    end
end


