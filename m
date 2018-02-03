From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: Not finding symbol information
Date: Fri, 2 Feb 2018 18:38:29 -0600
Message-ID: <20180202183829.8ca5ac81d7c48bfafc7b79d1@arm.com>
References: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
        <1590706.6giPFGD14k@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeBCAib (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Feb 2018 19:38:31 -0500
In-Reply-To: <1590706.6giPFGD14k@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "Vuille, Martin (Martin)" <vmartin@avaya.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Fri, 2 Feb 2018 15:31:08 +0100
Milian Wolff <milian.wolff@kdab.com> wrote:

> On Friday, February 2, 2018 3:06:32 PM CET Vuille, Martin (Martin) wrote:
> > We are using 'perf record' to collect information on an embedded ARM board
> > (the target) and then using 'perf report' on a PC (the host) to interpret
> > the data.
> > 
> > The host has a copy of the rootfs of the target that also includes debug
> > info. We pass the '--symfs' option to 'perf report' to point to the rootfs.
> > 
> > Whenever an event in the data corresponds to a DSO that exists on the host,
> > 'perf report' complains that the debug info is not available, even though
> > that info is in fact available in the rootfs.
> > 
> > What seems to be happening is that 'perf report' "sees" the host's copy of
> > the DSO first, "remembers" this DSO's buildid (which is incorrect), then
> > "sees" the debug info in the rootfs but rejects it because it doesn't match
> > the buildid "remembered" earlier, and then concludes that there is no debug
> > info available.
> 
> `perf record` (not `perf report`) is "remembering" build-ids in ~/.debug.

I've experienced bugs in the area that come about when using different
versions of perf writing to the common cache area, and at one point
started rm -fr ~/.debug; mkdir -p ~/.debug, and re-extracting the 'perf
archive' result, with tar jxf perf.data.tar.bz2 -C ~/.debug, just for
sanity's sake.

> > Using /bin/bash as an example, selected output from 'perf report -v':
> > 
> > ...
> > build id event received for /bin/bash:
> > a35856957f6f165a1ca4ea98afbd1a986dfa785c ...
> > symsrc__init: build id mismatch for
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
> > symsrc__init: build id mismatch for
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
> > symsrc__init: build id mismatch for
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> > bash. /bin/bash with build id 04eca96c5bf3e9a300952a29ef3218f00487d37b not
> > found, continuing without symbols ...
> > 
> > $ file /bin/bash
> > /bin/bash: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically
> > linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32,
> > BuildID[sha1]=04eca96c5bf3e9a300952a29ef3218f00487d37b, stripped
> > 
> > $ file
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash:
> > ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked,
> > interpreter /lib/ld-linux.so.3, for GNU/Linux 3.2.0,
> > BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, stripped
> > 
> > $ file
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> > bash
> > sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/
> > bash: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically
> > linked, interpreter *empty*, for GNU/Linux 3.2.0,
> > BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, not stripped
> 
> This indeed looks like a bug in the build id matching algorithm. I suggest you 
> debug it to figure out why it thinks the build id mismatches. I.e. expand the 
> debug output and write the build id it has read and compare that to what file 
> sees and what the perf file expects.
> 
> > We are using Linux 4.4-11 on the target and 4.4.0-109-generic (Ubuntu 16.04)
> > on the host.
> > 
> > Is this a known issue? Has it been addressed in a more recent kernel?
> 
> This should not be part of the kernel, but rather part of the userland perf 
> tools. You can easily build the latest versions of those yourself, without 
> having to build a new kernel. So on your host, try this:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git -b 
> perf/core
> cd tools/perf
> make # make sure you have all the required dependencies, most notably 
> elfutils, libiberty, ...
> /perf report -i <path to perf.data>

FWIW, I just tried acme's tip against some old arm32 perf.data capture
& archive, and the problem still seems to exist:

$ file ~/.debug/bin/dd/0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb 
/home/kim/.debug/bin/dd/0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32, BuildID[sha1]=0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb, stripped

$ perf report -vv
...
build id event received for /bin/dd: 0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb
...
symsrc__init: build id mismatch for /bin/dd.
no symbols found in /bin/dd, maybe install a debug package?
...

Although the executable didn't have debug data, so the symbols weren't
going to be resolved anyway...

It might also be worth trying running the report on the target, if
possible.  I'll try and take a look next week...I need to revive my
arm32 boxes...

Kim
