From: Florin Trofin <ftrofin@adobe.com>
Subject: perf: generating a report from another machine doesn't show symbols
 for my binaries
Date: Wed, 7 Nov 2012 16:52:20 -0800
Message-ID: <CCC03D52.6EC0%ftrofin@adobe.com>
References: <CCC01133.6EA9%ftrofin@adobe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from exprod6og124.obsmtp.com ([64.18.1.242]:41270 "EHLO
	exprod6og124.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab2KHAw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 7 Nov 2012 19:52:27 -0500
Received: from inner-relay-4.eur.adobe.com (inner-relay-4b [10.128.4.237])
	by outbound-smtp-2.corp.adobe.com (8.12.10/8.12.10) with ESMTP id qA80qPHP024792
	for <linux-perf-users@vger.kernel.org>; Wed, 7 Nov 2012 16:52:25 -0800 (PST)
Received: from nahub01.corp.adobe.com (nahub01.corp.adobe.com [10.8.189.97])
	by inner-relay-4.eur.adobe.com (8.12.10/8.12.9) with ESMTP id qA80qOXL006350
	for <linux-perf-users@vger.kernel.org>; Wed, 7 Nov 2012 16:52:24 -0800 (PST)
In-Reply-To: <CCC01133.6EA9%ftrofin@adobe.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

I am having difficulties while trying to archive the performance
information from one machine so I can parse it on another. Here is my
setup:

I have two machines, say m1 and m2 and I want to profile my executable on
m1 and see the report on m2. Both m1 and m2 run the same OS: CentOS 6:

$uname -a
Linux florin-vm-cent6 2.6.32-279.el6.x86_64 #1 SMP Fri Jun 22 12:19:21 UTC
2012 x86_64 x86_64 x86_64 GNU/Linux

I run my perf record this way:

$sudo perf record -g -a mytest

After the recording is done when I check the build-ids collected in the
report I see only the system modules in there:

$ sudo perf buildid-list -i perf.data

3dfb468e07d40879575e016e8999a25ee2694792 [kernel.kallsyms]
caea6ee6167bf7c214c1008179879ff8ac2447b6
/lib/modules/2.6.32-279.el6.x86_64/kernel/fs/ext4/ext4.ko
2eba2e1710dd909986d1a5f5b27720f476fc6a74
/lib/modules/2.6.32-279.el6.x86_64/kernel/fs/jbd2/jbd2.ko
4c37e276cd23f0877af7587ed1f699aadb741ec9 /lib64/libc-2.12.so
48a9f8600f0a15f6418ede25846c324ec8891dd4 /lib64/libpthread-2.12.so
42aefafc23375dc250c49c420c37edc4515b9c02 /lib64/ld-2.12.so
bf14593d7915402aa62c2573fccdb252aeebf754 /lib64/libm-2.12.so
ee85ac5f03ac14df9dcc93b6b57cb65a208f1933 /lib64/libgobject-2.0.so.0.2200.5
545c98f5fd1fb2c21bf35c621d9760e698dce1f8 /usr/lib64/libXrender.so.1.3.0
b88f3388cedb5fd906faccbb3febd81cf541273c /usr/bin/Xorg
2b40e6807e9482617b35b1c4a7e6e908a0e1bfc6 /usr/lib64/libpixman-1.so.0.18.4
91fd6a6700be179c5679b23ea0908f0b10e82537 /usr/lib64/xorg/modules/libfb.so
bfaebdeecb20d4e8a842a4b3daeab93bbd3caaf3 /usr/lib64/libcairo.so.2.10800.8
8f5f1b5e9d1b4ca655c88c84704b3b9b705c245f /usr/lib64/libvte.so.9.2501.0
534663464360e8d2157395f397352d28742ba45e /usr/bin/perf
d578a8e6cf05018d25168822e4cdfd780abf4a4e /usr/sbin/lsof


The funny thing is that "perf report -g" gives me symbols for mytest
binary and all its shared libs like it is reading it from someplace else.

I compiled my code with -fno-omit-frame-pointer and "-Wl,--build-id".

If I issue a "sudo perf archive" and then expand the archive file that was
generated I see the same files as above in the archive (i.e. none of my
binaries). After moving the perf file and the symbol archive to m2 and use
perf report on it I see symbols only for the kernel and system libraries.

So it seems that "perf archive" doesn't store all the information that
"perf report" is able to read on m1 so when I try to generate a report on
m2 from the samples collected on m1 I miss the symbols for my binaries.

Thanks in advance for shedding any light on this issue. The new perf tools
seems very cool - I just wish there would be more information online for
it.

Florin
