Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AF22ACD1
	for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597616; cv=none; b=TjM4oyk8fs9urPSpTj8B4HJ0Elv6m+UgLWqvXOYkAZ7L6VMfVBNR5P7CHBhE+GelOTMZPcvOAGrqsgmglRxcT7zKdwNWWxlBMG2vmo+Eu+uEGfGJMO2aT37h7NO89SyaxmToAiDbo2DaSZbdcrK3D4rzTpt2OvXvEkxatL8bpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597616; c=relaxed/simple;
	bh=46IfJD6O+6SqRHValc80DBFn7y6T8YogODhoWzSz5NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DhzL+8mKKCmKN5XtflpdhCiDoI6fyTGxnS2r1cznn0VupA+C772gpKoohLQm6YBAsydkLd3aklwhkLviNuTHg1qRqg6GMNTpfbeffIc02VgFYLVPaCbdw8OnWkM74gc19qOHF+//9Yw8mWDtGy9Sbhf0II8ynsHR8lwgOtbnyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hvzumzsQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hvzumzsQ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so1404762a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 30 May 2025 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597614; x=1749202414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlVLKhSr7F4Ter0cssioRNY+mLV+eE5Kw7Y7qzhdKJU=;
        b=hvzumzsQd/1QOcNR9/uhM+UmOTvrOHgj5CQds8LFcKMO4yHbvfVDmRmkOK6fP31723
         a2Dw4rKLbTbq4oEyVstg0aHaELNgWLSLwt/7MEYhDfeB0QEX+BXX1stuyUxLyqQGyo11
         9aQUDCFWq+umcopDz9cMCi2RvOn24YCWUXNoMNZjBGJkZrXZPL5K+Dj9JRvaI1x+t6Vs
         xDRt/xrw6eyF8CKrIHUAIZibeDJ1LTOWDp+mO2BGmW1JbiFtF9QYH/CW15U1wVOmukrA
         UGCsxW1tIxdx89/BGZ2+wPJom/pKhj/+A792P8wSh0ggoSYui8F4AfSIBX2lgiNEx966
         iTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597614; x=1749202414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlVLKhSr7F4Ter0cssioRNY+mLV+eE5Kw7Y7qzhdKJU=;
        b=r+c+Rffqy6mNYoKu4wD1PkuF/Rppt3AQuyT0bHUKW9v0zvTqfvzLUN4+gQjq4YTP34
         NNKi77W3FghDvscFNNlR3q8rDhB/7Tb896VgooAJx8r8zMw/v2ztU2NY+/+G9TFYt/aG
         FiCjmKYr/Lly1SJwHc46LUZTRzMep1YF7rwwqsDGvpJO5lUaiqzl8MUyYVGH7V6a7xCW
         93oodvd9Z5GATBeQ9ZNL/oD0iExfSYPwWo3yPlIJONqmLDVYANe73XMbnzE61iRdrv0+
         4dBhgL/KTpG1BlKLpvX8qumWXXkjHcxFN9wDc+lKbIa/k5fc9X3cuyYtGG/S7qdMiyus
         CFfw==
X-Forwarded-Encrypted: i=1; AJvYcCVLfXFWkhL8vQMYV3Cb4CWVcji2Fcd0x3Ufo4eaTzwD3nET2gBKJb3n3RLA4NNVIFWPQXf0bZ9yHhV9Egb94A8F@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6YrUhvqK9VLb2CVYfMFsVZ+3atQHG+91bPpvj0nx2Qgd8D4s
	IT9moRx8lK5G040Arm3iiU57oaek8MVYft+nzVtQNCmVwB39Jh07EmuZ4KupInbensQ=
X-Gm-Gg: ASbGncvbALOolqaBA9o+vBk32qqftES8MPhAd4GrYYvOouISbjbtrRssfE7+EvbaLvp
	r87st4oFgMMM91enY1XsC/CdXz+bAlvIdIOLqeSWkew1ChWPhYS2ehC83WdigWk+JxMW4fNlo2/
	D5FUSDMj3kONu2NiCWo2VMd+/uBmjs6jwV+t7WLwS7HE8eZ2puQXgaHuhHZMTsRC0uPLxTk3ALS
	77mFUeuSdT9EmYd4EOtHEESjU/gGcxR1Gk2KZT0ldqMcoiI4kIcMAaBTRXA36NDp33VQC52Xfj2
	NERbtNhU4+Y3UXEzX3n0/KdQnnwbPik0+jg1YD3otZYfKkDRG5yUW1X5W3NOUxIJ9rvorp5pjZH
	I61zNcjNoqw==
