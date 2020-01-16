docker build -t elrajdocker/multi-client:latest -t elrajdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t elrajdocker/multi-server:latest -t elrajdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t elrajdocker/multi-worker:latest -t elrajdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push elrajdocker/multi-client:latest
docker push elrajdocker/multi-server:latest
docker push elrajdocker/multi-worker:latest

docker push elrajdocker/multi-client:$SHA
docker push elrajdocker/multi-server:$SHA
docker push elrajdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=elrajdocker/multi-client:$SHA
kubectl set image deployments/server-deployment server=elrajdocker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=elrajdocker/multi-worker:$SHA