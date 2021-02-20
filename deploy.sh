docker build -t dcenteno448/multi-client:latest -t dcenteno448/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dcenteno448/multi-server:latest -t dcenteno448/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dcenteno448/multi-worker:latest -t dcenteno448/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dcenteno448/multi-client:latest
docker push dcenteno448/multi-server:latest
docker push dcenteno448/multi-worker:latest

docker push dcenteno448/multi-client:$SHA
docker push dcenteno448/multi-server:$SHA
docker push dcenteno448/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=dcenteno448/multi-client:$SHA
kubectl set image deployments/server-deployment server=dcenteno448/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dcenteno448/multi-worker:$SHA