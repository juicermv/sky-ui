workspace "sky-ui"
	configurations { "ReleaseSA", "DebugSA", "ReleaseVC", "DebugVC", "ReleaseIII", "DebugIII" }
	location "project_files"
   
project "sky-ui"
	kind "SharedLib"
	language "C++"
	targetdir "output/asi/"
	objdir ("output/obj")
	targetextension ".asi"
	characterset ("MBCS")
	linkoptions "/SAFESEH:NO"
	buildoptions { "-std:c++latest", "/permissive" }
	defines { "_CRT_SECURE_NO_WARNINGS", "_CRT_NON_CONFORMING_SWPRINTFS", "_USE_MATH_DEFINES" }
	disablewarnings { "4244", "4800", "4305", "4073", "4838", "4996", "4221", "4430", "26812", "26495", "6031" }

	files {
		"source/**.*",
	}
	
	includedirs { 
		"source/**",
	}
	
	includedirs {
		"$(PLUGIN_SDK_DIR)/shared/",
		"$(PLUGIN_SDK_DIR)/shared/game/",
	}
	
	filter { "configurations:*III" }
		defines { "GTA3", "PLUGIN_SGV_10EN" }
		includedirs {
			"$(PLUGIN_SDK_DIR)/plugin_III/",
			"$(PLUGIN_SDK_DIR)/plugin_III/game_III/",
			"$(RWD3D9_DIR)/source"
		}
		targetname "SkyUI"
		debugdir "$(GTA_III_DIR)"
		debugcommand "$(GTA_III_DIR)/gta3.exe"
		postbuildcommands "copy /y \"$(TargetPath)\" \"$(GTA_III_DIR)\\scripts\\SkyUI.asi\""
		
	filter { "configurations:*VC" }	
		defines { "GTAVC", "PLUGIN_SGV_10EN" }	
		includedirs {
			"$(PLUGIN_SDK_DIR)/plugin_vc/",
			"$(PLUGIN_SDK_DIR)/plugin_vc/game_vc/",
			"$(RWD3D9_DIR)/source"
		}
		targetname "SkyUI"
		debugdir "$(GTA_VC_DIR)"
		debugcommand "$(GTA_VC_DIR)/gta-vc.exe"
		postbuildcommands "copy /y \"$(TargetPath)\" \"$(GTA_VC_DIR)\\scripts\\SkyUI.asi\""
	
	filter { "configurations:*SA" }
		defines { "GTASA", "PLUGIN_SGV_10US" }
		includedirs {
			"$(PLUGIN_SDK_DIR)/plugin_sa/",
			"$(PLUGIN_SDK_DIR)/plugin_sa/game_sa/"
		}
		targetname "SkyUI"
		debugdir "$(GTA_SA_DIR)"
		debugcommand "$(GTA_SA_DIR)/gta-sa.exe"
		postbuildcommands "copy /y \"$(TargetPath)\" \"$(GTA_SA_DIR)\\scripts\\SkyUI.asi\""
	
	filter { }
	
	libdirs { 
		"$(PLUGIN_SDK_DIR)/output/lib/",
	}
	
	filter "configurations:Debug*"		
		defines { "DEBUG" }
		symbols "on"
		staticruntime "on"

	filter "configurations:Release*"
		defines { "NDEBUG" }
		symbols "off"
		optimize "On"
		staticruntime "on"
		
	filter "configurations:ReleaseSA"
		links { "plugin" }
	filter "configurations:ReleaseVC"
		links { "plugin_vc" }
	filter "configurations:ReleaseIII"
		links { "plugin_iii" }
		
	filter "configurations:DebugSA"
		links { "plugin_d" }
	filter "configurations:DebugVC"
		links { "plugin_vc_d" }
	filter "configurations:DebugIII"
		links { "plugin_iii_d" }
			
	filter { }
