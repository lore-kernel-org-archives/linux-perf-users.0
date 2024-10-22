Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D419AD7E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611646; cv=none; b=rEP7F9+V2lZx44GpF9WWZ0RTW2cTu+iyEPkTxhp0Lh/Wl2/ENnjDEL7Otn7W/22+t/H2KMj6f5Ml56XhOcoPjsRqZc3u40P5muqDEEA3CnxDwFLp7qGGmuY+Yl6o9y+TYB/LyNtK8MaEKT83mjLqUjWs3MioUFYSsP2AoxDmVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611646; c=relaxed/simple;
	bh=Fz/La2t94ik4/K+LIBtcmpv2qCpf5Dde6QbkFn9j73Q=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZHs41OTHyuLDMnk1ffvS+Ccc7ZEaZ1seNzZb1iwtQOGHJhenFV4QV7Nc2/kB6ScDba51daW7i70Gw0J/vrqxTzpezmd5m5XUtyMFzW4och2jYTj+6b31rdOA3olGMyAjk6INA9y7niq8xPmTte5yNjitanp2zjdXyM8G/e7s6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=gRccz82p; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="gRccz82p"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b13bf566c0so375950985a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1729611643; x=1730216443; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aCAEp4QAEi7Oa48A7wSJlXlBhHhjC0+UmRGpFNIqQcE=;
        b=gRccz82pd8r42f9HH7JjZm5mvpQ9N7K8xBx9I7b62z5oGeJrzb6DH8areEdKJd+eGQ
         YJVbvkh/+GI0WSKgeFFx64iiPsX/H7LIdVGFKakgA/U4QR9Jlu7/VlXDxkCJQTVysgR9
         rnQIvyLUv1Iiwka/e+3ZB0j8DQ9WgyikKlGWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611643; x=1730216443;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCAEp4QAEi7Oa48A7wSJlXlBhHhjC0+UmRGpFNIqQcE=;
        b=vKTy5O0kSFGD9jlSJx0Yxw65sJY5Xd4TgvJH2sjA6sUBpAy3iS9G4TXkJTentsCRlz
         kM4aEmp0OPSV8z2ZlTQwlr/uxsSCjPYyzGjW7o397B2+cDB/Z0L+XzPG5btrT3J6fPTS
         qTWJA3wMFeU0B9Mziw4uCfuZXz3O4It1p8V6DOXD6K409YyoCQPYGSGrkW+rEPqBgxUu
         fOZFqGKNJjHt0PeEaZfhovxUos8qG+Vneaq3GCQv5f5tpKHrQ3/2zRja2XmSchLGBXIy
         Yf9HAWS76XdWmMXjx38tP5IwaRomUfhQyLtBiDxVD0ysUE/nydk3IzmVewL7Wif3oZLz
         +Qrw==
X-Gm-Message-State: AOJu0YzEiEFQIHKAhyRmiNaOZ3/wyqgQu4CUHw31a1+KIFLQDg7biJ5K
	TLsV8R017PhnDH8iz8kwhXPnDKAiy/P8WUCCVrO/vc81CwIKTAL+L/ieCCWCYWcOg2y+qfQzWbV
	IQw==
X-Google-Smtp-Source: AGHT+IHQMjwhSP8cVy5yaUW7rStPht83UpR3a0nZdydwtHkSwUyYoxZjE/l86Jkqqy8VlMplyGWNmQ==
X-Received: by 2002:a05:620a:4714:b0:7b1:516c:8601 with SMTP id af79cd13be357-7b1751cd329mr583889085a.20.1729611642535;
        Tue, 22 Oct 2024 08:40:42 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659b9802sm291221285a.5.2024.10.22.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:40:41 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 22 Oct 2024 11:40:40 -0400 (EDT)
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>
Subject: perf_event: possible circle locking dependency
Message-ID: <5dde8db3-ffd6-0c84-d00a-ee374fb86af0@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

the perf_fuzzer triggered this circular locking warning on my haswell 
fuzzing box running 6.12.0-rc2.  Not sure if people care about reports 
like this.  Unfortunately I can't test if it's repeatable because my 
logging box was down at the time this happened.

Vince


