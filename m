Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075D34CDD;
	Thu,  5 Feb 2026 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256229; cv=none; b=Mh1ogF6W7TNX5CTPXQXsbPz4m4pmdX1kPhZcpVuzQGjWHj7EQJQWgepzBFpN8k0lt3S578O7+ifBZKRgMCaMepeDLYzYwjMueCu1km8kLLyfTItCE4BIxd+8hT9q7B10BKN088mCB02kP4XQPAgKI/Z9FS20WznGi90Rlhb3fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256229; c=relaxed/simple;
	bh=nPRY4vVJAIFccVMk8CH+5lvP9L8860L47h2sDG4AXlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jr7oJU7yFoEQdzAUyD0Qf3GCMlmFKFXdUI8QaXRWmsDtfT+UemDL/rCNEUtRMAkzklNIx8KQN1k2xLiHFHjdLScl+z0EDMqmsQzqUm1/+bOVzv778Q1zAgi/LrcnTWVwN6v83GMgkqNse6QT+Y4UEiVuF7mf6PGtKK/Ag1c2YLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCV+BkvT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCV+BkvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770256229; x=1801792229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPRY4vVJAIFccVMk8CH+5lvP9L8860L47h2sDG4AXlU=;
  b=BCV+BkvT4+zh8KdA3jRaKRPp1F9W22R/0nq2T3ZbqCmXA1EAY8+jiE4A
   FyVI3QaN9/iFqLE1UJn6EXtzF0XPKqV/rGPbktb1Qe/8NihQzBeHA1540
   Plh5vqgzTy/jxuIWSL5hnHgtXIV4VfT7CUorxVfIg1EEWlalN9nmw8K5p
   A3HpxeYAGwuXaUxIymmAUrjxxXw4sqctGzqhKXb7v+3/NVQJ07x3+IcwW
   7PMrL8vTQpHgofwlmQktTXdwNya0CA0rTmnIWQp369hXLltxrHKpsKWhy
   Qevrd21s6Bw/pmI3xF1s++y3IJie9GVp7YFktg8kFT9VN92WIxg95/tvk
   g==;
