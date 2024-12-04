Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E093FC1D;
	Wed,  4 Dec 2024 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281390; cv=none; b=IOxHF6k7TohVcOSod4pgK2RIS/QxaSSs1kXtMF9TqE246XSLW73SKosooRrf+xLw0b2qc6F9116EThmDkPWcw07hjFl5u+D1mk3g5PzeV71s08bi0kCPGNxEZy9O9A4L48KTa23UVnUvjhHmINtbBdCzd6ISlWRsSnFejNyXNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281390; c=relaxed/simple;
	bh=wM3rnMtVYlDzgaChpi1A+d29F5+aqVNfsXHz1k3njhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVd5fj8bmJj9p7xwpHXc4NSM5l8zUpie4+/8u4zahaViihRKsBupkFJvOaGLnTyXVdZp7ef3pd3Mk2w5Cl6c8MIP6YUVnb2QLXuBdr/09iJQQyWUa5N3/SFgX71OHSNVN/X1nQT9xTc4V7pVzNzfJOUgMqNnvfOd1eIfiaadcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC7JBtun; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC7JBtun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281389; x=1764817389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wM3rnMtVYlDzgaChpi1A+d29F5+aqVNfsXHz1k3njhs=;
  b=gC7JBtun0Htq/1tQ7JcIn6wBUGoBRGs/dVMZKQIM/KBD4stCuK3qfySC
   gucjYcsAGvTxUcsb66VZEBxByGq7AZSUem2/7gd5luPUDniXGxTqpTrba
   +sWTppl/r990Dp6X6a79ZtigPUrq8noVASenaP1tuQGR02rR/t3P/cYvJ
   i8SeOuXVbpaBkQYsyE99IJPLCSIh4CsskR/zsB1J/6JWjd1cRwzTHDm8p
   duTwwZc+YxiigxLhnh7fCAxt3tmjSHwtiVueSsECteJIrS7bGRcM6FZBA
   W5yfgP+u+V2ZbrVCyKF4pBn7HutXIbWoFpjKWuAVY4vW+zhU+xS1EarKO
   g==;
X-CSE-ConnectionGUID: 4ETQAe1KQCmajPZkLe9Dbg==
X-CSE-MsgGUID: av4oM8ImTNOYwt3vcSBA/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32888717"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="32888717"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:03:07 -0800
X-CSE-ConnectionGUID: hrlQTglPSgCi4doORQoFeg==
X-CSE-MsgGUID: +lXEcFqVRY26Pe0YhoQDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="94459135"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:03:02 -0800
Date: Wed, 4 Dec 2024 11:02:28 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <Z0/GRGpARFh89rVh@ly-workstation>
References: <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111120857.5cWFpNkJ@linutronix.de>

On Mon, Nov 11, 2024 at 01:08:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-08 23:26:36 [+0100], Frederic Weisbecker wrote:
> > > Please see
> > > https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
> > > and the whole thread.
> 
> Thank you for this Oleg.
> 
> > > I don't think raw_spin_lock_irq + cmpxchg for each work is a good
> > > idea, but quite possibly I misunderstood this change.
> > 
> > I did not realize there could be gazillion files released in a row. So there
> > could be noticeable performance issues I guess...
> 
> I made a testcase to open 2M (2 *10^6) files and then exit. This led
> task_work_run() run 2M + 3 callbacks (+ stdin/out/err) for the task.
> 
> Running 70 samples on the "orig" kernel:
> - avg callback time 1.156.470,3 us
> - 63 samples are starting with 11 (1,1 sec) avg: 1.128.046,7 us
> - 6 samples are starting with 14 (1,4 sec) avg: 1.435.294,8us
> 
> Running 70 samples on the "patched" kernel:
> - avg callback time 1.278.938,8 us
> - 59 samples are starting with 12 (1,2 sec) avg: 1.230.189,1 us
> - 10 samples are starting with 15 (1,5sec) avg: 1.555.934,5 us
> 
> With the extra lock the task_work_run() runtime extends by approximately
> ~122ms for the 2M invoked callbacks. 
> The spike 1,1sec -> 1,4sec or 1,2sec -> 1,5 sec is due to context
> switching (there are few cond_resched()/ might_sleep()).
> 
> It is not that bad, is it?
>

Hi,

Do we reach consensus about the fix? The issue can still be reproduced
using v6.13-rc1 kernel. Call trace:

[  300.429498]  ? lock_acquire+0x80/0xb0
[  300.429695]  ? schedule+0x216/0x3f0
[  300.429888]  schedule+0xf6/0x3f0
[  300.430068]  _free_event+0x531/0x14c0
[  300.430277]  perf_event_release_kernel+0x648/0x870
[  300.430680]  ? __pfx_perf_event_release_kernel+0x10/0x10
[  300.430969]  ? __this_cpu_preempt_check+0x21/0x30
[  300.431228]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[  300.431519]  ? __pfx_perf_release+0x10/0x10
[  300.431746]  perf_release+0x3a/0x50
[  300.431940]  __fput+0x414/0xb60
[  300.432127]  ____fput+0x22/0x30
[  300.432303]  task_work_run+0x19c/0x2b0
[  300.432518]  ? __pfx_task_work_run+0x10/0x10
[  300.432752]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  300.433038]  ? switch_task_namespaces+0xc6/0x110
[  300.433295]  do_exit+0xb19/0x2a30
[  300.433484]  ? lockdep_hardirqs_on+0x89/0x110
[  300.433728]  ? __pfx_do_exit+0x10/0x10
[  300.433942]  do_group_exit+0xe4/0x2c0
[  300.434147]  get_signal+0x2279/0x24c0
[  300.434360]  ? __pfx_get_signal+0x10/0x10
[  300.434601]  ? __might_fault+0xf1/0x1b0
[  300.434824]  arch_do_signal_or_restart+0x8e/0x7d0
[  300.435083]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[  300.435375]  ? __this_cpu_preempt_check+0x21/0x30
[  300.435629]  ? syscall_exit_to_user_mode+0x10f/0x200
[  300.435901]  syscall_exit_to_user_mode+0x144/0x200
[  300.436161]  do_syscall_64+0x79/0x140
[  300.436366]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  300.436643] RIP: 0033:0x7f5add83ee5d
[  300.436843] RSP: 002b:00007fff21a70e68 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
[  300.437240] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f5add83ee5d
[  300.437610] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
[  300.437969] RBP: 00007fff21a70e70 R08: 000000000000000b R09: 00007fff21a70ea0
[  300.438329] R10: 00000000ffffffff R11: 0000000000000206 R12: 00007fff21a70fc8
[  300.438703] R13: 0000000000401b4f R14: 0000000000403e08 R15: 00007f5addc0e000
[  300.439075]  </TASK>
[  300.439197]
[  300.439197] Showing all locks held in the system:
[  300.439513] 1 lock held by khungtaskd/33:
[  300.439723]  #0: ffffffff8705ca40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x73/0x3c0
[  300.440199]
[  300.440288] =============================================
[  300.440288]

Regards,
Yi Lai

> > Thanks.
> > > 
> > > Oleg.
> 
> Sebastian
