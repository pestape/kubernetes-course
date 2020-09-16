docker build -t pestape1/k8s-multi-client:latest -t pestape1/k8s-multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t pestape1/k8s-multi-server:latest -t pestape1/k8s-multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t pestape1/k8s-multi-worker:latest -t pestape1/k8s-multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push pestape1/k8s-multi-client:latest
docker push pestape1/k8s-multi-server:latest
docker push pestape1/k8s-multi-worker:latest
docker push pestape1/k8s-multi-client:$GIT_SHA
docker push pestape1/k8s-multi-server:$GIT_SHA
docker push pestape1/k8s-multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pestape1/k8s-multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=pestape1/k8s-multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=pestape1/k8s-multi-worker:$GIT_SHA