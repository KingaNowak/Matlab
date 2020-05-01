function varargout = KingaNowak_JustynaHerok(varargin)
% KINGANOWAK_JUSTYNAHEROK MATLAB code for KingaNowak_JustynaHerok.fig
%      KINGANOWAK_JUSTYNAHEROK, by itself, creates a new KINGANOWAK_JUSTYNAHEROK or raises the existing
%      singleton*.
%
%      H = KINGANOWAK_JUSTYNAHEROK returns the handle to a new KINGANOWAK_JUSTYNAHEROK or the handle to
%      the existing singleton*.
%
%      KINGANOWAK_JUSTYNAHEROK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KINGANOWAK_JUSTYNAHEROK.M with the given input arguments.
%
%      KINGANOWAK_JUSTYNAHEROK('Property','Value',...) creates a new KINGANOWAK_JUSTYNAHEROK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KingaNowak_JustynaHerok_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KingaNowak_JustynaHerok_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KingaNowak_JustynaHerok

% Last Modified by GUIDE v2.5 01-Nov-2019 13:05:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KingaNowak_JustynaHerok_OpeningFcn, ...
                   'gui_OutputFcn',  @KingaNowak_JustynaHerok_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before KingaNowak_JustynaHerok is made visible.
function KingaNowak_JustynaHerok_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KingaNowak_JustynaHerok (see VARARGIN)

% Choose default command line output for KingaNowak_JustynaHerok
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KingaNowak_JustynaHerok wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KingaNowak_JustynaHerok_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in wybormapy.
function wybormapy_Callback(~, eventdata, handles)
% hObject    handle to wybormapy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% wybór obrazu
mapa=uigetfile('*.jpg','Wybierz obraz:');
% wczytywanie obrazu
A=imread(mapa);
% skalowanie obrazu mapy
A=imresize(A,0.15);
% rysowanie mapy pokoju
A=double(A)/255;
A=rgb2gray(A);
A=logical(A);
% macierz na podstawie wczytanej mapy
B=A;
B=double(B);
% rysowanie mapy w odpowiednim axes
axes(handles.os1);

imshow(A)
%pobieranie wspó³rzêdnych za pomoc¹ klikniêcia, od którego zaczynamy
%"odkurzaæ"
[k,w]=ginput(1);
w=int16(w);
k=int16(k);
hold on
plot(k,w,'*g');
hold on
[i,j]=size(A);
i=int16(i);
j=int16(j);
hold on
%liczba iteracji-> "czas"
iteracja=1;
%liczba posprz¹tanych pikseli
posprzatanep=0;
%zapamiêtanie po³o¿enia punktu
zmienna_x=k;
zmienna_y=w;
%liczba wolnych pikseli=1 w ca³ej mapie
caloscp=0;
for x=1:j
    for y=1:i
        if A(y,x)==1
            caloscp=caloscp+1;
        end
    end
