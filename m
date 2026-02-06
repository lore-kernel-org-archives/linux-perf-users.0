Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94533168E1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363450; cv=pass; b=ruQu1Fc77bbQF+R9jxQFFUfvAYdk7/vtsjTAjTUo41An7eMPUD0O7TaoGIRE4zLSSh3S0S+tJQaPYnPHSUAd9AVL6gxBjO0o6wl3HQImjUH+8fX3/llLwmr2X1S0/QAn8khnllm5CelSPuRiJx6aylHzkcs4L7ujWi2iIGFb7Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363450; c=relaxed/simple;
	bh=n2mCbtKCVO9PTP/jCP/z7AwOSR9QCQQX+/5YJ5ZXnRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKQsfY+lMABqXu7fOQzoVfUBl0nZoDvbfJ3wQ3gmvcjyWhQJwS70ECKEJ+QXAeltswDPhGpF77a9KWhPv6GZ+BWf/r9GS+tnUGE2guDp5bMiIZbbBr/JVXWZwEFwJgJCTdDS2Itd2YFg14dXdOvDNGZeGby9L55KnbfVKOOTV/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx9OKxny; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx9OKxny"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso3274864e87.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 23:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770363448; cv=none;
        d=google.com; s=arc-20240605;
        b=YDI3yUa9o3o/WMh3Fbh+IS5tZHusDg/mUIdj4zIhNyenwNMtykv9tBUejj12q+IH6t
         Yc7JPlYrje994I5MR5ESCKQK0rVvq70vBJawwbahTzdhPscRzXvbqdgGJDK/Ty3S+qOP
         Cewb990KfkkZXyVaYS+EgnHsjgu539jTCq4DhcZ0NsHAgZTvr95RX/BodUtSkTkDhu92
         TjI78Gqqf1QyjnD4hSG4u4bP0U+hpX4S+H54cv1+Qh49eG5jJXJlyj3QE25OAUz5Cz7e
         20sc60V1pDZP74sVGaK1eSBSB3us/KlaDNv0wzp56uERwEOPVtuOumiAyx0MMyOVgcdm
         B9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nTyF5rDQ69ax+lkC0M0G2iPghoopg157dIN7PG+yetM=;
        fh=MZSIrKQHPJA5MWpBvMVNqoYILwFDma9RwyKx+AlJ1Uk=;
        b=A0dF47KNTr6H3nvoQih68t5bJy6IjYz2xyeC6HM9Te7p7f7jTUUZqty92nFrXHpvZH
         E4ZJitRdOKZZ7w3PI4uDV+OR+V9AOUe3V4+wZnbaSALAxwPWhN6fC1OqkgeAD6pWXxQb
         i0KLvrqTDCPJ/qXij+VNXW7euIzLnymQDa9w/J/bV2lWfH0rTjCU0YWsccyNmG5jz+pQ
         7GXBS3dFN2ok1ZKzM/GPziMBVZSTPaCd3L+0GlmEahTIh58KxQmeb18YTGGhIVrcBweB
         bTcFlA0py83bqDjiEF4qQGDbS3dzK6QDvEgJpimwN2d8AHCNKD9h3XR5ppRMWUlWQg81
         Uc8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770363448; x=1770968248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nTyF5rDQ69ax+lkC0M0G2iPghoopg157dIN7PG+yetM=;
        b=Lx9OKxnyJTcemgsCr1OjDl58WrCWZBiNLpd/BLDueT5Cn7zODiHu0j+IWceZj8nlGg
         ERgctKZB66/pyQFvCOteXnnhkS7DRQ59p8k/BaxizNey2fNOViTx2jrDgpGv5BKCuqSj
         BHc87fQEdWBqUWvl4idagAkF4+munV06C/fsGv/PYSsN/hPp75DMkZ4/j/NDxgeFoUWM
         g5x//E00GmB6DqEdqqXsJaahu9yV5091lWtNZUJAJtu+K4h8ptE7W+Ydice6IqU3srfw
         B6vMKz+VVfTw+EiavBr0uvkJ7ro0kAo8O5z420fPAzEIDewczyhVP4kOqdoCZ5C6a49z
         7B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363448; x=1770968248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTyF5rDQ69ax+lkC0M0G2iPghoopg157dIN7PG+yetM=;
        b=ANwMmOiBlSofNFF0IULbDkh15NThPJMrJS4gvQnkravFCz8+M5reYBoaeQVYL+fZJa
         tQwSz3kZiJRGx9InEnvtsaAJmuu1peAfT98oowLsxZELmrZbV9wZ5fKlc3ZvnPc9G0AN
         JGL+O9Q+ozJ8ehmoPTltC57GPJIswK8DU7tczyv48Y1VuzoCtrgtVJodB2H5pguF4ZGf
         H0JRjRbp9wuLA1FM/l94lrqzO6Eipqvc7ELidHxB7AJMxoUMWVOZYjcN6eOFJV5yz/JW
         fxnXSyGKFI0727NoCkp84VFYDWJiWOPmsiqw7/7VFXLkSJ/eHt/iupqN17yBdVxehQs9
         F5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVZX/SAyCy+Q2I4mYGGeALu1ua+ez/LMLxT9Ll/Vs0kaEFXz35YFbLrjoKeFoJiWdlb0xeGO+dZR9r+Iz6WYAnt@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvHX+fPhIZ6CPDVbBZ7BQzEeBOkdJQNeo/Vs1Asia/3ayw7jC
	/aEIxc1u+PjH+KATWb/Wm2nUE1vrC21Ix3nO4ARXqve68DDcqAHHoWn/QiyD1V/r3RGcAjbnz/c
	O9TEhkZ4hNHTlNsSexfYc0ZbXRcVS8anzt/nRmXfp