X-CSE-ConnectionGUID: JTiPRyX3TkWUZ7H7H7a++Q==
X-CSE-MsgGUID: V74WsJkjTyKP7ASKH+rudQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82190174"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="82190174"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 17:50:28 -0800
X-CSE-ConnectionGUID: bzN0Ael8TmOEOtG8q/o2qg==
X-CSE-MsgGUID: FxNw+gg/T9CLnkOK61wowA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="209634401"
Received: from unknown (HELO [10.238.0.190]) ([10.238.0.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 17:50:25 -0800
Message-ID: <5a8b9593-d458-474d-b084-3c2374b1c039@linux.intel.com>
Date: Thu, 5 Feb 2026 09:50:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WARNING] WARNING in x86_pmu_stop() (arch/x86/events/core.c:1624)
 triggered by syzkaller repro
To: =?UTF-8?B?5piv5Y+C5beu?= <shicenci@gmail.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>
References: <PS1PPF7E1D7501F6302C4D63E37AB0D5FC5AB98A@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <PS1PPF7E1D7501F6302C4D63E37AB0D5FC5AB98A@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for reporting this issue. I would look at it later.

On 2/4/2026 9:11 PM, 是参差 wrote:
> Hi,
> I’m reporting a reproducible WARNING observed in the x86 perf PMU stop path.
> The WARNING is triggered by a syzkaller C reproducer that performs multiple perf_event_open() calls with high-frequency sampling settings and then exercises a workload that heavily hits perf/tracepoint paths (e.g., sched tracepoints). The kernel hits a WARN in x86_pmu_stop() while handling perf event throttling/overflow.
> The WARNING report points to:
> WARNING: arch/x86/events/core.c:1624 at x86_pmu_stop+0x247/0x260, CPU#0: syz.2.7419/25339
> Call trace (trimmed to the perf-relevant part):
> perf_event_throttle.part.0
> __perf_event_account_interrupt
> __perf_event_overflow
> perf_swevent_overflow
> perf_swevent_event
> perf_tp_event
> perf_trace_run_bpf_submit
> perf_trace_sched_stat_runtime
> ...
> This suggests a possible state-machine inconsistency or corner-case interaction between the perf throttling/overflow handling and the x86 PMU stop path (x86_pmu_stop()), potentially triggered by an unusual perf_event_attr combination and high event rate.
> Reproducer:
> C reproducer: https://pastebin.com/raw/t9u91hQf
> console output: https://pastebin.com/raw/XUw5zuQg
> kernel config: https://pastebin.com/raw/dP93yBLn
> Kernel:
> git tree: torvalds/linux
> kernel version: 6.19.0-rc7 #1 VOLUNTARY (QEMU Ubuntu 24.10)
> HEAD commit:63804fed149a6750ffd28610c5c1c98cce6bd377
>
>
>
> EXT4-fs (loop2): mounting ext3 file system using the ext4 subsystem
> EXT4-fs (loop2): 1 truncate cleaned up
> EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
> ------------[ cut here ]------------
> WARNING: arch/x86/events/core.c:1624 at x86_pmu_stop+0x247/0x260 arch/x86/events/core.c:1624, CPU#0: syz.2.7419/25339
> CPU: 0 UID: 0 PID: 25339 Comm: syz.2.7419 Not tainted 6.19.0-rc7 #1 VOLUNTARY 
> Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:x86_pmu_stop+0x247/0x260 arch/x86/events/core.c:1624
> Code: 4c 89 ef e8 9b 59 6e 00 e9 48 ff ff ff 4c 89 ef e8 2e 5a 6e 00 eb 85 4c 89 e7 e8 84 59 6e 00 e9 83 fe ff ff e8 6a 99 3e 00 90 <0f> 0b 90 e9 44 ff ff ff 4c 89 e7 e8 69 59 6e 00 eb 96 0f 1f 80 00
> RSP: 0018:ffff88800bebe868 EFLAGS: 00010012
> RAX: 000000000000797b RBX: ffff888010488000 RCX: ffffc90000390000
> RDX: 0000000000080000 RSI: ffff88802e495640 RDI: 0000000000000002
> RBP: 0000000000000000 R08: ffffffff87073701 R09: ffffffff8120c1a6
> R10: 0000000000000001 R11: ffffffff86e3a6c7 R12: 0000000000000001
> R13: ffff8880104881f8 R14: 0000000000000001 R15: 0000000000000000
> FS:  00007f99e6c976c0(0000) GS:0000000000000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000002000 CR3: 000000005f659000 CR4: 0000000000350ef0
> DR0: 0000200000000080 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>  <TASK>
>  perf_event_throttle.part.0+0x89/0xf0 kernel/events/core.c:2682
>  perf_event_throttle kernel/events/core.c:2678 [inline]
>  perf_event_throttle_group kernel/events/core.c:2700 [inline]
>  __perf_event_account_interrupt+0x2a6/0x430 kernel/events/core.c:10258
>  __perf_event_overflow+0xb6/0xa00 kernel/events/core.c:10405
>  perf_swevent_overflow+0xac/0x150 kernel/events/core.c:10545
>  perf_swevent_event+0x14d/0x2e0 kernel/events/core.c:10583
>  perf_tp_event+0x3b7/0x810 kernel/events/core.c:11090
>  perf_trace_run_bpf_submit+0xef/0x180 kernel/events/core.c:11014
>  do_perf_trace_sched_stat_runtime include/trace/events/sched.h:553 [inline]
>  perf_trace_sched_stat_runtime+0x360/0x680 include/trace/events/sched.h:553
>  __do_trace_sched_stat_runtime include/trace/events/sched.h:576 [inline]
>  trace_sched_stat_runtime include/trace/events/sched.h:576 [inline]
>  update_se+0x39b/0x480 kernel/sched/fair.c:1159
>  update_curr+0x71/0x450 kernel/sched/fair.c:1209
>  put_prev_entity+0x97/0x1b0 kernel/sched/fair.c:5504
>  pick_next_task_fair+0xf7e/0x17b0 kernel/sched/fair.c:8949
>  __pick_next_task kernel/sched/core.c:5890 [inline]
>  pick_next_task kernel/sched/core.c:6426 [inline]
>  __schedule+0x740/0x1df0 kernel/sched/core.c:6809
>  preempt_schedule_common kernel/sched/core.c:7051 [inline]
>  __cond_resched+0x45/0x70 kernel/sched/core.c:7378
>  mutex_lock+0x75/0xe0 kernel/locking/mutex.c:287
>  ext4_mb_group_or_file fs/ext4/mballoc.c:5886 [inline]
>  ext4_mb_initialize_context+0x85e/0xcf0 fs/ext4/mballoc.c:5930
>  ext4_mb_new_blocks+0x603/0x3fc0 fs/ext4/mballoc.c:6304
>  ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
>  ext4_ind_map_blocks+0x1635/0x20c0 fs/ext4/indirect.c:635
>  ext4_map_create_blocks fs/ext4/inode.c:615 [inline]
>  ext4_map_blocks+0xb51/0x1350 fs/ext4/inode.c:816
>  _ext4_get_block+0x1bb/0x550 fs/ext4/inode.c:916
>  ext4_block_write_begin+0x88a/0x1040 fs/ext4/inode.c:1203
>  ext4_write_begin+0x75f/0x11d0 fs/ext4/inode.c:1364
>  generic_perform_write+0x37d/0x800 mm/filemap.c:4314
>  ext4_buffered_write_iter+0x11a/0x430 fs/ext4/file.c:299
>  ext4_file_write_iter+0x560/0x1790 fs/ext4/file.c:723
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write fs/read_write.c:686 [inline]
>  vfs_write+0xa66/0xe30 fs/read_write.c:666
>  ksys_write+0x120/0x240 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xa9/0x320 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f99e822ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f99e6c97038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f99e8465fa0 RCX: 00007f99e822ebe9
> RDX: 000000000208e24b RSI: 0000200000000340 RDI: 000000000000000a
> RBP: 00007f99e82b1e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f99e8466038 R14: 00007f99e8465fa0 R15: 00007ffc60f336c8
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>
> Thanks
