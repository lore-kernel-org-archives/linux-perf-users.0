From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: cross compiling perf
Date: Thu, 4 Aug 2016 21:13:27 -0300
Message-ID: <20160805001327.GM14639@kernel.org>
References: <16135005.c00Xa53Rc9@milian-kdab2>
 <3173583.b0RsRJyeV2@milian-kdab2>
 <20160804183605.GJ14639@kernel.org>
 <1973740.7uikfxrqxa@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38956 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759170AbcHEANe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Aug 2016 20:13:34 -0400
Content-Disposition: inline
In-Reply-To: <1973740.7uikfxrqxa@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: hekuang@huawei.com, wangnan0@huawei.com, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org

Em Thu, Aug 04, 2016 at 11:58:32PM +0200, Milian Wolff escreveu:
> On Donnerstag, 4. August 2016 15:36:05 CEST Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 04, 2016 at 05:02:01PM +0200, Milian Wolff escreveu:
> > > On Thursday, August 4, 2016 10:22:25 AM CEST Arnaldo Carvalho de Melo 
> wrote:
> > > > Em Wed, Aug 03, 2016 at 10:56:20PM +0200, Milian Wolff escreveu:
> > > > > I hope this helps others. I finally have a working up2date perf on my
> > > > > aarch64 platform and it seems to work form my simple 5min tests so
> > > > > far.
> > > > 
> > > > Ok, that should help people, but it is way convoluted :-\
> > > > 
> > > > How did you obtained your cross compiler environment? Some ready made
> > > > tarball or set of distro packages? I have an ever growing set of perf
> > > 
> > > > build cointainers that includes a few cross compilers:
> > > The environment was provided to us as a tarball from a customer of ours,
> > > who probably got that from another subcontractor.
> > > 
> > > <snip>
> > > 
> > >     export INSTALLDIR=/usr/${TARGET} && \
> > > 
> > > ^-- is that path potentially special cased in the build file? I mean you
> > > don't
> > Huh? Not that I am aware, no, I just looked at where the existing cross
> > build packages were located, so that I used the same place for the cross
> > built versions of libelf and zlib:
> 
 <snip>
> 
> > etc. So I assumed the best place to install the zlib and libelf devel files
> > was with that path prefix.
> 
> Right, I think my point above was not clear: Since you essentially put your 
> custom libelf into the implicit sysroot and also don't specify any prefix to 
> install to, it seems to work out of the box. Is this the common way people 
> build perf?

I have no idea besides what is documented for android in
tools/perf/Documentation/, and that uses a --sysroot

> From my experience working on e.g. KDE, one often has the sysroot 
> (e.g. /usr), and then a bunch of custom stuff in a prefix somewhere in $HOME. 
> Doing that with perf seems to be "hard", as it's not enough to do
 
>     make prefix=$HOME/path/to/foo
> 
> but instead one also needs to pass `-I.../include` and `-L.../lib` to 
> EXTRA_CFLAGS & LDFLAGS. I'd be willing to supply a patch to simplify this 
> process, if you think that is acceptable.
> 
> > See it running:
> 
> <snip>
> 
> > See? The features it is finding are just the ones related to having glibc,
> > zlib and libelf devel packages that can be used in a cross build.
> 
> OK, good to know. Then this clearly is something else special to my setup, 
> similar to my initial problems with `--sysroot` being defined in `CC` rather 
> than `EXTRA_CFLAGS`. I'll try to dig into that eventually.
>  
> > > set the sysroot anywhere, nor do you seem to pass special include paths to
> > > perf. This of course works fine in a docker environment, but for "normal"
> > > development machines, where you compile and install stuff somewhere in
> > > $HOME, this won't work at all.
> > 
> > Hey, a "docker environment" should be no different than a "normal"
> > development machine, it should work just the same, its just the former will
> > run inside a container, but the packages are the same I would install in my
> > workstation if I wanted to pollute it with a cross compiler environment.
> > Since I want to install tons of cross compiler environments, I better use
> > some sort of container, docker being the most popular, I picked it.
> 
> My point here is exactly the pollution that happens in my non-containered 
> environment. There, I have tons of dev packages installed in e.g. /usr, which 
> may potentially get picked up, as well as the "actual" stuff that should be 
> used from the sysroot. But, again, at this point this is just speculation.

Sure, this is a valid concern and one that should grand creating a few
more containers, taking advantage of its layers stuff to reduce the
space needed, i.e. share the base stuff I have and then have another set
with the native devel packages, to test that there is no pollution and
the results are the expected ones in a cross compile env.
 
> If you have the time, could you try to install some more x86 dev packages in 
> your docker environments? E.g. when you install libunwind(-x86-64) - does it 

I'll try what I described above, which is in line with your suggestion.

> then get picked up by your arm cross compile, or does it work as it should? 
> That data point would help me figure out what could go wrong.

Will try tomorrow, if time allows, and will do it in the container
fashion, i.e. it should be a few more containers, testing this
possibility.
 