X-Gm-Gg: AZuq6aIDAFouDm5Yx8nV1/iKkmi46oUu95NfGNvzZiZVTRond3Rv1tvXvxqY1YkoCXK
	0bc+GxbKsL7tNRZaBnMxRojmlk+2Q5qOLaSSdsFKc2idMpTt3kYkhPW/QZHLdEJakv0C6Tz9xNV
	QfSta1RQNZYKqTcZPG+Luh42ELaK9q4w/KR8OvKHI1FHjn87+Q5Lio9GApg+M+c4+Fl5+T6KWuU
	PBb6mZss48t9Uvyo/DyzM/RDqsRTk3nEFnUQ5Kj3hVDPkELGotckv7hfPX0epxqAhI7Y+CXvGvg
	n8ow2bZ5rSZtGQEVojWxlgOeS/yy
X-Received: by 2002:a05:6512:3d01:b0:59d:e304:e2b8 with SMTP id
 2adb3069b0e04-59e3c74102amr1957223e87.19.1770363447711; Thu, 05 Feb 2026
 23:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69859989.a00a0220.34fa92.0026.GAE@google.com>
In-Reply-To: <69859989.a00a0220.34fa92.0026.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 08:37:14 +0100
X-Gm-Features: AZwV_QjUlmz-h62nV1noScCu7rIue-hIG5x6f_HkFuDXlb2Ix9QQ75oIGhphfjk
Message-ID: <CACT4Y+a9+OhtX2NeH9ZOPi=5DH36mqFWqU2cTD7MoUXJEFZjzw@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in __perf_event_read_value /
 perf_event_set_state (6)
To: syzbot <syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 08:34, syzbot
<syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5dbeeb268b63 Merge tag 'driver-core-6.19-rc7' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169a105a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9e86480ac654d3
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d5529efa784dcc0b926
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8a4a5a3502b5/disk-5dbeeb26.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/65e86e2ad6af/vmlinux-5dbeeb26.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/050ae083081a/bzImage-5dbeeb26.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6d5529efa784dcc0b926@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in __perf_event_read_value / perf_event_set_state
>
> write to 0xffff8881311a8538 of 8 bytes by task 13031 on cpu 1:
>  __perf_update_times kernel/events/core.c:-1 [inline]
>  perf_event_update_time kernel/events/core.c:735 [inline]
>  perf_event_set_state+0x1c4/0x440 kernel/events/core.c:754
>  event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
>  group_sched_out kernel/events/core.c:2415 [inline]
>  __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
>  ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
>  task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
>  perf_event_context_sched_out kernel/events/core.c:3746 [inline]
>  __perf_event_task_sched_out+0x2df/0x3c0 kernel/events/core.c:3846
>  perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
>  prepare_task_switch kernel/sched/core.c:5049 [inline]
>  context_switch kernel/sched/core.c:5205 [inline]
>  __schedule+0xbaa/0xc90 kernel/sched/core.c:6867
>  __schedule_loop kernel/sched/core.c:6949 [inline]
>  schedule+0x5e/0xd0 kernel/sched/core.c:6964
>  futex_do_wait kernel/futex/waitwake.c:358 [inline]
>  __futex_wait+0x121/0x260 kernel/futex/waitwake.c:687
>  futex_wait+0x9c/0x1d0 kernel/futex/waitwake.c:715
>  do_futex+0x2bf/0x380 kernel/futex/syscalls.c:130
>  __do_sys_futex kernel/futex/syscalls.c:207 [inline]
>  __se_sys_futex+0x2f6/0x370 kernel/futex/syscalls.c:188
>  __x64_sys_futex+0x78/0x90 kernel/futex/syscalls.c:188
>  x64_sys_call+0x2bc2/0x3000 arch/x86/include/generated/asm/syscalls_64.h:203
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff8881311a8538 of 8 bytes by task 13182 on cpu 0:
>  __perf_event_read_value+0xb6/0x1d0 kernel/events/core.c:5894
>  perf_read_one kernel/events/core.c:6049 [inline]
>  __perf_read kernel/events/core.c:6102 [inline]
>  perf_read+0x171/0x4f0 kernel/events/core.c:6119
>  loop_rw_iter+0x2c6/0x3f0 include/linux/uio.h:-1
>  io_iter_do_read io_uring/rw.c:836 [inline]
>  __io_read+0xbf6/0xc50 io_uring/rw.c:950
>  io_read+0x4a/0x190 io_uring/rw.c:1030
>  __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
>  io_issue_sqe+0x56/0xa70 io_uring/io_uring.c:1816
>  io_wq_submit_work+0x3f7/0x5f0 io_uring/io_uring.c:1928
>  io_worker_handle_work+0x41e/0x950 io_uring/io-wq.c:650
>  io_wq_worker+0x22d/0x860 io_uring/io-wq.c:704
>  ret_from_fork+0x148/0x280 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> value changed: 0x000000004a891b66 -> 0x000000004a89847d
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 13182 Comm: iou-wrk-13031 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================

LLM was concerned about the atomicity of these u64 operations on
32-bit systems, and thus concluded the race is harmful.
