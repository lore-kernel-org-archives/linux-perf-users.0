Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86F31812E;
	Fri,  6 Feb 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369528; cv=none; b=EBN2mhKTpNfMaLTzwPxNY2MvVxLxc9xWqpMnwDMx8ztx43PwHBUYYVNqAjYpZODd8D5XKe6vNJiV/M3FHG0b7dGE3FutzgMt4Eo1a5vavWtlEs2FW9dhh4nHrb3zuJbKyqp5IgT317Thtir/ftnV6fEhsDazMQTdb+kMGGmnW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369528; c=relaxed/simple;
	bh=c3pE5PI3NJUSDxEG5fIm+hbiO7W2Wr+hTUrVc7myUcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjCyEEFlr7byT9sFUPTJSB2atQss48F+PHynXU1QWgWTmEGtYzGD5MosMDeTnsZAJ3tSyilMhyKjIu3HNvOKJarP+Nwxmwf2quMvzaNuoMeMFrM8f+lu9rx1vpMAJptQyWexxNlSpilrnw7Vg6wG1SFavexzPYqWfT/LjaWcqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YO3vkfVs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YO3vkfVs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ej7Kagyl+8+UZuhb+AQ2z965KfjwhkrxWjt1dxT2Rw0=; b=YO3vkfVs/WunoESX14vzKgmDUG
	uMhZ0iLEGaMyqGBexLZ0rbMYIu+deSLRbk6qQUTPv7YmiMW9ntqsC285cwDfLTjJ6EPVU02DMv/ic
	IoT8X0cAcfNzU+zwslysYzA4UMPC92csdxnyDfSUHh5AzxzwKJ5dSL95gP5nlpYAvueq604oy65Dr
	kKfSkcBXGwye29g3EhkSH1n7tDBsT8+MiUoBK7RctvMrgS77GcplBdO3hDCHT+/cuNXQieKyuy2Dx
	8LzBg79HABOR9sASQEL1Qoe+KT7Wb8AdpcIMfa/INRMEgJFZvhbcFkEdwe+mLyDdf0GPHEj4Da7m/
	NzctAskw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voHz5-00000004wzq-3Iyz;
	Fri, 06 Feb 2026 09:18:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3A0F3030DB; Fri, 06 Feb 2026 10:18:38 +0100 (CET)
Date: Fri, 6 Feb 2026 10:18:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com>,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KCSAN: data-race in perf_event_set_state /
 perf_mmap_rb
Message-ID: <20260206091838.GP1395266@noisy.programming.kicks-ass.net>
References: <69859a00.a00a0220.34fa92.0028.GAE@google.com>
 <CACT4Y+axrv7knEVcS_2BHoPgkrqfwKd0VmHVRk7eogjssfZ6jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+axrv7knEVcS_2BHoPgkrqfwKd0VmHVRk7eogjssfZ6jQ@mail.gmail.com>

On Fri, Feb 06, 2026 at 08:38:25AM +0100, Dmitry Vyukov wrote:
> On Fri, 6 Feb 2026 at 08:36, syzbot
> <syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c537e12daeec Merge tag 'bpf-fixes' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1133a5fc580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c160236e1ef1e401
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5334e6bdc43f6d1dcb7d
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/036ac5d12a14/disk-c537e12d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/07ddd15f46f8/vmlinux-c537e12d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/7866e67b7a58/bzImage-c537e12d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in perf_event_set_state / perf_mmap_rb
> >
> > write to 0xffff88812279f1a0 of 8 bytes by task 12011 on cpu 1:
> >  perf_event_update_time kernel/events/core.c:737 [inline]
> >  perf_mmap_rb+0x71c/0x910 kernel/events/core.c:7037
> >  perf_mmap+0x1ce/0x2f0 kernel/events/core.c:7164
> >  vfs_mmap include/linux/fs.h:2053 [inline]
> >  mmap_file mm/internal.h:167 [inline]
> >  __mmap_new_file_vma mm/vma.c:2421 [inline]
> >  __mmap_new_vma mm/vma.c:2484 [inline]
> >  __mmap_region mm/vma.c:2708 [inline]
> >  mmap_region+0x1045/0x1410 mm/vma.c:2786
> >  do_mmap+0x9b3/0xbe0 mm/mmap.c:558
> >  vm_mmap_pgoff+0x17a/0x2e0 mm/util.c:581
> >  ksys_mmap_pgoff+0x268/0x310 mm/mmap.c:604
> >  x64_sys_call+0x16bb/0x3000 arch/x86/include/generated/asm/syscalls_64.h:10
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff88812279f1a0 of 8 bytes by task 12005 on cpu 0:
> >  __perf_update_times kernel/events/core.c:720 [inline]
> >  perf_event_update_time kernel/events/core.c:735 [inline]
> >  perf_event_set_state+0x153/0x440 kernel/events/core.c:754
> >  event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
> >  group_sched_out kernel/events/core.c:2415 [inline]
> >  __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
> >  ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
> >  task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
> >  perf_event_context_sched_out kernel/events/core.c:3746 [inline]
> >  __perf_event_task_sched_out+0x286/0x370 kernel/events/core.c:3846
> >  perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
> >  prepare_task_switch kernel/sched/core.c:5045 [inline]
> >  context_switch kernel/sched/core.c:5201 [inline]
> >  __schedule+0xbf0/0xcd0 kernel/sched/core.c:6863
> >  __schedule_loop kernel/sched/core.c:6945 [inline]
> >  schedule+0x5f/0xd0 kernel/sched/core.c:6960
> >  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:7017
> >  __mutex_lock_common kernel/locking/mutex.c:692 [inline]
> >  __mutex_lock+0x4ff/0xe20 kernel/locking/mutex.c:776
> >  __mutex_lock_slowpath+0xa/0x10 kernel/locking/mutex.c:1065
> >  mutex_lock+0x89/0x90 kernel/locking/mutex.c:290
> >  perf_poll+0x180/0x1f0 kernel/events/core.c:6150
> >  vfs_poll include/linux/poll.h:82 [inline]
> >  select_poll_one fs/select.c:480 [inline]
> >  do_select+0x8f1/0xf40 fs/select.c:536
> >  core_sys_select+0x3dc/0x6e0 fs/select.c:677
> >  do_pselect fs/select.c:759 [inline]
> >  __do_sys_pselect6 fs/select.c:798 [inline]
> >  __se_sys_pselect6+0x213/0x280 fs/select.c:789
> >  __x64_sys_pselect6+0x78/0x90 fs/select.c:789
> >  x64_sys_call+0x2e98/0x3000 arch/x86/include/generated/asm/syscalls_64.h:271
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x000000000038c145 -> 0x00000000003929d3
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 UID: 0 PID: 12005 Comm: syz.4.2772 Tainted: G        W           syzkaller #0 PREEMPT(voluntary)
> > Tainted: [W]=WARN
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > ==================================================================
> 
> 
> LLM concluded this is a harmful race:
> 
> ======
> 
> Because `perf_mmap_rb()` does not hold the `perf_event_context` lock
> (`ctx->lock`), which is the intended protection for these timing
> fields, it races with the `event_sched_out()` path (which does hold
> `ctx->lock`).
> 
> The race on `total_time_enabled` and `total_time_running` involves
> non-atomic read-modify-write operations. If both threads read the same
> old value of `total_time_enabled` before either writes back the
> updated value, one of the updates (representing a chunk of time the
> event was enabled) will be lost. Additionally, the race on
> `event->tstamp` can lead to inconsistent state where the timestamp and
> the total time counters are out of sync, causing further errors in
> subsequent time calculations.

Yeah, fair enough. Let me go stare at that.
