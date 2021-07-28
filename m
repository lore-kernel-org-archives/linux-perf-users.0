Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63408C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C4F6101B
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhG1XCv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:02:51 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34718 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhG1XCs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jul 2021 19:02:48 -0400
Received: by mail-io1-f52.google.com with SMTP id y200so4675944iof.1;
        Wed, 28 Jul 2021 16:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+wbcr+VBTDUZpsNhwOBUg2XbpkNI7kdtS7DIAN1nS4=;
        b=p5GNR2RljaZFPNVr3PjgO6cJFiCB85DWGF5Q1ERJHEQYJluumpQ9SVT8EXJuCbKaXR
         xK5TZrTHV776dxzMa47zGDqSQD1qb5pqP5kjRDtFanUwFxaqNuY4CG0cC3+nbFei69oF
         PZxiNbnyhC07XBLUd6AKJiLkwRMYAEyZ46Oj16MrEH+gwPy7ido2Zv6ACnNLsKxhMpWF
         qfJqHJl8YO0DM+rpNvKeC00opOZUdKhQKiBPmm+KAnKxNSNB0UsyVlwGtcKfSqow0hoK
         TY6+MXAwkOft+FsQJw5LCmvNZvAMqQS+USxsD1KSbuG+gYwSyJk8fIgCgvXMY4u6KU1d
         aXPg==
X-Gm-Message-State: AOAM532uiPXuxtjNwy5B/Ajmh0jq7hEw57loYjrLhGE1RN7dB82Tgmcj
        UNfX0gIATSMRsTC6NDNnuw==
X-Google-Smtp-Source: ABdhPJw85aApxfcjzIRuCO0duB5kWC+cEDlFbc17PV/Mk8g7msGOrqqs8b4kuADa9AG4yBS4FRMFCg==
X-Received: by 2002:a5d:9648:: with SMTP id d8mr1441382ios.171.1627513365698;
        Wed, 28 Jul 2021 16:02:45 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j20sm974821ile.17.2021.07.28.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:02:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [RFC 3/3] perf/x86: Call mmap event callbacks on event's CPU
Date:   Wed, 28 Jul 2021 17:02:30 -0600
Message-Id: <20210728230230.1911468-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728230230.1911468-1-robh@kernel.org>
References: <20210728230230.1911468-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Mark suggested that mmapping of events should be treated like other
event changes in that the PMU callbacks run on the CPU the event is on.
Given that the only implementation of .event_(un)mapped() (on x86) end up
running on each CPU, this makes sense.

Since the .event_(un)mapped() callbacks are now called on multiple CPUs,
the tracking of enabling RDPMC is moved to the context in the perf core.
This allows removing perf_rdpmc_allowed, and for arm64 to share the same
user access tracking.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that the intent here is to only call event_mapped() on the first mmap
and event_unmapped on the last unmapping using the event->mmap_count. I'm
not sure if there's some flaw with that idea?


 arch/x86/events/core.c     | 38 +++++++-------------------
 arch/x86/include/asm/mmu.h |  1 -
 include/linux/perf_event.h |  7 +++--
 kernel/events/core.c       | 56 ++++++++++++++++++++++++++++++++------
 4 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5c1703206ef5..c755190c3970 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -753,9 +753,13 @@ static void perf_clear_dirty_counters(struct cpu_hw_events *cpuc)

 static void x86_pmu_set_user_access(struct cpu_hw_events *cpuc)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(cpuc->pmu->pmu_cpu_context);
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+
 	if (static_branch_unlikely(&rdpmc_always_available_key) ||
 	    (!static_branch_unlikely(&rdpmc_never_available_key) &&
-	     atomic_read(&(this_cpu_read(cpu_tlbstate.loaded_mm)->context.perf_rdpmc_allowed)))) {
+	     (atomic_read(&cpuctx->ctx.nr_user) ||
+	      (task_ctx && atomic_read(&task_ctx->nr_user))))) {
 		/*
 		 * Clear the existing dirty counters to
 		 * prevent the leak for an RDPMC task.
@@ -2522,34 +2526,12 @@ static void x86_pmu_set_user_access_ipi(void *unused)
 	x86_pmu_set_user_access(this_cpu_ptr(&cpu_hw_events));
 }

-static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
-{
-	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
-		return;
-
-	/*
-	 * This function relies on not being called concurrently in two
-	 * tasks in the same mm.  Otherwise one task could observe
-	 * perf_rdpmc_allowed > 1 and return all the way back to
-	 * userspace with CR4.PCE clear while another task is still
-	 * doing on_each_cpu_mask() to propagate CR4.PCE.
-	 *
-	 * For now, this can't happen because all callers hold mmap_lock
-	 * for write.  If this changes, we'll need a different solution.
-	 */
-	mmap_assert_write_locked(mm);
-
-	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
-		on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
-}
-
-static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+static void x86_pmu_event_map_changed(struct perf_event *event)
 {
-	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+	if (atomic_read(&event->ctx->nr_user) != 1)
 		return;

-	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
-		on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
+	x86_pmu_set_user_access_ipi(NULL);
 }

 static int x86_pmu_event_idx(struct perf_event *event)
