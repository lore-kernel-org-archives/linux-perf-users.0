Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB117A2FC
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706497; cv=none; b=jQWFQAQObRwsgRZjYFJiXF47IBsLGTkXZ7ueuyiggJ7m4uRFDcSDo4w6a31HkPVsSi5ioWn5vQf5dry8zqq0dmHQsQZ0yDfy3RJTF/fkov3X/VW/1/sejHWyW7JwpmK7ys86wZZPBkFyJwnpoKOMh1FL9JSrPWj+Pa4VidEyMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706497; c=relaxed/simple;
	bh=uN1XIf9j3EMdH2lDUthVXiX8XqR1YNOhqPiJJ1Yexdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRHU0ClIzg40FHUl7zK5rZGE3lLf7160TZFh6AiK+Y61Ul6vnxBB03TZA0XuUpoxBgxhALJZ3h+tAZ1Xo9E8cELhFaSuj84tFrroWE2m3oFsJi9GPA63GlF3rICgYn0Ko2BV6AL/d7pCXXyvp1Bq59bMYgMeUjlS/mx+AEOWVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A6C2Pfgy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A6C2Pfgy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340e525487eso1465576a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Nov 2025 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762706495; x=1763311295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJYfd/k6hiGWNoGkFEOkKPXVXi0TBL8CCpdV4UfaIUU=;
        b=A6C2PfgykPfFKQ9+UpyaSqsXn2Y9jbP023k5b8qnJnqJ8W7U2orStq3jQRwSYz/rfG
         yUomKKbZyHv5qg3bQOHlIKV4yuCx91V75ciPKblYhGhOLPaRjpV0+EueVGrGXwTAsExN
         zQZzSxoP13xISSzfOUWFJOK1whE+/ECdmj7uVLxrYdBi4rRsMDZyaNQOE4edCpqwBsYF
         RnMDZx6SOx93t/SK7143kbsGzJhR7P22d5qQasAzqtr2IUalbK2rmTAZ/lgWonRrKwox
         fccbTIahQ7rkE8JG8p0vosZjKNGdGBCEJVdAYomSw80dVmVwGsxxeasI1qn/DWGuQY+9
         txow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762706495; x=1763311295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJYfd/k6hiGWNoGkFEOkKPXVXi0TBL8CCpdV4UfaIUU=;
        b=QaxUT4P7kHKUutDBKhAqYx6zY7xo1jG/JdVvwUUrqZuQBcE9nLlgvrRQXTb2vqCp1d
         mY0iBOi4lik27xCxurJsTWDMNp4DdUjYG8u6MBOIB+3AA8vvV4oJnC4bHj2keIoCYP5r
         NuTDzAWvqOCgw3Df4k36AefJGGTfCWODRyViMP6DlZGT4VTMGRX7P3wIoGMUNHbozoz0
         rUdW6Kv2xQe6F+d+0KeYULtbLqslNCcRIA85r1pgUWgOJmfkQ19D5gTpLLNWuX8SbS6+
         ikwXMU9sQSqPFYm/nB4u2Kqu8U3l2wkqHZGVy0Tg2gE2TAcXqAzeODGk3hJGo6K6j1SU
         1YGg==
X-Forwarded-Encrypted: i=1; AJvYcCVeZxSeR92RyqOX4n7uTo0uFr/yLMKutBUhwT2HLie8FlbT9aHR8PrYXw/b/UJfVUb95K8Owz7Cc4aEr253Vfhj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6bzGe6dQZ83BLbTZUOY/SKHovBNgXnmhUxDyMyaiLxqy8+aL
	X74xjl4GkI43mj3s7p58wnwdBpIdM81j/Y0+i5Twdos23yZnQGCSZtnycDOrGN/gECM=
X-Gm-Gg: ASbGncuKq44Gb7rA9aufJpY9CYml0rJo531DcCDaOvnF35SLjJ5u+258r9OjC6a84qT
	67faR/7ML/RsU/QFqx7Z0cGFcquIReWYONfZJDc+i7P2hVQ/M+oZ3FCquIDpR+lyqpl5MkdoKVt
	cH1aL5NR9HfZJCAA4KtStm3yQvF6gE66gEFZoz4VNh+8zAPztTKPiZgt2jl6wdAQw2zUqDgRfqV
	vsx0ZEPWtZKxo6tgEiDPOpU8jPYRvb7MdIYjb63kMIJwiGvFOJt5+J3uyp11CxHkB5f9dnqbzo9
	BUjuwlXqDKlS5/sOal88NXhcja59is+2Jne+XFful8exTwXOLszw4/lt5d0P/PmNrbTHUEzHklj
	x7FtoJaMaa6IDnTkZrDfds96uR3KEkFQ1xFlgKda6v81YQbrIguZqji3cXTD8FvW+gcJ0UkmWyL
	Q80LwXZxWFH1B7tysnN+ByEItadac6oli0J6Hd+ng1BehXFU1aYw==
