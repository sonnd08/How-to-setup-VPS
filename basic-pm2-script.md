https://pm2.keymetrics.io/

# Run npm script
```
pm2 start npm -n '3000-my-app-name' -- run start
```


# Serve static files
```
pm2 serve ./react-front-end-build  3002 --name "3002-static-page"
```


# run  ejected create-react-app with pm2:
```
pm2 start node_modules/react-scripts/scripts/start.js --name "myapp"
```

# List all processes:
```
pm2 list

pm2 l
```


# Act on processes:

```
pm2 stop <id or name>
pm2 start <id or name>
pm2 restart <id or name>
pm2 delete <id or name>
pm2 log <id or name>
```