X-Google-Smtp-Source: AGHT+IF9UpDBed3ioNwTFOPq4QXc23on+j+5SNtglVD6Wkl9cnonPhoeqxqRBdAvjyhyCYWucdvIFA==
X-Received: by 2002:a17:90a:e708:b0:311:a314:c2d1 with SMTP id 98e67ed59e1d1-3124150e443mr4004525a91.6.1748597613983;
        Fri, 30 May 2025 02:33:33 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.33.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:33:33 -0700 (PDT)
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
Subject: [RFC v2 20/35] RPAL: add rpal_ret_from_lazy_switch
Date: Fri, 30 May 2025 17:27:48 +0800
Message-Id: <4cd58d0e989640f0c230196e81cec5cee0ceb476.1748594841.git.libo.gcs85@bytedance.com>
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

After lazy switch the task before the lazy switch will lose its user mode
context (which is passed to the task after the lazy switch). Therefore,
RPAL needs to handle the issue of the previous task losing its user mode
context.

After the lazy switch occurs, the sender can resume execution in two ways.
One way is to be scheduled by the scheduler. In this case, RPAL handles
this issue in a manner similar to ret_from_fork. the sender will enter
rpal_ret_from_lazy_switch through the constructed stack frame by lazy
switchto execute the return logic and finally return to the pre-defined
user mode (referred to as "kernel return"). The other way is to be switched
back to by the receiver through another lazy switch. In this case, the
receiver will pass the user mode context to the sender, so there is no need
to construct a user mode context for the sender. And the receiver can
return to the user mode through the kernel return method.

rpal_ret_from_lazy_switch primarily handles scheduler cleanup work, similar
to schedule_tail(), but does not perform set_child_tid-otherwise, it might
cause set_child_tid to be executed repeatedly. It then calls
rpal_kernel_ret(), which is primarily used to set the states of the sender
and receiver and attempt to unlock the CPU. Finally, it performs syscall
cleanup work and returns to user mode.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/entry/entry_64.S | 23 ++++++++++++++++++++
 arch/x86/rpal/core.c      | 45 +++++++++++++++++++++++++++++++++++++--
 include/linux/rpal.h      |  5 ++++-
 kernel/sched/core.c       | 25 +++++++++++++++++++++-
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ed04a968cc7d..13b4d0684575 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -169,6 +169,29 @@ SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
 	int3
 SYM_CODE_END(entry_SYSCALL_64)
 
