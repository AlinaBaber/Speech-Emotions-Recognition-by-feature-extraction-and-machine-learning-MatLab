% Syntax :
% [voise,pitch] = pitch_par_fft (signal,start,finish,Fe)
%
% Grace a une fft, cette fonction retourne un boolean qui indique si le
% son est vois� ou non, et si oui, elle retourne le pic de fr�quence
% principal.
% Le facteur de fiabilite n'est pas tr�s fiable mais un peu quand meme.
%
% Crit�res de d�cisions :
% - largeur des pics (si > a un seuil c un son bruit�)
% - Positionnement des pics (si on trouve des pics en tr�s haute fr�quence c pas
% vois�)
% - Espacement des pics (si un pic isol� en haute fr�quence ya pas de
% probleme)
% - le nombre total de valeurs 'fortes', les sons voises ont moins de valeurs
% fortes (valeurs superieur au max du spectre / constante)
% - le rapport entre la hauteur du pic principal et les hauteurs
% secondaires
%


function [voise,pitch] = pitch_par_fft (signal,start,finish,Fe)

% multiplication du signal par une fen�tre de hamming
signal_deux = signal(start:finish).*hamming(finish-start+1);
% extraction du spectre en valeur absolue
res_fft = abs(fft((signal_deux)));

size_fft = size(res_fft);
num_rows = size_fft(1,1);
rapport_precalcule = Fe / num_rows;

[a,b] = max(res_fft);
% on choisit d'embl�e le pitch comme la valeur max du spectre
% le spectre commence a 1 mais ceci correspond a la fr�quence nulle
% d'ou le b-1
pitch = (b-1) * rapport_precalcule;

% la fft est sym�trique par rapport a Fe/2 et des fois le max est vu
% dans la partie droite, il faut recalculer le pitch en conc�quence
if(pitch > Fe/2)
    pitch = Fe - pitch;
end

%plot(res_fft);
%pause

% on observe parfois pour un son non vois� de faible puissance un grand pic en z�ro
% du au fen�trage, il ne faut pas le confondre avec un son vois�. 
% Comme de toute mani�re le pic d'un son vois� n'est pas en z�ro on peut
% se permettre de couper les trois premieres valeurs
for i=1:3
        res_fft(i) = 0;
end
for i=finish-start-2:finish-start+1
        res_fft(i) = 0;
end

% on calcule la valeur de seuil par rapport au nouveau maximum du spectre
[maxium,ant_max] = max (res_fft);
% la valeur seuil est �gale au max/3 mais on peut faire varier
% ce chiffre '3' pour r�gler la tol�rance vois�/non vois�.
% Plus il est petit plus le spectre est tronqu�, et plus les pics
% apparaitront fins pour le traitement suivant, et plus la d�cision sera
% en faveur d'un son vois�.
threshhold = maxium / 4;


% on troncque le spectre par rapport a la valeur seuil, pour �liminer
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
title('spectre tronqu� et non tronqu�');
%pause;

% quelques param�tres de l'analyse
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
    % on incr�mente largeur du pic
    if (res_fft(i)>0)&&(indic==1)
        largeur_pic = largeur_pic + rapport_precalcule;
    % sinon il s'agit d'un nouveau pic et on initialise largeur de pic �
    % zero
    elseif (res_fft(i)>0)&&(indic==0)   
        indic = 1;
        largeur_pic = 0;
    % sinon on trouve un zero et qu'on �tait en train de regarder un pic,
    % on est tomb� sur la fin du pic
    elseif (res_fft(i)==0)&&(indic==1)
        % si la largeur est trop importante (400 Hz) c'est un son non vois�
        if largeur_pic > 400
            %disp(sprintf('detection dun pic trop large pour etre un son vois� � %.1f, i=%i',(i*Fe/num_rows),i));
            %disp(sprintf('largeur pic = %.1f',largeur_pic));
            voise = 0;
            pitch = 0;
 %           break;
        end
        
        % si le pic est en trop haute fr�quence (1400Hz)
        if (i*rapport_precalcule) > 1400
            % si en plus ce pic n'est pas isol�
            if (indic_dernier_pic > 0) && (indic_dernier_pic < 600)    
                %entre 300 et 600 plus c pr�s de 300 plus ya de vois�
                %disp(sprintf('detection dun pic haute fr�quence pour etre un son vois� � %.1f, i=%i, espacement=%.1f',(i*Fe/num_rows),i,indic_dernier_pic));
                voise = 0;
                pitch = 0;
    %            break;
            else
                %disp(sprintf('detection dun pic en trop hautre fr�quence mais isol� !'));
            end
        end
        % on vient de rencontrer la fin d'un pic, on remets tout les �tats
        % a zero.
        indic = 0;
        largeur_pic = 0;
        indic_dernier_pic = 0;
    else
        indic_dernier_pic = indic_dernier_pic + rapport_precalcule;
    end
end

% Si on a pas d�tect� de pic trop gros mais qu'il y a n�anmoins trop de
% pics non nuls on mets vois� a zero.
% Ce crit�re ne sert quasiment jamais. En g�n�ral l'analyse pr�c�dente
% d�piste un son non vois�.
if (voise==1)&&(nombre_pic_non_nuls > 20)
    %disp(sprintf('Trop de bazard, trop de valeur positives : %i',nombre_pic_non_nuls));
    voise = 0;
    pitch = 0;
end

% si on pas trouv� un son non vois� mais que le pic de fr�quence �tait
% quand meme en zero, alors on prends le max ailleurs
if (voise==1)&&(pitch==0)
    %disp(sprintf('Max de fr�quence en 0, mais consid�r� comme vois�'));
    voise = 1;
    pitch = (ant_max-1) * rapport_precalcule;
    if(pitch > Fe/2)
        pitch = Fe - pitch;
    end
end


