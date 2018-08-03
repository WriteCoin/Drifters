	function ItemAoEFireDamage takes nothing returns boolean
		if UnitLife( MUIUnit( 100 ) ) > 0 then
			if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
				call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Magical", 30 + MUILevel( ) )
				call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl", GetFilterUnit( ), "chest" ) )
			endif
		endif

		return true
	endfunction

	function ItemAoEFireAction takes nothing returns nothing
		local integer LocTime = MUIInteger( 0 )

		call SaveInteger( HashTable, MUIHandle( ), 0, LocTime + 1 )

		if UnitHasItemById( MUIUnit( 100 ), 'I000' ) then
			if LocTime == 100 then
				call SaveInteger( HashTable, MUIHandle( ), 0, 0 )
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, Filter( function ItemAoEFireDamage ) )
			endif
		else
			call SaveBoolean( HashTable, GetHandleId( MUIUnit( 100 ) ), 300, false )
			call PauseTimer( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, MUIHandle( ) )
			call DestroyTimer( GetExpiredTimer( ) )
		endif
	endfunction

	function ItemAoEFirePickUp takes nothing returns nothing
		if CountItems( GetTriggerUnit( ), 'I000' ) == 1 and LoadBoolean( HashTable, GetHandleId( GetTriggerUnit( ) ), 300 ) == false then
			call SaveTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ), CreateTimer( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ) ) ), 100, GetTriggerUnit( ) )
			call SaveBoolean( HashTable, GetHandleId( GetTriggerUnit( ) ), 300, true )
			call TimerStart( LoadTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ) ), .01, true, function ItemAoEFireAction )
		endif
	endfunction 
