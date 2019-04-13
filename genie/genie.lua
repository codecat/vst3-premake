local DIR_ROOT = (path.getabsolute('..') .. '/')
local DIR_VST3TEST = DIR_ROOT .. 'Vst3Test/'
local DIR_VST3_SDK = 'D:/Dev/VST3_SDK/'

solution 'Vst3Test'
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
	flags {
		'NoRTTI',
		'Cpp11',

		'FullSymbols',
		'Symbols',
	}

	-- Uncomment when this bug is fixed: https://github.com/bkaradzic/GENie/issues/426
	--targetextension '.vst3'

	-- Configurations
	configuration 'Debug'
		targetdir(DIR_ROOT .. 'bin/debug/')
		removeflags { 'Optimize' }

	configuration 'Release'
		targetdir(DIR_ROOT .. 'bin/release/')
		flags { 'OptimizeSpeed' }

	-- Vst3Test project
	project 'Vst3Test'
		kind 'SharedLib'

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
			DIR_VST3_SDK .. 'base/**.cpp',
			DIR_VST3_SDK .. 'base/**.h',

			DIR_VST3_SDK .. 'pluginterfaces/**.cpp',
			DIR_VST3_SDK .. 'pluginterfaces/**.h',

			DIR_VST3_SDK .. 'public.sdk/source/common/**.cpp',
			DIR_VST3_SDK .. 'public.sdk/source/common/**.h',

			DIR_VST3_SDK .. 'public.sdk/source/vst/*.cpp',
			DIR_VST3_SDK .. 'public.sdk/source/vst/*.h',
			DIR_VST3_SDK .. 'public.sdk/source/vst/utility/**.cpp',
			DIR_VST3_SDK .. 'public.sdk/source/vst/utility/**.h',

			DIR_VST3_SDK .. 'public.sdk/source/main/pluginfactory.cpp',
			DIR_VST3_SDK .. 'public.sdk/source/main/pluginfactory.h',
		}

		-- SDK includes
		includedirs {
			DIR_VST3_SDK,
		}

		-- These need to be excluded for the VST3 SDK as they're getting included
		-- from other cpp files. (strange but ok)
		removefiles {
			DIR_VST3_SDK .. 'public.sdk/source/vst/vsteditcontroller.cpp',
			DIR_VST3_SDK .. 'public.sdk/source/vst/basewrapper/basewrapper.sdk.cpp',
		}

		-- Exclude some things we don't care about for this test
		removefiles {
			DIR_VST3_SDK .. 'public.sdk/source/vst/vstgui*',
		}

		-- Platform-dependant files
		if os.get() == 'windows' then
			files {
				DIR_VST3_SDK .. 'public.sdk/source/main/dllmain.cpp',
			}
		elseif os.get() == 'macosx' then
			files {
				DIR_VST3_SDK .. 'public.sdk/source/main/macmain.cpp',
			}
		elseif os.get() == 'linux' then
			files {
				DIR_VST3_SDK .. 'public.sdk/source/main/linuxmain.cpp',
			}
		end
