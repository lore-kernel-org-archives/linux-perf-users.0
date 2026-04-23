Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CE1F3BA4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905003; cv=none; b=C6M2LhkpFEVl5UqtAICxosIqvMJuCrwRwznIRpzGKIZXg0/o09UhAc8AI51mtLtaDOXIlCUfWIoB6VrNYjZ6+I9eb4NT1uVfXneNryytPRO5GHkJg1pWO8mTCqqKajeWunmtBlUQfxKDlJHUVlSqIO7/3+pTQs6gqeq77PPl9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905003; c=relaxed/simple;
	bh=jZd45ZdUB7d8PBIX0VwBunnG1rIf+cmqKA66rheBVy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMHloiPbPMD4hGo1H0/eESFdfLKJdUn8l5NdY08FIzzakTvyC4O5AGJxnUVgJpPhD4SDrtdnvXdmJ66HQPYEYDXwelzBRzL0atBwjg8fJmN6OWJleGTP6Mup/60dP7en/EfWPG907INUu5tsUJqO8ArUY3n0zAmlCbPjs4QxvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0WvlE1D; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0WvlE1D"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35e576110adso4117181a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776905001; x=1777509801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtalh6zbKNjbvuq2euPG1xhgePyOONZZRM8Q06aWf/Y=;
        b=q0WvlE1DWPeOeGNzoGrvu3VZ3u6KnWJFK4d5acmlQsVMCsibPxqfo7gYwREYZOgA08
         mgsfkev0Bh5bv0HR746N93+6Oud5SRGwY4u6+cZT/OhQR+MdS2jJXAlzW3L00Gh3lqmR
         7Cf09UiiKz+cuxjT9NyogRJcnNMM1QOjdUko/W+qYRP4NUJDBo09K/Ivi9aAs8wwiyaj
         zaj9Kc7Q4cjpZjd/2jh8QS8PFAeOZyY0TEVlbuAPz+pRLvI09KzzVua1MXr29vwnrpES
         oxAIw2Z7zeK1NfWXs5CIc1PnZySxMWLg5yGjtVxVTCK/Utz4EbNX5KsGA+bsRmxNeeh3
         TA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776905001; x=1777509801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtalh6zbKNjbvuq2euPG1xhgePyOONZZRM8Q06aWf/Y=;
        b=MdkjQGA91vfd/rJXLHgu3TxIoJb/AKgTok1v06GMv51Rm3sF47x5iSEtgYhVQ14E8C
         zrDS1cw4zhLQ08SUmOE8Z7Cv3p2fz0SOvZ/ls2PiARGdvg8AJNalQdL+9vx6liA+W7HP
         hb1nWzhbc10IMbXAdLapNxMZQPClvQWe3nzGv/mtiEIT3qcReKzWSxx9c+FxNnEQr3Ks
         GUkj6CIZPRI7Urdi7cJWebM0jjk311u2kFf+eMEFcgKRTgwbpvVcNqYw7R+hofB9RYvt
         gjK3AbuqmAnFw8d7p06WtdtJfKZ9zPJb57Bn7P+UxpzPNs/mwEuOyaejuYZYmdGpUl74
         2cvg==
X-Gm-Message-State: AOJu0YyEEwc5AXL9vO4SMac+Vjero2SUJVqurGoHmgWSrRCO1hWRrXM8
	ssn5US6T9zc1xdNKN6uxslKmjmnGG7EltQdAb9fv6tZYk//VsN6QNo/HNqYl4w==
X-Gm-Gg: AeBDieuJRuo1v1fYuhDP89wZZYom7ucYPwMoOzwx4xEyq0YVb2nsV/3DxoXxYnyK6oi
	8YVV8cA5kNuhC+4gxAqm/a8uyBgCMhaO1cW6XMT4CrkzrJmOlpiqM8fnlFsg0KeKXJQ/K0B/w/7
	1oeQMr506jr/xf6JH8zQ/6uyD2BtpW05+AyXVxfZQLi8CfGZLv4wZCa0ar0kRtXATtWSVOZrgU3
	33wftMzdwZ+qCkY3c4aDAtFlgx7VuAs6El1No6UX83fs60aVOanPMHr3HXVax5/CZ6w7zqkZlb6
	3q9SgFQMwMD8wVC3jCwt8vs6DWq+lcBsqLJTwOooz0FZZaGfNkYh1rz55xHawVkWqmZiMUXCPCG
	83pJKw0cSl4We8n3zNkRhNtIezQC1lqGL1gAt0BjnGLZOe6erdkXLZIY1nwFJgAJ3IyIh6ManxR
	4hFxaJtW1qESj6tWcSrIDSpcdaDybjU+5Oo8LKRXEY/7IrA6uN
