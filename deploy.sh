docker build -t nielango/multi-client:latest -t nielango/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nielango/multi-server:latest -t nielango/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nielango/multi-worker:latest -t nielango/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nielango/multi-client:latest
docker push nielango/multi-server:latest
docker push nielango/multi-worker:latest

docker push nielango/multi-client:$SHA
docker push nielango/multi-server:$SHA
docker push nielango/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nielango/multi-server:$SHA
