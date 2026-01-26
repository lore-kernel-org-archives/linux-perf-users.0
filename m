Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB062EA156;
	Mon, 26 Jan 2026 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447160; cv=none; b=O5uwYQKhnSZhWH3iacwcvbZtRVU/kKUCUHIs/IFFvW8hlMfU/gB4sGSYEJjeBCKyDCPLKLKIPSNi4j6G0uNmQcq1wJac/O4JRWtS/3hNNyrbq8Zt84GU0CUasvEK9qgyLHw/LNHc1zCqgTiTSK2P0n/t/bBg3PUM2/tkv2qKFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447160; c=relaxed/simple;
	bh=Jr3JpXfvPESmmq6HTTCKanzCKC9BSKYku2/D5i+UlLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwn2gDfrdaLqMa0SABH1YgxdzOVv6LEu4RyrjsyqmVIfM5NN7vY5Wm4ovGLkHQ5QnTjgXyqDbvDyHsek0yCf/fa4Z3w+LAYeZdmEpLuY1jaUfAMRlfEDWz58iKAHPuUz9H94Oyghc2ZXF0mpK5vBY60W+EhqMN3Nr9Lggo/Dj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfXumpwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfXumpwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D7EC116C6;
	Mon, 26 Jan 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447160;
	bh=Jr3JpXfvPESmmq6HTTCKanzCKC9BSKYku2/D5i+UlLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gfXumpwLe9HEm0/Rn0J6FSijJ2fTrlwmpGNJeOJXilQgjkFYrJsBa4EZU7jZUjYN6
	 adBRs5+Qb8puRwbcdazwoABxWtCDYEDa+jC/opdscvsngI8evjTyh3fxBFrfABUdWn
	 24qmQYtvHYdkWBEjoY2ezgMjX+fjhidaWYPvwNF4bUHYeqOKGtkQSHOGPOktxafjs3
	 zG5CXedsW/4mc6i/QGriR5iIalL/N8atDCEd1UKngE7lQUTkloL1cRzM7XJhi/owTc
	 CRZJwdvxuE4/wuA7KmD8rTNZ/3uwrCr3/FO/mn2ghZ8kNKWhA6Hd7z869SJsDImt6O
	 7acW0R2MyWfeQ==
Date: Mon, 26 Jan 2026 12:05:53 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
Message-ID: <20260126120553.2fa79048@gandalf.local.home>
In-Reply-To: <0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
References: <20250820180338.701352023@kernel.org>
	<20250820180428.592367294@kernel.org>
	<0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 19:11:15 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> [  120.334908] BUG: kernel NULL pointer dereference, address: 0000000000000078
