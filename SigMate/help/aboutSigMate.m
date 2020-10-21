function varargout = aboutSigMate(varargin)
% ABOUTSIGMATE M-file for aboutSigMate.fig
%      ABOUTSIGMATE, by itself, creates a new ABOUTSIGMATE or raises the existing
%      singleton*.
%
%      H = ABOUTSIGMATE returns the handle to a new ABOUTSIGMATE or the handle to
%      the existing singleton*.
%
%      ABOUTSIGMATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABOUTSIGMATE.M with the given input arguments.
%
%      ABOUTSIGMATE('Property','Value',...) creates a new ABOUTSIGMATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aboutSigMate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aboutSigMate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aboutSigMate

% Last Modified by GUIDE v2.5 04-May-2012 18:17:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aboutSigMate_OpeningFcn, ...
                   'gui_OutputFcn',  @aboutSigMate_OutputFcn, ...
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


% --- Executes just before aboutSigMate is made visible.
function aboutSigMate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aboutSigMate (see VARARGIN)

% Choose default command line output for aboutSigMate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aboutSigMate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aboutSigMate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnCloseWindow.
function btnCloseWindow_Callback(hObject, eventdata, handles)
% hObject    handle to btnCloseWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    delete(gcf);

% --- Executes during object creation, after setting all properties.
function axsAboutSigMate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axsAboutSigMate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axsAboutSigMate
    axes(hObject)
    pathLogo = which('SigMate-Logo');
    imshow([pathLogo '\' 'SigMate-Logo.gif'])
