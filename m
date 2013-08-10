From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: How can I get timestamps of samples in perf
Date: Fri, 9 Aug 2013 22:35:13 -0400
Message-ID: <CAEuYUeqSbcMiszy-mZBROobsHv1Ohr4n2rVNXr_penhux3Dy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63213 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031202Ab3HJCfO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 9 Aug 2013 22:35:14 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so1561232vcb.33
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Aug 2013 19:35:13 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi all,

I am trying to understand something about perf record. In its guide,
perf record could use option -T to generate sample timestamp, and then
use perf report -D to get them.

However, what I get from perf report -D is something as follows. Does
anyone have an idea what content of perf.data  means?

# ========pei-OptiPlex-960:~$
# captured on: Fri Aug  9 15:58:02 2013
# hostname : peipei-OptiPlex-960
# os release : 3.2.0-49-generic-pae
# perf version : 3.2.46
# arch : i686
# nrcpus online : 4
# nrcpus avail : 4
# cpudesc : Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
# cpuid : GenuineIntel,6,23,10
# total memory : 8134988 kB
# cmdline : /usr/bin/perf_3.2.0-49 record -T sleep 3
# event : name = cycles, type = 0, config = 0x0, config1 = 0x0, config2 = 0x0, e
# HEADER_CPU_TOPOLOGY info available, use -I to display
# ========
#

0x128 [0x50]: event: 1
.
. ... raw event: size 80 bytes
.  0000:  01 00 00 00 01 00 50 00 ff ff ff ff 00 00 00 00  ......P.........
.  0010:  00 00 00 c1 00 00 00 00 ff 9f 41 37 00 00 00 00  ..........A7....
.  0020:  00 00 00 c1 00 00 00 00 5b 6b 65 72 6e 65 6c 2e  ........[kernel.
.  0030:  6b 61 6c 6c 73 79 6d 73 5d 5f 74 65 78 74 00 00  kallsyms]_text..
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.
0 0x128 [0x50]: PERF_RECORD_MMAP -1/0: [0xc1000000(0x37419fff) @ 0xc1000000]: [k

0x178 [0x80]: event: 1
.
. ... raw event: size 128 bytes
.  0000:  01 00 00 00 01 00 80 00 ff ff ff ff 00 00 00 00  ................
.  0010:  00 a0 41 f8 00 00 00 00 ff 5f 00 00 00 00 00 00  ..A......_......
.  0020:  00 00 00 00 00 00 00 00 2f 6c 69 62 2f 6d 6f 64  ......../lib/mod
.  0030:  75 6c 65 73 2f 33 2e 32 2e 30 2d 34 39 2d 67 65  ules/3.2.0-49-ge
.  0040:  6e 65 72 69 63 2d 70 61 65 2f 6b 65 72 6e 65 6c  neric-pae/kernel
.  0050:  2f 64 72 69 76 65 72 73 2f 70 6c 61 74 66 6f 72  /drivers/platfor
.  0060:  6d 2f 78 38 36 2f 77 6d 69 2e 6b 6f 00 00 00 00  m/x86/wmi.ko....
.  0070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.
0 0x178 [0x80]: PERF_RECORD_MMAP -1/0: [0xf841a000(0x5fff) @ 0]: /lib/modules/3.

0x1f8 [0x88]: event: 1
.
. ... raw event: size 136 bytes
.  0000:  01 00 00 00 01 00 88 00 ff ff ff ff 00 00 00 00  ................
.  0010:  00 00 42 f8 00 00 00 00 ff 6f 00 00 00 00 00 00  ..B......o......
.  0020:  00 00 00 00 00 00 00 00 2f 6c 69 62 2f 6d 6f 64  ......../lib/mod
.  0030:  75 6c 65 73 2f 33 2e 32 2e 30 2d 34 39 2d 67 65  ules/3.2.0-49-ge
.  0040:  6e 65 72 69 63 2d 70 61 65 2f 6b 65 72 6e 65 6c  neric-pae/kernel
.  0050:  2f 64 72 69 76 65 72 73 2f 69 32 63 2f 61 6c 67  /drivers/i2c/alg
.  0060:  6f 73 2f 69 32 63 2d 61 6c 67 6f 2d 62 69 74 2e  os/i2c-algo-bit.
.  0070:  6b 6f 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ko..............
.  0080:  00 00 00 00 00 00 00 00                          ........
.
0 0x1f8 [0x88]: PERF_RECORD_MMAP -1/0: [0xf8420000(0x6fff) @ 0]: /lib/modules/3.


Thanks for your help.

Yours,
Wang Peipei
