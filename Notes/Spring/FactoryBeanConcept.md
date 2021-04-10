# Spring FactoryBean 使用及原理

## Factory Bean 使用

### 1. 配置AppConfig
```java
@ComponentScan("com.carl.sectionone") //扫描包路径
public class AppConfig {
}
```

#### 2.设置FactoryBean类
```java
@Component("testObj") //如果@Component 添加了name则获取bean时要通过自定义的名字进行获取，默认spring会将名字解析为首字母小写 MyFactoryBean -> myFactoryBean
@Scope("prototype") // spring中的Bean默认为单例模式，若配置Scope为prototype则为多例
public class MyFactoryBean implements FactoryBean { // Bean -> myFactoryBean
	@Override
	public Object getObject() throws Exception { // BeanName: myFactoryBean
		return new User();
	}

	@Override
	public Class<?> getObjectType() {
		return User.class;
	}
}
```

### 3. 获取Bean
获取Bean时如果名字前加上“&” 则Spring容器将返回FactoryBean
e.g.
如果getBean方法中传入 “&testObj” 则返回的对象不是User而是MyFactoryBean 
```java
public class TestOne {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext applicationContext =
				new AnnotationConfigApplicationContext(AppConfig.class);
		System.out.println(applicationContext.getBean("testObj"));
	}

}
```

## Mybatis SqlSessionFactory Bean 调用原理
MyBatis执行的SQL语句通过注解的方式添加在Mapper接口的方法上。Mybatis 的SqlSessionFactory bean 利用了代理对象和反射的方式获取sql并执行语句

UserMapper
```java
public interface UserMapper {
	@Insert("insert into t1 values(1,1,1,1,'1')")
	void insert1();

	@Insert("insert into t1 values(2,2,2,2,'2')")
	void insert2();

	@Delete("delete * from t1")
	void delete();

}
```

FactoryBean 模拟
```java
@Component
public class MyProxyFactoryBean  implements FactoryBean {
	@Override
	public Object getObject() throws Exception {
		Object instance = Proxy.newProxyInstance(MyProxyFactoryBean.class.getClassLoader(), new Class[]{UserMapper.class},
				(proxy, method, args) -> {
					Insert annotation = method.getDeclaredAnnotation(Insert.class);
					String sql = annotation.value()[0];
					System.out.println(sql);
					return null;
				});
		return instance;
	}

	@Override
	public Class<?> getObjectType() {
		return UserMapper.class;
	}
}

```

main class
```java
public class TestOne {

	public static void main(String[] args) {
		AnnotationConfigApplicationContext applicationContext =
				new AnnotationConfigApplicationContext(AppConfig.class);
		((UserMapper)(applicationContext.getBean("myProxyFactoryBean"))).insert2();
	}

}
```

## FactoryBean 获取时执行原理

### 调用 applicationContext 时首先会进入AbstractApplicationContext中的getBean() 方法。

org.springframework.context.support.AbstractApplicationContext
```java
@Override
	public Object getBean(String name) throws BeansException {
		assertBeanFactoryActive();
		return getBeanFactory().getBean(name);
	}
```

### 进入AbstractBeanFactory的doGetBean方法
org.springframework.beans.factory.support.AbstractBeanFactory

```java
@Override
	public Object getBean(String name) throws BeansException {
		return doGetBean(name, null, null, false);
	}
```

dogetBean()方法执行核心任务
1. 对beanName进行转换 name如果是"&MyFactoryBean"，那么beanName就是"myFactoryBean"
```java
final String beanName = transformedBeanName(name);
```

2. 调用 transformedBeanName 的 canonicalName 方法
```java
/**
	 * Return the bean name, stripping out the factory dereference prefix if necessary,
	 * and resolving aliases to canonical names.
	 * @param name the user-specified name
	 * @return the transformed bean name
	 *
	 * 返回beanName，去掉FactoryBean的&前缀，并且把name当做别名去aliasMap中寻找原始的beanName
	 */
	protected String transformedBeanName(String name) {  // &lubanFactoryBean lubanFactoryBean1 user1  &beanName
		return canonicalName(BeanFactoryUtils.transformedBeanName(name));
	}
```

