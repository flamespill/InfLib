local Plugin={
    ['PluginCreator']='noteveryone.',
    ['PluginName']='Join Job ID',
    ['PluginDescription']='Teleports you to the specified JobId in the current game',
    ['Commands']={
        ['joinjobid']={
            ['ListName']='joinjobid / jjobid / jjid [jobid]',
            ['Description']='Join a server using its JobId',
            ['Aliases']={'joinjobid','jjobid','jjid'},
            ['Function']=function(args,speaker)
                if args[1]then 
                    TeleportService:TeleportToPlaceInstance(game.PlaceId,args[1])
                else
                    notify('Missing arg 1, JobId expected')
                end
            end
        }
    }
}
 
return Plugin
