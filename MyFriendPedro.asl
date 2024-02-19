state("My Friend Pedro - Blood Bullets Bananas", "Steam") {
    int iLevel      : "mono.dll", 0x264110, 0xA8, 0x18, 0x78;
}

state("My Friend Pedro - Blood Bullets Bananas", "Non-Steam") {
    int iLevel      : "mono.dll", 0x264110, 0x70, 0x18, 0x78;
}

startup {
    vars.levels = new Dictionary<int, Tuple<string, string>>{ {3, Tuple.Create("TutorialLevel_1","Tutorial 1")},
                                                              {4, Tuple.Create("TutorialLevel_2","Tutorial 2")},
                                                              {5, Tuple.Create("TutorialLevel_3","Tutorial 3")},
                                                              {6, Tuple.Create("OldTownLevel_1","Old Town 1")},
                                                              {7, Tuple.Create("OldTownLevel_2","Old Town 2")},
                                                              {8, Tuple.Create("OldTownLevel_3","Old Town 3")},
                                                              {9, Tuple.Create("OldTownLevel_4","Old Town 4")},
                                                              {10,Tuple.Create("OldTownLevel_5","Old Town 5")},
                                                              {11,Tuple.Create("OldTownLevel_6","Old Town 6")},
                                                              {12,Tuple.Create("OldTownLevel_7","Old Town 7")},
                                                              {13,Tuple.Create("OldTownLevel_7_5","Old Town 7.1 level with taking a bike")},
                                                              {14,Tuple.Create("OldTownLevel_8","Old Town 8")},
                                                              {15,Tuple.Create("DistrictNullLevel_Cutscene","District Null cutscene")},
                                                              {16,Tuple.Create("DistrictNullLevel_1","District Null 1")},
                                                              {17,Tuple.Create("DistrictNullLevel_2","District Null 2")},
                                                              {18,Tuple.Create("DistrictNullLevel_3","District Null 3")},
                                                              {19,Tuple.Create("DistrictNullLevel_4","District Null 4")},
                                                              {20,Tuple.Create("DistrictNullLevel_5","District Null 5")},
                                                              {21,Tuple.Create("DistrictNullLevel_6","District Null 6")},
                                                              {22,Tuple.Create("DistrictNullLevel_7","District Null 7")},
                                                              {23,Tuple.Create("DistrictNullLevel_8","District Null 8")},
                                                              {24,Tuple.Create("DistrictNullLevel_9","District Null 9")},
                                                              {25,Tuple.Create("PedroWorldLevel_1","Pedro's World 1")},
                                                              {26,Tuple.Create("PedroWorldLevel_2","Pedro's World 2")},
                                                              {27,Tuple.Create("PedroWorldLevel_3","Pedro's World 3")},
                                                              {28,Tuple.Create("PedroWorldLevel_4","Pedro's World 4")},
                                                              {29,Tuple.Create("PedroWorldLevel_CutScene","Pedro's World End Level cutscene")},
                                                              {30,Tuple.Create("SewerLevel_CutScene","The Sewer cutscene")},
                                                              {31,Tuple.Create("SewerLevel_1","The Sewer 1")},
                                                              {32,Tuple.Create("SewerLevel_2","The Sewer 2")},
                                                              {33,Tuple.Create("SewerLevel_3","The Sewer 3")},
                                                              {34,Tuple.Create("SewerLevel_4","The Sewer 4")},
                                                              {35,Tuple.Create("SewerLevel_5","The Sewer 5")},
                                                              {36,Tuple.Create("SewerLevel_6","The Sewer 6")},
                                                              {37,Tuple.Create("SewerLevel_7","The Sewer 7")},
                                                              {38,Tuple.Create("SewerLevel_8","The Sewer 8")},
                                                              {39,Tuple.Create("SewerLevel_9","The Sewer 9")},
                                                              {40,Tuple.Create("SewerLevel_CutScene2","The Sewer 9.1 level with jumping into a train")},
                                                              {41,Tuple.Create("SewerLevel_10","The Sewer 10")},
                                                              {42,Tuple.Create("InternetLevel_CutScene","The Internet cutscene")},
                                                              {43,Tuple.Create("InternetLevel_1","The Internet 1")},
                                                              {44,Tuple.Create("InternetLevel_2","The Internet 2")},
                                                              {45,Tuple.Create("InternetLevel_3","The Internet 3")},
                                                              {46,Tuple.Create("InternetLevel_4","The Internet 4")},
                                                              {47,Tuple.Create("InternetLevel_5","The Internet 5")},
                                                              {48,Tuple.Create("InternetLevel_6","The Internet 6")},
                                                              {49,Tuple.Create("InternetLevel_7","The Internet 7")},
                                                              {50,Tuple.Create("InternetLevel_8","The Internet 8")},
                                                              {51,Tuple.Create("InternetLevel_CutScene2","The Internet 8.1 level with spamming E")},
                                                              {52,Tuple.Create("PedroBossFightLevel","The End (Pedro Boss Fight)")}};
    
    settings.Add("StartGroup", true, "Start Timer At");
    settings.Add("TutorialLevel_start", true, "Tutorial", "StartGroup");
    settings.Add("OldTownLevel_start", false, "Old Town", "StartGroup");
    settings.Add("DistrictNullLevel_start", false, "District Null", "StartGroup");
    settings.Add("PedroWorldLevel_start", false, "Pedro World", "StartGroup");
    settings.Add("SewerLevel_start", false, "The Sewer", "StartGroup");
    settings.Add("InternetLevel_start", false, "The Internet", "StartGroup");
    settings.Add("PedroBossFightLevel_start", false, "The End", "StartGroup");
    settings.Add("level_splits", true, "Splits");    
    foreach (var level in vars.levels) {
        settings.Add(level.Value.Item1, true, level.Value.Item2, "level_splits");
    };
}

init {
    vars.LTArrayOffset = 0;
    vars.levelsTimer = new float[55];
    try {
        modules.Where(m => m.ModuleName == "steamclient64.dll").First();
        version = "Steam";
        vars.LTArrayOffset = 0x688;
    }
    catch {
        version = "Non-Steam";
        vars.LTArrayOffset = 0x618;
    }
}

split {
    return old.iLevel != current.iLevel && settings[vars.levels[old.iLevel].Item1];
}

reset {
    return current.iLevel == 1;
}

start {
    vars.TheTotalTime = 0;
    for (int i = 0; i <= 54; i++) {
        vars.levelsTimer[i] = 0;
    }
    if(settings["TutorialLevel_start"]) {
        return current.iLevel == 3;
    }
    if(settings["OldTownLevel_start"]) {
        return current.iLevel == 6;
    }
    if(settings["DistrictNullLevel_start"]) {
        return current.iLevel == 16;
    }
    if(settings["PedroWorldLevel_start"]) {
        return current.iLevel == 25;
    }
    if(settings["SewerLevel_start"]) {
        return current.iLevel == 31;
    }
    if(settings["InternetLevel_start"]) {
        return current.iLevel == 43;
    }
    if(settings["PedroBossFightLevel_start"]) {
        return current.iLevel == 52;
    }
}

isLoading {
    return true;
}

update {
    vars.levelsTimer[current.iLevel] = new DeepPointer(
        "mono.dll", 0x264110, vars.LTArrayOffset, 0x38, current.iLevel * 4 + 0x20).Deref<float>(game);
    vars.TheTotalTime = 0;
    vars.TheTotalTime = ((float[])vars.levelsTimer).Sum();
}

gameTime {
    return TimeSpan.FromSeconds(vars.TheTotalTime);
}

exit {
    timer.IsGameTimePaused = true;
}
