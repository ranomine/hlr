# How to use Wercker manually (CLI)

The wercker.yml file defines [pipelines][1], which are steps remotely run by [wercker][2] on each pushed commit.
It is also possible to run such pipelines manually via the [wercker CLI][3].
The notes below are a guide to use the CLI in current wercker.yml.

[1]: https://devcenter.wercker.com/development/pipelines/
[2]: https://app.wercker.com/
[3]: https://devcenter.wercker.com/development/cli/


## Build pipelines

To build the *hub*:
```
wercker build --commit werker_build
```

To build *documentation*:
```
wercker build --pipeline documentation --commit wercker_documentation
```

To run *unit tests*:
```
wercker build --pipeline unit_tests --commit wercker_unit_tests
```

To run *integration tests*:
```
wercker build --pipeline integration_tests --commit wercker_integration_tests
```

To run *latency tests*:
```
wercker build --pipeline latency_tests --commit wercker_latency_tests
```


## Important remarks:

The `--commit` argument is optional: it enables you to run a docker container on the pipeline result, e.g.:
```
docker run -it --rm werker_build:<git_branch> /bin/bash
cd /pipeline/source/build
```

The `wercker build ...` command requires the variables `X_USERNAME` and `X_PASSWORD`. One way to do it is to define a local `wercker.env` file with:
```
export X_USERNAME=moijidev
export X_PASSWORD=<THE_MOIJIDEVS_PASS>
```

And then:

```
source wercker.env
wecker build <bla bla>
```

## Use VNC

docker run -p 5900:5900 -it --rm werker_build:<git_branch>
cd pipeline/source/build/
vm/pharo -vm-display-null RoamingHub.image eval --no-quit "\
Workspace openContents: '\
"Evaluate after VNC login:"\
UIManager default: MorphicUIManager new.\
"Evaluate before save or VNC logout:"\
UIManager default: NonInteractiveUIManager new.'.\
RFBServer current\
    initializePreferences;\
    allowEmptyPasswords: false;\
    setFullPassword: 'secret';\
    setViewPassword: 'secrettoo';\
    start: 0."

Now, run a VNC client and connect to localhost:5900.