end
%ustalanie osi na os2
axes(handles.os2);
xlabel('Czas (liczba iteracji)');
ylabel('Liczba posprz¹tanych pikseli');
ylim(handles.os2,[0,caloscp]);
xlim(handles.os2,[0,(j*i)]);
%obliczenie skutecznoœci
zmienna=((posprzatanep*100)/caloscp);
hold on
for x=1:(j*j*i*i) % kolumny
    for y=1:(j*j*i*i) % wiersze
        %sprawdzanie warunku o 90% wydajnoœci sprz¹tania
        if ((posprzatanep*100)/caloscp)>=90 && B(zmienna_y+1, zmienna_x+1) ~=1 && B(zmienna_y-1, zmienna_x-1) ~=1 && B(zmienna_y+1, zmienna_x-1) ~=1 && B(zmienna_y-1, zmienna_x+1) ~=1
            axes(handles.os1);
            plot(zmienna_x,zmienna_y,'*r');
            title('Sprz¹tanie skoñczone!');
            axes(handles.os2);
            title(['Sprz¹tanie skoñczone! Uzyskany wynik to:', num2str(zmienna),'%']);
            break
            
        else 
            %gdy odkurzacz siê zapêtli,  czyli od pewnego czasu nie sprz¹ta
            %nowej przestrzeni
            
            if B(zmienna_y,zmienna_x)~=1 && B(zmienna_y+1,zmienna_x)~=1 && B(zmienna_y-1,zmienna_x)~=1 && B(zmienna_y,zmienna_x+1)~=1 && B(zmienna_y,zmienna_x-1)~=1  
                 %waruen sprawdzaj¹cy czy siê nie zapêtli³ od jakiegoœ
                 %czasu
                 if B(zmienna_y, zmienna_x)<=-1
                     %szukanie najbli¿szego wolnego piksela
                     [wiersz, kolumna]=find(B==1);
                     wyniki=zeros(length(wiersz),1);
                     for s=1:length(wiersz)
                         for t=1:length(kolumna)
                             if(s==t)
                                droga=abs(((wiersz(s,1)-zmienna_x)^2)+((kolumna(t,1)-zmienna_y)^2));
                                wyniki(s,1)=droga;
                             end
                         end
                     end
                     minimum=min(wyniki);
                     najblizej=find(wyniki==minimum,1, 'first');
                    polozenie_x=kolumna(najblizej,1);
                    polozenie_y=wiersz(najblizej,1);

                    while zmienna_y~=polozenie_y || zmienna_x~=polozenie_x
                    %ruch w wierszach
                    while zmienna_y~=polozenie_y
                        %ruch do do³u, czyli przód
                        if zmienna_y==polozenie_y
                            break
                        elseif A(zmienna_y+1, zmienna_x)==1 && zmienna_y<polozenie_y
                            while A(zmienna_y+1, zmienna_x)==1 && zmienna_y~=polozenie_y
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y+1,zmienna_x)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y+1,zmienna_x)=B(zmienna_y+1,zmienna_x)-1;
                                zmienna_x=zmienna_x;
                                zmienna_y=zmienna_y+1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                            
                             %ruch do gór, czyli w ty³
                        elseif A(zmienna_y-1, zmienna_x)==1 && zmienna_y>polozenie_y
                            while A(zmienna_y-1, zmienna_x)==1 && zmienna_y>polozenie_y
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y-1],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y-1,zmienna_x)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y-1,zmienna_x)=B(zmienna_y-1,zmienna_x)-1;
                                zmienna_x=zmienna_x;
                                zmienna_y=zmienna_y-1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                            
                            %ewentulany ruch w prawo
                        elseif A(zmienna_y, zmienna_x+1)==1
                            axes(handles.os1);
                            line([zmienna_x zmienna_x+1],[zmienna_y zmienna_y],'Color', 'green')   
                            title('Trwa odkurzanie!');
                            poprzedniepop=posprzatanep;
                            if B(zmienna_y,zmienna_x+1)==1
                            posprzatanep=posprzatanep+1;
                            end
                            B(zmienna_y,zmienna_x+1)=B(zmienna_y,zmienna_x+1)-1;
                            zmienna_x=zmienna_x+1;
                            zmienna_y=zmienna_y;
                            %rysowanie wykresu
                            axes(handles.os2);
                            iteracja=iteracja+1;
                            zmienna=((posprzatanep*100)/caloscp);
                            line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                            title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                            pause(0.00001)
                            
                            %ewentualny ruch w lewo
                        elseif A(zmienna_y, zmienna_x-1)==1
                            axes(handles.os1);
                            line([zmienna_x-1 zmienna_x],[zmienna_y zmienna_y],'Color', 'green')   
                            title('Trwa odkurzanie!');
                            poprzedniepop=posprzatanep;
                            if B(zmienna_y,zmienna_x-1)==1
                            posprzatanep=posprzatanep+1;
                            end
                            B(zmienna_y,zmienna_x-1)=B(zmienna_y,zmienna_x-1)-1;
                            zmienna_x=zmienna_x-1;
                            zmienna_y=zmienna_y;
                            %rysowanie wykresu
                            axes(handles.os2);
                            iteracja=iteracja+1;
                            zmienna=((posprzatanep*100)/caloscp);
                            line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                            title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                            pause(0.00001)
                        end
                        
                    end
                    
                    %ruch w kolumnach
                    while zmienna_x~=polozenie_x
                        %ruch w prawo
                        if zmienna_x==polozenie_x
                            break
                        elseif A(zmienna_y, zmienna_x+1)==1 && zmienna_x<polozenie_x
                            while A(zmienna_y, zmienna_x+1)==1 && zmienna_x~=polozenie_x
                                axes(handles.os1);
                                line([zmienna_x zmienna_x+1],[zmienna_y zmienna_y],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y,zmienna_x+1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y,zmienna_x+1)=B(zmienna_y,zmienna_x+1)-1;
                                zmienna_x=zmienna_x+1;
                                zmienna_y=zmienna_y;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                            
                            %ruch w lewo
                        elseif A(zmienna_y, zmienna_x-1)==1 && zmienna_x>polozenie_x
                            while A(zmienna_y, zmienna_x-1)==1 && zmienna_x~=polozenie_x
                                axes(handles.os1);
                                line([zmienna_x-1 zmienna_x],[zmienna_y zmienna_y],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y,zmienna_x-1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y,zmienna_x-1)=B(zmienna_y,zmienna_x-1)-1;
                                zmienna_x=zmienna_x-1;
                                zmienna_y=zmienna_y;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                            
                        %ewentualny ruch w ty³, czyli w górê
                        elseif A(zmienna_y-1, zmienna_x)==1
                            axes(handles.os1);
                            line([zmienna_x zmienna_x],[zmienna_y-1 zmienna_y],'Color', 'green')   
                            title('Trwa odkurzanie!');
                            poprzedniepop=posprzatanep;
                            if B(zmienna_y-1,zmienna_x)==1
                            posprzatanep=posprzatanep+1;
                            end
                            B(zmienna_y-1,zmienna_x)=B(zmienna_y-1,zmienna_x)-1;
                            zmienna_x=zmienna_x;
                            zmienna_y=zmienna_y-1;
                            %rysowanie wykresu
                            axes(handles.os2);
                            iteracja=iteracja+1;
                            zmienna=((posprzatanep*100)/caloscp);
                            line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                            title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                            pause(0.00001)
                            
                            %ewentualnych ruch w dó³, czyli w przód
                        elseif A(zmienna_y+1, zmienna_x)==1
                            axes(handles.os1);
                            line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1],'Color', 'green')   
                            title('Trwa odkurzanie!');
                            poprzedniepop=posprzatanep;
                            if B(zmienna_y+1,zmienna_x)==1
                            posprzatanep=posprzatanep+1;
                            end
                            B(zmienna_y+1,zmienna_x)=B(zmienna_y+1,zmienna_x)-1;
                            zmienna_x=zmienna_x;
                            zmienna_y=zmienna_y+1;
                            %rysowanie wykresu
                            axes(handles.os2);
                            iteracja=iteracja+1;
                            zmienna=((posprzatanep*100)/caloscp);
                            line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                            title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                            pause(0.00001)
                            

                        end
                    end
                    %sprawdzanie czy po³o¿enie siê zgadza z tym, które znaleŸlimy
                    if zmienna_x==polozenie_x && zmienna_y~=polozenie_y
                        %do góry
                        if zmienna_y>polozenie_y
                            while zmienna_y~=polozenie_y
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y-1 zmienna_y],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y-1,zmienna_x)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y-1,zmienna_x)=B(zmienna_y-1,zmienna_x)-1;
                                zmienna_x=zmienna_x;
                                zmienna_y=zmienna_y-1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                            %na dó³
                        elseif zmienna_y<polozenie_y
                            while zmienna_y~=polozenie_y
                                 axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y+1 zmienna_y],'Color', 'green')   
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y+1,zmienna_x)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y+1,zmienna_x)=B(zmienna_y+1,zmienna_x)-1;
                                zmienna_x=zmienna_x;
                                zmienna_y=zmienna_y+1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                            end
                        end
                    end
                    end 
                %warunek sprawdzaj¹cy czy po lewej stronie nie ma przeszkody      
                 elseif A(zmienna_y, zmienna_x-1)==1 
                    while A(zmienna_y, zmienna_x-1)==1 && B(zmienna_y, zmienna_x-1)~=1
                    axes(handles.os1);
                    line([zmienna_x-1 zmienna_x],[zmienna_y zmienna_y],'Color', 'red')   
                    title('Trwa odkurzanie!');
                    poprzedniepop=posprzatanep;
                    if B(zmienna_y,zmienna_x-1)==1
                    posprzatanep=posprzatanep+1;
                    end
                    B(zmienna_y,zmienna_x-1)=B(zmienna_y,zmienna_x-1)-1;
                    zmienna_x=zmienna_x-1;
                    zmienna_y=zmienna_y;
                    %rysowanie wykresu
                    axes(handles.os2);
                    iteracja=iteracja+1;
                    zmienna=((posprzatanep*100)/caloscp);
                    line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                    title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                    pause(0.00001)
                    end
                  %warunek sprawdzaj¹cy czy na dole (w przód) nie ma przeszkody
                elseif A(zmienna_y+1, zmienna_x)==1
                    while A(zmienna_y+1, zmienna_x)==1 && B(zmienna_y+1, zmienna_x)~=1
                        %sprawdzanie czy mo¿na pójœæ w bok
                        if A(zmienna_y+1, zmienna_x-1)==1 && A(zmienna_y, zmienna_x-1)==0
                            while A(zmienna_y+1, zmienna_x-1)==1 
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1], 'Color', 'red')
                                pause(0.00001)
                                line([zmienna_x-1 zmienna_x],[zmienna_y+1 zmienna_y+1], 'Color', 'red')
                                pause(0.00001)
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y+1,zmienna_x-1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y+1,zmienna_x-1)= B(zmienna_y+1,zmienna_x-1)-1;
                                zmienna_x=zmienna_x-1;
                                zmienna_y=zmienna_y+1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                                break
                            end
                        elseif A(zmienna_y+1, zmienna_x+1)==1 && A(zmienna_y, zmienna_x+1)==0
                            while A(zmienna_y+1, zmienna_x+1)==1
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1], 'Color', 'red')
                                pause(0.00001)
                                line([zmienna_x+1 zmienna_x],[zmienna_y+1 zmienna_y+1], 'Color', 'red')
                                pause(0.00001)
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y+1,zmienna_x+1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y+1,zmienna_x+1)=B(zmienna_y+1,zmienna_x+1)-1;
                                zmienna_x=zmienna_x+1;
                                zmienna_y=zmienna_y+1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                                break
                            end
                            break
                        end 
                            axes(handles.os1);
                            line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1],'Color', 'red')   
                            title('Trwa odkurzanie!');
                            poprzedniepop=posprzatanep;
                            if B(zmienna_y+1,zmienna_x)==1
                            posprzatanep=posprzatanep+1;
                            end
                            B(zmienna_y+1,zmienna_x)=B(zmienna_y+1,zmienna_x)-1;
                            zmienna_x=zmienna_x;
                            zmienna_y=zmienna_y+1;
                            %rysowanie wykresu
                            axes(handles.os2);
                            iteracja=iteracja+1;
                            zmienna=((posprzatanep*100)/caloscp);
                            line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                            title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                            pause(0.00001)
                            %sprawdzanie czy siê nie zapêtli
                            if B(zmienna_y+1, zmienna_x)==0.6 && B(zmienna_y+1, zmienna_x+1)==0.6 && B(zmienna_y+1, zmienna_x-1)==0.6
                                break
                            end
                    end  
                  %warunek sprawdzaj¹cy czy po prawej stronie nie ma przeszkody
                elseif A(zmienna_y, zmienna_x+1)==1 
                    while A(zmienna_y, zmienna_x+1)==1 && B(zmienna_y, zmienna_x+1)~=1
                    axes(handles.os1);
                    line([zmienna_x zmienna_x+1],[zmienna_y zmienna_y],'Color', 'red')   
                    title('Trwa odkurzanie!');
                    poprzedniepop=posprzatanep;
                    if B(zmienna_y,zmienna_x+1)==1
                    posprzatanep=posprzatanep+1;
                    end
                    B(zmienna_y,zmienna_x+1)=B(zmienna_y,zmienna_x+1)-1;
                    zmienna_x=zmienna_x+1;
                    zmienna_y=zmienna_y;
                    %rysowanie wykresu
                    axes(handles.os2);
                    iteracja=iteracja+1;
                    zmienna=((posprzatanep*100)/caloscp);
                    line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                    title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                    pause(0.00001)
                    end
                    %warunek sprawdzaj¹cy czy na górze (w ty³) nie ma przeszkody
                elseif A(zmienna_y-1, zmienna_x)==1
                    while A(zmienna_y-1, zmienna_x)==1 && B(zmienna_y-1, zmienna_x)~=1
                        %sprawdzanie czy mo¿na pójœæ w bok
                        if A(zmienna_y-1, zmienna_x+1)==1 && A(zmienna_y, zmienna_x+1)==0
                            while A(zmienna_y-1, zmienna_x+1)==1
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y-1], 'Color', 'red')
                                pause(0.00001)
                                line([zmienna_x+1 zmienna_x],[zmienna_y-1 zmienna_y-1], 'Color', 'red')
                                pause(0.00001)
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y-1,zmienna_x+1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y-1,zmienna_x+1)=B(zmienna_y-1,zmienna_x+1)-1;
                                zmienna_x=zmienna_x+1;
                                zmienna_y=zmienna_y-1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                                break
                            end
                        elseif A(zmienna_y-1, zmienna_x-1)==1 && A(zmienna_y, zmienna_x-1)==0
                            while A(zmienna_y-1, zmienna_x-1)==1
                                axes(handles.os1);
                                line([zmienna_x zmienna_x],[zmienna_y zmienna_y-1], 'Color', 'red')
                                pause(0.00001)
                                line([zmienna_x-1 zmienna_x],[zmienna_y-1 zmienna_y-1], 'Color', 'red')
                                pause(0.00001)
                                title('Trwa odkurzanie!');
                                poprzedniepop=posprzatanep;
                                if B(zmienna_y-1,zmienna_x-1)==1
                                posprzatanep=posprzatanep+1;
                                end
                                B(zmienna_y-1,zmienna_x-1)=B(zmienna_y-1,zmienna_x-1)-1;
                                zmienna_x=zmienna_x-1;
                                zmienna_y=zmienna_y-1;
                                %rysowanie wykresu
                                axes(handles.os2);
                                iteracja=iteracja+1;
                                zmienna=((posprzatanep*100)/caloscp);
                                line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                                pause(0.00001)
                                break
                            end
                            break
                        end
                    axes(handles.os1);
                    line([zmienna_x zmienna_x],[zmienna_y zmienna_y-1],'Color', 'red')   
                    title('Trwa odkurzanie!');
                    poprzedniepop=posprzatanep;
                    if B(zmienna_y-1,zmienna_x)==1
                    posprzatanep=posprzatanep-1;
                    end
                    B(zmienna_y-1,zmienna_x)=B(zmienna_y-1,zmienna_x)-1;
                    zmienna_x=zmienna_x;
                    zmienna_y=zmienna_y-1;
                    %rysowanie wykresu
                     axes(handles.os2);
                     iteracja=iteracja+1;
                     zmienna=((posprzatanep*100)/caloscp);
                     line([iteracja-1 iteracja],[poprzedniepop posprzatanep]);
                     title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                     pause(0.00001)
                     %sprawdzanie czy siê nie zapêtli
                    if B(zmienna_y-1, zmienna_x)==0.6 && B(zmienna_y-1, zmienna_x+1)==0.6 && B(zmienna_y-1, zmienna_x-1)==0.6
                       break
                    end
                    end
                end
                
                %ruch w dó³, czyli do przodu
            elseif (A(zmienna_y+1,zmienna_x)==1 && B(zmienna_y+1, zmienna_x)==1) || (A(zmienna_y+1,zmienna_x)==1 && A(zmienna_y+2, zmienna_x)==1 && B(zmienna_y+2, zmienna_x)==1 && A(zmienna_y+1, zmienna_x)~=0) % przestrzeñ wolna to 1
                axes(handles.os1);
                line([zmienna_x zmienna_x],[zmienna_y zmienna_y+1])
                title('Trwa odkurzanie!');
                if B(zmienna_y+1,zmienna_x)==1
                posprzatanep=posprzatanep+1;
                end
                B(zmienna_y+1,zmienna_x)=B(zmienna_y+1,zmienna_x)-1;
                zmienna_x=zmienna_x;
                zmienna_y=zmienna_y+1;
                %rysowanie wykresu
                axes(handles.os2);
                iteracja=iteracja+1;
                line([iteracja-1 iteracja],[posprzatanep-1 posprzatanep]);
                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                pause(0.00001)
                %ruch w górê, czyli z powrotem
            elseif (A(zmienna_y-1, zmienna_x)==1 && B(zmienna_y-1, zmienna_x)==1) || (A(zmienna_y-1, zmienna_x)==1 && A(zmienna_y-2, zmienna_x)==1 && B(zmienna_y-2, zmienna_x)==1 && A(zmienna_y-1, zmienna_x)~=0)
                axes(handles.os1);
                line([zmienna_x zmienna_x],[zmienna_y zmienna_y-1])
                title('Trwa odkurzanie!');
                if B(zmienna_y-1,zmienna_x)==1
                posprzatanep=posprzatanep+1;
                end
                B(zmienna_y-1, zmienna_x)=B(zmienna_y-1, zmienna_x)-1;
                zmienna_x=zmienna_x;
                zmienna_y=zmienna_y-1;
                %rysowanie wykresu
                axes(handles.os2);
                iteracja=iteracja+1;
                line([iteracja-1 iteracja],[posprzatanep-1 posprzatanep]);
                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                pause(0.00001)
                %ruch w prawo
            elseif (A(zmienna_y,zmienna_x+1)==1 && B(zmienna_y,zmienna_x+1)==1) || (A(zmienna_y,zmienna_x+1)==1 && A(zmienna_y, zmienna_x+2)==1 && B(zmienna_y, zmienna_x+2)==1 && A(zmienna_y, zmienna_x+1)~=0)
                axes(handles.os1);
                line([zmienna_x zmienna_x+1],[zmienna_y zmienna_y])
                title('Trwa odkurzanie!');
                if B(zmienna_y,zmienna_x+1)==1
                posprzatanep=posprzatanep+1;
                end
                B(zmienna_y,zmienna_x+1)=B(zmienna_y,zmienna_x+1)-1;
                zmienna_x=zmienna_x+1;
                zmienna_y=zmienna_y;
                %rysowanie wykresu
                axes(handles.os2);
                iteracja=iteracja+1;
                line([iteracja-1 iteracja],[posprzatanep-1 posprzatanep]);
                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                pause(0.00001)
                %ruch w lewo
            elseif (A(zmienna_y,zmienna_x-1)==1 && B(zmienna_y,zmienna_x-1)==1) || (A(zmienna_y,zmienna_x-1)==1 && A(zmienna_y, zmienna_x-2)==1 && B(zmienna_y, zmienna_x-2)==1 && A(zmienna_y, zmienna_x-1)~=0)
                axes(handles.os1);
                line([zmienna_x zmienna_x-1],[zmienna_y zmienna_y])
                title('Trwa odkurzanie!');
                if B(zmienna_y,zmienna_x-1)==1
                posprzatanep=posprzatanep+1;
                end
                B(zmienna_y,zmienna_x-1)=B(zmienna_y,zmienna_x-1)-1;
                zmienna_x=zmienna_x-1;
                zmienna_y=zmienna_y;
                %rysowanie wykresu
                axes(handles.os2);
                iteracja=iteracja+1;
                line([iteracja-1 iteracja],[posprzatanep-1 posprzatanep]);
                title(['Skutecznoœæ odkurzania odkurzacza:', num2str(zmienna),'%']);
                pause(0.00001)   
            end
                   zmienna=((posprzatanep*100)/caloscp);
        end  

    end  
end