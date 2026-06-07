Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BA2D9EED
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849599; cv=none; b=qIVcwTiFs5naldUme7pPlLLdJVjrdLDLbiONmPeNdby9rIBDyMHQOTwHRFpCODdMgGHweR2CUQrscAXaj1uThL3w13zgmRdnknyt2kmpVJjSUpt8fpzYZqrbzGk/GKoahaXcj68CbTfyRm9qCjIgggfemOz3K+K/3/d434AIj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849599; c=relaxed/simple;
	bh=mo1Wk+WwlQEcNQvQctwFbj+YSgxn1XhAC4/7JOESomg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyhjryUcYf/6swcweDMr3xu3XPpc0S43n5Csk3C4SXbnZvr26qEvPiVLsF5RmO8MMCbSVTzdYnjOxVVtjiecAcjXOi/O3zTcRD1xSJteFcPyJNIsNd8m04zsiSahT+rlp7P9QTTKykDjWhsa/um5tSZMHgb3XAlY1CyQwsqUtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0Wbm0Dd; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Wbm0Dd"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36da151a152so2443388a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jun 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780849597; x=1781454397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDB0HY3akzOHaSvEgmBf8Tnd41v7y1zlfrvlwqokhTE=;
        b=U0Wbm0DdLDpKWDu1+zYfNf7TH87970LhoLHm0QHx6WCeN4swJ1SPUPJ0XlyioEfdt5
         oyRy4ve4jO5gvJLq2b/hVQkjoZx6xyaFiXRSIvKydL8/AWAQMXLcY/9MRTdnYi8OVTbv
         vkjqBkOCuCoTASpSdq/tVD3TnAHNwxuVr5lE8H89JRZA8xK55ImxAxYF29dM4nTBUIEB
         B9T2OqB/8zGWlauqIHJQ8DERca1IEwvgjwI31FF0Qt0PNTjni4GVefU/qUOqKRuTmatC
         81OiI4TnxWXoHNxMuIQ6Bpb9naQIyJVsnKRCNnp+z9GuO6VEByroVD3DyIRYcuBypxnz
         gpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780849597; x=1781454397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDB0HY3akzOHaSvEgmBf8Tnd41v7y1zlfrvlwqokhTE=;
        b=seeckEFnXYCD3uzKADDPg7/bOS3g3YE6E86EYhVSfypOfu4ANaJBzAjmDSz3w4ITM4
         4TuuyawHBcud4qJT3KI2TN5I6PjzJR2K/BLAlvvTnCPhqUdrUWyvqGwMlBhUMFWgDbS2
         +697W+8yvRmozG957bKx93cx34JJsRVc2oJl+X/TzUQpYj9Nb9eg4nTTwwOBkWODUy0q
         9l1JV7quudM4CEFjvsu8kxB2YrDCKXO5GnG9msV74Zg59tJakbFIiskqXUX/QZOBOIZ3
         6fUM75VSHUoZVjOHupkThIUR0h4yMNePBczNhbYEGM3tSrB4PVIgwAH6gM+gHcQodI9V
         YUFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zalbXh+gqK4krtYrZ3fhsGbgGe6aTJRtQpZgJFVgJnfVPoDU2S+Ep8WYfWVu7wDX4MIdZsvDQfX8L94bwe4Xg@vger.kernel.org
X-Gm-Message-State: AOJu0YyHId/AB+rrgI6iendFfYP8ivuxjTbhWrvV+TvQdX37u1Z2zEiN
	T2Avc4t8ns9h3xT8R5vdGvQefGLWVN95/6XlAUokEqurW5S13nT9IATbUnn28304RxCYYA==