+#ifdef CONFIG_RPAL
+SYM_CODE_START(rpal_ret_from_lazy_switch)
+	UNWIND_HINT_END_OF_STACK
+	ANNOTATE_NOENDBR
+	movq	%rax, %rdi
+	call	rpal_schedule_tail
+
+	movq	%rsp, %rdi
+	call	rpal_kernel_ret
+
+	movq	%rsp, %rdi
+	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
+
+	UNWIND_HINT_REGS
+#ifdef CONFIG_X86_FRED
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp asm_fred_exit_user", X86_FEATURE_FRED
+#else
+	jmp	swapgs_restore_regs_and_return_to_usermode
+#endif
+SYM_CODE_END(rpal_ret_from_lazy_switch)
+#endif
+
 /*
  * %rdi: prev task
  * %rsi: next task
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 19c4ef38bca3..ed4c11e6838c 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -18,7 +18,7 @@ unsigned long rpal_cap;
 
 static inline void rpal_lock_cpu(struct task_struct *tsk)
 {
-	rpal_set_cpus_allowed_ptr(tsk, true);
+	rpal_set_cpus_allowed_ptr(tsk, true, false);
 	if (unlikely(!irqs_disabled())) {
 		local_irq_disable();
 		rpal_err("%s: irq is enabled\n", __func__);
@@ -27,13 +27,54 @@ static inline void rpal_lock_cpu(struct task_struct *tsk)
 
 static inline void rpal_unlock_cpu(struct task_struct *tsk)
 {
-	rpal_set_cpus_allowed_ptr(tsk, false);
+	rpal_set_cpus_allowed_ptr(tsk, false, false);
 	if (unlikely(!irqs_disabled())) {
 		local_irq_disable();
 		rpal_err("%s: irq is enabled\n", __func__);
 	}
 }
 
+static inline void rpal_unlock_cpu_kernel_ret(struct task_struct *tsk)
+{
+	rpal_set_cpus_allowed_ptr(tsk, false, true);
+}
+
+void rpal_kernel_ret(struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct rpal_receiver_call_context *rcc;
+	int state;
+
+	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
+		rcc = current->rpal_rd->rcc;
+		atomic_xchg(&rcc->receiver_state, RPAL_RECEIVER_STATE_KERNEL_RET);
+	} else {
+		tsk = current->rpal_sd->receiver;
+		rcc = tsk->rpal_rd->rcc;
+		rpal_clear_task_thread_flag(tsk, RPAL_LAZY_SWITCHED_BIT);
+		state = atomic_xchg(&rcc->sender_state, RPAL_SENDER_STATE_KERNEL_RET);
+		WARN_ON_ONCE(state != RPAL_SENDER_STATE_CALL);
+		/* make sure kernel return is finished */
+		smp_mb();
+		WRITE_ONCE(tsk->rpal_rd->sender, NULL);
+		/*
+		 * We must unlock receiver first, otherwise we may unlock
+		 * receiver which is already locked by another sender.
+		 *
+		 *  Sender A			Receiver B      Sender C
+		 *	lazy switch (A->B)
+		 *  kernel return
+		 *      unlock cpu A
+		 *                      epoll_wait
+		 *                                         lazy switch(C->B)
+		 *                                         lock cpu B
+		 *		unlock cpu B
+		 *						BUG()			BUG()
+		 */
+		rpal_unlock_cpu_kernel_ret(tsk);
+		rpal_unlock_cpu_kernel_ret(current);
+	}
+}
 
 static inline struct task_struct *rpal_get_sender_task(void)
 {
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 0813db4552c0..01b582fa821e 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -480,14 +480,17 @@ int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 					 unsigned long addr, int error_code);
 struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild);
 struct task_struct *rpal_find_next_task(unsigned long fsbase);
+void rpal_kernel_ret(struct pt_regs *regs);
 
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
 	struct rlimit *rlim_stack);
 int rpal_try_to_wake_up(struct task_struct *p);
 int rpal_init_thread_pending(struct rpal_common_data *rcd);
 void rpal_free_thread_pending(struct rpal_common_data *rcd);
-int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock);
+int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock,
+	bool is_kernel_ret);
 void rpal_schedule(struct task_struct *next);
 asmlinkage struct task_struct *
 __rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p);
+asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 760d88458b39..0f9343698198 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3181,7 +3181,8 @@ void rpal_free_thread_pending(struct rpal_common_data *rcd)
 /*
  * CPU lock is forced and all cpumask will be ignored by RPAL temporary.
  */
-int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock)
+int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock,
+							 bool is_kernel_ret)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	struct set_affinity_pending *pending = p->rpal_cd->pending;
@@ -3210,6 +3211,9 @@ int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock)
 		rpal_clear_task_thread_flag(p, RPAL_CPU_LOCKED_BIT);
 	}
 
+	if (is_kernel_ret)
+		return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
+
 	update_rq_clock(rq);
 
 	if (cpumask_equal(&p->cpus_mask, ac.new_mask))
@@ -11011,6 +11015,25 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #ifdef CONFIG_RPAL
+asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev)
+	__releases(rq->lock)
+{
+	/*
+	 * New tasks start with FORK_PREEMPT_COUNT, see there and
+	 * finish_task_switch() for details.
+	 *
+	 * finish_task_switch() will drop rq->lock() and lower preempt_count
+	 * and the preempt_enable() will end up enabling preemption (on
+	 * PREEMPT_COUNT kernels).
+	 */
+
+	finish_task_switch(prev);
+	trace_sched_exit_tp(true, CALLER_ADDR0);
+	preempt_enable();
+
+	calculate_sigpending();
+}
+
 static struct rq *rpal_finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
-- 
2.20.1

