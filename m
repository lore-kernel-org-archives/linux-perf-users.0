From: Benjamin King <benjaminking@web.de>
Subject: perf tracepoints for regular user?
Date: Fri, 15 Jan 2016 22:05:16 +0100
Message-ID: <20160115210516.GA6329@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:61601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbcAOVFT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 15 Jan 2016 16:05:19 -0500
Received: from localhost ([31.19.65.77]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M9dCJ-1aSB7538TX-00D1LV for
 <linux-perf-users@vger.kernel.org>; Fri, 15 Jan 2016 22:05:16 +0100
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Linux perf users <linux-perf-users@vger.kernel.org>

Hi,

I am trying to use 'perf stat -e uprobes:xyz' on a tracepoint that I ha=
ve
previously set, but with no success.
I thought that I should be able to do that when allowing my user access=
 to
debugfs, but this is what I get:

$ id -u;id -g
1001
1001
$ mount|grep debug
none on /sys/kernel/debug type debugfs (rw,uid=3D1001,gid=3D1001)
$ ls /sys/kernel/debug
acpi  bluetooth  cleancache  dell_laptop  dri extfrag ...
$ ls /sys/kernel/debug/tracing/
ls: cannot open directory /sys/kernel/debug/tracing/: Permission denied

So, my user can't look in the tracing subdirectory and perf list doesn'=
t show
the uprobes either.

I have also tried to =B4sudo setcap cap_sys_admin+eip $(which perf)=B4,=
 also
without success.

Any ideas?
Thanks,
  Benjamin King
