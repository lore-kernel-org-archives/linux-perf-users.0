From: Vinson Lee <vlee@twopensource.com>
Subject: watchdog warnings on 3.4 triggered by perf
Date: Tue, 25 Mar 2014 10:56:10 -0700
Message-ID: <CAHTgTXUSc6Ns-7v6JYKYR6TJCtbrKA+oka18sPTyNhaRkigncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:60570 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024AbaCYR4L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 25 Mar 2014 13:56:11 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so1012467oag.7
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2014 10:56:11 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org

Hi.

We are seeing kernel watchdog warnings on Linux 3.4.78 on several
different machines. The warning occurs occasionally when there are
multiple instances of perf stat with an event list each tracing a
different process. This isn't a recent regression as we saw this
happen with earlier versions of 3.4.y too.

Here is the typical stack trace.

------------[ cut here ]------------
WARNING: at kernel/watchdog.c:241 watchdog_overflow_callback+0x9b/0xa6()
Watchdog detected hard LOCKUP on cpu 4
Modules linked in: netconsole configfs ipv6 dm_multipath video sbs
sbshc acpi_pad acpi_memhotplug acpi_ipmi parport_pc lp parport
tcp_diag inet_diag ipmi_si ipmi_d
andler igb dcdbas hed sb_edac i2c_i801 ioatdma i2c_core iTCO_wdt
shpchp iTCO_vendor_support edac_core wmi dca microcode
Pid: 20128, comm: java Not tainted 3.4.78 #1
Call Trace:
 <NMI>  [<ffffffff8103c20c>] warn_slowpath_common+0x85/0x9d
 [<ffffffff8103c2c7>] warn_slowpath_fmt+0x46/0x48
 [<ffffffff810689db>] ? sched_clock_cpu+0x44/0xce
 [<ffffffff810ad7c4>] watchdog_overflow_callback+0x9b/0xa6
 [<ffffffff810dbae7>] __perf_event_overflow+0x137/0x1c1
 [<ffffffff8100fa36>] ? x86_perf_event_set_period+0x107/0x113
 [<ffffffff810dbeeb>] perf_event_overflow+0x14/0x16
 [<ffffffff81014406>] intel_pmu_handle_irq+0x263/0x2e0
 [<ffffffff814bcc8f>] perf_event_nmi_handler+0x19/0x1b
 [<ffffffff814bc663>] default_do_nmi+0x66/0x1d4
 [<ffffffff814bc841>] do_nmi+0x70/0xbb
 [<ffffffff814bbd0c>] end_repeat_nmi+0x1a/0x1e
 <<EOE>>
---[ end trace 6a76b814d8600490 ]---

Cheers,
Vinson