> [  120.341901] #PF: supervisor read access in kernel mode
> [  120.347055] #PF: error_code(0x0000) - not-present page
> [  120.352208] PGD 0 P4D 0
> [  120.354750] Oops: Oops: 0000 [#1] SMP NOPTI
> [  120.358946] CPU: 36 UID: 0 PID: 14127 Comm: page_table_stre Tainted: G S         O        6.18.0-smp-DEV #2 NONE
> [  120.369242] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> [  120.374568] Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.116.4 08/29/2025
> [  120.382075] RIP: 0010:gup_fast_fallback+0x150/0xb60
> [  120.386977] Code: d0 c9 8b 48 89 84 24 a0 00 00 00 48 8b 80 30 05 00 00 0f b6 0d 0d 6b 1a 01 49 89 f8 49 d3 e8 41 81 e0 ff 01 00 00 41 c1 e0
>  03 <4c> 03 40 78 4c 8d 5b ff 44 89 c8 83 e0 01 48 8d 04 45 05 00 00 00
> [  120.405809] RSP: 0018:ffffa32be5f9b7a0 EFLAGS: 00010006
> [  120.411051] RAX: 0000000000000000 RBX: 00007f0f57dfd000 RCX: 0000000000000027
> [  120.418210] RDX: 0000000000000046 RSI: 0000000000000001 RDI: 00007f0f57dfc000
> [  120.425368] RBP: 0000000000000000 R08: 00000000000007f0 R09: 0000000000100002
> [  120.432526] R10: ffffa32be5f9b8c8 R11: 0000000000000000 R12: 00007f0f57dfc6c0
> [  120.439683] R13: ffff99b44dd7c800 R14: 00000000fffffff2 R15: 00000000000800c3
> [  120.446842] FS:  0000000000000000(0000) GS:ffff9a127357b000(0000) knlGS:0000000000000000
> [  120.454956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  120.460721] CR2: 0000000000000078 CR3: 000000512d03e006 CR4: 00000000007706f0
> [  120.467879] PKRU: 55555554
> [  120.470592] Call Trace:
> [  120.473045]  <TASK>
> [  120.475152]  perf_prepare_sample+0x77b/0x910
> [  120.479445]  perf_event_output+0x35/0x100
> [  120.483467]  intel_pmu_drain_pebs_nhm+0x570/0x750
> [  120.488198]  intel_pmu_pebs_sched_task+0x74/0x80
> [  120.492839]  ? __put_partials+0xd6/0x130
> [  120.496775]  ? __mt_destroy+0x3f/0x80
> [  120.500451]  ? put_cpu_partial+0x9b/0xc0
> [  120.504384]  ? __slab_free+0x249/0x320
> [  120.508144]  ? refill_obj_stock+0x120/0x1a0
> [  120.512341]  ? __mt_destroy+0x3f/0x80
> [  120.516013]  ? kfree+0x2ca/0x390
> [  120.519254]  ? update_load_avg+0x1c8/0x7d0
> [  120.523364]  ? update_entity_lag+0xf6/0x110
> [  120.527560]  intel_pmu_sched_task+0x1d/0x30
> [  120.531755]  perf_pmu_sched_task+0xf2/0x1a0
> [  120.535952]  __perf_event_task_sched_out+0x3f/0x1f0
> [  120.540844]  ? pick_next_task_fair+0x3e/0x2a0
> [  120.545214]  __schedule+0xad0/0xb40
> [  120.548715]  do_task_dead+0x48/0xa0

Ah, this is called at do_task_dead()

I guess we need to also test for !current->mm because the flags set for an
exiting task is done when we can still do callchains. Thus, the only way to
know if it is safe to do a callchain when a task is exiting is via task->mm
and not task->flags :-/

-- Steve



> [  120.552215]  do_exit+0x734/0x920
> [  120.555463]  ? do_exit+0x9/0x920
> [  120.558699]  do_group_exit+0x85/0x90
> [  120.562284]  __x64_sys_exit_group+0x17/0x20
> [  120.566478]  x64_sys_call+0x21f7/0x2200
> [  120.570327]  do_syscall_64+0x6f/0x940
> [  120.574001]  ? clear_bhb_loop+0x50/0xa0
> [  120.577849]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  120.582915] RIP: 0033:0x7f0f5a0d2c48
> [  120.586501] Code: Unable to access opcode bytes at 0x7f0f5a0d2c1e.
> [  120.592700] RSP: 002b:00007f0f57dfcec8 EFLAGS: 00000207 ORIG_RAX: 00000000000000e7
> [  120.600294] RAX: ffffffffffffffda RBX: 00007f0f57dfd700 RCX: 00007f0f5a0d2c48
> [  120.607452] RDX: 00007f0f57dfd660 RSI: 0000000000000000 RDI: 0000000000000000
> [  120.614607] RBP: 00007f0f57dfcef0 R08: 00007f0f57dfd700 R09: 00007f0f57dfd700
> [  120.621765] R10: 00007f0f5a17a6c0 R11: 0000000000000207 R12: 00007f0f57dfd9d0
> [  120.628923] R13: 00007ffc64840aa6 R14: 00007f0f57dfdd1c R15: 00007f0f57dfcfc0
> [  120.636081]  </TASK>
> [  120.638272] Modules linked in: vfat fat i2c_mux_pca954x i2c_mux spidev cdc_acm xhci_pci xhci_hcd gq(O) sha3_generic
> [  120.649976] gsmi: Log Shutdown Reason 0x03
> [  120.654086] CR2: 0000000000000078
> [  120.657409] ---[ end trace 0000000000000000 ]---
