clusters = [
  {
    env                 = "local"
    name                = "frontend"
    worker_count        = 2
    control_plane_count = 1
  },
  {
    env                 = "local"
    name                = "backend"
    worker_count        = 3
    control_plane_count = 2
  },
  {
    env                 = "local"
    name                = "db"
    worker_count        = 2
    control_plane_count = 1
  }
]
