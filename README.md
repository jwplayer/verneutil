verneutil
=========

Virtual environments for your rubies!


`verneutil` has 2 modes: a controller mode and a client mode. The client mode
is what you will use to create virtual environments and is what you will use
95% of the time.

The controller mode is used to ... wait for it ... control `verneutil`. That is
to say: initialize the application, install rubies, etc.


Great! Let's get started.

Installing & Managing `verneutil`
---------------------------------

### 1) Install `verneutil`
Clone the repo to a reasonable location for your needs:

```bash
git clone https://github.com/jwplayer/verneutil.git /usr/local/lib/verneutil
```

Create link in your system path, for example:

```bash
ln -s /usr/local/lib/verneutil/main.sh /usr/local/bin/verneutil
```


### 2) Initialize the application
There are submodules and what not included with verneutil... go ahead
and initialize it so that all is well:

```bash
verneutil init
```

### 3) Install some rubies.
Now, you should be able to install versions on rubies you want to use
all over the place, for instance:

```bash
verneutil ctl --install 2.2.3
```

and,

```bash
verneutil ctl --install 2.1.7
```


Creating virtual rubies
-----------------------

### 1) List available rubies
You can always see what rubies are available for your use by using the
`-l` or `--list` option, like so:

```bash
$ verneutil --list
* 2.1.7
* 2.2.3
```

### 2) Create a virtual environment
You can create a virtual environment with the `--create` option and specifying
the relative path (relative to the path where `verneutil` is being called from)
where the virtual environment should be installed along with the version of
ruby you want installed in that virualenvironment. The rubies available can be listed
by running `virtualenv -l` (see above).

For example, to create and virtual environment in the `env` directory which
has ruby version 2.2.3 installed:

```bash
verneutil --create env 2.2.3
```

### 3) Activate the environment
Yep, you gotta to activate it:

```bash
source env/activate
```

or,

```bash
. env/activate
```


### 4) Deactivate when you're done
Deactivate the virtual environment when you're done with it to restore
your environments variables and paths:

```bash
deactivate
```



System Depencies
----------------
At a minimum on ubuntu you'll need the following packages in order to compile
recent versions of ruby (~v2.1+):

* `git`
* `curl` or `wget`
* `libssl-dev`
* `libreadline-dev `
* `zlib1g-dev`
* `build-essential`

If you want to install old rubies (~v1.8), you'll probably need some additional
packages like:

* `subversion`
* `autoconf`
* `byacc`


Known Issues
------------
Somewhere around <= ruby v2.0.0 `gem` is really badly behaved. It's possible that
`gem` will write into `~/.gem` even if you don't want it to... deal with it.

I don't really know what's going to happen when you use `rubinius` or  `mruby`.


About the name
--------------
`verneutil` is a bastardization of "verneuil" (go ahead, [look it up][verneuil_process]). And before you ask it's [MIT-licensed][license_file].


[verneuil_process]: https://en.wikipedia.org/wiki/Verneuil_process
[license_file]: https://github.com/jwplayer/verneutil/blob/master/LICENSE