> > > The above wouldn't directly explain the really strange behavior of the
> > > feature detection though (which enables _everything_ for me).
> > 
> > That is strage, yes, and I haven't even tried to figure out why this
> > happens in your case, I was just trying to show cross compiler
> > environments where the cross build of perf works, perhaps that would
> > help you figure out your specific case.
> 
> Yep, it does help (see above). Thanks!
> 
> > Further example, here is the Android NDK one, that is on top of Fedora 24
> > instead of the previous example, that is on top of Ubuntu 16.04, and here
> > you may have your answer, i.e. use EXTRA_CFLAGS to set --sysroot, I got
> > that from tools/perf/Documentation/android.txt:
> 
> I do pass --sysroot to EXTRA_CFLAGS via CFLAGS. From my previous mail:
> 
> export CFLAGS="--sysroot=...
> #              ^-- CFLAGS contains --sysroot
> 
> make ...\
>     EXTRA_CFLAGS="$CFLAGS -I/home/yocto/milian/target-prefix/include" \
> #                 ^--- and gets passed in here
>     LDFLAGS="-L/home/yocto/milian/target-prefix/lib $LDFLAGS" \
>     prefix=/home/yocto/milian/target-prefix
> 
> > [root@jouet x-arm64]# cat /root/perf/android/r12b/arm/Dockerfile
> > # docker.io/acmel/linux-perf-tools-build-android-ndk:r12b
> > FROM docker.io/fedora:24
> > MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> > ENV SOURCEFILE=android-ndk-r12b-linux-x86_64.zip
> > RUN dnf -y install make bison flex unzip && \
> >     dnf -y clean all && \
> >     mkdir -m 777 -p /tmp/build/perf /tmp/build/objtool && \
> >     curl -OL http://dl.google.com/android/repository/${SOURCEFILE} && \
> >     unzip -d /opt ${SOURCEFILE} && \
> >     rm -f ${SOURCEFILE} && \
> >     rm -rf /opt/android-ndk-r12b/sources \
> > 	   /opt/android-ndk-r12b/platforms/android-[19]* \
> > 	   /opt/android-ndk-r12b/platforms/android-2[0-3]* \
> > 	   /opt/android-ndk-r12b/platforms/android-24/arch-mips* \
> > 	   /opt/android-ndk-r12b/platforms/android-24/arch-x86* \
> > 	   /opt/android-ndk-r12b/toolchains/x86* \
> > 	   /opt/android-ndk-r12b/toolchains/mips* \
> > 	   /opt/android-ndk-r12b/toolchains/llvm* \
> > 	   /opt/android-ndk-r12b/prebuilt/ \
> > 	   /opt/android-ndk-r12b/python* \
> > 	   /opt/android-ndk-r12b/shader-tools/ &&\
> >     groupadd -r perfbuilder && \
> >     useradd -r -g perfbuilder perfbuilder
> > USER perfbuilder
> > ENV NDK=/opt/android-ndk-r12b/
> > ENV
> > NDK_TOOLCHAIN=${NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x8
> > 6_64/bin/arm-linux-androideabi- ENV
> > NDK_SYSROOT=${NDK}/platforms/android-24/arch-arm
> > ENTRYPOINT make -C /git/linux/tools/perf O=/tmp/build/perf WERROR=0 ARCH=arm
> > CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie --sysroot=${NDK_SYSROOT}"
> > && \ make -C /git/linux/tools/objtool O=/tmp/build/objtool WERROR=0
> > ARCH=arm CROSS_COMPILE=${NDK_TOOLCHAIN} EXTRA_CFLAGS="-pie
> > --sysroot=${NDK_SYSROOT}" [root@jouet x-arm64]#
> > 
> > --------------------------------------------------------
> > 
> > This one comes with a bit more pre-built devel packages, so did not have to
> > cross build zlib (I'll copy the cross build of libelf to get a bit more code
> > tested...) instead I threw away lots of toolchains for arches I didn't
> > want, leaving just the ones for "arm-linux-androideabi-", running it we
> > get:
> > 
> > [root@jouet ~]# docker run -v /home/acme/git:/git:Z --rm -ti
> > docker.io/acmel/linux-perf-tools-build-android-ndk:r12b make: Entering
> > directory '/git/linux/tools/perf'
> >   BUILD:   Doing 'make -j4' parallel build
> > 
> > Auto-detecting system features:
> > ...                         dwarf: [ OFF ]
> > ...            dwarf_getlocations: [ OFF ]
> > ...                         glibc: [ OFF ]
> 
> glibc fails, but no fatal error is shown. from the make files I seem to 
> remember special casing for the bionic libc implementation, which doesn't seem 
> to be represented in the feature list.

Right, in this case we _expect_ glibc to fail, IIRC, because it is not
present in this environment.
 
> <snip>
> 
> Still, good to see that the feature detection otherwise seems to work just 
> fine for your docker setups.
> 
> Thanks for the input, I'll get back to you once I know more about the failures 
> on my system. Btw.:
> 
> - would it be acceptable to add a warning/error to the build system when CC 
> contains more than the compiler name? 
> - would a patch be accepted to automatically add $prefix/include and $prefix/
> lib to -I & -L via CFLAGS/LDFLAGS in the makefile (see above)?
> 
> If so, then I'd create some patches for that.

Send patches for each of these cases, make sure to CC Jiri Olsa,
Namhyung Kim, Wang Nan, they all worked at the makefiles and hopefully
will chime in, some in cross environments, like Wang and He.

- Arnaldo