[1174639.971967] ======================================================
[1174639.971970] WARNING: possible circular locking dependency detected
[1174639.971974] 6.12.0-rc2 #7 Not tainted
[1174639.971980] ------------------------------------------------------
[1174639.971983] perf_fuzzer/3609323 is trying to acquire lock:
[1174639.971988] ffffffff8339dc18 ((console_sem).lock){-...}-{2:2},
 at: down_trylock+0x11/0x50
[1174639.972014] 
                 but task is already holding lock:
[1174639.972016] ffff888019527018 (&ctx->lock){-.-.}-{2:2}, at: 
__perf_event_read+0xb4/0x3a0
[1174639.972035] 
                 which lock already depends on the new lock.

[1174639.972038] 
                 the existing dependency chain (in reverse order) is:
[1174639.972040] 
                 -> #2 (&ctx->lock){-.-.}-{2:2}:
[1174639.972051]        _raw_spin_lock+0x2f/0x40
[1174639.972062]        perf_tp_event+0x309/0x880
[1174639.972071]        perf_trace_sched_wakeup_template+0x1fe/0x250
[1174639.972083]        trace_sched_waking+0x99/0xf0
[1174639.972092]        try_to_wake_up+0x1c4/0x8f0
[1174639.972101]        __wake_up_common+0xc5/0x110
[1174639.972109]        __wake_up_sync_key+0x37/0x50
[1174639.972116]        do_notify_parent+0x47d/0x860
[1174639.972127]        do_exit+0xd72/0x1130
[1174639.972135]        do_group_exit+0x63/0x110
[1174639.972143]        get_signal+0xe09/0xeb0
[1174639.972149]        arch_do_signal_or_restart+0x82/0x3a0
[1174639.972157]        irqentry_exit_to_user_mode+0xd3/0x130
[1174639.972165]        asm_sysvec_reschedule_ipi+0x16/0x20
[1174639.972174] 
                 -> #1 (&p->pi_lock){-.-.}-{2:2}:
[1174639.972183]        _raw_spin_lock_irqsave+0x47/0x70
[1174639.972192]        try_to_wake_up+0x8f/0x8f0
[1174639.972199]        up+0x4e/0x60
[1174639.972205]        __up_console_sem+0x54/0x70
[1174639.972211]        console_unlock+0x25f/0x2f0
[1174639.972219]        vprintk_emit.part.0+0x33f/0x570
[1174639.972227]        devkmsg_emit.constprop.0+0xab/0xde
[1174639.972234]        devkmsg_write.cold+0x2d/0x5b
[1174639.972240]        do_iter_readv_writev+0x1df/0x370
[1174639.972248]        vfs_writev+0x211/0x700
[1174639.972256]        do_writev+0xdf/0x200
[1174639.972263]        do_syscall_64+0x69/0x170
[1174639.972273]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[1174639.972280] 
                 -> #0 ((console_sem).lock){-...}-{2:2}:
[1174639.972290]        __lock_acquire+0x1c91/0x31b0
[1174639.972297]        lock_acquire.part.0+0x10c/0x2d0
[1174639.972303]        _raw_spin_lock_irqsave+0x47/0x70
[1174639.972312]        down_trylock+0x11/0x50
[1174639.972318]        __down_trylock_console_sem+0x2f/0xa0
[1174639.972325]        console_trylock+0x36/0x90
[1174639.972332]        vprintk_emit.part.0+0x336/0x570
[1174639.972339]        _printk+0xb2/0xe5
[1174639.972345]        lockdep_rcu_suspicious+0x87/0x180
[1174639.972355]        get_callchain_entry+0x12f/0x190
[1174639.972361]        get_perf_callchain+0x9d/0x2d0
[1174639.972367]        perf_callchain+0xc9/0xe0
[1174639.972374]        setup_pebs_fixed_sample_data+0x6ae/0x820
[1174639.972382]        intel_pmu_drain_pebs_nhm+0x795/0x9f0
[1174639.972389]        intel_pmu_drain_pebs_buffer+0x8c/0xd0
[1174639.972400]        intel_pmu_auto_reload_read+0x3f/0x60
[1174639.972407]        __perf_event_read+0x308/0x3a0
[1174639.972415]        __flush_smp_call_function_queue+0x154/0x370
[1174639.972427]        __sysvec_call_function_single+0x4c/0x1f0
[1174639.972438]        sysvec_call_function_single+0x4c/0xc0
[1174639.972449]        asm_sysvec_call_function_single+0x16/0x20
[1174639.972456] 
                 other info that might help us debug this:

[1174639.972459] Chain exists of:
                   (console_sem).lock --> &p->pi_lock --> &ctx->lock

[1174639.972472]  Possible unsafe locking scenario:

[1174639.972475]        CPU0                    CPU1
[1174639.972477]        ----                    ----
[1174639.972479]   lock(&ctx->lock);
[1174639.972485]                                lock(&p->pi_lock);
[1174639.972490]                                lock(&ctx->lock);
[1174639.972496]   lock((console_sem).lock);
[1174639.972501] 
                  *** DEADLOCK ***

[1174639.972503] 1 lock held by perf_fuzzer/3609323:
[1174639.972508]  #0: ffff888019527018 (&ctx->lock){-.-.}-{2:2}, at: __perf_event_read+0xb4/0x3a0
[1174639.972527] 
                 stack backtrace:
[1174639.972531] CPU: 0 UID: 1000 PID: 3609323 Comm: perf_fuzzer Not tainted 6.12.0-rc2 #7
[1174639.972540] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[1174639.972545] Call Trace:
[1174639.972549]  <TASK>
[1174639.972553]  dump_stack_lvl+0x68/0x90
[1174639.972566]  print_circular_bug.cold+0x193/0x1e2
[1174639.972582]  check_noncircular+0x24a/0x290
[1174639.972595]  ? __pfx_check_noncircular+0x10/0x10
[1174639.972605]  ? __pfx__prb_read_valid+0x10/0x10
[1174639.972618]  ? lockdep_lock+0xb1/0x160
[1174639.972627]  ? __pfx_lockdep_lock+0x10/0x10
[1174639.972640]  __lock_acquire+0x1c91/0x31b0
[1174639.972658]  ? __pfx___lock_acquire+0x10/0x10
[1174639.972667]  ? vprintk_store+0x543/0x610
[1174639.972679]  lock_acquire.part.0+0x10c/0x2d0
[1174639.972687]  ? down_trylock+0x11/0x50
[1174639.972697]  ? __pfx_lock_acquire.part.0+0x10/0x10
[1174639.972705]  ? rcu_is_watching+0x34/0x60
[1174639.972717]  ? trace_lock_acquire+0x110/0x140
[1174639.972729]  ? lock_acquire+0x3b/0x90
[1174639.972735]  ? down_trylock+0x11/0x50
[1174639.972746]  _raw_spin_lock_irqsave+0x47/0x70
[1174639.972755]  ? down_trylock+0x11/0x50
[1174639.972763]  down_trylock+0x11/0x50
[1174639.972770]  ? vprintk_emit.part.0+0x336/0x570
[1174639.972779]  __down_trylock_console_sem+0x2f/0xa0
[1174639.972788]  console_trylock+0x36/0x90
[1174639.972796]  vprintk_emit.part.0+0x336/0x570
[1174639.972806]  ? __pfx_vprintk_emit.part.0+0x10/0x10
[1174639.972817]  ? __lock_acquire+0x94b/0x31b0
[1174639.972829]  _printk+0xb2/0xe5
[1174639.972836]  ? __pfx__printk+0x10/0x10
[1174639.972846]  ? __pfx___lock_acquire+0x10/0x10
[1174639.972855]  ? find_held_lock+0x83/0xa0
[1174639.972863]  ? nbcon_cpu_emergency_enter+0x20/0x30
[1174639.972873]  lockdep_rcu_suspicious+0x87/0x180
[1174639.972887]  get_callchain_entry+0x12f/0x190
[1174639.972896]  get_perf_callchain+0x9d/0x2d0
[1174639.972905]  ? __pfx_get_perf_callchain+0x10/0x10
[1174639.972916]  ? lock_is_held_type+0xd5/0x130
[1174639.972923]  ? __rcu_read_unlock+0x4e/0x2a0
[1174639.972933]  ? perf_event_update_userpage+0x2a4/0x450
[1174639.972945]  perf_callchain+0xc9/0xe0
[1174639.972956]  setup_pebs_fixed_sample_data+0x6ae/0x820
[1174639.972971]  intel_pmu_drain_pebs_nhm+0x795/0x9f0
[1174639.972990]  ? __pfx_intel_pmu_drain_pebs_nhm+0x10/0x10
[1174639.973000]  ? __lock_acquire+0x94b/0x31b0
[1174639.973014]  ? find_held_lock+0x83/0xa0
[1174639.973024]  ? lock_release+0x28f/0x430
[1174639.973033]  ? mark_lock+0x101/0xcd0
[1174639.973049]  ? wp_page_reuse+0xdb/0xf0
[1174639.973071]  intel_pmu_drain_pebs_buffer+0x8c/0xd0
[1174639.973085]  ? __pfx_intel_pmu_drain_pebs_buffer+0x10/0x10
[1174639.973098]  ? __pfx___lock_acquire+0x10/0x10
[1174639.973106]  ? __pfx_mark_lock+0x10/0x10
[1174639.973117]  ? lock_acquire.part.0+0x10c/0x2d0
[1174639.973126]  ? lock_acquire.part.0+0x11c/0x2d0
[1174639.973134]  ? __pfx_lock_acquire.part.0+0x10/0x10
[1174639.973142]  ? rcu_is_watching+0x34/0x60
[1174639.973152]  ? do_raw_spin_lock+0x10c/0x1a0
[1174639.973163]  ? lock_is_held_type+0xd5/0x130
[1174639.973173]  ? intel_pmu_lbr_disable_all+0x3c/0xe0
[1174639.973184]  intel_pmu_auto_reload_read+0x3f/0x60
[1174639.973193]  __perf_event_read+0x308/0x3a0
[1174639.973202]  ? rcu_is_watching+0x34/0x60
[1174639.973213]  ? __pfx___perf_event_read+0x10/0x10
[1174639.973221]  __flush_smp_call_function_queue+0x154/0x370
[1174639.973231]  ? __pfx___perf_event_read+0x10/0x10
[1174639.973242]  __sysvec_call_function_single+0x4c/0x1f0
[1174639.973254]  sysvec_call_function_single+0x4c/0xc0
[1174639.973265]  asm_sysvec_call_function_single+0x16/0x20
[1174639.973274] RIP: 0033:0x5616fdc38bd7
[1174639.973281] Code: 0f 1f 00 48 89 d1 31 c0 48 89 f2 89 fe bf 41 01 00 00 e9 9c 06 ff ff 66 2e 0f 1f 84 00 00 00 00 00 66 90 31 c9 b9 1f a1 07 00 <ff> c9 75 fc 31 c0 c3 66 90 48 8b 05 99 a0 00 00 48 89 44 24 f8 b9
[1174639.973289] RSP: 002b:00007ffeffe6f0b8 EFLAGS: 00000202
[1174639.973296] RAX: 0000000000000000 RBX: 000000000000000d RCX: 000000000005c0b0
[1174639.973302] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[1174639.973306] RBP: 00007ffeffe6f0d0 R08: 0000000000000000 R09: 00007fef59807740
[1174639.973311] R10: 00007fef59a540b8 R11: 0000000000000246 R12: 0000000000000000
[1174639.973316] R13: 00007ffeffe71528 R14: 00007fef59a53000 R15: 00005616fdc45dd8
[1174639.973333]  </TASK>
[1174640.764359] =============================
[1174640.768560] WARNING: suspicious RCU usage
[1174640.772765] 6.12.0-rc2 #7 Not tainted
[1174640.776620] -----------------------------
[1174640.780825] kernel/events/callchain.c:162 suspicious rcu_dereference_check() usage!
[1174640.788672] 
                 other info that might help us debug this:

