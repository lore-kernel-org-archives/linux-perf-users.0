Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE790322A2E;
	Mon,  5 Jan 2026 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602882; cv=none; b=MIY89AHU9nXN+HvtnQYefkHE0DkYgmqxRsyDke/7bcuV0/ENxbKD75q+o6IQSNIm9NhvQA5DjaeCcavtpQqqfqF+Le02FRC69WF99yJv/vzcrlBgO9WSxpNEkPvGVhD3z/ayCHTGu7Fqmo+7luH0zzZrJB86XP2QW3xNzlyTDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602882; c=relaxed/simple;
	bh=eeRgo1eimy5JEpRhN4x62p8ln3Ey9DMyPaMrDQermUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FimyNlsDpxGtekd7f7dyqbX1RXJICyA1QUfFcL0H7frI+zsYS6P9UYuvit63uZJz0d45ieAromMgNhZpGBgm8ZPemAo++WqsLdmekpdCda9g4GhQ7yS6uTyE8cNN4qC7NefZVER/g8gjRrjWhv+8/TnZKlEfZIFZNUYwQK5elLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYt0dm4g; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYt0dm4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767602878; x=1799138878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eeRgo1eimy5JEpRhN4x62p8ln3Ey9DMyPaMrDQermUM=;
  b=BYt0dm4giS4FNCjKVlHX3IyyfNJfmouLNKSPVXWwgC7ECtE0s6WTPmn0
   FCEdD6air4oIHHWgoviw+TQ8jwl3cl2PTicOi+2yO4L0uwsDK65zXLedW
   YLE7KbSZrtIBjt2mvy77icChtBpw67aojotyL8azT/ottoNKeKXBb+4cj
   uc3nHjo2z/jUoUUSQWZIPfN6hxtu2noWy9lN9OhKnqikd9YuAjjHvESZz
   QUgza0URyNa/f94/tNU1EURUctfBccAWzDM/efZQDrhkBilMxLjVvg91v
   hM6AqzAiT6UFFwpLzO44lOtXgBvpAAPQYtKjczFI4O2lIvI/Dlfc2heYW
   A==;
X-CSE-ConnectionGUID: RHORX7rURKauTG3OqKTGJg==
X-CSE-MsgGUID: ehfBYQ8vRtOkCchIKwKbew==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="68707340"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="68707340"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 00:47:56 -0800
X-CSE-ConnectionGUID: L7Kd/KXlQPGHu0BF6dfdfw==
X-CSE-MsgGUID: c++DDhIRTPuzpZ3GV/mGiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="206826471"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 00:47:53 -0800
Date: Mon, 5 Jan 2026 16:47:50 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	yi1.lai@intel.com
Subject: Re: [PATCH] perf: Fix refcount warning on event->mmap_count increment
Message-ID: <aVt6tqOp+fGnFuBb@ly-workstation>
References: <20251229210355.65732-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229210355.65732-1-whrosenb@asu.edu>

On Mon, Dec 29, 2025 at 02:03:55PM -0700, Will Rosenberg wrote:
> When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
> following warning is triggered:
> 
> 	refcount_t: addition on 0; use-after-free.
> 	WARNING: lib/refcount.c:25
> 
> PoC:
> 
>     struct perf_event_attr attr = {0};
>     int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
>     mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>     int victim = syscall(__NR_perf_event_open, &attr, 0, -1, fd,
>                          PERF_FLAG_FD_OUTPUT);
>     mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);
> 
> This occurs when creating a group member event with the flag
> PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
> the event triggers the warning.
> 
> Since the event has copied the output_event in perf_event_set_output(),
> event->rb is set. As a result, perf_mmap_rb() calls
> refcount_inc(&event->mmap_count) when event->mmap_count = 0.
> 
> Account for the case when event->mmap_count = 0. This patch goes against
> the design philosophy of the refcount library by re-enabling an empty
> refcount, but the patch remains inline with the current treatment of
> mmap_count.
> 
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
> 
> Notes:
>     I also have a related concern about code that handles the mmap_count.
>     In perf_mmap_close(), if refcount_dec_and_mutex_lock() decrements
>     event->mmap_count to zero, then event->rb is set to NULL. This
>     effectively undos our output_event copy. However, is this desired
>     behavior? Should event->rb remain unchanged since it may still be
>     mmap-ed by other events and can still be used?
> 
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

I also hit the refcount bug in perf_mmap using v6.19-rc4 kernel. Here is
the call trace:

