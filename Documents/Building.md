# Building this application from source

So, you want to build this thing on your PC? I don't blame ya, messing with the source code and pushing something to its limits can be fun! This guide will walk you through how to build the app on your PC.

**Note:** I do not have a Mac. Unfortunately, that means I do not have the ability to give instructions for building on a Mac.

## What you'll need

Alright, first up. Let's get some things set up on your PC before we build.

You'll need the latest version of [Haxe](https://haxe.org/download). If you're on Windows, choose the Windows installer for your PC's architecture. You can find that in one of three places: Settings > System > About (under system type), Control Panel > System and Security > System, or msinfo32 (under System Type). An x86-based PC would need the **32-bit** installer, while an x64-based PC would need the **64-bit** installer. Make sure you pick the right one!

You'll also need to set up [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/). Just follow the instructions on their website.

In addition to HaxeFlixel's libraries, you also need (as of when this was written) one additional library.

To install it, type `haxelib install weatherapi-hx` in your terminal.

### Additional requirements for Windows

Linux/macOS users, you can ignore this step.

If you're compiling on Windows, you'll also need to set up Visual Studio Community 2019. It's not gonna be on the main Visual Studio Community page on Microsoft's website, so instead click [here](https://visualstudio.microsoft.com/vs/older-downloads/#visual-studio-2019-and-other-products) to get it. You'll have to sign into your Microsoft account.

In the Visual Studio Installer, ignore the workload options and instead go to the Individual Components tab. Search for and select these:
* MSVC v142 - VS 2019 C++ x64/x86 build tools (Latest)
* Windows 10 SDK (10.0.17763.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools (v14.16)

This install may take a while. Once it's done, you can continue to the next part of the guide.

## Compiling the application

So, you have everything set up? Good! Let's get a few more things out of the way before you can compile.

### API Keys

I gitignore the API key for WeatherAPI as I don't need to have that public. You can get your own API key by signing up [here](https://weatherapi.com/signup.aspx). On the dashboard you'll see after confirming your email and signing in, the API key will be right there. Just click copy and paste it into a new file in the Source folder named APIKey.hx:

```haxe
package;

class APIKey {
    public static final WeatherKey = 'YourKeyHere';
}
```

You should be good to go after that! **Do note that you *cannot* compile if you do not have an API key!**

### Actually compiling the app

Now then, you've got everything installed and your API key. Let's compile your application!

If you use VS Code like I do, open a new terminal and run `lime test windows -debug` (on Windows) or `lime test linux -debug` (on Linux) to make sure it works.

Otherwise, just open a terminal (cmd, PowerShell, doesn't matter) and run the same command in the directory of your cloned repository. (Usually just `C:\Users\YOURNAME\haxe-weather-thing` if you're on Windows, or `~/haxe-weather-thing` if you're on Linux)