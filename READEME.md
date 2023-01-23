# A simple todo api with vlang
I wanted to try vlang and implementing clean arch. There aren't many tutorials on vlang,
so I relied heavily on:
- [Vlang docs](vlang.io)
- [Github docs](https://github.com/vlang/v)
- [Vlang Examples](https://github.com/vlang/V/tree/master/examples)

## How to run
1. create the .env file
2. run the app using docker
3. execute any of the API routes

## The API
- `GET    /api/todo`
- `GET    /api/todo/:id`
- `POST   /api/todo`
- `Patch  /api/todo/:id`
- `Patch  /api/todo/active-status/:id`
- `Delete /api/todo/:id`
- `GET    /api/health`

### Post / Patch body
You only need to send the value `todo_text` in a json object. 
The [schema](vlang_simple_api/repository/todo.v) of todos is quite simple