path = require('path')
fs = require('fs-plus')

atom.project.resolvePath = (uri) ->
  return unless uri

  if uri?.match(/[A-Za-z0-9+-.]+:\/\//) # leave path alone if it has a scheme
    uri
  else
    if fs.isAbsolute(uri)
      # Normalize disk drive letter on Windows to avoid opening two buffers for the same file
      uriWithNormalizedDiskDriveLetter = uri
      if matchData = uri.match(/^([A-Za-z]):/)
        uriWithNormalizedDiskDriveLetter = "#{matchData[1].toUpperCase()}#{uri.slice(1)}"
      path.normalize(fs.resolveHome(uriWithNormalizedDiskDriveLetter))

    # TODO: what should we do here when there are multiple directories?
    else if projectPath = @getPaths()[0]
      path.normalize(fs.resolveHome(path.join(projectPath, uri)))
    else
      undefined

# module.exports =
# class AtomHacks
#   subscriptions: null
#
#   activate: (state) ->
#     atom.project.resolvePath = (uri) ->
#       return unless uri
#
#       if uri?.match(/[A-Za-z0-9+-.]+:\/\//) # leave path alone if it has a scheme
#         uri
#       else
#         if fs.isAbsolute(uri)
#           # Normalize disk drive letter on Windows to avoid opening two buffers for the same file
#           uriWithNormalizedDiskDriveLetter = uri
#           if matchData = uri.match(/^([A-Za-z]):/)
#             uriWithNormalizedDiskDriveLetter = "#{matchData[1].toUpperCase()}#{uri.slice(1)}"
#           path.normalize(fs.resolveHome(uriWithNormalizedDiskDriveLetter))
#
#         # TODO: what should we do here when there are multiple directories?
#         else if projectPath = @getPaths()[0]
#           path.normalize(fs.resolveHome(path.join(projectPath, uri)))
#         else
#           undefined
#
#
#   deactivate: ->
#
#   serialize: ->
