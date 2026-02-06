Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BC35B65E;
	Fri,  6 Feb 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369394; cv=none; b=G0nSednyBnXZsvIN8kYDu3SW+xim9PmPVWNjYFMRSlQnZXvyLZSfmr7lPD8PfqxEZOPCSzYjgJNFQCOWqlFCEFT0vyVDODLh3o6RiPVi2uCXJWt6RYHiVnWX+s11uKbuXxyQy3p03Jnt0EKTeAAXlzgLgAxFRDedPIFdYQjcH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369394; c=relaxed/simple;
	bh=HMUfP0kdiac9IvfKwv7iPFX8cSxDTu3B5VXA+3T45bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWaISQKnWV9gB71e1xwLMBW5Elz05k9UNSSL2vrAPFrTsEGiktDiN0fGwQBqIGu0/7U+75VGpfOQiUnqYVJ9E4GAuMybNvmrsWtvBXaPtKZi60dip1dF7l540If2fpeErjCH4nX5qCPhUzYCLZuctZ8zGE5aCrXAUhCNV4n5iaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cvLwKu73; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvLwKu73"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TXK5KGMRGuWHce3AJrzzqe3ZlTeqHV3VIZ8VHYvAwdI=; b=cvLwKu73VC5HPQVu1+fFZBBY3n
	ePZRtzpalVwOX76urqdmo+hVemk/WcoZdQ6JsWnUKsoiPC4TIB+xUJoIbsdzloj4b4OXJzrQcgYmC
	3aRKrS33ghn3roc+w7pqyzKStXByJHCa8E9oSLa2DzNibcLQPcfuCZuUhQFvFwLXY8HZ5VlszggrA
	C5i5AXsQ5F8sJTfIRyCepraHTJOK90X0gZVIkoTVK/Klia+Py3OIryCDbSxloyU0RMKg3Nn+Bljzg
	1otv9dCQrsprEApOZ5ui71Tk+htZjxfJMMpMJLSdNsvA9RQYsqkgnp5T3KjXtX9FgUU42+zAP5xXB
	WwNDAWHg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voHws-00000003WoY-2Iad;
	Fri, 06 Feb 2026 09:16:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 205B2302DA9; Fri, 06 Feb 2026 10:16:21 +0100 (CET)
Date: Fri, 6 Feb 2026 10:16:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com>,
	acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KCSAN: data-race in __perf_event_read_value /
 perf_event_set_state (6)
Message-ID: <20260206091621.GO1395266@noisy.programming.kicks-ass.net>
References: <69859989.a00a0220.34fa92.0026.GAE@google.com>
 <CACT4Y+a9+OhtX2NeH9ZOPi=5DH36mqFWqU2cTD7MoUXJEFZjzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a9+OhtX2NeH9ZOPi=5DH36mqFWqU2cTD7MoUXJEFZjzw@mail.gmail.com>

On Fri, Feb 06, 2026 at 08:37:14AM +0100, Dmitry Vyukov wrote:
> On Fri, 6 Feb 2026 at 08:34, syzbot
> <syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5dbeeb268b63 Merge tag 'driver-core-6.19-rc7' of git://git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=169a105a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9e86480ac654d3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6d5529efa784dcc0b926
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/8a4a5a3502b5/disk-5dbeeb26.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/65e86e2ad6af/vmlinux-5dbeeb26.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/050ae083081a/bzImage-5dbeeb26.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in __perf_event_read_value / perf_event_set_state
> >
> > write to 0xffff8881311a8538 of 8 bytes by task 13031 on cpu 1:
> >  __perf_update_times kernel/events/core.c:-1 [inline]
> >  perf_event_update_time kernel/events/core.c:735 [inline]
> >  perf_event_set_state+0x1c4/0x440 kernel/events/core.c:754
> >  event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
> >  group_sched_out kernel/events/core.c:2415 [inline]
> >  __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
> >  ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
> >  task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
> >  perf_event_context_sched_out kernel/events/core.c:3746 [inline]
> >  __perf_event_task_sched_out+0x2df/0x3c0 kernel/events/core.c:3846

  acquires ctx->lock

> >  perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
> >  prepare_task_switch kernel/sched/core.c:5049 [inline]
> >  context_switch kernel/sched/core.c:5205 [inline]
> >  __schedule+0xbaa/0xc90 kernel/sched/core.c:6867
> >  __schedule_loop kernel/sched/core.c:6949 [inline]
> >  schedule+0x5e/0xd0 kernel/sched/core.c:6964
> >  futex_do_wait kernel/futex/waitwake.c:358 [inline]
> >  __futex_wait+0x121/0x260 kernel/futex/waitwake.c:687
> >  futex_wait+0x9c/0x1d0 kernel/futex/waitwake.c:715
> >  do_futex+0x2bf/0x380 kernel/futex/syscalls.c:130
> >  __do_sys_futex kernel/futex/syscalls.c:207 [inline]
> >  __se_sys_futex+0x2f6/0x370 kernel/futex/syscalls.c:188
> >  __x64_sys_futex+0x78/0x90 kernel/futex/syscalls.c:188
> >  x64_sys_call+0x2bc2/0x3000 arch/x86/include/generated/asm/syscalls_64.h:203
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff8881311a8538 of 8 bytes by task 13182 on cpu 0:
> >  __perf_event_read_value+0xb6/0x1d0 kernel/events/core.c:5894
> >  perf_read_one kernel/events/core.c:6049 [inline]
> >  __perf_read kernel/events/core.c:6102 [inline]

  acquires ctx->lock

> >  perf_read+0x171/0x4f0 kernel/events/core.c:6119
> >  loop_rw_iter+0x2c6/0x3f0 include/linux/uio.h:-1
> >  io_iter_do_read io_uring/rw.c:836 [inline]
> >  __io_read+0xbf6/0xc50 io_uring/rw.c:950
> >  io_read+0x4a/0x190 io_uring/rw.c:1030
> >  __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
> >  io_issue_sqe+0x56/0xa70 io_uring/io_uring.c:1816
> >  io_wq_submit_work+0x3f7/0x5f0 io_uring/io_uring.c:1928
> >  io_worker_handle_work+0x41e/0x950 io_uring/io-wq.c:650
> >  io_wq_worker+0x22d/0x860 io_uring/io-wq.c:704
> >  ret_from_fork+0x148/0x280 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >
> > value changed: 0x000000004a891b66 -> 0x000000004a89847d
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 UID: 0 PID: 13182 Comm: iou-wrk-13031 Not tainted syzkaller #0 PREEMPT(voluntary)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > ==================================================================
> 
> LLM was concerned about the atomicity of these u64 operations on
> 32-bit systems, and thus concluded the race is harmful.

I'm not exactly sure I understand how there is a race, things should be
serialized on ctx->lock.
