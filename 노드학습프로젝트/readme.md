# AIFFEL Campus Online 5th Code Peer Review Templete
- 코더 : 임현석
- 리뷰어 : 김소연

# PRT(Peer Review Template)
- [O]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 
    퀘스트 문제 요구조건 등을 지칭
        - 전이학습 사용
        ```python
        IMG_SHAPE = (IMG_SIZE, IMG_SIZE, 3)

        #완전연결계층은 불러오지 않음
        base_model = tf.keras.applications.VGG16(input_shape=IMG_SHAPE,
                                                include_top=False,
                                                weights='imagenet')
        Downloading data from https://storage.googleapis.com/tensorflow/keras-applications/vgg16/vgg16_weights_tf_dim_ordering_tf_kernels_notop.h5
        58892288/58889256 [==============================] - 0s 0us/step
        58900480/58889256 [==============================] - 0s 0us/step
        ```
        - 시각화자료들을 포함하여 체계적으로 진행
        ```python
       plt.figure(figsize=(10,5))

        get_label_name = metadata.features['label'].int2str
        
        for idx, (image, label) in enumerate(train.take(10)):
            plt.subplot(2, 5 , idx+1)
            image = (image + 1) / 2
            plt.imshow(image)
            plt.title(f'label {label}: {get_label_name(label)}')
            plt.axis('off')
        ```
        - 분류모델의 정확도가 85%이상
        ```python
        count = 0
        for image, label, prediction in zip(images, labels, predictions):
            correct = label == prediction
            if correct:
                count = count + 1
        print(count / 32*100 )
        87.5
        ```
    
- [O]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭에 doc string/annotation이 달려 있는지 확인
    - 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
    - 주석을 보고 코드 이해가 잘 되었는지 확인
      ```python
      #GAP사용
        global_average_layer = tf.keras.layers.GlobalAveragePooling2D()
        print('완료')
        완료
        feature_batch_average = global_average_layer(feature_batch)
        print(feature_batch_average.shape)
        (32, 512)
        dense_layer = tf.keras.layers.Dense(units = 512, activation='relu')
        prediction_layer = tf.keras.layers.Dense(units = 5, activation='softmax')
        
        
        #feature_batch_averag가 dense_layer를 거친결과가 다시 predict_layer를 거치게 되면
        prediction_batch = prediction_layer(dense_layer(feature_batch_average))
        print(prediction_batch.shape)
        (32, 5)
        #vgg16에 해당하는 베이스모델은 학습 시킴
        base_model.trainable = True
        print('완료')
        완료
        model = tf.keras.Sequential([
            base_model,
            global_average_layer,
            dense_layer,
            prediction_layer
        ])
        
        print('완료')
        완료
        model.summary()
        Model: "sequential_1"
        _________________________________________________________________
        Layer (type)                 Output Shape              Param #   
        =================================================================
        vgg16 (Functional)           (None, 5, 5, 512)         14714688  
        _________________________________________________________________
        global_average_pooling2d (Gl (None, 512)               0         
        _________________________________________________________________
        dense_1 (Dense)              (None, 512)               262656    
        _________________________________________________________________
        dense_2 (Dense)              (None, 5)                 2565      
        =================================================================
        Total params: 14,979,909
        Trainable params: 14,979,909
        Non-trainable params: 0
        _________________________________________________________________
        base_learning_rate = 0.0001
        model.compile(optimizer= tf.keras.optimizers.Adam(learning_rate=base_learning_rate),
                     loss= tf.keras.losses.sparse_categorical_crossentropy,
                     metrics=['accuracy'])
        
        print('완료')
        완료
      ```
        
- [O]  **3. 에러가 난 부분을 디버깅하여 문제를 “해결한 기록을 남겼거나” 
”새로운 시도 또는 추가 실험을 수행”해봤나요?**
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인
    - 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 
    실험이 기록되어 있는지 확인
        - 시각화 한 상태에서 추출한 이미지의 정확도를 구해보았다.
        ```python
        count = 0
        for image, label, prediction in zip(images, labels, predictions):
            correct = label == prediction
            if correct:
                count = count + 1
        print(count / 32*100 )
        87.5
        ```
        
- [O]  **4. 회고를 잘 작성했나요?**
    - 주어진 문제를 해결하는 완성된 코드 내지 프로젝트 결과물에 대해
    배운점과 아쉬운점, 느낀점 등이 기록되어 있는지 확인
    - 전체 코드 실행 플로우를 그래프로 그려서 이해를 돕고 있는지 확인
      ```
        루브릭
        base 모델을 활용한 전이학습이 성공적으로 진행되었는가?
        vgg16을 이용해서 전이학습을 진행했습니다.
        학습과정 및 결과에 대한 설명이 시각화를 포함하여 체계적으로 진행되었는가?
        pyplot을 이용해서 그래프로 나타내었습니다.
        분류모델의 정확도가 85% 이상나왔는가?
        네, 32개의 이미지를 추출하여 확인한 결과 87.5%가 나왔습니다.
      ```
        
- [O]  **5. 코드가 간결하고 효율적인가요?**
    - 파이썬 스타일 가이드 (PEP8) 를 준수하였는지 확인
    - 하드코딩을 하지않고 함수화, 모듈화가 가능한 부분은 함수를 만들거나 클래스로 짰는지
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 함수화했는지
        - 이미지 리사이징 함수 선언하여 간결하게 만들었다.
      ```python
      #이미지의 크기가 각각 다르므로 리사이징
        IMG_SIZE = 160
        
        def format_example(image, label):
            image = tf.cast(image, tf.float32) #이미지를 tf.float32로 변환
            image = (image/127.5) - 1 #픽셀값 스케일 수정
            image = tf.image.resize(image, (IMG_SIZE, IMG_SIZE))
            return image, label
        
        print('완료')
        완료
      ```


# 참고 링크 및 코드 개선
- 모델의 전체 정확도를 알 수 없었다. 추가하여 모델의 정확도를 알아볼 수 있다.
```python
history = model.fit(train_batches,     #모델학습시킨 후
                   epochs = 10,
                   validation_data = validation_batches)

#학습시킨 모델의 정확도를 측정하는 코드를 추가한다.
loss, accuracy = model.evaluate(test_batches)
print("Test accuracy : ", accuracy)
```


