Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68627229B3D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597602; cv=none; b=Oe22BIZrDRwB04a0vcwMdpripCutC/A4Ls/8dABu+wZsYva02p8yJlKCP2ySF5z0dxMJukZ2QilJdXW4L0HIPhN4tSttsgctFaJuliOcKbx6zH1Ydr4qjEHB1fgSHgQa10YeW+Ikm3FZUv1VsDNdMQatYk/ZTYzzwDAf3KvyXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597602; c=relaxed/simple;
	bh=/coDkbmv4cf7oezrwY1QvpvI3EAobs0jwEpk59sloz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N85oqJ0ZznO3nPpUxquQ2xmN73aKczhNlgXAKz5Plm660lj+2Ei4cFZ/63uWrFp2eJ/dLfhOQOVN3f3HCNN7HR0aOF15GiEsMVBnIfsDVem3vmuBChRojcGeGMG+SnsL8nn3779rOyQODo/4ysEdSd7V3CwYJMzXIw4jTlQ4ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Iabt5j9d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Iabt5j9d"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c336fcdaaso17079895ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597599; x=1749202399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfNjslNRihNfiwS5akxUBJSCwiXFfcNf3iOCsj/nqzk=;
        b=Iabt5j9dK9glJJBOhTe35ftUFRbR4Yr7rMXyySnHDVdV3laIIN62yErWTq/EklGARb
         5W/xFj0dn7pWBANxln+62SH1rmv6mx/4hJFvALJDcvZtsizrZelhkSY3jOL9pC5NGoUa
         Ed8LEGXL9b4stXrsBJF9Uu2jA+P/8uaQP4lBRgOg12twY82gifzZ7yEFP3B6XS8zzOV6
         OsXF6EjZLg/hrXjFcUPZt6lxUiPqDQmQb40lH0DWAiEZ0H6D7cFvRFVIIoIx/9oLb1mZ
         jFFydyUYRHXSbaucuqsudcDPYhAFcZcSQmesFbpYKLeiqxEsMfX98ougqI03ppz0rAjP
         44KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597599; x=1749202399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfNjslNRihNfiwS5akxUBJSCwiXFfcNf3iOCsj/nqzk=;
        b=KkJHx+LQOSSW8gxoPyJcpGYfyIhbYy8oUWFHX2u6YmMjP8r98Yvl0H+YZUmVa6a6rA
         SoNf6KbjeH2T5CrmH1FgzmIXHRhv3dQ5qoJd7jH3ioMAouwANN2nzzHj+NiMakhJqnEo
         s+P2wrS3mKbhhHKCrjHu8DLtXuwT/yqFKsRQFyDwhfYUJjggW6l/ZP1yTP0/itYeLE7M
         nSioCnVOhf5aFdFBjJAFH7r88eVprRV1CAAdexFTQ2nMxpdZheblGjuFTJ+orFMB8qNV
         a3bEwDUe3wCalPDMYErspGvlqEtqP0XEynnLgE3eJk/UZ9Li8iyng74+uHwIF3fY5EB1
         +Ifg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0VSMIPQu9ccXUBFaACsGJvdCgYoF2XyJgbIcFy7OTHiptYhyqfx7giJS5p3hQshezBWQJN/JuJ/kW/8LMzRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjh2j3lLbNo/eXoXkj9WEuJv7auhz/yVU7+neQV8llbCQ1ftVG
	Cw9S2HMAF47H8SIichZ39opiglD/+OYhjn+8PLVMXdV5jJKkjoJMcxwgJ4E8Eh6TBDE=
X-Gm-Gg: ASbGncssG+ue3K11dT91yYsl4vmA8vTnVdvT0RGR2bAW6rQSjN2bqN2RIQnXZ5hQ3WQ
	+haIy1A6J/EF/tzSUs/qa68GrvwtrmfGmHfihLdWcBCyBCw2ruMmzwxsFiV6d3Jn9xsGVHQdRLa
	zsiP2hARW1lYd/1GwG8WagbrAdM0Fcses1P/D3opRL30FgRNTjOhxpUa0WH2Vyw4sc2uxOH50J3
	7K14qYS1S6ojmcP2AUDztGau1tQdZ7d66v8fSmooCbCINugXVFqI9Dwvm+HHaHR5GFUPn0Av0S0
	7WG4kJ207mn9LO2Z6To8TnXsJzB2W03B6AgH/h3CsHhR3hKarBg25Ra8J7XODX7jUdEv2NbVjXC
	WMHzumeiRYw==