X-Gm-Gg: Acq92OE0zq/ggrWwkMOCVnfx/R44OefDXeShybNDheRX3lCMvTBpdWQzkkXSg+mRAnf
	Ur56KONZx2HQAKx9s6UOE6hI1cfmQOD/dZb9wZG8MAZhXah5T9G0gros3czZODEmKg2tSHeF+d4
	3LAI8PVA3ebrqHYZvdKGidBjo26toCKh1oJE1jR107mhb+OllpY2prjgIKIkkyqM6JSpYspEcso
	5Uf4uori8OfXIaSI1q2wn4xFpj9OsfFLxztkhDTfJ399dmKDWkA9GjB4/GB+sR9A1WhgMmFT1d7
	0bCnCAol1AzrKGIFcVTZFThAzuOaBq7bC8hLwb0TE57XImue0hhfkvezPhT/byMbCFceGKJ8SAM
	mh/YBGFWzIBJb1AfCSPIJgv0f34Wc/s4No8ZcNz5Hm50SDBFurcu6PmvVz+nrOowjxvNW4hu5Ks
	nTxWPjt/aW9Vw8rF+8lgMuCiDT8OXJszCVovx9ba1QIW9r3WEzOKnFPZqb
X-Received: by 2002:a17:90b:4cc9:b0:36d:8e49:d8 with SMTP id 98e67ed59e1d1-370f04818e9mr13191896a91.15.1780849596456;
        Sun, 07 Jun 2026 09:26:36 -0700 (PDT)