@@ -2707,8 +2689,8 @@ static struct pmu pmu = {

 	.event_init		= x86_pmu_event_init,

-	.event_mapped		= x86_pmu_event_mapped,
-	.event_unmapped		= x86_pmu_event_unmapped,
+	.event_mapped		= x86_pmu_event_map_changed,
+	.event_unmapped		= x86_pmu_event_map_changed,

 	.add			= x86_pmu_add,
 	.del			= x86_pmu_del,
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..bd27fc666024 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -46,7 +46,6 @@ typedef struct {
 	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */

-	atomic_t perf_rdpmc_allowed;	/* nonzero if rdpmc is allowed */
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	/*
 	 * One bit per protection key says whether userspace can
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5815448ca9b..23944f9386b3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -329,10 +329,10 @@ struct pmu {

 	/*
 	 * Notification that the event was mapped or unmapped.  Called
-	 * in the context of the mapping task.
+	 * on each CPU the event is on.
 	 */
-	void (*event_mapped)		(struct perf_event *event, struct mm_struct *mm); /* optional */
-	void (*event_unmapped)		(struct perf_event *event, struct mm_struct *mm); /* optional */
+	void (*event_mapped)		(struct perf_event *event); /* optional */
+	void (*event_unmapped)		(struct perf_event *event); /* optional */

 	/*
 	 * Flags for ->add()/->del()/ ->start()/->stop(). There are
@@ -824,6 +824,7 @@ struct perf_event_context {
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
+	atomic_t			nr_user;
 	/*
 	 * Set when nr_events != nr_active, except tolerant to events not
 	 * necessary to be active due to scheduling constraints, such as cgroups.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 464917096e73..26c3fb962e4a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5988,6 +5988,48 @@ void ring_buffer_put(struct perf_buffer *rb)
 	call_rcu(&rb->rcu_head, rb_free_rcu);
 }

+static void __perf_event_mapped(struct perf_event *event,
+				 struct perf_cpu_context *cpuctx,
+				 struct perf_event_context *ctx,
+				 void *info)
+{
+	event->pmu->event_mapped(event);
+}
+
+static void perf_event_mapped(struct perf_event *event)
+{
+	struct perf_event_context *ctx;
+
+	if (!event->pmu->event_mapped || !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		return;
+
+	ctx = perf_event_ctx_lock(event);
+	event_function_call(event, __perf_event_mapped, NULL);
+	atomic_dec(&ctx->nr_user);
+	perf_event_ctx_unlock(event, ctx);
+}
+
+static void __perf_event_unmapped(struct perf_event *event,
+				 struct perf_cpu_context *cpuctx,
+				 struct perf_event_context *ctx,
+				 void *info)
+{
+	event->pmu->event_unmapped(event);
+}
+
+static void perf_event_unmapped(struct perf_event *event)
+{
+	struct perf_event_context *ctx;
+
+	if (!event->pmu->event_unmapped || !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
+		return;
+
+	ctx = perf_event_ctx_lock(event);
+	atomic_inc(&ctx->nr_user);
+	event_function_call(event, __perf_event_unmapped, NULL);
+	perf_event_ctx_unlock(event, ctx);
+}
+
 static void perf_mmap_open(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
@@ -5997,9 +6039,6 @@ static void perf_mmap_open(struct vm_area_struct *vma)

 	if (vma->vm_pgoff)
 		atomic_inc(&event->rb->aux_mmap_count);
-
-	if (event->pmu->event_mapped)
-		event->pmu->event_mapped(event, vma->vm_mm);
 }

 static void perf_pmu_output_stop(struct perf_event *event);
@@ -6021,9 +6060,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;

-	if (event->pmu->event_unmapped)
-		event->pmu->event_unmapped(event, vma->vm_mm);
-
 	/*
 	 * rb->aux_mmap_count will always drop before rb->mmap_count and
 	 * event->mmap_count, so it is ok to use event->mmap_mutex to
@@ -6056,6 +6092,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
 		goto out_put;

+	perf_event_unmapped(event);
+
 	ring_buffer_attach(event, NULL);
 	mutex_unlock(&event->mmap_mutex);

@@ -6330,6 +6368,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (atomic_read(&event->mmap_count) == 1)
+		perf_event_mapped(event);
+
 	mutex_unlock(&event->mmap_mutex);

 	/*
@@ -6339,9 +6380,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_ops = &perf_mmap_vmops;

-	if (event->pmu->event_mapped)
-		event->pmu->event_mapped(event, vma->vm_mm);
-
 	return ret;
 }

--
2.27.0
