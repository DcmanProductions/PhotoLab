// LFInteractive LLC. 2021-2024﻿
using Microsoft.Extensions.Logging;
using System.Reflection;

namespace PhotoLab
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder.UseMauiApp<App>();

            builder.Services.AddMauiBlazorWebView();

#if DEBUG
            builder.Services.AddBlazorWebViewDeveloperTools();
            builder.Logging.AddDebug();
#endif

            Task.Run(() =>
            {
                Chase.FFmpeg.Downloader.FFmpegDownloader.Instance.GetLatest(Directory.GetParent(Assembly.GetExecutingAssembly().Location).CreateSubdirectory("ffmpeg").FullName);
            }).Wait();
            return builder.Build();
        }
    }
}