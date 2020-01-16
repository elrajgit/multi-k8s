docker build -t elrajgit/multi-client:latest -t elrajgit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t elrajgit/multi-server:latest -t elrajgit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t elrajgit/multi-worker:latest -t elrajgit/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push elrajgit/multi-client:latest
docker push elrajgit/multi-server:latest
docker push elrajgit/multi-worker:latest

docker push elrajgit/multi-client:$SHA
docker push elrajgit/multi-server:$SHA
docker push elrajgit/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=elrajgit/multi-client:$SHA
kubectl set image deployments/server-deployment server=elrajgit/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=elrajgit/multi-worker:$SHA