BeanFactoryUtil的transformedBeanName
```java
public static String transformedBeanName(String name) {
		Assert.notNull(name, "'name' must not be null");
		// 如果beanName没有以&开头，则直接返回
		if (!name.startsWith(BeanFactory.FACTORY_BEAN_PREFIX)) {   // myFactoryBean
			return name;
		}
		// 如果beanName以&开头，截取&后的beanName，并且把截取前后的name存在transformedBeanNameCache中
		return transformedBeanNameCache.computeIfAbsent(name, beanName -> {
			do {
				beanName = beanName.substring(BeanFactory.FACTORY_BEAN_PREFIX.length());
			}
			while (beanName.startsWith(BeanFactory.FACTORY_BEAN_PREFIX));
			return beanName;
		});
	}
```

canonicalName方法会根据获取的名字从别名map中寻找
```java
/**
	 * Determine the raw name, resolving aliases to canonical names.
	 * @param name the user-specified name
	 * @return the transformed name
	 */
	public String canonicalName(String name) {
		String canonicalName = name;
		// Handle aliasing...
		String resolvedName;
		do {
			resolvedName = this.aliasMap.get(canonicalName);  // 别名：beanName
			if (resolvedName != null) {
				canonicalName = resolvedName;
			}
		}
		while (resolvedName != null);
		return canonicalName;
	}
```

### 从单例池中获取myFactoryBean
```java
// Eagerly check singleton cache for manually registered singletons.
Object sharedInstance = getSingleton(beanName); 
```

### 判断传入的名字是否以“&”开始
```java
// 判断sharedInstance是不是FactoryBean，如果是FactoryBean，那么真正需要拿到的是getObject方法所返回的对象
bean = getObjectForBeanInstance(sharedInstance, name, beanName, null);
```

```java
/**
	 * Get the object for the given bean instance, either the bean
	 * instance itself or its created object in case of a FactoryBean.
	 * @param beanInstance the shared bean instance
	 * @param name name that may include factory dereference prefix
	 * @param beanName the canonical bean name
	 * @param mbd the merged bean definition
	 * @return the object to expose for the bean
	 */
	// 判断beanInstance是不是FactoryBean
	// 如果是FactoryBean
		// 如果name是以&开头，那么则返回beanInstance
		// 如果name不是以&开头，那么返回的是getObject方法中所返回的对象（注意如果是单例，则会进行缓存）
	// 如果不是FactoryBean，那么返回的是beanInstance
	protected Object getObjectForBeanInstance(
			Object beanInstance, String name, String beanName, @Nullable RootBeanDefinition mbd) {

		// Don't let calling code try to dereference the factory if the bean isn't a factory.
		// 如果是&myFactoryBean，那么则直接返回单例池（SingletonObjects）中的对象
		if (BeanFactoryUtils.isFactoryDereference(name)) {
			if (beanInstance instanceof NullBean) {
				return beanInstance;
			}
			if (!(beanInstance instanceof FactoryBean)) {
				throw new BeanIsNotAFactoryException(beanName, beanInstance.getClass());
			}
			if (mbd != null) {
				mbd.isFactoryBean = true;
			}
			return beanInstance;
		}

		// Now we have the bean instance, which may be a normal bean or a FactoryBean.
		// If it's a FactoryBean, we use it to create a bean instance, unless the
		// caller actually wants a reference to the factory .
		if (!(beanInstance instanceof FactoryBean)) {
			return beanInstance;
		}

		// 如果beanInstance是FactoryBean，并且name也不是以&开头
		Object object = null;
		if (mbd != null) {
			mbd.isFactoryBean = true;
		}
		else {
			object = getCachedObjectForFactoryBean(beanName);
		}

		// 从factoryBeanObjectCache中没有拿到则进行创建
		if (object == null) {
			// Return bean instance from factory.
			FactoryBean<?> factory = (FactoryBean<?>) beanInstance;
			// Caches object obtained from FactoryBean if it is a singleton.
			if (mbd == null && containsBeanDefinition(beanName)) {
				mbd = getMergedLocalBeanDefinition(beanName);
			}
			boolean synthetic = (mbd != null && mbd.isSynthetic());
			// 调用getObject方法得到对象并放入factoryBeanObjectCache中
			object = getObjectFromFactoryBean(factory, beanName, !synthetic);
		}
		return object;
	}
```