X-Received: by 2002:a17:90b:4a51:b0:35b:939c:e859 with SMTP id 98e67ed59e1d1-3614029b0d0mr21493410a91.12.1776905001292;
        Wed, 22 Apr 2026 17:43:21 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:963d:c5da:6762:8843])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4bf7bsm176724085ad.81.2026.04.22.17.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 17:43:20 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org,
	sj@kernel.org,
	akinobu.mita@gmail.com
Subject: [RFC PATCH v3 3/4] mm/damon/vaddr: support perf event based access check
Date: Thu, 23 Apr 2026 09:42:09 +0900
Message-ID: <20260423004211.7037-4-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423004211.7037-1-akinobu.mita@gmail.com>
References: <20260423004211.7037-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds perf event based access check for virtual address space
monitoring.

The perf event that can be specified for perf event-based access check
must be able to obtain the data source address corresponding to the
sample.  In other words, PERF_SAMPLE_DATA_SRC must be able to be
specified in perf_event_attr.sample_type

The perf event based access check is performed as follows:

1. During the sampling interval, samples of the perf event are stored in
   a sampling buffer.

2. After the sampling interval ends, during the access check, a
   histogram showing the number of accesses to each memory address is
   generated based on each sample contained in the sampling buffer.

If the sampling buffer is full during a sampling interval, the sampling
buffer is expanded to prepare for the next sampling interval.

If you configure the memory addresses corresponding to the perf event
samples to be obtained as virtual addresses, the histogram is
implemented as a two-dimensional xarray indexed by pid and virtual
memory address.

If you configure perf event samples to have their corresponding memory
addresses retrieved by physical addresses, the histogram is implemented
using an xarray indexed by physical addresses.

3. For each monitoring target region, the number of accesses is updated
   based on the histogram.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/core.c       |  42 ++++-
 mm/damon/ops-common.h |  24 +++
 mm/damon/vaddr.c      | 348 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 412 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 220b105482da..def72672982a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3014,6 +3014,40 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	}
 }
 
+static void kdamond_prepare_perf_event_report(struct damon_ctx *ctx)
+{
+	struct damon_perf_event *event;
+
+	list_for_each_entry(event, &ctx->perf_events, list)
+		damon_perf_prepare_access_checks(ctx, event);
+}
+
+static unsigned int kdamond_check_perf_event_reported_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_perf_event *event;
+	unsigned int max_nr_accesses = 0;
+
+	if (damon_target_has_pid(ctx)) {
+		list_for_each_entry(event, &ctx->perf_events, list)
+			damon_va_perf_check_accesses(ctx, event);
+	}
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		damon_for_each_region(r, t) {
+			if (r->access_reported)
+				r->access_reported = false;
+			else
+				damon_update_region_access_rate(r, false, &ctx->attrs);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -3057,13 +3091,17 @@ static int kdamond_fn(void *data)
 		if (kdamond_wait_activation(ctx))
 			break;
 
-		if (ctx->ops.prepare_access_checks)
+		if (!list_empty(&ctx->perf_events))
+			kdamond_prepare_perf_event_report(ctx);
+		else if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
 
-		if (ctx->ops.check_accesses)
+		if (!list_empty(&ctx->perf_events))
+			max_nr_accesses = kdamond_check_perf_event_reported_accesses(ctx);
+		else if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index e28c5afab7f0..da39abe07cfc 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -27,14 +27,33 @@ bool damos_ops_has_filter(struct damos *s);
 #ifdef CONFIG_PERF_EVENTS
 
 void damon_perf_prepare_access_checks(struct damon_ctx *ctx, struct damon_perf_event *event);
+void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event);
 int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event);
 void damon_perf_cleanup(struct damon_ctx *ctx, struct damon_perf_event *event);
 
