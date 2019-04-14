local DIR_ROOT = (path.getabsolute('..') .. '/')
local DIR_VST3TEST = DIR_ROOT .. 'Vst3Test/'
local DIR_VST3_SDK = 'D:/Dev/VST3_SDK/'

workspace 'Vst3Test'
	language 'C++'
	location('Projects/' .. _ACTION)

	-- Configurations
	configurations {
		'Debug',
		'Release',
	}

	-- Platforms
	platforms {
		'x64',
	}

	-- Flags
	cppdialect 'C++11'
	symbols 'On' -- Or 'Full'

	-- Configurations
	configuration 'Debug'
		targetdir(DIR_ROOT .. 'bin/debug/')
		optimize 'Off'

	configuration 'Release'
		targetdir(DIR_ROOT .. 'bin/release/')
		optimize 'Speed'

	-- Vst3Test project
	project 'Vst3Test'
		kind 'SharedLib'

		-- Vst3 target extension
		targetextension '.vst3'

		-- Processor files
		files {
			DIR_VST3TEST .. '**.cpp',
			DIR_VST3TEST .. '**.hpp',
			DIR_VST3TEST .. '**.c',
			DIR_VST3TEST .. '**.h',
		}

		-- Processor includes
		includedirs {
			DIR_VST3TEST,
		}

		-- SDK files
		files {
			path.join(DIR_VST3_SDK, 'base/**.cpp'),
			path.join(DIR_VST3_SDK, 'base/**.h'),

			path.join(DIR_VST3_SDK, 'pluginterfaces/**.cpp'),
			path.join(DIR_VST3_SDK, 'pluginterfaces/**.h'),

			path.join(DIR_VST3_SDK, 'public.sdk/source/common/**.cpp'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/common/**.h'),

			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/*.cpp'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/*.h'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/utility/**.cpp'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/utility/**.h'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/hosting/parameterchanges.cpp'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/hosting/parameterchanges.h'),

			path.join(DIR_VST3_SDK, 'public.sdk/source/main/pluginfactory.cpp'),
			path.join(DIR_VST3_SDK, 'public.sdk/source/main/pluginfactory.h'),
		}

		-- SDK includes
		includedirs {
			DIR_VST3_SDK,
		}

		removefiles {
			-- This needs to be excluded as it's getting included from other cpp files (strange but ok)
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/vsteditcontroller.cpp'),

			-- We don't need vstgui
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/vstgui*'),
		}

		-- Exclude some things we don't care about for this test
		removefiles {
			path.join(DIR_VST3_SDK, 'public.sdk/source/vst/vstgui*'),
		}

		-- Platform-dependant files
		filter 'system:windows'
			files { path.join(DIR_VST3_SDK, 'public.sdk/source/main/dllmain.cpp') }
		filter 'system:macosx'
			files { path.join(DIR_VST3_SDK, 'public.sdk/source/main/macmain.cpp') }
		filter 'system:linux'
			files { path.join(DIR_VST3_SDK, 'public.sdk/source/main/linuxmain.cpp') }
