state("My Friend Pedro - Blood Bullets Bananas") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "My Friend Pedro";

    settings.Add("start", true, "Start settings:");
        settings.Add("s-3", true, "Tutorial", "start");
        settings.Add("s-6", false, "Old Town", "start");
        settings.Add("s-15", false, "District Null", "start");
        settings.Add("s-25", false, "Pedro's World", "start");
        settings.Add("s-31", false, "The Sewer", "start");
        settings.Add("s-43", false, "The Internet", "start");
        settings.Add("s-52", false, "Pedro Fight", "start");

    settings.Add("tutorial", true, "Tutorial");
        settings.Add("l-3", true, "Level 1", "tutorial");
        settings.Add("l-4", true, "Level 2", "tutorial");
        settings.Add("l-5", true, "Level 3", "tutorial");
    settings.Add("oldtown", true, "Old Town");
        settings.Add("l-6", true, "Level 1", "oldtown");
        settings.Add("l-7", true, "Level 2", "oldtown");
        settings.Add("l-8", true, "Level 3", "oldtown");
        settings.Add("l-9", true, "Level 4", "oldtown");
        settings.Add("l-10", true, "Level 5", "oldtown");
        settings.Add("l-11", true, "Level 6", "oldtown");
        settings.Add("l-12", true, "Level 7", "oldtown");
        settings.Add("l-13", true, "Take Motorcycle", "oldtown");
        settings.Add("l-14", true, "Level 8", "oldtown");
    settings.Add("districtnull", true, "District Null");
        settings.Add("l-15", true, "Arrive at District Null", "districtnull");
        settings.Add("l-16", true, "Level 1", "districtnull");
        settings.Add("l-17", true, "Level 2", "districtnull");
        settings.Add("l-18", true, "Level 3", "districtnull");
        settings.Add("l-19", true, "Level 4", "districtnull");
        settings.Add("l-20", true, "Level 5", "districtnull");
        settings.Add("l-21", true, "Level 6", "districtnull");
        settings.Add("l-22", true, "Level 7", "districtnull");
        settings.Add("l-23", true, "Level 8", "districtnull");
        settings.Add("l-24", true, "Level 9", "districtnull");
    settings.Add("pedrosworld", true, "Pedro's World");
        settings.Add("l-25", true, "Level 1", "pedrosworld");
        settings.Add("l-26", true, "Level 2", "pedrosworld");
        settings.Add("l-27", true, "Level 3", "pedrosworld");
        settings.Add("l-28", true, "Level 4", "pedrosworld");
    settings.Add("sewer", true, "The Sewer");
        settings.Add("l-29", true, "Enter Sewer", "pedrosworld");
        settings.Add("l-30", true, "Arcade Cutscene", "sewer");
        settings.Add("l-31", true, "Level 1", "sewer");
        settings.Add("l-32", true, "Level 2", "sewer");
        settings.Add("l-33", true, "Level 3", "sewer");
        settings.Add("l-34", true, "Level 4", "sewer");
        settings.Add("l-35", true, "Level 5", "sewer");
        settings.Add("l-36", true, "Level 6", "sewer");
        settings.Add("l-37", true, "Level 7", "sewer");
        settings.Add("l-38", true, "Level 8", "sewer");
        settings.Add("l-39", true, "Level 9", "sewer");
        settings.Add("l-40", true, "Enter Train", "sewer");
        settings.Add("l-41", true, "Level 10", "sewer");
    settings.Add("theinternet", true, "The Internet");
        settings.Add("l-42", true, "Exit Train", "theinternet");
        settings.Add("l-43", true, "Level 1", "theinternet");
        settings.Add("l-44", true, "Level 2", "theinternet");
        settings.Add("l-45", true, "Level 3", "theinternet");
        settings.Add("l-46", true, "Level 4", "theinternet");
        settings.Add("l-47", true, "Level 5", "theinternet");
        settings.Add("l-48", true, "Level 6", "theinternet");
        settings.Add("l-49", true, "Level 7", "theinternet");
        settings.Add("l-50", true, "Level 8", "theinternet");
        settings.Add("l-51", true, "Resist", "theinternet");
    settings.Add("theend", true, "The End");
        settings.Add("l-52", true, "Pedro Fight", "theend");

    vars.TimeFormats = new[]
    {
        @"h\:mm\:ss\.ff",
        @"m\:ss\.ff"
    };

    vars.Helper.AlertGameTime();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var rss = mono["Assembly-UnityScript", "RootSharedScript"];
        var uts = mono["Assembly-UnityScript", "UITimerScript"];
        var tmpt = mono["TextMeshPro-2017.3-Runtime", "TMP_Text"];

        vars.Helper["Level"] = mono.Make<int>(rss, "Instance", "loadingScreenLevelToLoad");
        vars.Helper["TimeStr"] = mono.MakeString(rss, "Instance", "uiTimer", 0x10, 0x30, 0x10 * 3 + 0x8, 0x28, uts["uiTimerTotal"], tmpt["m_text"]);

        return true;
    });
}

update
{
    var len = current.TimeStr.Length;

    var min = current.TimeStr.Substring(0, len - 18);
    var ms = current.TimeStr.Substring(len - 9, 2);

    // This kinda sucks because parsing is slow.
    // The alternative is finding a pointer to TimeManager.unscaledTime and doing the math ourselves.
    // But I can't really be bothered to do that right now.
    current.Time = TimeSpan.ParseExact(min + "." + ms, vars.TimeFormats, System.Globalization.CultureInfo.InvariantCulture);
}

start
{
    return old.Level != current.Level
        && settings["s-" + current.Level];
}

split
{
    return old.Level != current.Level
        && settings["l-" + old.Level];
}

reset
{
    return old.Level != current.Level
        && current.Level == 1;
}

gameTime
{
    return current.Time;
}

isLoading
{
    return true;
}

exit
{
    timer.IsGameTimePaused = true;
}
