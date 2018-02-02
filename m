From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: Not finding symbol information
Date: Fri, 2 Feb 2018 14:06:32 +0000
Message-ID: <30C2D590D16A5C46ADFE65219103779892609BF7@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from p-us1-iereast-outbound.us1.avaya.com ([135.11.29.13]:46822 "EHLO
        p-us1-iereast-outbound.us1.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751900AbeBBOQu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Feb 2018 09:16:50 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

We are using 'perf record' to collect information on an embedded ARM board (the target)
and then using 'perf report' on a PC (the host) to interpret the data.

The host has a copy of the rootfs of the target that also includes debug info. We pass the
'--symfs' option to 'perf report' to point to the rootfs.

Whenever an event in the data corresponds to a DSO that exists on the host, 'perf report'
complains that the debug info is not available, even though that info is in fact available in
the rootfs.

What seems to be happening is that 'perf report' "sees" the host's copy of the DSO first,
"remembers" this DSO's buildid (which is incorrect), then "sees" the debug info in the
rootfs but rejects it because it doesn't match the buildid "remembered" earlier, and then
concludes that there is no debug info available.

Using /bin/bash as an example, selected output from 'perf report -v':

...
build id event received for /bin/bash: a35856957f6f165a1ca4ea98afbd1a986dfa785c
...
symsrc__init: build id mismatch for sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
symsrc__init: build id mismatch for sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash.
symsrc__init: build id mismatch for sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/bash.
/bin/bash with build id 04eca96c5bf3e9a300952a29ef3218f00487d37b not found, continuing without symbols
...

$ file /bin/bash
/bin/bash: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=04eca96c5bf3e9a300952a29ef3218f00487d37b, stripped

$ file sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash
sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/bash: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, stripped

$ file sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/bash
sip96x1_prod/cp/lib/dvf99/sysroots/armv5te-dspg-linux-gnueabi///bin/.debug/bash: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter *empty*, for GNU/Linux 3.2.0, BuildID[sha1]=a35856957f6f165a1ca4ea98afbd1a986dfa785c, not stripped

We are using Linux 4.4-11 on the target and 4.4.0-109-generic (Ubuntu 16.04) on the host.

Is this a known issue? Has it been addressed in a more recent kernel?

Thanks in advance,
MV
