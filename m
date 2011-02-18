From: David Ahern <dsahern@gmail.com>
Subject: perf events: cpu-clock with callchain generates WARNING
Date: Fri, 18 Feb 2011 14:15:52 -0700
Message-ID: <4D5EE188.5090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37151 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1BRVP5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 16:15:57 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

perf-core branch as of commit 02ca752e4181e219e243cd61a60dd1da47251f11.

Seems to be very reproducible with:
perf record -v -e cpu-clock  -c 100000 -ag -fo /tmp/perf.data


[   30.884016] WARNING: at
/opt/kernel/perf-core/arch/x86/kernel/dumpstack_64.c:129
dump_trace+0x2bc/0x308()
[   30.884016] Hardware name: Bochs
[   30.884016] Perf: bad frame pointer = 0000000000001fff in callchain
[   30.884016] Modules linked in: sunrpc serio_raw virtio_net virtio_blk
virtio_pci virtio_ring virtio
[   30.884016] Pid: 903, comm: perf Not tainted 2.6.38-rc5 #3
[   30.884016] Call Trace:
[   30.884016]  <IRQ>  [<ffffffff81041917>] ? warn_slowpath_common+0x85/0x9d
[   30.884016]  [<ffffffff810419d2>] ? warn_slowpath_fmt+0x46/0x48
[   30.884016]  [<ffffffff8138c1f6>] ? bad_to_user+0x70/0x5e0
[   30.884016]  [<ffffffff81005448>] ? dump_trace+0x2bc/0x308
[   30.884016]  [<ffffffff81023531>] ? kvm_clock_read+0x19/0x1b
[   30.884016]  [<ffffffff81013030>] ? perf_callchain_kernel+0x5a/0x5c
[   30.884016]  [<ffffffff810bb893>] ? perf_prepare_sample+0xf2/0x1d2
[   30.884016]  [<ffffffff810bbab3>] ? __perf_event_overflow+0x140/0x18e
[   30.884016]  [<ffffffff8100919c>] ? sched_clock+0x9/0xd
[   30.884016]  [<ffffffff81061839>] ? sched_clock_local+0x12/0x75
[   30.884016]  [<ffffffff810619c9>] ? sched_clock_cpu+0xbb/0xc6
[   30.884016]  [<ffffffff810bc11b>] ? perf_event_overflow+0x14/0x16
[   30.884016]  [<ffffffff810bc1bb>] ? perf_swevent_hrtimer+0x9e/0xeb
[   30.884016]  [<ffffffff81002b5a>] ? system_call_after_swapgs+0x1a/0x6c
[   30.884016]  [<ffffffff8105f43a>] ? __remove_hrtimer+0x62/0x6e
[   30.884016]  [<ffffffff8105f6b9>] ? __run_hrtimer+0xbc/0x142
[   30.884016]  [<ffffffff810bc11d>] ? perf_swevent_hrtimer+0x0/0xeb
[   30.884016]  [<ffffffff8105feba>] ? hrtimer_interrupt+0xd1/0x1bd
[   30.884016]  [<ffffffff8138a90e>] ? smp_apic_timer_interrupt+0x79/0x8c
[   30.884016]  [<ffffffff81003593>] ? apic_timer_interrupt+0x13/0x20
[   30.884016]  <EOI>  [<ffffffff81086b27>] ? audit_syscall_exit+0x130/0x14c
[   30.884016]  [<ffffffff81002b5a>] ? system_call_after_swapgs+0x1a/0x6c
[   30.884016] ---[ end trace 94efe95e8c0ba650 ]---
