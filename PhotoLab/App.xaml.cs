// LFInteractive LLC. 2021-2024﻿
namespace PhotoLab;

public partial class App : Application
{
    public App()
    {
        InitializeComponent();

        MainPage = new MainPage();
    }

    protected override Window CreateWindow(IActivationState activationState)
    {
        Window window = base.CreateWindow(activationState);
        window.Title = "PhotoLab - Open Source Photo Gallery";

        window.MinimumWidth = 800;
        window.MinimumHeight = 480;

        return window;
    }
}