[   17.446965] ------------[ cut here ]------------
[   17.447357] refcount_t: addition on 0; use-after-free.
[   17.447732] WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc5/0x150, CPU#1: repro/713
[   17.448358] Modules linked in:
[   17.448613] CPU: 1 UID: 0 PID: 713 Comm: repro Not tainted 6.19.0-rc1-v6.19-rc1 #1 PREEMPT(voluntary)
[   17.449277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebu4
[   17.450209] RIP: 0010:refcount_warn_saturate+0xc5/0x150
[   17.450589] Code: 31 fa 61 fe 48 8d 3d fa 66 0e 05 67 48 0f b9 3a e8 20 fa 61 fe 5b 41 5c 5d c3 cc cc cc9
[   17.451950] RSP: 0018:ff11000014ddf5d0 EFLAGS: 00010293
[   17.452333] RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff8327b5d2
[   17.452827] RDX: ff1100001a1d8000 RSI: ffffffff8327b62e RDI: ffffffff88361d20
[   17.453322] RBP: ff11000014ddf5e0 R08: 0000000000000001 R09: ffe21c00028c3a78
[   17.453813] R10: 0000000000000002 R11: ff1100001a1d8e98 R12: ff1100001461d3c0
[   17.454401] R13: ff1100001461d3c0 R14: 0000000000000000 R15: ff11000010325dc0
[   17.454908] FS:  00007f16e9af0740(0000) GS:ff110000e35b9000(0000) knlGS:0000000000000000
[   17.455475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.455881] CR2: 0000200000000080 CR3: 000000000ee14003 CR4: 0000000000771ef0
[   17.456383] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   17.456877] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000602
[   17.457376] PKRU: 55555554
[   17.457576] Call Trace:
[   17.457757]  <TASK>
[   17.457918]  perf_mmap+0x1a35/0x2390
[   17.458250]  ? mas_preallocate+0x2cb/0xe70
[   17.458554]  ? __pfx_perf_mmap+0x10/0x10
[   17.458849]  ? lockdep_init_map_type+0x50/0x260
[   17.459187]  __mmap_region+0x11a7/0x2970
[   17.459482]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   17.459834]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   17.460227]  ? __pfx___mmap_region+0x10/0x10
[   17.460552]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   17.460941]  ? perf_ctx_unlock+0xfa/0x180
[   17.461252]  ? perf_ctx_unlock+0xfa/0x180
[   17.461580]  ? __this_cpu_preempt_check+0x21/0x30
[   17.461990]  ? lock_is_held_type+0xef/0x150
[   17.462308]  mmap_region+0x307/0x3e0
[   17.462577]  do_mmap+0xa5d/0x12e0
[   17.462835]  ? lock_acquire+0x180/0x2f0
[   17.463130]  ? __pfx_do_mmap+0x10/0x10
[   17.463408]  ? down_write_killable+0x163/0x250
[   17.463729]  ? __pfx_down_write_killable+0x10/0x10
[   17.464076]  vm_mmap_pgoff+0x2b8/0x4a0
[   17.464376]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   17.464692]  ? __fget_files+0x204/0x3b0
[   17.464982]  ksys_mmap_pgoff+0x3dc/0x520
[   17.465277]  __x64_sys_mmap+0x139/0x1d0
[   17.465561]  x64_sys_call+0x19a4/0x21b0
[   17.465842]  do_syscall_64+0x6d/0x1180
[   17.466180]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.466544] RIP: 0033:0x7f16e983ee5d
[   17.466811] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca8
[   17.468073] RSP: 002b:00007ffefb1af538 EFLAGS: 00000216 ORIG_RAX: 0000000000000009
[   17.468607] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f16e983ee5d
[   17.469103] RDX: 0000000000000000 RSI: 0000000000002000 RDI: 0000200000ab9000
[   17.469595] RBP: 00007ffefb1af560 R08: 0000000000000004 R09: 0000000000000000
[   17.470145] R10: 0000000004002013 R11: 0000000000000216 R12: 00007ffefb1af678
[   17.470652] R13: 0000000000401136 R14: 0000000000404e08 R15: 00007f16e9b3d000
[   17.471172]  </TASK>
[   17.471338] irq event stamp: 2257
[   17.471579] hardirqs last  enabled at (2265): [<ffffffff816661b5>] __up_console_sem+0x95/0xb0
[   17.472185] hardirqs last disabled at (2272): [<ffffffff8166619a>] __up_console_sem+0x7a/0xb0
[   17.472773] softirqs last  enabled at (2230): [<ffffffff81489a9e>] __irq_exit_rcu+0x10e/0x170
[   17.473368] softirqs last disabled at (2185): [<ffffffff81489a9e>] __irq_exit_rcu+0x10e/0x170
[   17.474011] ---[ end trace 0000000000000000 ]---

After applying the fix patch, the issue cannot be reproduced.

Tested-by: Yi Lai <yi1.lai@intel.com>

Regards,
Yi Lai
 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 376fb07d869b..49709b627b1f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7279,7 +7279,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
>  			 * multiple times.
>  			 */
>  			perf_mmap_account(vma, user_extra, extra);
> -			refcount_inc(&event->mmap_count);
> +			if (!refcount_inc_not_zero(&event->mmap_count))
> +				refcount_set(&event->mmap_count, 1);
>  			return 0;
>  		}
>  
> 
> base-commit: 538254cd98afb31b09c4cc58219217d8127c79be
> -- 
> 2.34.1
> 
