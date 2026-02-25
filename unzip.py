
  import zipfile
  with zipfile.ZipFile("attached_assets/Staff-Health-mob_1771968095773.zip", 'r') as zip_ref:
      zip_ref.extractall("attached_assets/Staff-Health-mob")
  print("Unzipped with python")
  