[1174640.797209] 
                 rcu_scheduler_active = 2, debug_locks = 1
[1174640.804097] 1 lock held by perf_fuzzer/3609323:
[1174640.808817]  #0: ffff888019527018 (&ctx->lock){-.-.}-{2:2}, at: __perf_event_read+0xb4/0x3a0
[1174640.817452]                  stack backtrace:
[1174640.822176] CPU: 0 UID: 1000 PID: 3609323 Comm: perf_fuzzer Not tainted 6.12.0-rc2 #7
[1174640.830192] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[1174640.837775] Call Trace:
[1174640.840416]  <TASK>
[1174640.842713]  dump_stack_lvl+0x68/0x90
[1174640.846569]  lockdep_rcu_suspicious.cold+0x4e/0xad
[1174640.851555]  get_callchain_entry+0x12f/0x190
[1174640.856016]  get_perf_callchain+0x9d/0x2d0
[1174640.860306]  ? __pfx_get_perf_callchain+0x10/0x10
[1174640.865205]  ? lock_is_held_type+0xd5/0x130
[1174640.869581]  ? __rcu_read_unlock+0x4e/0x2a0
[1174640.873959]  ? perf_event_update_userpage+0x2a4/0x450
[1174640.879205]  perf_callchain+0xc9/0xe0
[1174640.883057]  setup_pebs_fixed_sample_data+0x6ae/0x820
[1174640.888307]  intel_pmu_drain_pebs_nhm+0x795/0x9f0
[1174640.893214]  ? __pfx_intel_pmu_drain_pebs_nhm+0x10/0x10
[1174640.898633]  ? __lock_acquire+0x94b/0x31b0
[1174640.902922]  ? find_held_lock+0x83/0xa0
[1174640.906951]  ? lock_release+0x28f/0x430
[1174640.910984]  ? mark_lock+0x101/0xcd0
[1174640.914754]  ? wp_page_reuse+0xdb/0xf0
[1174640.918699]  intel_pmu_drain_pebs_buffer+0x8c/0xd0
[1174640.923691]  ? __pfx_intel_pmu_drain_pebs_buffer+0x10/0x10
[1174640.929372]  ? __pfx___lock_acquire+0x10/0x10
[1174640.933924]  ? __pfx_mark_lock+0x10/0x10
[1174640.938042]  ? lock_acquire.part.0+0x10c/0x2d0
[1174640.942675]  ? lock_acquire.part.0+0x11c/0x2d0
[1174640.947311]  ? __pfx_lock_acquire.part.0+0x10/0x10
[1174640.952290]  ? rcu_is_watching+0x34/0x60
[1174640.956404]  ? do_raw_spin_lock+0x10c/0x1a0
[1174640.960782]  ? lock_is_held_type+0xd5/0x130
[1174640.965157]  ? intel_pmu_lbr_disable_all+0x3c/0xe0
[1174640.970140]  intel_pmu_auto_reload_read+0x3f/0x60
[1174640.975037]  __perf_event_read+0x308/0x3a0
[1174640.979329]  ? rcu_is_watching+0x34/0x60
[1174640.983443]  ? __pfx___perf_event_read+0x10/0x10
[1174640.988247]  __flush_smp_call_function_queue+0x154/0x370
[1174640.993748]  ? __pfx___perf_event_read+0x10/0x10
[1174640.998548]  __sysvec_call_function_single+0x4c/0x1f0
[1174641.003795]  sysvec_call_function_single+0x4c/0xc0
[1174641.008776]  asm_sysvec_call_function_single+0x16/0x20
[1174641.014105] RIP: 0033:0x5616fdc38bd7
[1174641.017873] Code: 0f 1f 00 48 89 d1 31 c0 48 89 f2 89 fe bf 41 01 00 00 e9 9c 06 ff ff 66 2e 0f 1f 84 00 00 00 00 00 66 90 31 c9 b9 1f a1 07 00 <ff> c9 75 fc 31 c0 c3 66 90 48 8b 05 99 a0 00 00 48 89 44 24 f8 b9
[1174641.036825] RSP: 002b:00007ffeffe6f0b8 EFLAGS: 00000202
[1174641.042245] RAX: 0000000000000000 RBX: 000000000000000d RCX: 000000000005c0b0
[1174641.049573] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[1174641.056894] RBP: 00007ffeffe6f0d0 R08: 0000000000000000 R09: 00007fef59807740
[1174641.064218] R10: 00007fef59a540b8 R11: 0000000000000246 R12: 0000000000000000
[1174641.071541] R13: 00007ffeffe71528 R14: 00007fef59a53000 R15: 00005616fdc45dd8
[1174641.078870]  </TASK>

