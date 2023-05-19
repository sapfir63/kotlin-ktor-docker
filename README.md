# kotlin-ktor-docker

<!-- wp:paragraph -->
<p>С помощью генератора <a rel="noreferrer noopener" href="https://start.ktor.io" target="_blank">https://start.ktor.io</a> делаем простейшую заготовку backend проекта с плагином Routing и скачиваем на проект. Отрываем и собираем его в ANDROID STUDIO. </p>
<!-- /wp:paragraph -->

<!-- wp:separator -->
<hr class="wp-block-separator"/>
<!-- /wp:separator -->

<!-- wp:code -->
<pre class="wp-block-code"><code>package com.example

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.cio.*
import com.example.plugins.*

fun main() {
    embeddedServer(CIO, port = 80, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    configureRouting()
}</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>переходим по адресу http://127.0.0.1 и видим в браузере строку  Hello World!. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Проект запущен</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>На удаленном сервере делаем папку test в нее добавляем папку app.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>В папке test делаем 2 файла </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Dockerfile</strong> </p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>FROM openjdk:18-jdk-alpine
EXPOSE 80:80

RUN mkdir -p /app
COPY app/ /app/

WORKDIR /app

ENTRYPOINT &#91;"java","-jar","com.example.ktor-sample-0.0.1.jar"]</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p><strong>docker-compose.ym</strong>l</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>services:
  web:
    build: .
    ports:
      - "80:80"</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>Теперь нужно настроить  в build.gradle.kts возможность создания jar файла для выполнения его на сервере с помощью кода</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>tasks.jar {
    manifest.attributes&#91;"Main-Class"] =  "com.example.ApplicationKt"
    val  dependencies = configurations
        .runtimeClasspath
        .get()
        .map(::zipTree) // OR .map { zipTree(it)  }
    from(dependencies)
    duplicatesStrategy =  DuplicatesStrategy.EXCLUDE
}</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>при создании проекта  в папке проекта build\libs будет создан файл com.example.ktor-sample-0.0.1.jar, который нужно будет поместить в папку app на сервере </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Теперь с помощью Docker поместим наш код  в контейнер</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>docker compose up --build -d</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>И проверяем его работу в браузере набираем строку http://x.x.x.x и видим в браузере строку  Hello World!.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>все заготовка закончена</p>
<!-- /wp:paragraph -->
