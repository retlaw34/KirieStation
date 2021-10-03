//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		//Mining Z levels
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\Mining\Icemoon.dmm"
		#include "map_files\Mining\Rockplanet.dmm"
		#include "map_files\Mining\Jungle.dmm"
		#include "map_files\Mining\Tidalmoon.dmm"

		//SMC Missions
		#include "map_files\Mining\mission_phobos.dmm"
		#include "map_files\Mining\mission_ice.dmm"

		//Debug Z Levels
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\debug\multiz.dmm"

		//Rotation maps
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\PackedStation\PackedStation.dmm"
		#include "map_files\RemoraStation\RemoraStation.dmm"
		#include "map_files\BoxStation\BoxStation.dmm"
		#include "map_files\PubbyStation\PubbyStation.dmm"
		#include "map_files\ChimeraStation\ChimeraStation.dmm"

		//Admin only maps
		#include "map_files\HelioStation\HelioStation.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\PhoboStation\PhoboStation.dmm"
		#include "map_files\AndromedaStation\Andromeda.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
