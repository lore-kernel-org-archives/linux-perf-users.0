From: "Qi, Yanling" <Yanling.Qi@netapp.com>
Subject: The sys_perf_event_open() syscall returned with 5 while dynamic probe
 of probe_libc:malloc
Date: Wed, 19 Oct 2016 23:04:30 +0000
Message-ID: <CO1PR06MB22199C32EF12C2613CED916E7D20@CO1PR06MB221.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx144.netapp.com ([216.240.21.25]:43757 "EHLO mx144.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbcJSXEc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Oct 2016 19:04:32 -0400
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


I am running Debian Jessie release with the kernel version 3.16.36-1. I cou=
ld successfully add malloc to perf.

# perf probe -x /lib/x86_64-linux-gnu/libc.so.6 --add malloc
Added new event:data# perf probe -x /lib/x86_64-linux-gnu/libc.so.6 --add m=
alloc
  probe_libc:malloc    (on malloc in /lib/x86_64-linux-gnu/libc-2.19.so)

You can now use it in all perf tools, such as:

        perf record -e probe_libc:malloc -aR sleep 1

But when I start to record the probe_libc:malloc event, I get EIO.

# perf record -e probe_libc:malloc -a sleep 1
Error:
The sys_perf_event_open() syscall returned with 5 (Input/output error) for =
event (probe_libc:malloc).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=3Dy kernel support configured?

Did anyone see this problem before?

Thanks,
Yanling
