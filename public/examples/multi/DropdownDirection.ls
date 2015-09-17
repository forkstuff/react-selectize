Form = React.create-class do 
    
    # render :: a -> ReactElement
    render: ->
        React.create-element MultiSelect,
            options: <[apple mango grapes melon strawberry]> |> map ~> label: it, value: it
            placeholder: "Select fruits"
            dropdown-direction: @state.dropdown-direction
            ref: \select
    
    # get-initial-state :: a -> UIState
    get-initial-state: ->    
        dropdown-direction: 1

    # component-did-mount :: a -> Void
    component-did-mount: !->
        @on-scroll-change = ~>
            {offset-top} = @refs.select.get-DOM-node!
            screen-top = offset-top - window.scroll-y
            dropdown-direction = if window.inner-height - screen-top < 215 then -1 else 1
            if dropdown-direction != @state.dropdown-direction
                @set-state {dropdown-direction}
        window.add-event-listener \scroll, @on-scroll-change

    # component-will-unmount :: a -> Void
    component-will-unmount: !->
        window.remove-event-listener \scroll, @on-scroll-change
                
React.render (React.create-element Form, null), mount-node