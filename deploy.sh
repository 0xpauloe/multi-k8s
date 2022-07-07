docker build -t pauloes/multi-client:latest -t pauloes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pauloes/multi-server:latest -t pauloes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pauloes/multi-worker:latest -t pauloes/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pauloes/multi-client:latest
docker push pauloes/multi-server:latest
docker push pauloes/multi-worker:latest

docker push pauloes/multi-client:$SHA
docker push pauloes/multi-server:$SHA
docker push pauloes/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=pauloes/multi-server:$SHA
kubectl set image deployments/client-deployments client=pauloes/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=pauloes/multi-worker:$SHA
