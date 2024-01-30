local function defaultEqualityFn(newState, oldState)
	return newState == oldState
end

local function useCustomSelector(
	hooks,
	selector: (state: any) -> any,
	equalityFn: ((newState: any, oldState: any) -> boolean)?,
	context
)
	-- This value wrapper is required so the variable context of the selector function can be updated on each run --
	local selectorRef = hooks.useRef()
	selectorRef.current = selector

	local store = hooks.useContext(context)
	local mappedState, setMappedState = hooks.useState(function()
		return selector(store:getState())
	end)
	local oldMappedState = hooks.useRef()
	oldMappedState.current = mappedState

	if equalityFn == nil then
		equalityFn = defaultEqualityFn
	end

	hooks.useEffect(function()
		local storeChanged = store.changed:connect(function(newState, _oldState)
			local newMappedState = selectorRef.current(newState)

			if not equalityFn(newMappedState, oldMappedState.current) then
				oldMappedState.value = newMappedState
				setMappedState(newMappedState)
			end
		end)

		return function()
			storeChanged:disconnect()
		end
	end, {})

	return mappedState
end

return useCustomSelector