Received: from LAPTOP-1HUHJV8R.localdomain ([2408:8642:893:d2da:4c45:b50d:cf54:5c66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba82c6sm12725484a91.13.2026.06.07.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:26:36 -0700 (PDT)
From: l1za0.sec@gmail.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: avoid lockdep warning in self-monitoring perf_event_open
Date: Mon,  8 Jun 2026 00:26:22 +0800
Message-ID: <20260607162622.15534-1-l1za0.sec@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <l1za0.sec@gmail.com>

A lockdep warning: possible deadlock in __perf_event_task_sched_out is
reported by a modified Syzkaller-based kernel fuzzing tool we use.

The warning is triggered on the self-monitoring perf_event_open() path.
When perf_install_in_context() targets the current task, it goes through
task_function_call() and the synchronous smp_call_function_single()
self-call path. The reported lockdep chain contains:

  rq->__lock -> ctx->lock

and an existing reverse dependency from:

  ctx->lock -> ... -> p->pi_lock -> rq->__lock

The current fix adds a fast path for task == current in
perf_install_in_context() and calls __perf_install_in_context()
directly.

This fix removes the self-call path for the reported self-monitoring
case. It does not change the scheduler-side locking order in
__perf_event_task_sched_out(), so it should be treated as a targeted
mitigation for this trigger path.

Signed-off-by: Haocheng Yu <l1za0.sec@gmail.com>
---
The full report:

syz.5.416/15637 is trying to acquire lock:
ffff888110979418 (&ctx->lock){....}-{2:2}, at: perf_event_context_sched_out kernel/events/core.c:3848 [inline]
ffff888110979418 (&ctx->lock){....}-{2:2}, at: __perf_event_task_sched_out+0x439/0x14e0 kernel/events/core.c:3953

but task is already holding lock:
ffff888135f3b3e0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2e/0x170 kernel/sched/core.c:652

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       _raw_spin_lock_nested+0x34/0x40 kernel/locking/spinlock.c:382
       raw_spin_rq_lock_nested+0x2e/0x170 kernel/sched/core.c:652
       raw_spin_rq_lock kernel/sched/sched.h:1624 [inline]
       _task_rq_lock+0xd3/0x4b0 kernel/sched/core.c:747
       cgroup_move_task+0x72/0x310 kernel/sched/psi.c:1170
       css_set_move_task+0x277/0x550 kernel/cgroup/cgroup.c:887
       cgroup_post_fork+0x1ff/0x970 kernel/cgroup/cgroup.c:6952
       copy_process+0x4869/0x7e30 kernel/fork.c:2524
       kernel_clone+0x11a/0xf30 kernel/fork.c:2721
       user_mode_thread+0xc8/0x110 kernel/fork.c:2797
       rest_init+0x23/0x2f0 init/main.c:727
       start_kernel+0x409/0x4e0 init/main.c:1220
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
       x86_64_start_kernel+0x101/0x150 arch/x86/kernel/head64.c:291
       common_startup_64+0x13e/0x148

-> #4 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:166
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:571 [inline]
       try_to_wake_up+0xb7/0x2220 kernel/sched/core.c:4190
       autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:403
       __wake_up_common+0x138/0x1f0 kernel/sched/wait.c:108
       __wake_up_common_lock+0x33/0x60 kernel/sched/wait.c:125
       tty_port_default_wakeup+0x4d/0x70 drivers/tty/tty_port.c:67
       serial8250_tx_chars+0xa6f/0x1200 drivers/tty/serial/8250/8250_port.c:1721
       serial8250_handle_irq_locked+0x55f/0xcd0 drivers/tty/serial/8250/8250_port.c:1825
       serial8250_handle_irq.part.0+0xb6/0x540 drivers/tty/serial/8250/8250_port.c:1841
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1837 [inline]
       serial8250_default_handle_irq+0xbf/0x150 drivers/tty/serial/8250/8250_port.c:1855
       serial8250_interrupt+0xf8/0x1c0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x242/0x8f0 kernel/irq/handle.c:209
       handle_irq_event_percpu+0x18/0xe0 kernel/irq/handle.c:246
       handle_irq_event+0xa5/0x140 kernel/irq/handle.c:263
       handle_edge_irq+0x25c/0x760 kernel/irq/chip.c:856
       generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
       handle_irq arch/x86/kernel/irq.c:262 [inline]
       call_irq_handler arch/x86/kernel/irq.c:286 [inline]
       __common_interrupt+0xd1/0x2f0 arch/x86/kernel/irq.c:333
       common_interrupt+0xf2/0x110 arch/x86/kernel/irq.c:326
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
       lowmem_page_address include/linux/mm.h:2973 [inline]
       kmap_local_page include/linux/highmem-internal.h:188 [inline]
       clear_highpage_kasan_tagged include/linux/highmem.h:342 [inline]
       kernel_init_pages+0x79/0xc0 mm/page_alloc.c:1218
       post_alloc_hook mm/page_alloc.c:1856 [inline]
       prep_new_page+0x19d/0x1d0 mm/page_alloc.c:1866
       get_page_from_freelist+0x1605/0x3280 mm/page_alloc.c:3946
       __alloc_frozen_pages_noprof+0x339/0x780 mm/page_alloc.c:5226
       alloc_slab_page mm/slub.c:3278 [inline]
       allocate_slab mm/slub.c:3467 [inline]
       new_slab+0x9c/0x670 mm/slub.c:3525
       refill_objects+0x254/0x400 mm/slub.c:7251
       refill_sheaf+0x27/0x40 mm/slub.c:2816
       __pcs_replace_empty_main+0x191/0x5f0 mm/slub.c:4651
       alloc_from_pcs mm/slub.c:4749 [inline]
       slab_alloc_node mm/slub.c:4883 [inline]
       __do_kmalloc_node mm/slub.c:5294 [inline]
       __kmalloc_noprof+0x7b5/0x970 mm/slub.c:5307
       kmalloc_noprof include/linux/slab.h:954 [inline]
       tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
       tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
       tomoyo_path_perm+0x235/0x440 security/tomoyo/file.c:827
       security_inode_getattr+0x122/0x2b0 security/security.c:1895
       vfs_getattr+0x26/0x70 fs/stat.c:259
       vfs_statx_path fs/stat.c:299 [inline]
       vfs_statx+0x125/0x3f0 fs/stat.c:356
       vfs_fstatat+0x77/0xe0 fs/stat.c:373
       vfs_lstat include/linux/fs.h:3212 [inline]
       __do_sys_newlstat+0x83/0x100 fs/stat.c:524
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x121/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&tty->write_wait){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:166
       __wake_up_common_lock+0x1d/0x60 kernel/sched/wait.c:124
       tty_port_default_wakeup+0x4d/0x70 drivers/tty/tty_port.c:67
       serial8250_tx_chars+0xa6f/0x1200 drivers/tty/serial/8250/8250_port.c:1721
       serial8250_handle_irq_locked+0x55f/0xcd0 drivers/tty/serial/8250/8250_port.c:1825
       serial8250_handle_irq.part.0+0xb6/0x540 drivers/tty/serial/8250/8250_port.c:1841
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1837 [inline]
       serial8250_default_handle_irq+0xbf/0x150 drivers/tty/serial/8250/8250_port.c:1855
       serial8250_interrupt+0xf8/0x1c0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x242/0x8f0 kernel/irq/handle.c:209
       handle_irq_event_percpu+0x18/0xe0 kernel/irq/handle.c:246
       handle_irq_event+0xa5/0x140 kernel/irq/handle.c:263
       handle_edge_irq+0x25c/0x760 kernel/irq/chip.c:856
       generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
       handle_irq arch/x86/kernel/irq.c:262 [inline]
       call_irq_handler arch/x86/kernel/irq.c:286 [inline]
       __common_interrupt+0xd1/0x2f0 arch/x86/kernel/irq.c:333
       common_interrupt+0xf2/0x110 arch/x86/kernel/irq.c:326
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
       _raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:198
       spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:788 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:91 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:88 [inline]
       uart_write+0x289/0xb10 drivers/tty/serial/serial_core.c:634
       do_output_char+0x5e8/0x870 drivers/tty/n_tty.c:418
       process_output drivers/tty/n_tty.c:482 [inline]
       n_tty_write+0x507/0x10a0 drivers/tty/n_tty.c:2377
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write.isra.0+0x4de/0x920 drivers/tty/tty_io.c:1081
       tty_write drivers/tty/tty_io.c:1102 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
       redirected_tty_write+0xc9/0x100 drivers/tty/tty_io.c:1105
       do_iter_readv_writev+0x655/0x9e0 fs/read_write.c:829
       vfs_writev+0x30c/0xd70 fs/read_write.c:1059
       do_writev+0x129/0x330 fs/read_write.c:1105
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x121/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:166
       uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
       serial8250_console_write+0x553/0x1700 drivers/tty/serial/8250/8250_port.c:3316
       console_emit_next_record kernel/printk/printk.c:3183 [inline]
       console_flush_one_record+0x7ae/0xe80 kernel/printk/printk.c:3269
       console_flush_all kernel/printk/printk.c:3343 [inline]
       __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
       console_unlock+0x224/0x530 kernel/printk/printk.c:3413
       vprintk_emit+0x46a/0xa30 kernel/printk/printk.c:2479
       _printk+0xbe/0xf0 kernel/printk/printk.c:2504
       register_console+0x7f0/0x11c0 kernel/printk/printk.c:4208
       univ8250_console_init+0x62/0x90 drivers/tty/serial/8250/8250_core.c:515
       console_init+0xc7/0x6d0 kernel/printk/printk.c:4407
       start_kernel+0x2b2/0x4e0 init/main.c:1157
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
       x86_64_start_kernel+0x101/0x150 arch/x86/kernel/head64.c:291
       common_startup_64+0x13e/0x148

-> #1 (console_owner){....}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       console_lock_spinning_enable+0x72/0x80 kernel/printk/printk.c:1902
       console_emit_next_record kernel/printk/printk.c:3177 [inline]
       console_flush_one_record+0x757/0xe80 kernel/printk/printk.c:3269
       console_flush_all kernel/printk/printk.c:3343 [inline]
       __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
       console_unlock+0x224/0x530 kernel/printk/printk.c:3413
       vprintk_emit+0x46a/0xa30 kernel/printk/printk.c:2479
       _printk+0xbe/0xf0 kernel/printk/printk.c:2504
       ex_handler_msr+0x3c4/0x540 arch/x86/mm/extable.c:170
       fixup_exception+0x119/0x10a0 arch/x86/mm/extable.c:347
       gp_try_fixup_and_notify.constprop.0+0x2e/0x130 arch/x86/kernel/traps.c:888
       __exc_general_protection arch/x86/kernel/traps.c:949 [inline]
       exc_general_protection+0x1b6/0x320 arch/x86/kernel/traps.c:914
       asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:612
       __wrmsrq arch/x86/include/asm/msr.h:80 [inline]
       native_write_msr arch/x86/include/asm/msr.h:137 [inline]
       wrmsrq arch/x86/include/asm/msr.h:199 [inline]
       __x86_pmu_enable_event arch/x86/events/perf_event.h:1283 [inline]
       intel_pmu_enable_event+0xea6/0x1340 arch/x86/events/intel/core.c:3309
       x86_pmu_start+0x19a/0x220 arch/x86/events/core.c:1553
       x86_pmu_enable+0x642/0xf60 arch/x86/events/core.c:1386
       perf_pmu_enable kernel/events/core.c:1355 [inline]
       perf_pmu_enable+0x113/0x160 kernel/events/core.c:1351
       ctx_resched+0x382/0x460 kernel/events/core.c:3031
       __perf_install_in_context+0x9a9/0xe60 kernel/events/core.c:3099
       remote_function kernel/events/core.c:95 [inline]
       remote_function+0x128/0x1b0 kernel/events/core.c:75
       csd_do_func kernel/smp.c:136 [inline]
       generic_exec_single+0x230/0x730 kernel/smp.c:453
       smp_call_function_single+0x196/0x610 kernel/smp.c:699
       task_function_call+0xe4/0x170 kernel/events/core.c:123
       perf_install_in_context+0x2cb/0x570 kernel/events/core.c:3202
       __do_sys_perf_event_open+0x17ab/0x2a00 kernel/events/core.c:14162
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x121/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ctx->lock){....}-{2:2}:
       check_prev_add+0xe9/0xd00 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14e8/0x24e0 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b0/0x360 kernel/locking/lockdep.c:5825
       __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
       perf_event_context_sched_out kernel/events/core.c:3848 [inline]
       __perf_event_task_sched_out+0x439/0x14e0 kernel/events/core.c:3953
       perf_event_task_sched_out include/linux/perf_event.h:1662 [inline]
       prepare_task_switch kernel/sched/core.c:5175 [inline]
       context_switch kernel/sched/core.c:5332 [inline]
       __schedule+0x3091/0x7fd0 kernel/sched/core.c:7188
       preempt_schedule_common+0x49/0xc0 kernel/sched/core.c:7369
       preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
       smp_call_function_single+0x54b/0x610 kernel/smp.c:704
       task_function_call+0xe4/0x170 kernel/events/core.c:123
       perf_install_in_context+0x2cb/0x570 kernel/events/core.c:3202
       __do_sys_perf_event_open+0x17ab/0x2a00 kernel/events/core.c:14162
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x121/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ctx->lock --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(&ctx->lock);

 *** DEADLOCK ***


The reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:8 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false HandleSegv:true Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
write$RDMA_USER_CM_CMD_LISTEN(0xffffffffffffffff, &(0x7f00000002c0)={0x7, 0x8, 0xfa00, {0xffffffffffffffff, 0x6}}, 0x10)
sendmsg$NL80211_CMD_SET_COALESCE(0xffffffffffffffff, &(0x7f00000002c0)={0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x44}, 0x60000084)
r0 = openat$rdma_cm(0xffffffffffffff9c, &(0x7f0000000080), 0x2, 0x0)
write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000300)={0x0, 0x18, 0xfa00, {0x1, &(0x7f00000002c0), 0x13f, 0x9}}, 0x20)
pkey_mprotect(&(0x7f0000000000/0x3000)=nil, 0x3000, 0xc, 0xffffffffffffffff)
perf_event_open(&(0x7f00000002c0)={0x5, 0x80, 0x40, 0x7, 0x7, 0xff, 0x0, 0x5, 0x180a08, 0xe, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x2, 0x0, 0x1, 0x1, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x1, 0x1, 0x0, 0x0, 0x1, 0x0, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0x3, 0x4, @perf_config_ext={0xf933, 0x3}, 0x1dec1, 0x246, 0x1, 0x5, 0xfffffffffffffff7, 0xffffffff, 0x6, 0x0, 0x6, 0x0, 0x3}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x2)


 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..6e689f2dafbd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3199,6 +3199,10 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_mb();
 again:
+	if (task == current) {
+		__perf_install_in_context(event);
+		return;
+	}
 	if (!task_function_call(task, __perf_install_in_context, event))
 		return;
 

base-commit: 33d8d8ec31b591952ded59d596c2f3db45004937
-- 
2.51.0

