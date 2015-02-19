FileSystem = require "fs"


glob = require("glob")
sizeOf = require('image-size')

glob "*.html", (error, documentFiles) ->
  glob "img/**/*.jpg", (error, imageFiles) ->
    throw error if error
    console.info imageFiles
    for imageFile in imageFiles
      try
        insertImageDimensions(documentFiles, imageFile, sizeOf(imageFile))
      catch
        console.error "Can’t process #{imageFile}"

insertImageDimensions = (documentFiles, imageFile, dimensions) ->
  insertImageDimensionsIntoDocument(documentFile, imageFile, dimensions) for documentFile in documentFiles

insertImageDimensionsIntoDocument = (documentFile, imageFile, dimensions) ->
  {height, width} = dimensions
  HTML = FileSystem.readFileSync(documentFile, "utf-8")
  console.info pattern = """<img src="#{imageFile}">"""
  console.info replacement = """<img src="#{imageFile}" height="#{height}" width="#{width}">"""
  FileSystem.writeFileSync(documentFile, HTML.replace(pattern, replacement), "utf-8")