X-Google-Smtp-Source: AGHT+IEyXGYQ2GCz5bdSvzR+T/Z8enoWNYF8Thjcb9xcpCHkk9mGcXueyM6Xj7aL+U99FPOWwALWDw==
X-Received: by 2002:a17:90b:3e45:b0:311:a623:676c with SMTP id 98e67ed59e1d1-31241e8d325mr4349242a91.27.1748597598509;
        Fri, 30 May 2025 02:33:18 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.33.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:33:18 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 19/35] RPAL: add lazy switch main logic
Date: Fri, 30 May 2025 17:27:47 +0800
Message-Id: <91e9db5ad4a3e1e58a666bd496e55d8f8db2c63c.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of lazy switch differs from a regular schedule() in
three key aspects:

1. It occurs at the kernel entry with irq disabled.
2. The next task is explicitly pre-determined rather than selected by
   the scheduler.
3. User-space context (excluding general-purpose registers) remains
   unchanged across the switch.

This patch introduces the rpal_schedule() interface to address these
requirements. Firstly, the rpal_schedule() skips irq enabling in
finish_lock_switch(), preserving the irq-disabled state required
during kernel entry. Secondly, the rpal_pick_next_task() interface is
used to explicitly specify the target task, bypassing the default
scheduler's decision-making process. Thirdly, non-general-purpose
registers (e.g., FPU, vector units) are not restored during the switch,
ensuring user space context remains intact. Handling of general-purpose
registers will be addressed in a subsequent patch by RPAL before invoking
rpal_schedule().

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/process_64.c |  75 +++++++++++++++++++++
 include/linux/rpal.h         |   3 +
 kernel/sched/core.c          | 126 +++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4830e9215de7..efc3f238c486 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -753,6 +753,81 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	return prev_p;
 }
 
+#ifdef CONFIG_RPAL
+__no_kmsan_checks
+__visible __notrace_funcgraph struct task_struct *
+__rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p)
+{
+	struct thread_struct *prev = &prev_p->thread;
+	struct thread_struct *next = &next_p->thread;
+	int cpu = smp_processor_id();
+
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
+		     this_cpu_read(hardirq_stack_inuse));
+
+	/* no need to switch fpu */
+	/* __fpu_invalidate_fpregs_state() */
+	x86_task_fpu(prev_p)->last_cpu = -1;
+	/* fpregs_activate() */
+	__this_cpu_write(fpu_fpregs_owner_ctx, x86_task_fpu(next_p));
+	trace_x86_fpu_regs_activated(x86_task_fpu(next_p));
+	x86_task_fpu(next_p)->last_cpu = cpu;
+	set_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD);
+	clear_tsk_thread_flag(next_p, TIF_NEED_FPU_LOAD);
+
+	/* no need to save fs */
+	savesegment(gs, prev_p->thread.gsindex);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		prev_p->thread.gsbase = __rdgsbase_inactive();
+	else
+		save_base_legacy(prev_p, prev_p->thread.gsindex, GS);
+
+	load_TLS(next, cpu);
+
+	arch_end_context_switch(next_p);
+
+	savesegment(es, prev->es);
+	if (unlikely(next->es | prev->es))
+		loadsegment(es, next->es);
+
+	savesegment(ds, prev->ds);
+	if (unlikely(next->ds | prev->ds))
+		loadsegment(ds, next->ds);
+
+	/* no need to load fs */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		if (unlikely(prev->gsindex || next->gsindex))
+			loadseg(GS, next->gsindex);
+
+		__wrgsbase_inactive(next->gsbase);
+	} else {
+		load_seg_legacy(prev->gsindex, prev->gsbase, next->gsindex,
+				next->gsbase, GS);
+	}
+
+	/* skip pkru load as we will use pkru in RPAL */
+
+	this_cpu_write(current_task, next_p);
+	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
+
+	/* no need to load fpu */
+
+	update_task_stack(next_p);
+	switch_to_extra(prev_p, next_p);
+
+	if (static_cpu_has_bug(X86_BUG_SYSRET_SS_ATTRS)) {
+		unsigned short ss_sel;
+
+		savesegment(ss, ss_sel);
+		if (ss_sel != __KERNEL_DS)
+			loadsegment(ss, __KERNEL_DS);
+	}
+	resctrl_sched_in(next_p);
+
+	return prev_p;
+}
+#endif
+
 void set_personality_64bit(void)
 {
 	/* inherit personality from parent */
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 45137770fac6..0813db4552c0 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -487,4 +487,7 @@ int rpal_try_to_wake_up(struct task_struct *p);
 int rpal_init_thread_pending(struct rpal_common_data *rcd);
 void rpal_free_thread_pending(struct rpal_common_data *rcd);
 int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock);
+void rpal_schedule(struct task_struct *next);
+asmlinkage struct task_struct *
+__rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e76376c5172..760d88458b39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6827,6 +6827,12 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	if (unlikely(is_special_task_state(task_state)))
 		flags |= DEQUEUE_SPECIAL;
 
