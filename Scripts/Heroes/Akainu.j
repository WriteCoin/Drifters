	function AkainuSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A049'
	endfunction

	function AkainuSpellDFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 12.5 + MUIPower( ) * 0.1 )
			call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl", GetFilterUnit( ), "chest" ) )
		endif

		return true
	endfunction

	function AkainuSpellDFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if GetUnitAbilityLevel( MUIUnit( 100 ), 'B04H' ) > 0 then
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 300, Filter( function AkainuSpellDFunction2 ) )
			call RemoveLocation( MUILocation( 102 ) )
		else
			call ClearAllData( HandleID )
		endif
	endfunction

	function AkainuSpellDFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call PlaySoundWithVolume( LoadSound( "AkainuD1" ), 100, 0 )
		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "GeneralEffects\\lavaspray.mdl", GetTriggerUnit( ), "head" ) )
		call TimerStart( LoadMUITimer( LocPID ), .5, true, function AkainuSpellDFunction3 )
	endfunction

	function AkainuSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04A'
	endfunction

	function AkainuSpellQFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
		endif

		return true
	endfunction

	function AkainuSpellQFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 20, MUIAngle( 102, 103 ) ) )	

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 90, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call MakeUnitAirborne( MUIUnit( 100 ), 100, 9999 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .25, .01, false, true, "origin", "Effects\\Akainu\\MagmaBlast.mdl" )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "AkainuR1" ), 90, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call AddEffect( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) + 90, 0 )
				call AddEffect( "GeneralEffects\\t_huobao.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 90 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 100, 99999 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call StunUnit( MUIUnit( 101 ), 2 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 300, .4, .01, false, false, "origin", DashEff( ) )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 300, Filter( function AkainuSpellQFunction2 ) )
				call ClearAllData( HandleID )
			else
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function AkainuSpellQFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellQFunction3 )
	endfunction

	function AkainuSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04C'
	endfunction

	function AkainuSpellWFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
		endif

		return true
	endfunction

	function AkainuSpellWFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuE1" ), 90, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 102 ) ) )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .5, .01, 600 )
			endif

			if LocTime == 50 then
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\LightningStrike1.mdl", MUILocation( 103 ) ) )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", 1, MUILocation( 103 ), 0, 0 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 350, Filter( function AkainuSpellWFunction2 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkainuSpellWFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellWFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function AkainuSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04B'
	endfunction

	function AkainuSpellEFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuW1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call AddEffect( "Effects\\Akainu\\MagmaWolf.mdl", 1., MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 106, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", .25, MUILocation( 102 ), 0, 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 126, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 126 ), false )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime > 20 then
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), 40, MUIAngle( 107, 103 ) ) )
				call FaceLocation( MUIUnit( 106 ), MUILocation( 103 ), 0 )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 109 ) )
				call FaceLocation( MUIUnit( 126 ), MUILocation( 103 ), 0 )
				call SetUnitPositionLoc( MUIUnit( 126 ), MUILocation( 109 ) )

				if LocTime == 21 or LocTime == 25 or LocTime == 30 or LocTime == 35 or LocTime == 40 or LocTime == 45 or LocTime == 50 then
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1., MUILocation( 109 ), 0, 90 )
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				endif

				if MUIDistance( 103, 109 ) <= 150 then
					call KillUnit( MUIUnit( 106 ) )
					call KillUnit( MUIUnit( 126 ) )
					call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
					call AddEffect( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, MUILocation( 103 ), MUIAngle( 103, 107 ) + 90, 0 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
					call RemoveLocation( MUILocation( 109 ) )
					call ClearAllData( HandleID )
				else
					call RemoveLocation( MUILocation( 103 ) )
					call RemoveLocation( MUILocation( 107 ) )
					call RemoveLocation( MUILocation( 109 ) )
				endif
			endif
		endif
	endfunction

	function AkainuSpellEFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellEFunction2 )
	endfunction

	function AkainuSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04D'
	endfunction

	function AkainuSpellRFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and IsUnitInGroup( GetFilterUnit( ), LoadGroupHandle( HashTable, MUIHandle( ), 111 ) ) == false then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 100 + MUIPower( ) )
			call GroupAddUnit( LoadGroupHandle( HashTable, MUIHandle( ), 111 ), GetFilterUnit( ) )
		endif

		return true
	endfunction

	function AkainuSpellRFunction3 takes nothing returns nothing
		local integer i	= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuQ1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 127, CreateLocation( MUILocation( 102 ), 300, MUIAngle( 102, 103 ) ) )
				call AddEffect( "Effects\\Akainu\\LinearMagmaHand.mdl", 2, MUILocation( 127 ), MUIAngle( 102, 103 ), 0 )
				call RemoveLocation( MUILocation( 127 ) )
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 60, 0 )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime > 20 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 100 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )

				loop
					exitwhen i > 2
					call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), GetRandomReal( 0, 500 ), GetRandomReal( 0, 360 ) ) )
					call DestroyEffect( AddSpecialEffectLoc( "abilities\\weapons\\catapult\\catapultmissile.mdl", MUILocation( 109 ) ) )
					call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", .25, MUILocation( 109 ), GetRandomReal( 0, 360 ), 0 )
					call RemoveLocation( MUILocation( 109 ) )
					set i = i + 1
				endloop

				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 500, Filter( function AkainuSpellRFunction2 ) )
				call RemoveLocation( MUILocation( 107 ) )

				if LoadReal( HashTable, HandleID, 110 ) >= 1500 then
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function AkainuSpellRFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellRFunction3 )
	endfunction

	function AkainuSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04E'
	endfunction

	function AkainuSpellTFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.05 )
		endif

		return true
	endfunction	

	function AkainuSpellTFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )	
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuT1" ), 90, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell" )
			endif

			call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
			call SaveReal( HashTable, HandleID, 118, LoadReal( HashTable, HandleID, 118 ) + 1 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )

			if LoadReal( HashTable, HandleID, 118 ) == 1 then
				call SaveReal( HashTable, HandleID, 5, -90 )
			else
				call SaveReal( HashTable, HandleID, 5, 90 )
				call SaveReal( HashTable, HandleID, 118, 0 )
			endif

			if LoadReal( HashTable, HandleID, 110 ) < 50 then
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 70, MUIAngle( 102, 103 ) + LoadReal( HashTable, HandleID, 5 ) ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif

			if LocTime > 10 then
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 103 ), GetRandomReal( 0, 550 ), GetRandomReal( 0, 360 ) ) )
				call AddEffect( "Effects\\Akainu\\VerticalMagmaHand.mdl", .65, MUILocation( 109 ), GetRandomReal( 0, 360 ), 0 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .5 )

				if LocCount > 7 then
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 109 ), 500, Filter( function AkainuSpellTFunction2 ) )
				endif

				call RemoveLocation( MUILocation( 109 ) )
			endif

			if LoadReal( HashTable, HandleID, 110 ) == 70 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkainuSpellTFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call TimerStart( LoadMUITimer( LocPID ), .05, true, function AkainuSpellTFunction3 )
	endfunction

	function HeroInit9 takes nothing returns nothing
		call SaveSound( "AkainuD1", "Akainu\\SpellD1.mp3" )
		call SaveSound( "AkainuQ1", "Akainu\\SpellQ1.mp3" )
		call SaveSound( "AkainuW1", "Akainu\\SpellW1.mp3" )
		call SaveSound( "AkainuE1", "Akainu\\SpellE1.mp3" )
		call SaveSound( "AkainuR1", "Akainu\\SpellR1.mp3" )
		call SaveSound( "AkainuR2", "Akainu\\SpellR2.mp3" )
		call SaveSound( "AkainuT1", "Akainu\\SpellT1.mp3" )

		call SaveTrig( "AkainuTrigD" )
		call GetUnitEvent( LoadTrig( "AkainuTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigD" ), Condition( function AkainuSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigD" ), function AkainuSpellDFunction4 )

		call SaveTrig( "AkainuTrigQ" )
		call GetUnitEvent( LoadTrig( "AkainuTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigQ" ), Condition( function AkainuSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigQ" ), function AkainuSpellQFunction4 )

		call SaveTrig( "AkainuTrigW" )
		call GetUnitEvent( LoadTrig( "AkainuTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigW" ), Condition( function AkainuSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigW" ), function AkainuSpellWFunction4 )	

		call SaveTrig( "AkainuTrigE" )
		call GetUnitEvent( LoadTrig( "AkainuTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigE" ), Condition( function AkainuSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigE" ), function AkainuSpellEFunction3 )

		call SaveTrig( "AkainuTrigR" )
		call GetUnitEvent( LoadTrig( "AkainuTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigR" ), Condition( function AkainuSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigR" ), function AkainuSpellRFunction4 )

		call SaveTrig( "AkainuTrigT" )
		call GetUnitEvent( LoadTrig( "AkainuTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuTrigT" ), Condition( function AkainuSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkainuTrigT" ), function AkainuSpellTFunction4 )
	endfunction	
