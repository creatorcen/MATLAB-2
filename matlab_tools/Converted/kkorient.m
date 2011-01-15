%kkorient 'Change Orientation of Data on Dimensions'
% This MatLab function was automatically generated by a converter (KhorosToMatLab) from the Khoros korient.pane file
%
% Parameters: 
% InputFile: i 'Input ', required: 'input data object'
% OutputFile: o 'Output', required: 'resulting data object'
% Toggle: ww ' ', default: 0: 'orient WIDTH data to be on WIDTH dimension'
% Toggle: wh ' ', default: 0: 'orient WIDTH data to be on HEIGHT dimension'
% Toggle: we ' ', default: 0: 'orient WIDTH data to be on ELEMENTS dimension'
% Toggle: wd ' ', default: 0: 'orient WIDTH data to be on DEPTH dimension'
% Toggle: wt ' ', default: 0: 'orient WIDTH data to be on TIME dimension'
% Toggle: hw ' ', default: 0: 'orient HEIGHT data to be on WIDTH dimension'
% Toggle: hh ' ', default: 0: 'orient HEIGHT data to be on HEIGHT dimension'
% Toggle: he ' ', default: 0: 'orient HEIGHT data to be on ELEMENTS dimension'
% Toggle: hd ' ', default: 0: 'orient HEIGHT data to be on DEPTH dimension'
% Toggle: ht ' ', default: 0: 'orient HEIGHT data to be on TIME dimension'
% Toggle: ew ' ', default: 0: 'orient ELEMENT data to be on WIDTH dimension'
% Toggle: eh ' ', default: 0: 'orient ELEMENT data to be on HEIGHT dimension'
% Toggle: ee ' ', default: 0: 'orient ELEMENT data to be on ELEMENTS dimension'
% Toggle: ed ' ', default: 0: 'orient ELEMENT data to be on DEPTH dimension'
% Toggle: et ' ', default: 0: 'orient ELEMENT data to be on TIME dimension'
% Toggle: dw ' ', default: 0: 'orient DEPTH data to be on WIDTH dimension'
% Toggle: dh ' ', default: 0: 'orient DEPTH data to be on HEIGHT dimension'
% Toggle: de ' ', default: 0: 'orient DEPTH data to be on ELEMENTS dimension'
% Toggle: dd ' ', default: 0: 'orient DEPTH data to be on DEPTH dimension'
% Toggle: dt ' ', default: 0: 'orient DEPTH data to be on TIME dimension'
% Toggle: tw ' ', default: 0: 'orient TIME data to be on WIDTH dimension'
% Toggle: th ' ', default: 0: 'orient TIME data to be on HEIGHT dimension'
% Toggle: te ' ', default: 0: 'orient TIME data to be on ELEMENTS dimension'
% Toggle: td ' ', default: 0: 'orient TIME data to be on DEPTH dimension'
% Toggle: tt ' ', default: 0: 'orient TIME data to be on TIME dimension'
%
% Example: o = kkorient(i, {'i','';'o','';'ww',0;'wh',0;'we',0;'wd',0;'wt',0;'hw',0;'hh',0;'he',0;'hd',0;'ht',0;'ew',0;'eh',0;'ee',0;'ed',0;'et',0;'dw',0;'dh',0;'de',0;'dd',0;'dt',0;'tw',0;'th',0;'te',0;'td',0;'tt',0})
%
% Khoros helpfile follows below:
%
%  PROGRAM
% korient - Change Orientation of Data on Dimensions
%
%  DESCRIPTION
% korient allows data to be reorganized from its original orientation
% on the dimensions of WIDTH (W), HEIGHT (H), ELEMENTS (E), DEPTH (D), 
% and TIME (T), to another orientation on these dimensions.  
% 
% \f(CW
% 
%                 +-----------+                              +-----------+
%             E  /-----------/|                          E  /-----------/|
%               /-----------/||                            /-----------/||
%         +-----------+----+|||                      +-----------+----+|||
%     E  /-----------/|    ||||                  E  /-----------/|    ||||
%       /-----------/||    ||||                    /-----------/||    ||||
%      +-----------+|||    ||||                   +-----------+|||    ||||
%      |           ||||    ||/  /                 |           ||||    ||/  /
%  H   |           ||||----+/  /              H   |           ||||----+/  /
%      |           ||||       D    .  .  .        |           ||||       D
%      |           ||/       /                    |           ||/       /
%      +-----------+/       /                     +-----------+/       /
%           W                                           W
% 
%      <----------------------------- T ------------------------------->
% 
% 
% 
% The new orientation is defined by setting the "OLD DIMENSIONS" to 
% "NEW DIMENSIONS" flags.  On the graphical user interface accessible via
% cantata, these flags are represented as a matrix of buttons, where each 
% row of the matrix represents the set of dimensions that will be oriented to 
% the new dimension.  On the command line, these flags are specified
% by two letter combinations of w,h,d,t,e -- the first letter indicates the 
% source, or old, dimension, the second indicates the destination, or new, 
% dimension.  For example, 
% 	
% 	korient -i infile -o outfile -hw 
% 
% will cause the height dimension (along with the width dimension) to be 
% reoriented along the width dimension.  
% If the input file has width = 4, height = 2, as shown below, 
% the output dimension will have width = 8, height = 1.
% 
% \f(CW
% Input Data:     1 2 3 4
% 		5 6 7 8
% 		
% Output Data:	1 2 3 4 5 6 7 8
% 
% 
% To transpose the same data set, one would execute
% 	
% 	korient -i infile -o outfile -wh -hw
% 
% 
% \f(CW
% Output Data:    1 5
% 		2 6
% 		3 7
% 		4 8
% 
% 
% As is illustrated above, data existing on a set of dimensions
% can be reoriented to a single dimension.  When this occurs,
% data will be arranged according to the following dimensional order:  Width, 
% Height, Elements, Depth, Time.
% 
% If defaults (korient -i infile -o outfile -ww, -hh, -ee, -dd, -tt) are used, 
% no change in orientation will occur between the input and output data files.
% 
% Implementation issue: If data on a dimension is not being transferred to 
% another dimension, first set that dimension for no transfer.  For example,
% if no flags have been set to orient width data along another dimension, 
% the -ww flag is set.  Then build the set of dimensions that
% will be oriented along the new dimension by going vertical on the 
% user interface matrix.  For example, the two letter flags that end
% in w that have been specified on the command line indicate the 
% dimensions that will be reoriented.
% 
%  "Map Data"
% If the source object has map data, the map data cannot
% have depth, time, or elements dimensions of greater than
% one.  The map width and height dimensions can be any size.
% 
%  "Location & Time Data"
% If the source object has rectilinear or curvilinear
% location or time data, the orientation operator will fail.  If the
% source object has uniform location data, orientation will
% continue, but the location data will not be modified
% to reflect the reorientation.
% 
%  "Map Data"
% If the object has mask data, it will be reoriented along with the value data.
% 
%  "Failure Modes"
% The orientation operator will fail if the source object does not contain
% value data, or if it contains rectilinear or curvilinear location or time
% data.
%
%  
%
%  EXAMPLES
%
%  "SEE ALSO"
% kaxis
%
%  RESTRICTIONS 
% This program has not yet been updated to completely support the
% polymorphic data model.
%
%  REFERENCES 
%
%  COPYRIGHT
% Copyright (C) 1993 - 1997, Khoral Research, Inc. ("KRI")  All rights reserved.
% 


function varargout = kkorient(varargin)
if nargin ==0
  Inputs={};arglist={'',''};
elseif nargin ==1
  Inputs=varargin{1};arglist={'',''};
elseif nargin ==2
  Inputs=varargin{1}; arglist=varargin{2};
else error('Usage: [out1,..] = kkorient(Inputs,arglist).');
end
if size(arglist,2)~=2
  error('arglist must be of form {''ParameterTag1'',value1;''ParameterTag2'',value2}')
 end
narglist={'i', '__input';'o', '__output';'ww', 0;'wh', 0;'we', 0;'wd', 0;'wt', 0;'hw', 0;'hh', 0;'he', 0;'hd', 0;'ht', 0;'ew', 0;'eh', 0;'ee', 0;'ed', 0;'et', 0;'dw', 0;'dh', 0;'de', 0;'dd', 0;'dt', 0;'tw', 0;'th', 0;'te', 0;'td', 0;'tt', 0};
maxval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
minval={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
istoggle=[0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
was_set=istoggle * 0;
paramtype={'InputFile','OutputFile','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle','Toggle'};
% identify the input arrays and assign them to the arguments as stated by the user
if ~iscell(Inputs)
Inputs = {Inputs};
end
NumReqOutputs=1; nextinput=1; nextoutput=1;
  for ii=1:size(arglist,1)
  wasmatched=0;
  for jj=1:size(narglist,1)
   if strcmp(arglist{ii,1},narglist{jj,1})  % a given argument was matched to the possible arguments
     wasmatched = 1;
     was_set(jj) = 1;
     if strcmp(narglist{jj,2}, '__input')
      if (nextinput > length(Inputs)) 
        error(['Input ' narglist{jj,1} ' has no corresponding input!']); 
      end
      narglist{jj,2} = 'OK_in';
      nextinput = nextinput + 1;
     elseif strcmp(narglist{jj,2}, '__output')
      if (nextoutput > nargout) 
        error(['Output nr. ' narglist{jj,1} ' is not present in the assignment list of outputs !']); 
      end
      if (isempty(arglist{ii,2}))
        narglist{jj,2} = 'OK_out';
      else
        narglist{jj,2} = arglist{ii,2};
      end

      nextoutput = nextoutput + 1;
      if (minval{jj} == 0)  
         NumReqOutputs = NumReqOutputs - 1;
      end
     elseif isstr(arglist{ii,2})
      narglist{jj,2} = arglist{ii,2};
     else
        if strcmp(paramtype{jj}, 'Integer') & (round(arglist{ii,2}) ~= arglist{ii,2})
            error(['Argument ' arglist{ii,1} ' is of integer type but non-integer number ' arglist{ii,2} ' was supplied']);
        end
        if (minval{jj} ~= 0 | maxval{jj} ~= 0)
          if (minval{jj} == 1 & maxval{jj} == 1 & arglist{ii,2} < 0)
            error(['Argument ' arglist{ii,1} ' must be bigger or equal to zero!']);
          elseif (minval{jj} == -1 & maxval{jj} == -1 & arglist{ii,2} > 0)
            error(['Argument ' arglist{ii,1} ' must be smaller or equal to zero!']);
          elseif (minval{jj} == 2 & maxval{jj} == 2 & arglist{ii,2} <= 0)
            error(['Argument ' arglist{ii,1} ' must be bigger than zero!']);
          elseif (minval{jj} == -2 & maxval{jj} == -2 & arglist{ii,2} >= 0)
            error(['Argument ' arglist{ii,1} ' must be smaller than zero!']);
          elseif (minval{jj} ~= maxval{jj} & arglist{ii,2} < minval{jj})
            error(['Argument ' arglist{ii,1} ' must be bigger than ' num2str(minval{jj})]);
          elseif (minval{jj} ~= maxval{jj} & arglist{ii,2} > maxval{jj})
            error(['Argument ' arglist{ii,1} ' must be smaller than ' num2str(maxval{jj})]);
          end
        end
     end
     if ~strcmp(narglist{jj,2},'OK_out') &  ~strcmp(narglist{jj,2},'OK_in') 
       narglist{jj,2} = arglist{ii,2};
     end
   end
   end
   if (wasmatched == 0 & ~strcmp(arglist{ii,1},''))
        error(['Argument ' arglist{ii,1} ' is not a valid argument for this function']);
   end
end
% match the remaining inputs/outputs to the unused arguments and test for missing required inputs
 for jj=1:size(narglist,1)
     if  strcmp(paramtype{jj}, 'Toggle')
        if (narglist{jj,2} ==0)
          narglist{jj,1} = ''; 
        end;
        narglist{jj,2} = ''; 
     end;
     if  ~strcmp(narglist{jj,2},'__input') && ~strcmp(narglist{jj,2},'__output') && istoggle(jj) && ~ was_set(jj)
          narglist{jj,1} = ''; 
          narglist{jj,2} = ''; 
     end;
     if strcmp(narglist{jj,2}, '__input')
      if (minval{jj} == 0)  % meaning this input is required
        if (nextinput > size(Inputs)) 
           error(['Required input ' narglist{jj,1} ' has no corresponding input in the list!']); 
        else
          narglist{jj,2} = 'OK_in';
          nextinput = nextinput + 1;
        end
      else  % this is an optional input
        if (nextinput <= length(Inputs)) 
          narglist{jj,2} = 'OK_in';
          nextinput = nextinput + 1;
        else 
          narglist{jj,1} = '';
          narglist{jj,2} = '';
        end;
      end;
     else 
     if strcmp(narglist{jj,2}, '__output')
      if (minval{jj} == 0) % this is a required output
        if (nextoutput > nargout & nargout > 1) 
           error(['Required output ' narglist{jj,1} ' is not stated in the assignment list!']); 
        else
          narglist{jj,2} = 'OK_out';
          nextoutput = nextoutput + 1;
          NumReqOutputs = NumReqOutputs-1;
        end
      else % this is an optional output
        if (nargout - nextoutput >= NumReqOutputs) 
          narglist{jj,2} = 'OK_out';
          nextoutput = nextoutput + 1;
        else 
          narglist{jj,1} = '';
          narglist{jj,2} = '';
        end;
      end
     end
  end
end
if nargout
   varargout = cell(1,nargout);
else
  varargout = cell(1,1);
end
global KhorosRoot
if exist('KhorosRoot') && ~isempty(KhorosRoot)
w=['"' KhorosRoot];
else
if ispc
  w='"C:\Program Files\dip\khorosBin\';
else
[s,w] = system('which cantata');
w=['"' w(1:end-8)];
end
end
[varargout{:}]=callKhoros([w 'korient"  '],Inputs,narglist);