getObjectFromFactoryBean()方法：
* 第一次调用时因为没有从缓存中拿到所以创建一个单利放到缓存中给下一次调用使用
* 第二次调用因为缓存中已存在则直接返回
```java
protected Object getObjectFromFactoryBean(FactoryBean<?> factory, String beanName, boolean shouldPostProcess) {
	// 是不是单例的
    if (factory.isSingleton() && containsSingleton(beanName)) {
        synchronized (getSingletonMutex()) {
            Object object = this.factoryBeanObjectCache.get(beanName);
            if (object == null) {
                // 调用getObject方法得到一个对象
                object = doGetObjectFromFactoryBean(factory, beanName);
                // Only post-process and store if not put there already during getObject() call above
                // (e.g. because of circular reference processing triggered by custom getBean calls)
                Object alreadyThere = this.factoryBeanObjectCache.get(beanName);
                if (alreadyThere != null) {
                    object = alreadyThere;
                }
                else {
                    if (shouldPostProcess) {
                        // 单例真正创建
                        if (isSingletonCurrentlyInCreation(beanName)) {
                            // Temporarily return non-post-processed object, not storing it yet..
                            return object;
                        }
                        beforeSingletonCreation(beanName);
                        try {
                            // 调用BeanPostProcessor执行初始化后的逻辑，主要就是进行AOP
                            object = postProcessObjectFromFactoryBean(object, beanName);
                        }
                        catch (Throwable ex) {
                            throw new BeanCreationException(beanName,
                                    "Post-processing of FactoryBean's singleton object failed", ex);
                        }
                        finally {
                            afterSingletonCreation(beanName);
                        }
                    }
                    if (containsSingleton(beanName)) {
                        this.factoryBeanObjectCache.put(beanName, object);
                    }
                }
            }
            return object;
        }
    }
    else {
        // 多例
        Object object = doGetObjectFromFactoryBean(factory, beanName); //多例则每次调用时都会执行 factory.getObject(); 生成一个新的对象
        if (shouldPostProcess) {
            try {
                object = postProcessObjectFromFactoryBean(object, beanName);
            }
            catch (Throwable ex) {
                throw new BeanCreationException(beanName, "Post-processing of FactoryBean's object failed", ex);
            }
        }
        return object;
    }
}
```

dogetObjectFromFactoryBean()方法：
```java
private Object doGetObjectFromFactoryBean(final FactoryBean<?> factory, final String beanName)
			throws BeanCreationException {

		Object object;
		try {
			if (System.getSecurityManager() != null) { // 安全性校验
				AccessControlContext acc = getAccessControlContext();
				try {
					object = AccessController.doPrivileged((PrivilegedExceptionAction<Object>) factory::getObject, acc);
				}
				catch (PrivilegedActionException pae) {
					throw pae.getException();
				}
			}
			else {
				object = factory.getObject(); //从此处调用实现的getObject() 方法
			}
		}
		catch (FactoryBeanNotInitializedException ex) {
			throw new BeanCurrentlyInCreationException(beanName, ex.toString());
		}
		catch (Throwable ex) {
			throw new BeanCreationException(beanName, "FactoryBean threw exception on object creation", ex);
		}

		// Do not accept a null value for a FactoryBean that's not fully
		// initialized yet: Many FactoryBeans just return null then.
		// 如果调用getObject()方法返回的是null，那么则返回一个NullBean
		if (object == null) {
			if (isSingletonCurrentlyInCreation(beanName)) {
				throw new BeanCurrentlyInCreationException(
						beanName, "FactoryBean which is currently in creation returned null from getObject");
			}
			object = new NullBean();
		}
		return object;
	}
```