+#ifdef CONFIG_RPAL
+	/* DELAY_DEQUEUE will cause CPU stalls after lazy switch, skip it */
+	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT))
+		flags |= DEQUEUE_SPECIAL;
+#endif
+
 	/*
 	 * __schedule()			ttwu()
 	 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -11005,6 +11011,62 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #ifdef CONFIG_RPAL
+static struct rq *rpal_finish_task_switch(struct task_struct *prev)
+	__releases(rq->lock)
+{
+	struct rq *rq = this_rq();
+	struct mm_struct *mm = rq->prev_mm;
+
+	if (WARN_ONCE(preempt_count() != 2*PREEMPT_DISABLE_OFFSET,
+		      "corrupted preempt_count: %s/%d/0x%x\n",
+		      current->comm, current->pid, preempt_count()))
+		preempt_count_set(FORK_PREEMPT_COUNT);
+
+	rq->prev_mm = NULL;
+	vtime_task_switch(prev);
+	perf_event_task_sched_in(prev, current);
+	finish_task(prev);
+	tick_nohz_task_switch();
+
+	/* finish_lock_switch, not enable irq */
+	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	__balance_callbacks(rq);
+	raw_spin_rq_unlock(rq);
+
+	finish_arch_post_lock_switch();
+	kcov_finish_switch(current);
+	kmap_local_sched_in();
+
+	fire_sched_in_preempt_notifiers(current);
+	if (mm) {
+		membarrier_mm_sync_core_before_usermode(mm);
+		mmdrop(mm);
+	}
+
+	return rq;
+}
+
+static __always_inline struct rq *rpal_context_switch(struct rq *rq,
+						      struct task_struct *prev,
+						      struct task_struct *next,
+						      struct rq_flags *rf)
+{
+	/* irq is off */
+	prepare_task_switch(rq, prev, next);
+	arch_start_context_switch(prev);
+
+	membarrier_switch_mm(rq, prev->active_mm, next->mm);
+	switch_mm_irqs_off(prev->active_mm, next->mm, next);
+	lru_gen_use_mm(next->mm);
+
+	switch_mm_cid(rq, prev, next);
+
+	prepare_lock_switch(rq, next, rf);
+	__rpal_switch_to(prev, next);
+	barrier();
+	return rpal_finish_task_switch(prev);
+}
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct task_struct *
 __rpal_pick_next_task(struct rq *rq, struct task_struct *prev,
@@ -11214,4 +11276,68 @@ rpal_pick_next_task(struct rq *rq, struct task_struct *prev,
 	BUG();
 }
 #endif
+
+/* enter and exit with irqs disabled() */
+void __sched notrace rpal_schedule(struct task_struct *next)
+{
+	struct task_struct *prev, *picked;
+	bool preempt = false;
+	unsigned long *switch_count;
+	unsigned long prev_state;
+	struct rq_flags rf;
+	struct rq *rq;
+	int cpu;
+
+	/* sched_mode = SM_NONE */
+
+	preempt_disable();
+
+	trace_sched_entry_tp(preempt, CALLER_ADDR0);
+
+	cpu = smp_processor_id();
+	rq = cpu_rq(cpu);
+	prev = rq->curr;
+
+	schedule_debug(prev, preempt);
+
+	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
+		hrtick_clear(rq);
+
+	rcu_note_context_switch(preempt);
+	rq_lock(rq, &rf);
+	smp_mb__after_spinlock();
+
+	rq->clock_update_flags <<= 1;
+	update_rq_clock(rq);
+	rq->clock_update_flags = RQCF_UPDATED;
+
+	switch_count = &prev->nivcsw;
+
+	prev_state = READ_ONCE(prev->__state);
+	if (prev_state) {
+		try_to_block_task(rq, prev, &prev_state);
+		switch_count = &prev->nvcsw;
+	}
+
+	picked = rpal_pick_next_task(rq, prev, next, &rf);
+	rq_set_donor(rq, next);
+	if (unlikely(next != picked))
+		panic("rpal error: next != picked\n");
+
+	clear_tsk_need_resched(prev);
+	clear_preempt_need_resched();
+	rq->last_seen_need_resched_ns = 0;
+
+	rq->nr_switches++;
+	RCU_INIT_POINTER(rq->curr, next);
+	++*switch_count;
+	migrate_disable_switch(rq, prev);
+	psi_account_irqtime(rq, prev, next);
+	psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
+					     prev->se.sched_delayed);
+	trace_sched_switch(preempt, prev, next, prev_state);
+	rq = rpal_context_switch(rq, prev, next, &rf);
+	trace_sched_exit_tp(true, CALLER_ADDR0);
+	preempt_enable_no_resched();
+}
 #endif
-- 
2.20.1

