classdef statisticsInput_App_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1               matlab.ui.Figure
        uipanel1              matlab.ui.container.Panel
        text2                 matlab.ui.control.Label
        g1ManualSelectionBtn  matlab.ui.control.Button
        g1BatchSelectionBtn   matlab.ui.control.Button
        g1ListBox             matlab.ui.control.ListBox
        text2_2               matlab.ui.control.Label
        g1Total               matlab.ui.control.EditField
        unitgroup             matlab.ui.container.ButtonGroup
        text1                 matlab.ui.control.Label
        g2ManualSelectionBtn  matlab.ui.control.Button
        g2BatchSelectionBtn   matlab.ui.control.Button
        g2ListBox             matlab.ui.control.ListBox
        text2_3               matlab.ui.control.Label
        g2Total               matlab.ui.control.EditField
        go                    matlab.ui.control.Button
        text8                 matlab.ui.control.Label
        text9                 matlab.ui.control.Label
        outputDir             matlab.ui.control.EditField
        outputDirBtn          matlab.ui.control.Button
    end

    
    methods (Access = private)
       
        
        function initialize_gui(app, fig_handle, handles, isreset)
            % If the metricdata field is present and the reset flag is false, it means
            % we are we are just re-initializing a GUI by calling it from the cmd line
            % while it is up. So, bail out as we dont want to reset the data.
 
            
            
            % Update handles structure
            guidata(handles.figure1, handles);
        end
        
    end
    

    % Callbacks that handle component events
    methods (Access = public)

        % Code that executes after component creation
        function statisticsInput_OpeningFcn(app, varargin)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app); %#ok<ASGLU>
            
            % This function has no output args, see OutputFcn.
            % hObject    handle to figure
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            % varargin   command line arguments to statisticsInput (see VARARGIN)
            
            % Choose default command line output for statisticsInput
            handles.output = hObject;
            
            % Update handles structure
            guidata(hObject, handles);
            
            initialize_gui(app, hObject, handles, false);
        end

     

        % Button pushed function: go
        function go_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to reset (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            initialize_gui(app, gcbf, handles, true);
        end

        % Selection changed function: unitgroup
        function unitgroup_SelectionChangedFcn(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            % hObject    handle to the selected object in unitgroup
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            
            
        end

       
        % Button pushed function: g1ManualSelectionBtn
        function G1ManualSelectionButtonPushed(app, event)
            
        end

        % Button pushed function: g1BatchSelectionBtn
        function G1BatchSelectionButtonPushed(app, event)
            
        end

        % Button pushed function: outputDirBtn
        function outputDirBtnPushed(app, event)
            
        end

        % Button pushed function: g2ManualSelectionBtn
        function G2ManualSelectionButton_2Pushed(app, event)
            
        end

        % Button pushed function: g2BatchSelectionBtn
        function G2BatchSelectionButton_2Pushed(app, event)
            
        end

        % Value changed function: g1ListBox
        function G1ListBoxValueChanged(app, event)
            value = app.g1ListBox.Value;
            
        end

        % Value changed function: g2ListBox
        function G2ListBoxValueChanged(app, event)
            value = app.g2ListBox.Value;
            
        end

        % Value changed function: g1Total
        function G1TotalValueChanged(app, event)
            value = app.g1Total.Value;
            
        end

        % Value changed function: g2Total
        function G2TotalValueChanged(app, event)
            value = app.g2Total.Value;
            
        end
    end

    % Component initialization
    methods (Access = public)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Color = [1 1 1];
            app.figure1.Position = [544 36 801 589];
            app.figure1.Name = 'Untitled';
            app.figure1.Scrollable = 'on';
            app.figure1.HandleVisibility = 'callback';
            app.figure1.Tag = 'figure1';

            % Create uipanel1
            app.uipanel1 = uipanel(app.figure1);
            app.uipanel1.BorderType = 'none';
            app.uipanel1.TitlePosition = 'centertop';
            app.uipanel1.Title = 'Group 1';
            app.uipanel1.BackgroundColor = [0.9412 0.9412 0.9412];
            app.uipanel1.Tag = 'uipanel1';
            app.uipanel1.FontWeight = 'bold';
            app.uipanel1.FontSize = 14;
            app.uipanel1.Position = [26 61 361 421];

            % Create text2
            app.text2 = uilabel(app.uipanel1);
            app.text2.Tag = 'text2';
            app.text2.HorizontalAlignment = 'right';
            app.text2.VerticalAlignment = 'top';
            app.text2.FontSize = 11;
            app.text2.Position = [27 331 117 16];
            app.text2.Text = 'Files/Groups Selected:';

            % Create g1ManualSelectionBtn
            app.g1ManualSelectionBtn = uibutton(app.uipanel1, 'push');
            app.g1ManualSelectionBtn.ButtonPushedFcn = createCallbackFcn(app, @G1ManualSelectionButtonPushed, true);
            app.g1ManualSelectionBtn.Tag = 'g1ManualSelectionBtn';
            app.g1ManualSelectionBtn.Position = [29 364 135 22];
            app.g1ManualSelectionBtn.Text = 'Manual Selection';

            % Create g1BatchSelectionBtn
            app.g1BatchSelectionBtn = uibutton(app.uipanel1, 'push');
            app.g1BatchSelectionBtn.ButtonPushedFcn = createCallbackFcn(app, @G1BatchSelectionButtonPushed, true);
            app.g1BatchSelectionBtn.Tag = 'g1BatchSelectionBtn';
            app.g1BatchSelectionBtn.Position = [212 364 128 22];
            app.g1BatchSelectionBtn.Text = 'Batch Selection';

            % Create g1ListBox
            app.g1ListBox = uilistbox(app.uipanel1);
            app.g1ListBox.Items = {};
            app.g1ListBox.ValueChangedFcn = createCallbackFcn(app, @G1ListBoxValueChanged, true);
            app.g1ListBox.Tag = 'g1ListBox';
            app.g1ListBox.Position = [27 43 310 288];
            app.g1ListBox.Value = {};

            % Create text2_2
            app.text2_2 = uilabel(app.uipanel1);
            app.text2_2.Tag = 'text2';
            app.text2_2.HorizontalAlignment = 'right';
            app.text2_2.VerticalAlignment = 'top';
            app.text2_2.FontSize = 11;
            app.text2_2.Position = [29 11 160 22];
            app.text2_2.Text = 'Number of Subjects in Group 1:';

            % Create g1Total
            app.g1Total = uieditfield(app.uipanel1, 'text');
            app.g1Total.ValueChangedFcn = createCallbackFcn(app, @G1TotalValueChanged, true);
            app.g1Total.Tag = 'g1Total';
            app.g1Total.Editable = 'off';
            app.g1Total.HorizontalAlignment = 'center';
            app.g1Total.FontSize = 13;
            app.g1Total.Position = [203 15 134 21];

            % Create unitgroup
            app.unitgroup = uibuttongroup(app.figure1);
            app.unitgroup.SelectionChangedFcn = createCallbackFcn(app, @unitgroup_SelectionChangedFcn, true);
            app.unitgroup.TitlePosition = 'centertop';
            app.unitgroup.Title = 'Group 2';
            app.unitgroup.Tag = 'unitgroup';
            app.unitgroup.FontWeight = 'bold';
            app.unitgroup.FontSize = 14;
            app.unitgroup.Position = [420 61 359 421];

            % Create text1
            app.text1 = uilabel(app.unitgroup);
            app.text1.Tag = 'text1';
            app.text1.HorizontalAlignment = 'right';
            app.text1.VerticalAlignment = 'top';
            app.text1.FontSize = 11;
            app.text1.Position = [25 331 117 14];
            app.text1.Text = 'Files/Groups Selected:';

            % Create g2ManualSelectionBtn
            app.g2ManualSelectionBtn = uibutton(app.unitgroup, 'push');
            app.g2ManualSelectionBtn.ButtonPushedFcn = createCallbackFcn(app, @G2ManualSelectionButton_2Pushed, true);
            app.g2ManualSelectionBtn.Tag = 'g2ManualSelectionBtn';
            app.g2ManualSelectionBtn.Position = [25 363 135 22];
            app.g2ManualSelectionBtn.Text = 'Manual Selection';

            % Create g2BatchSelectionBtn
            app.g2BatchSelectionBtn = uibutton(app.unitgroup, 'push');
            app.g2BatchSelectionBtn.ButtonPushedFcn = createCallbackFcn(app, @G2BatchSelectionButton_2Pushed, true);
            app.g2BatchSelectionBtn.Tag = 'g2BatchSelectionBtn';
            app.g2BatchSelectionBtn.Position = [207 363 128 22];
            app.g2BatchSelectionBtn.Text = 'Batch Selection';

            % Create g2ListBox
            app.g2ListBox = uilistbox(app.unitgroup);
            app.g2ListBox.Items = {};
            app.g2ListBox.ValueChangedFcn = createCallbackFcn(app, @G2ListBoxValueChanged, true);
            app.g2ListBox.Tag = 'g2ListBox';
            app.g2ListBox.Position = [25 42 310 286];
            app.g2ListBox.Value = {};

            % Create text2_3
            app.text2_3 = uilabel(app.unitgroup);
            app.text2_3.Tag = 'text2';
            app.text2_3.HorizontalAlignment = 'right';
            app.text2_3.VerticalAlignment = 'top';
            app.text2_3.FontSize = 11;
            app.text2_3.Position = [25 10 160 22];
            app.text2_3.Text = 'Number of Subjects in Group 2:';

            % Create g2Total
            app.g2Total = uieditfield(app.unitgroup, 'text');
            app.g2Total.ValueChangedFcn = createCallbackFcn(app, @G2TotalValueChanged, true);
            app.g2Total.Tag = 'g2Total';
            app.g2Total.Editable = 'off';
            app.g2Total.HorizontalAlignment = 'center';
            app.g2Total.FontSize = 13;
            app.g2Total.Position = [201 14 134 21];

            % Create go
            app.go = uibutton(app.figure1, 'push');
            app.go.ButtonPushedFcn = createCallbackFcn(app, @go_Callback, true);
            app.go.Tag = 'go';
            app.go.BackgroundColor = [0.651 0.651 0.651];
            app.go.FontSize = 14;
            app.go.FontWeight = 'bold';
            app.go.Position = [363 9 79 36];
            app.go.Text = 'GO';

            % Create text8
            app.text8 = uilabel(app.figure1);
            app.text8.Tag = 'text8';
            app.text8.BackgroundColor = [1 1 1];
            app.text8.HorizontalAlignment = 'center';
            app.text8.VerticalAlignment = 'top';
            app.text8.FontSize = 16;
            app.text8.FontWeight = 'bold';
            app.text8.Position = [129 508 171 31];
            app.text8.Text = 'Save Results in';

            % Create text9
            app.text9 = uilabel(app.figure1);
            app.text9.Interruptible = 'off';
            app.text9.Tag = 'text9';
            app.text9.BackgroundColor = [0 0 0];
            app.text9.HorizontalAlignment = 'center';
            app.text9.VerticalAlignment = 'top';
            app.text9.FontSize = 19;
            app.text9.FontWeight = 'bold';
            app.text9.FontColor = [1 1 1];
            app.text9.Position = [1 557 801 33];
            app.text9.Text = 'Statistics';

            % Create outputDir
            app.outputDir = uieditfield(app.figure1, 'text');
            app.outputDir.Tag = 'outputDir';
            app.outputDir.HorizontalAlignment = 'center';
            app.outputDir.FontSize = 13;
            app.outputDir.Position = [300 512 301 27];

            % Create outputDirBtn
            app.outputDirBtn = uibutton(app.figure1, 'push');
            app.outputDirBtn.ButtonPushedFcn = createCallbackFcn(app, @outputDirBtnPushed, true);
            app.outputDirBtn.Tag = 'outputDirBtn';
            app.outputDirBtn.FontSize = 13;
            app.outputDirBtn.Position = [600 510 50 30];
            app.outputDirBtn.Text = '...';

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = statisticsInput_App_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.figure1)

            % Execute the startup function
            runStartupFcn(app, @(app)statisticsInput_OpeningFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure1)
        end
    end
end