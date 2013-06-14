From: Cody P Schafer <devel-lists@codyps.com>
Subject: BUG: perf kvm top --callgraph not showing callgraph
Date: Thu, 13 Jun 2013 18:04:57 -0700
Message-ID: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f66.google.com ([209.85.219.66]:53584 "EHLO
	mail-oa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab3FNBE6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Jun 2013 21:04:58 -0400
Received: by mail-oa0-f66.google.com with SMTP id g12so5237oah.9
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2013 18:04:57 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all, I'm trying to use perf kvm to profile linux early boot.

However, perf kvm top always appears to behave as though it's in
non-callgraph mode.

I dug through the code a bit, and it looks as though
machine__resolve_challchain_sample() is getting called with an
ip_callchain consistently containing only 2 entries:
PERF_CONTEXT_KERNEL followed by PERF_CONTEXT_USER. This makes it
appear that the perf_sample is not getting any callchain info from the
kernel.

System setup:

I'm running qemu as follows:

$ qemu-system-x86_64 -M pc -kernel ./bzImage  -drive
file=./rootfs.ext2,if=virtio -append "root=/dev/vda console=ttyS0
earlyprintk=ttyS0 debug numa=fake=2 kmemleak=on extra_nr_node_ids=100"
-smp 8 -nographic -enable-kvm -s -m 64G

And perf kvm top as follows:
$  sudo ./perf kvm --guestvmlinux ~/vmlinux top --call-graph

The host `uname -a` is
     Linux pizza 3.7.10-gentoo-r1 #1 SMP Thu Apr 25 15:11:18 PDT 2013
x86_64 Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz GenuineIntel
GNU/Linux

(And I've gotten the same results with 3.8.0-22-generic #33~precise1-Ubuntu).

The guest kernel is v3.10-rc5 with some additional patches mostly to mm/*

The version of the perf tool is 3.9.rc8.g25e33e (the version in
linus's tree today).