+struct damon_vaddr_histogram {
+	struct xarray targets;
+};
+
+struct damon_paddr_histogram {
+	struct xarray accesses;
+};
+
 struct damon_perf {
 	struct perf_event * __percpu *event;
 	struct damon_perf_buffer __percpu *buffer;
+	union {
+		struct damon_vaddr_histogram vaddr_histogram;
+		struct damon_paddr_histogram paddr_histogram;
+	};
 };
 
+void damon_paddr_histogram_init(struct damon_paddr_histogram *histogram);
+unsigned long damon_paddr_histogram_count(struct damon_paddr_histogram *histogram, u64 paddr);
+void damon_paddr_histogram_destroy(struct damon_paddr_histogram *histogram);
+
+void damon_perf_populate_paddr_histogram(struct damon_ctx *ctx, struct damon_perf_event *event);
+
 #else /* CONFIG_PERF_EVENTS */
 
 static inline void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
@@ -42,6 +61,11 @@ static inline void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
 {
 }
 
+static inline void damon_va_perf_check_accesses(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+}
+
 static inline int damon_perf_init(struct damon_ctx *ctx, struct damon_perf_event *event)
 {
 	return 0;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1534372e7637..1afbad9dfe64 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -17,6 +17,7 @@
 
 #include <linux/circ_buf.h>
 #include <linux/perf_event.h>
+#include <linux/xarray.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -948,6 +949,63 @@ struct damon_perf_buffer {
 	unsigned long size;
 };
 
+struct damon_vaddr_histogram_per_target {
+	struct xarray accesses;
+};
+
+static void damon_vaddr_histogram_init(struct damon_vaddr_histogram *histogram)
+{
+	xa_init(&histogram->targets);
+}
+
+static void damon_vaddr_histogram_add(struct damon_vaddr_histogram *histogram, u32 pid,
+						u64 vaddr)
+{
+	struct damon_vaddr_histogram_per_target *target;
+	unsigned long nr_accesses;
+
+	while (!(target = xa_load(&histogram->targets, pid))) {
+		target = kmalloc_obj(*target);
+		if (!target)
+			return;
+
+		xa_init(&target->accesses);
+
+		if (xa_err(xa_store(&histogram->targets, pid, target, GFP_KERNEL))) {
+			pr_warn_once("Failed to store target histogram\n");
+			kfree(target);
+			return;
+		}
+	}
+
+	nr_accesses = xa_to_value(xa_load(&target->accesses, vaddr));
+	xa_store(&target->accesses, vaddr, xa_mk_value(nr_accesses + 1), GFP_KERNEL);
+}
+
+static unsigned long damon_vaddr_histogram_count(struct damon_vaddr_histogram *histogram,
+							u32 pid, u64 vaddr)
+{
+	struct damon_vaddr_histogram_per_target *target;
+	unsigned long nr_accesses = 0;
+
+	target = xa_load(&histogram->targets, pid);
+	if (target)
+		nr_accesses = xa_to_value(xa_load(&target->accesses, vaddr));
+
+	return nr_accesses;
+}
+
+static void damon_vaddr_histogram_destroy(struct damon_vaddr_histogram *histogram)
+{
+	unsigned long index;
+	struct damon_vaddr_histogram_per_target *target;
+
+	xa_for_each(&histogram->targets, index, target)
+		xa_destroy(&target->accesses);
+
+	xa_destroy(&histogram->targets);
+}
+
 static void damon_perf_overflow(struct perf_event *perf_event, struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
@@ -1092,6 +1150,296 @@ void damon_perf_prepare_access_checks(struct damon_ctx *ctx,
 	}
 }
 
