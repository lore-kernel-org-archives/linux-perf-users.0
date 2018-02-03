From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Not finding symbol information
Date: Sat, 3 Feb 2018 03:30:02 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989260A050@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
        <1590706.6giPFGD14k@milian-kdab2>
 <20180202183829.8ca5ac81d7c48bfafc7b79d1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from de307622-de-outbound.net.avaya.com ([198.152.71.100]:54639 "EHLO
        de307622-de-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbeBCDkH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Feb 2018 22:40:07 -0500
In-Reply-To: <20180202183829.8ca5ac81d7c48bfafc7b79d1@arm.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kim Phillips <kim.phillips@arm.com>, Milian Wolff <milian.wolff@kdab.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> > > What seems to be happening is that 'perf report' "sees" the host's
> > > copy of the DSO first, "remembers" this DSO's buildid (which is
> > > incorrect), then "sees" the debug info in the rootfs but rejects it
> > > because it doesn't match the buildid "remembered" earlier, and then
> > > concludes that there is no debug info available.
> >
> > `perf record` (not `perf report`) is "remembering" build-ids in ~/.debug.
> 
> I've experienced bugs in the area that come about when using different
> versions of perf writing to the common cache area, and at one point started
> rm -fr ~/.debug; mkdir -p ~/.debug, and re-extracting the 'perf archive'
> result, with tar jxf perf.data.tar.bz2 -C ~/.debug, just for sanity's sake.
> 

I wasn't referring to the buildid cache, but to the internal buildid processing
logic of 'perf report'.

If I understand what it does correctly, 'perf archive' would be of no use to me,
as there is no debug info to preserve on the target. I use a custom script to prepare
the buildid cache on the host based on the output of 'perf buildid-list'.

BTW, I found some odd behaviour around that too. 'perf report --symfs PATH' is
looking for the buildid cache in 'PATH/$HOME/.debug', not '$HOME/.debug'.
Not sure whether that's design intent or a bug.

> FWIW, I just tried acme's tip against some old arm32 perf.data capture &
> archive, and the problem still seems to exist:
> 
> $ file ~/.debug/bin/dd/0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb
> /home/kim/.debug/bin/dd/0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb:
> ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked,
> interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32,
> BuildID[sha1]=0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb, stripped
> 
> $ perf report -vv
> ...
> build id event received for /bin/dd:
> 0ff7b46a4aec92df5ccdb83ab5eef7f1888315fb
> ...
> symsrc__init: build id mismatch for /bin/dd.
> no symbols found in /bin/dd, maybe install a debug package?
> ...
> 
> Although the executable didn't have debug data, so the symbols weren't
> going to be resolved anyway...

Thanks.

> 
> It might also be worth trying running the report on the target, if possible.  I'll
> try and take a look next week...I need to revive my
> arm32 boxes...

Unfortunately the stripped binaries just barely fit on the target, so getting the
debug info on there is out of the question.

Regards,
MV
