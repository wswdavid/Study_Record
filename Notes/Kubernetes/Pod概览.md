每一个 pod 都有一个特殊的被成为“根容器”的 Pause 容器，Pause 容器对应的镜像属于 K8s 平台的一部分。

除了 Pause 容器，每个 Pod 还包含一个或者多个用户业务容器。

![](../../Pictures/Kubernetes/pause-container.png)

为什么有 Pod 的组成结构？

1. Pause 容器不容易死亡，代表整个容器的状态。
2. Pod 里各个业务容器共享 Pause 容器的 IP，简化通信问题；共享 Pause 容器挂在的 Volume，解决文件共享问题。