+static void damon_va_perf_check_accesses_by_vaddr(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	int cpu;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_vaddr_histogram_init(&perf->vaddr_histogram);
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+		unsigned long head, tail, count, i;
+
+		if (!perf_event)
+			continue;
+
+		perf_event_disable(perf_event);
+
+		head = smp_load_acquire(&buffer->head);
+		tail = buffer->tail;
+		count = CIRC_CNT(head, tail, buffer->size);
+
+		for (i = 0; i < count; i++) {
+			struct damon_access_report *report =
+				&buffer->reports[(tail + i) & (buffer->size - 1)];
+
+			damon_vaddr_histogram_add(&perf->vaddr_histogram, report->tgid,
+							report->vaddr & PAGE_MASK);
+		}
+		smp_store_release(&buffer->tail, (tail + count) & (buffer->size - 1));
+
+		if ((count == buffer->size - 1) && (buffer->size < DAMON_PERF_MAX_RECORDS)) {
+			void *new_reports = kvcalloc_node(buffer->size * 2,
+					sizeof(buffer->reports[0]), GFP_KERNEL,
+					cpu_to_node(cpu));
+
+			if (new_reports) {
+				kvfree(buffer->reports);
+				buffer->reports = new_reports;
+				buffer->head = 0;
+				buffer->tail = 0;
+				buffer->size *= 2;
+			}
+		}
+	}
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		u32 pid = pid_nr(t->pid);
+
+		damon_for_each_region(r, t) {
+			unsigned long addr;
+
+			if (r->access_reported)
+				continue;
+
+			for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+				if (damon_vaddr_histogram_count(&perf->vaddr_histogram, pid,
+									addr & PAGE_MASK)) {
+					damon_update_region_access_rate(r, true, &ctx->attrs);
+					r->access_reported = true;
+					break;
+				}
+			}
+		}
+		tidx++;
+	}
+
+	damon_vaddr_histogram_destroy(&perf->vaddr_histogram);
+}
+
+struct damon_paddr_walk {
+	struct damon_paddr_histogram *histogram;
+	bool accessed;
+};
+
+static void damon_paddr_histogram_add(struct damon_paddr_histogram *histogram, u64 paddr);
+static const struct mm_walk_ops damon_paddr_ops;
+
+void damon_perf_populate_paddr_histogram(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	int cpu;
+
+	if (!perf)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct perf_event *perf_event = per_cpu(*perf->event, cpu);
+		struct damon_perf_buffer *buffer = per_cpu_ptr(perf->buffer, cpu);
+		unsigned long head, tail, count, i;
+
+		if (!perf_event)
+			continue;
+
+		perf_event_disable(perf_event);
+
+		head = smp_load_acquire(&buffer->head);
+		tail = buffer->tail;
+		count = CIRC_CNT(head, tail, buffer->size);
+
+		for (i = 0; i < count; i++) {
+			struct damon_access_report *report =
+				&buffer->reports[(tail + i) & (buffer->size - 1)];
+
+			damon_paddr_histogram_add(&perf->paddr_histogram,
+							report->paddr & PAGE_MASK);
+		}
+		smp_store_release(&buffer->tail, (tail + count) & (buffer->size - 1));
+
+		if ((count == buffer->size - 1) && (buffer->size < DAMON_PERF_MAX_RECORDS)) {
+			void *new_reports = kvcalloc_node(buffer->size * 2,
+					sizeof(buffer->reports[0]), GFP_KERNEL,
+					cpu_to_node(cpu));
+
+			if (new_reports) {
+				kvfree(buffer->reports);
+				buffer->reports = new_reports;
+				buffer->head = 0;
+				buffer->tail = 0;
+				buffer->size *= 2;
+			}
+		}
+	}
+}
+
+static void damon_va_perf_check_accesses_by_paddr(struct damon_ctx *ctx,
+		struct damon_perf_event *event)
+{
+	struct damon_perf *perf = event->priv;
+	struct damon_target *t;
+	unsigned int tidx = 0;
+
+	if (!perf)
+		return;
+
+	damon_paddr_histogram_init(&perf->paddr_histogram);
+
+	damon_perf_populate_paddr_histogram(ctx, event);
+
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+		struct mm_struct *mm = damon_get_mm(t);
+
+		if (!mm)
+			continue;
+
+		mmap_read_lock(mm);
+		damon_for_each_region(r, t) {
+			struct damon_paddr_walk walk_private = {
+				.histogram = &perf->paddr_histogram,
+				.accessed = false,
+			};
+
+			if (r->access_reported)
+				continue;
+
+			walk_page_range(mm, r->ar.start, r->ar.end, &damon_paddr_ops,
+					&walk_private);
+			if (walk_private.accessed) {
+				damon_update_region_access_rate(r, true, &ctx->attrs);
+				r->access_reported = true;
+			}
+		}
+		mmap_read_unlock(mm);
+		mmput(mm);
+		tidx++;
+	}
+
+	damon_paddr_histogram_destroy(&perf->paddr_histogram);
+}
+
+void damon_va_perf_check_accesses(struct damon_ctx *ctx, struct damon_perf_event *event)
+{
+	if (event->attr.sample_phys_addr)
+		return damon_va_perf_check_accesses_by_paddr(ctx, event);
+	else
+		return damon_va_perf_check_accesses_by_vaddr(ctx, event);
+}
+
+void damon_paddr_histogram_init(struct damon_paddr_histogram *histogram)
+{
+	xa_init(&histogram->accesses);
+}
+
+static void damon_paddr_histogram_add(struct damon_paddr_histogram *histogram,
+						u64 paddr)
+{
+	unsigned long nr_accesses;
+
+	nr_accesses = xa_to_value(xa_load(&histogram->accesses, paddr));
+	xa_store(&histogram->accesses, paddr, xa_mk_value(nr_accesses + 1), GFP_KERNEL);
+}
+
+unsigned long damon_paddr_histogram_count(struct damon_paddr_histogram *histogram, u64 paddr)
+{
+	return xa_to_value(xa_load(&histogram->accesses, paddr));
+}
+
+void damon_paddr_histogram_destroy(struct damon_paddr_histogram *histogram)
+{
+	xa_destroy(&histogram->accesses);
+}
+
+static int damon_paddr_pmd_entry(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	pte_t *pte;
+	spinlock_t *ptl;
+	struct damon_paddr_walk *paddr_walk = walk->private;
+
+	ptl = pmd_trans_huge_lock(pmd, walk->vma);
+	if (ptl) {
+		pmd_t pmde = pmdp_get(pmd);
+
+		if (pmd_present(pmde)) {
+			for (; addr < next && !paddr_walk->accessed; addr += PAGE_SIZE) {
+				u64 frame = pmd_pfn(pmde) +
+					((addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT);
+
+				if (damon_paddr_histogram_count(paddr_walk->histogram,
+						PFN_PHYS(frame))) {
+					paddr_walk->accessed = true;
+					break;
+				}
+			}
+		}
+		spin_unlock(ptl);
+		return paddr_walk->accessed ? 1 : 0;
+	}
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (!pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (; addr < next && !paddr_walk->accessed; pte++, addr += PAGE_SIZE) {
+		pte_t ptent = ptep_get(pte);
+
+		if (pte_present(ptent)) {
+			if (damon_paddr_histogram_count(paddr_walk->histogram,
+					PFN_PHYS(pte_pfn(ptent)))) {
+				paddr_walk->accessed = true;
+			}
+		}
+	}
+
+	pte_unmap_unlock(pte - 1, ptl);
+
+	return paddr_walk->accessed ? 1 : 0;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+static int damon_paddr_hugetlb_entry(pte_t *pte, unsigned long hmask,
+		unsigned long addr, unsigned long end,
+		struct mm_walk *walk)
+{
+	struct damon_paddr_walk *paddr_walk = walk->private;
+	pte_t entry = huge_ptep_get(walk->mm, addr, pte);
+
+	if (pte_present(entry)) {
+		for (; addr < end; addr += PAGE_SIZE) {
+			u64 frame = pte_pfn(entry) + ((addr & ~hmask) >> PAGE_SHIFT);
+
+			if (damon_paddr_histogram_count(paddr_walk->histogram,
+						PFN_PHYS(frame))) {
+				paddr_walk->accessed = true;
+				break;
+			}
+		}
+	}
+
+	return paddr_walk->accessed ? 1 : 0;
+}
+#else
+#define damon_perf_hugetlb_entry NULL
+#endif /* CONFIG_HUGETLB_PAGE */
+
+static const struct mm_walk_ops damon_paddr_ops = {
+	.pmd_entry = damon_paddr_pmd_entry,
+	.hugetlb_entry = damon_paddr_hugetlb_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
 #endif /* CONFIG_PERF_EVENTS */
 
 static int __init damon_va_initcall(void)
-- 
2.43.0

