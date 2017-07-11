# Chaturbate Overlay App

![build status](https://travis-ci.org/paulallen87/chaturbate-overlay-app.svg?branch=master)
![automated](https://img.shields.io/docker/automated/paulallen87/chaturbate-overlay-app.svg)
![build status](https://img.shields.io/docker/build/paulallen87/chaturbate-overlay-app.svg)
![pulls](https://img.shields.io/docker/pulls/paulallen87/chaturbate-overlay-app.svg)
![stars](https://img.shields.io/docker/stars/paulallen87/chaturbate-overlay-app.svg)

This app serves views that display information directly from a Chaturbte profile.

These views are intended to be used as an [OBS](https://obsproject.com/) source overlay.

![screenshot](https://github.com/paulallen87/chaturbate-overlay-app/raw/master/screenshot.png)

### Quickstart

Run the docker image:

```shell
docker run \
  -ti \
  --name=cb-overlay-app \
  --publish=8080:8080 \
  paulallen87/chaturbate-overlay-app
```

Then navigate to:

    http://localhost:8080/default/<your username>

### Prerequisites

You must already have [node.js](https://nodejs.org) installed.

You also need [Google Chrome](https://www.google.com/chrome/index.html)/[Chromium](https://www.chromium.org) (version >= 59) installed.

Then install the [yarn](https://yarnpkg.com/en/docs/install) package manager.

```shell
npm install -g yarn
```

### Starting A Development Instance

```shell
sh chaturbate-overlay-app/bin/start-dev.sh
```

### Starting A Production Instance

```shell
sh chaturbate-overlay-app/bin/start-prod.sh
```

### Developing New Views

Views are located at:

    src/views/<VIEW NAME>/view-<VIEW NAME>.html

They need to be registered with **src/my-app.html** under this comment:

```html
<!-- ADD VIEWS HERE -->
```

##### Note:

There are two places in **my-app.html** that need to be updated.

All views should include the [&lt;chaturbate-controller&gt;](https://github.com/paulallen87/chaturbate-controller) tag:

```html
<chaturbate-controller 
    username="[[subrouteData.username]]"
    chat="{{chat}}"
    ...>
</chaturbate-controller>
```

The data-bindings provided by the controller component can be used to dive other UI components:

```html
<chaturbate-chat items="{{chat}}"></chaturbate-chat>
```

### Developing New Polymer Components

First create a new git repo for the component.

Then create the new component and create a global link to it:

```shell
mkdir new-component && cd new-component
git clone https://github.com/YOUR-USERNAME/new-component.git  .
bower init
touch new-component.html
bower link
```

Link the new component to this app:

```shell
cd chaturbate-overlay-app
bower link new-component
```

Update your view to import the new component:

```html
<link rel="import" href="../../../bower_components/new-component/new-component.html">
```

Update your view to use the new component:

```html
<new-component></new-component>
```

Test the new component:

```shell
sh chaturbate-overlay-app/bin/start-dev.sh
```

After the component is complete, upload it to Github.

```shell
cd new-component
git add .
git commit -m 'initial commit'
git tag v1.0.0
git push origin master --tags
```

Add the new component to the Bower dependencies:

```shell
cd chaturbate-overlay-app
bower add https://github.com/YOUR-USERNAME/new-component.git --save
```

Finally push a commit of this app with the new component:

```shell
git add .
git commit -m 'added new component'
git push origin master
```

### Developing New Node Modules

First create a new git repo for the module.

Then create the new module and create a global link to it:

```shell
mkdir new-module && cd new-module
git clone https://github.com/YOUR-USERNAME/new-module.git  .
yarn init --scope=YOUR-USERNAME
touch index.js
yarn link
```

Link the new module to this app:

```shell
cd chaturbate-overlay-app
yarn link @YOUR-USERNAME/new-module
```

Update the server to import the new module:

```javascript
const NewModule = require('@YOUR-USERNAME/new-module')
```

Test the new module:

```shell
sh chaturbate-overlay-app/bin/start-dev.sh
```

After the module is complete, upload it to Github.

```shell
cd new-module
git add .
git commit -m 'initial commit'
git tag v1.0.0
git push origin master --tags
```

The publish it to NPM:

```shell
yarn publish --access=public
```

Add the new module to the node dependencies:

```shell
cd chaturbate-overlay-app
yarn install @YOUR-USERNAME/new-module --save
```

Finally push a commit of this app with the new component:

```shell
git add .
git commit -m 'added new module'
git push origin master
```

### Building A New Docker Image

```shell
sh chaturbate-overlay-app/bin/docker/build.sh
```

### Running A New Docker Image

```shell
sh chaturbate-overlay-app/bin/docker/run.sh
```
