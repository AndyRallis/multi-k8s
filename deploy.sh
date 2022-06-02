docker build -t nashno9/multi-client:latest -t nashno9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nashno9/multi-server:latest -t nashno9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nashno9/multi-worker:latest -t nashno9/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nashno9/multi-client:latest
docker push nashno9/multi-server:latest
docker push nashno9/multi-worker:latest

docker push nashno9/multi-client:$SHA
docker push nashno9/multi-server:$SHA
docker push nashno9/multi-worker:$SHA

kubectl apply -f k8s

#kubectl set image deployments/server-deployment server=nashno9/multi-server:$SHA
kubectl set image deployments/client-deployment server=nashno9/multi-client:$SHA
kubectl set image deployments/worker-deployment server=nashno9/multi-worker:$SHA