X-Google-Smtp-Source: AGHT+IET/mGXD2ni7sWPyMN0C+P9SHk0+rmZ5fsof+JSnk24k+RKu+IfUR44fFUSHoQx02HLNj/hkQ==
X-Received: by 2002:a17:90b:57c4:b0:343:6af9:ad30 with SMTP id 98e67ed59e1d1-3436cd0e005mr6107745a91.34.1762706495237;
        Sun, 09 Nov 2025 08:41:35 -0800 (PST)
Received: from T179DVVMRY.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm4503347a91.19.2025.11.09.08.41.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Nov 2025 08:41:34 -0800 (PST)
From: Liangyan <liangyan.peng@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	bigeasy@linutronix.de,
	zengxianjun@bytedance.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liangyan <liangyan.peng@bytedance.com>
Subject: [PATCH v2] perf/core: Fix pending work re-queued in __perf_event_overflow
Date: Mon, 10 Nov 2025 00:41:22 +0800
Message-Id: <20251109164122.80138-1-liangyan.peng@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20251109103253.57081-1-liangyan.peng@bytedance.com>
References: <20251109103253.57081-1-liangyan.peng@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We got warning below during perf test.
[  467.100914] [      T1] WARNING: CPU: 0 PID: 1 at kernel/events/core.c:5147 put_pmu_ctx+0x2ef/0x3c0
[  467.107702] [      T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Kdump: loaded Tainted: G            E       6.18.0-rc4-dirty #114 PREEMPT(voluntary)
[  467.109835] [      T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1
[  467.111027] [      T1] RIP: 0010:put_pmu_ctx+0x2ef/0x3c0
[  467.122081] [      T1] Call Trace:
[  467.122463] [      T1]  <TASK>
[  467.124822] [      T1]  __free_event+0x337/0xa50
[  467.125306] [      T1]  perf_pending_task+0x10f/0x3b0
[  467.125824] [      T1]  task_work_run+0x140/0x210
[  467.127413] [      T1]  exit_to_user_mode_loop+0x10e/0x130
[  467.127965] [      T1]  do_syscall_64+0x26d/0x2e0
[  467.128453] [      T1]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  467.129025] [      T1] RIP: 0033:0x7f01d22349ca
[  467.135157] [      T1]  </TASK>

A race condition occurs between task context and IRQ context when
handling sigtrap tracepoint event overflows:

1. In task context, an event is overflowed and its pending work is
   queued to task->task_works
2. Before pending_work is set, the same event overflows in IRQ context
3. Both contexts queue the same perf pending work to task->task_works

This double queuing causes:
- task_work_run() enters infinite loop calling perf_pending_task()
- Potential warnings and use-after-free when event is freed in
perf_pending_task()

Fix the race by disabling interrupts during queuing of perf pending work.

The calltrace of re-queuing pending work is something like below.
[  466.979877] [      C0] CPU: 0 UID: 0 PID: 1 Comm: systemd Kdump: loaded Tainted: G            E       6.18.0-rc4-dirty #114 PREEMPT(voluntary)
[  466.979889] [      C0] Tainted: [E]=UNSIGNED_MODULE
[  466.979892] [      C0] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1
[  466.979897] [      C0] Call Trace:
[  466.979909] [      C0]  <IRQ>
[  466.979913] [      C0]  dump_stack_lvl+0x88/0xb0
[  466.979924] [      C0]  __perf_event_overflow+0xb4f/0xcb0
[  466.979972] [      C0]  perf_swevent_event+0x230/0x340
[  466.979980] [      C0]  perf_tp_event+0x412/0x910
[  466.980355] [      C0]  perf_trace_run_bpf_submit+0x103/0x190
[  466.980363] [      C0]  perf_trace_kmem_cache_alloc+0x156/0x1b0
[  466.980374] [      C0]  kmem_cache_alloc_noprof+0x214/0x600
[  466.980383] [      C0]  __alloc_object+0x2f/0x2d0
[  466.980392] [      C0]  __create_object+0x22/0x90
[  466.980402] [      C0]  kmem_cache_alloc_node_noprof+0x39d/0x620
[  466.980419] [      C0]  kmalloc_reserve+0x167/0x280
[  466.980428] [      C0]  __alloc_skb+0x12e/0x330
[  466.980466] [      C0]  napi_alloc_skb+0x147/0x270
[  466.980473] [      C0]  page_to_skb+0x171/0xaa0 [virtio_net]
[  466.980498] [      C0]  receive_buf+0x7c9/0x3ae0 [virtio_net]
[  466.980637] [      C0]  virtnet_poll+0xb98/0x3160 [virtio_net]
[  466.980749] [      C0]  __napi_poll+0xb0/0x5c0
[  466.980756] [      C0]  net_rx_action+0x416/0xbb0
[  466.980809] [      C0]  handle_softirqs+0x186/0x5d0
[  466.980818] [      C0]  __irq_exit_rcu+0x13f/0x180
[  466.980826] [      C0]  common_interrupt+0x7a/0xa0
[  466.980834] [      C0]  </IRQ>
[  466.980836] [      C0]  <TASK>
[  466.980839] [      C0]  asm_common_interrupt+0x22/0x40
[  466.980846] [      C0] RIP: 0010:delay_tsc+0x3a/0xa0
[  466.980854] [      C0] Code: 44 8b 05 ad 59 90 02 0f 01 f9 66 90 48 c1 e2 20 48 89 d7 48 09 c7 eb 21 65 ff 0d 91 59 90 02 74 57 f3 90 65 ff 05 86 59 90 02 <65> 8b 35 83 59 90 02 41 39 f0 75 28 41 89 f0 0f 01 f9 66 90 48 c1
[  466.980862] [      C0] RSP: 0018:ff110001009477e0 EFLAGS: 00000283
[  466.980869] [      C0] RAX: 000000fea17a6aa9 RBX: ff11000100a8c500 RCX: 0000000000000000
[  466.980874] [      C0] RDX: 000000000026df92 RSI: 0000000000000000 RDI: 000000fea1538b17
[  466.980878] [      C0] RBP: ff11001b3a03bb20 R08: 0000000000000000 R09: 0000000000af7a2e
[  466.980883] [      C0] R10: ff1100010093cc87 R11: 000000006a14397b R12: 1fe2200020128f03
[  466.980887] [      C0] R13: ff11000100a8c64c R14: ff11000100a8c600 R15: ff11000100a8c82c
[  466.980894] [      C0]  __perf_event_overflow+0x783/0xcb0
[  466.980937] [      C0]  perf_swevent_event+0x230/0x340
[  466.980944] [      C0]  perf_tp_event+0x412/0x910
[  466.981200] [      C0]  perf_trace_run_bpf_submit+0x103/0x190
[  466.981212] [      C0]  perf_trace_kmem_cache_alloc+0x156/0x1b0
[  466.981223] [      C0]  kmem_cache_alloc_noprof+0x214/0x600
[  466.981232] [      C0]  __alloc_object+0x2f/0x2d0
[  466.981241] [      C0]  __create_object+0x22/0x90
[  466.981251] [      C0]  __kmalloc_cache_noprof+0x405/0x640
[  466.981283] [      C0]  kmem_cache_free+0x18a/0x630
[  466.981300] [      C0]  __fput+0x5c4/0xa70
[  466.981310] [      C0]  fput_close_sync+0xf2/0x1f0
[  466.981336] [      C0]  __x64_sys_close+0x88/0xf0
[  466.981344] [      C0]  do_syscall_64+0x60/0x2e0
[  466.981351] [      C0]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  466.981357] [      C0] RIP: 0033:0x7f01d22349ca
[  466.981399] [      C0]  </TASK>

Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Reported-by: Xianjun Zeng <zengxianjun@bytedance.com>
Signed-off-by: Liangyan <liangyan.peng@bytedance.com>
---
v2: Use guard(irqsave) suggested by Peter.
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cae921f4d137..7c63e5fdd334 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10433,6 +10433,16 @@ static int __perf_event_overflow(struct perf_event *event,
 
 		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
 
+		/*
+		 * Task context queues the work via task_work_add() but has not yet
+		 * set event->pending_work when the same event overflows in
+		 * IRQ context. The IRQ path, seeing !event->pending_work,
+		 * queues the work again.
+		 * The double queuing causes corruption in task->task_works.
+		 * Prevent this by disabling interrupts around the critical section.
+		 */
+		guard(irqsave)();
+
 		if (!event->pending_work &&
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
-- 
2.39.3 (Apple Git-145)

