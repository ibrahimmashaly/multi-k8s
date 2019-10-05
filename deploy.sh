docker build -t imashaly/multi-client:latest -t imashaly/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imashaly/multi-server:latest -t imashaly/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imashaly/multi-worker:latest -t imashaly/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push imashaly/multi-client:latest
docker push imashaly/multi-server:latest
docker push imashaly/multi-worker:latest
docker push imashaly/multi-client:$SHA
docker push imashaly/multi-server:$SHA
docker push imashaly/multi-worker:$SHA
kubectl apply -f K8s
kubectl set image deployments/server-deployment server=imashaly/multi-server:$SHA
kubectl set image deployments/client-deployment client=imashaly/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=imashaly/multi-worker:$SHA