Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819B26461C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837589; cv=none; b=gu6tu+gMkf0NIMF6TxICgPdtbtaYOCvUnLgajxpjwsVnqN2D3jZBKBRI6pbU/1MYS+v0hyC+l/XIVFxyORmk30FPihaeuVQm4D6iIrrnGUH7oNHKLy2SG4R9g1PXmdEv+/kFSkV09SS3Y0/rFz1QUra9cXyc9ynocBdMG078LPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837589; c=relaxed/simple;
	bh=CzYGuYYUd7AX2Fs1hEVjbTbxTpXC9vjjk2D4/WR/4rs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGwQbo9pxkWDnKq0BAFBDh34ZI6y4kMsWlPbiJ0VP3aQ9eBLrAm5jE57UWr6ZRLFzHakBVm6FcrnONBf0U4gwfwR4BM1oxbRM0ksy21bKlwNs6OdCSxO8IV2Te8gUegRnZwRX3nDMWUabYOW86swuUcxcCgGNnzh2OgBHxCmcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wqmLZQP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wqmLZQP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ca2a4a5so54652775ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837586; x=1743442386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0bq5uIWHPtPqH2Nz7MB6IWHn/nwEFnOT5cezx9vd7Ig=;
        b=1wqmLZQPeQtUFnYNjfIpE9DNlCWBbD6sXlzENq5LTZxza9NkKcFNFstKe4P2x442iT
         apXGgx0RfgMYB56eQSX3jhwDoY10mhnYWcABNX19bBCrYYLZV0zpY7l7Uc58BSjB5bv9
         sz6ME/HByP4/JfzTy5w3WxsSD3lBJEJmR329p0gZiZoP7q9mVvrEEbSDJ8CgyBnY0d9H
         L2LL5yF9fdatoFaIp7dp0jzXw/dyrlc8WqW/u5c9Mzh9Hir9z7yxhPYPqO+adD3G2RxV
         Wk5wZix9IWUeuSuw0S8YwtP5wNQca+HDt68r2nDzN1oZRKgHNDAdugwBotF8rTjMxiAT
         TvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837586; x=1743442386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bq5uIWHPtPqH2Nz7MB6IWHn/nwEFnOT5cezx9vd7Ig=;
        b=d1XRYecHEaYdoJzieOuxLFfjGwDUpbjUIswCoMFghVJ3mA1WYwNeE7Y0brnsubtHAR
         IPuxBDk3X3WaQ5CP6sDHOZBn5GxJvTuPaNLUrZbixUm2XxCUJwyzPhITEe3iIwaCXwx+
         yo8Ub5PPTOmbDXfALUqswmmRx9misrRb/stKR6JSl3WbdB/8lV/OldoBu5IqJ5tzSJ5p
         zaoMYMc1yg0iNA35S3AgfsiqNp3g00s6+AXzCJ22AlGwTVf0nGw0tcLgtFBu8dF5dogK
         92swgIEFAdAT2dLt8/ZiBPbYgHBwWjgS2XNElITaQMAEWNcJ3/Gw7prO+F0g/juYH8Sm
         dKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+IrGacBbEBqDc90BIota+7oQG//NjQka3H3jrKthEw11IAImndtHg6sp74a0vWOEVOJvAEhlCcbnrhOLh6pIn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xOWWnsL4GqqND5kXOARrv2mJtmuQ0N2VX1BhiC88v+OeE5xQ
	zakGo/vq9S1Fdb7QPLufJTfEjHBsdQRxKjdw06fEm3L8HZMkWZwt/IESNlHDTZK6szVYAwJw/0S
	GxNgMOg==
X-Google-Smtp-Source: AGHT+IFbjdGhv2on6ZGQymO61yqZIfPGWJmtEpWmLtg8c3el8x4krG9NA7ZJsIUev60Xj0G8Vxi6JsLrov10
X-Received: from pjbsi11.prod.google.com ([2002:a17:90b:528b:b0:2f9:c349:2f84])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c9:b0:216:7926:8d69
 with SMTP id d9443c01a7336-22780e26127mr197421695ad.47.1742837586412; Mon, 24
 Mar 2025 10:33:06 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:49 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-10-mizhang@google.com>
Subject: [PATCH v4 09/38] perf: Add switch_guest_ctx() interface
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

When entering/exiting a guest, some contexts for a guest have to be
switched. For examples, there is a dedicated interrupt vector for
guests on Intel platforms.

When PMI switch into a new guest vector, guest_lvtpc value need to be
reflected onto HW, e,g., guest clear PMI mask bit, the HW PMI mask
bit should be cleared also, then PMI can be generated continuously
for guest. So guest_lvtpc parameter is added into perf_guest_enter()
and switch_guest_ctx().

Add a dedicated list to track all the pmus with the PASSTHROUGH cap, which
may require switching the guest context. It can avoid going through the
huge pmus list.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/perf_event.h | 17 +++++++++++--
 kernel/events/core.c       | 51 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 37187ee8e226..58c1cf6939bf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -584,6 +584,11 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Switch guest context when a guest enter/exit, e.g., interrupt vectors.
+	 */
+	void (*switch_guest_ctx)	(bool enter, void *data); /* optional */
 };
 
 enum perf_addr_filter_action_t {
@@ -1030,6 +1035,11 @@ struct perf_event_context {
 	local_t				nr_no_switch_fast;
 };
 
+struct mediated_pmus_list {
+	raw_spinlock_t		lock;
+	struct list_head	list;
+};
+
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
@@ -1044,6 +1054,9 @@ struct perf_cpu_pmu_context {
 	struct hrtimer			hrtimer;
 	ktime_t				hrtimer_interval;
 	unsigned int			hrtimer_active;
+
+	/* Track the PMU with PERF_PMU_CAP_MEDIATED_VPMU cap */
+	struct list_head		mediated_entry;
 };
 
 /**
@@ -1822,7 +1835,7 @@ extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
 int perf_get_mediated_pmu(void);
 void perf_put_mediated_pmu(void);
-void perf_guest_enter(void);
+void perf_guest_enter(u32 guest_lvtpc);
 void perf_guest_exit(void);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
@@ -1921,7 +1934,7 @@ static inline int perf_get_mediated_pmu(void)
 }
 
 static inline void perf_put_mediated_pmu(void)			{ }
-static inline void perf_guest_enter(void)			{ }
+static inline void perf_guest_enter(u32 guest_lvtpc)		{ }
 static inline void perf_guest_exit(void)			{ }
 #endif
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d05487d465c9..406b86641f02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -451,6 +451,7 @@ static inline bool is_include_guest_event(struct perf_event *event)
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
+static DEFINE_PER_CPU(struct mediated_pmus_list, mediated_pmus);
 static cpumask_var_t perf_online_mask;
 static cpumask_var_t perf_online_core_mask;
 static cpumask_var_t perf_online_die_mask;
@@ -6053,8 +6054,26 @@ static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
 	}
 }
 
+static void perf_switch_guest_ctx(bool enter, u32 guest_lvtpc)
+{
+	struct mediated_pmus_list *pmus = this_cpu_ptr(&mediated_pmus);
+	struct perf_cpu_pmu_context *cpc;
+	struct pmu *pmu;
+
+	lockdep_assert_irqs_disabled();
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(cpc, &pmus->list, mediated_entry) {
+		pmu = cpc->epc.pmu;
+
+		if (pmu->switch_guest_ctx)
+			pmu->switch_guest_ctx(enter, (void *)&guest_lvtpc);
+	}
+	rcu_read_unlock();
+}
+
 /* When entering a guest, schedule out all exclude_guest events. */
-void perf_guest_enter(void)
+void perf_guest_enter(u32 guest_lvtpc)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -6067,6 +6086,8 @@ void perf_guest_enter(void)
 
 	perf_host_exit(cpuctx);
 
+	perf_switch_guest_ctx(true, guest_lvtpc);
+
 	__this_cpu_write(perf_in_guest, true);
 
 unlock:
@@ -6098,6 +6119,8 @@ void perf_guest_exit(void)
 	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
 		goto unlock;
 
+	perf_switch_guest_ctx(false, 0);
+
 	perf_host_enter(cpuctx);
 
 	__this_cpu_write(perf_in_guest, false);
@@ -12104,6 +12127,15 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
 		__perf_init_event_pmu_context(&cpc->epc, pmu);
 		__perf_mux_hrtimer_init(cpc, cpu);
+
+		if (pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) {
+			struct mediated_pmus_list *pmus;
+
+			pmus = per_cpu_ptr(&mediated_pmus, cpu);
+			raw_spin_lock(&pmus->lock);
+			list_add_rcu(&cpc->mediated_entry, &pmus->list);
+			raw_spin_unlock(&pmus->lock);
+		}
 	}
 
 	if (!pmu->start_txn) {
@@ -12162,6 +12194,20 @@ void perf_pmu_unregister(struct pmu *pmu)
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
 
+	if (pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU) {
+		struct mediated_pmus_list *pmus;
+		struct perf_cpu_pmu_context *cpc;
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+			pmus = per_cpu_ptr(&mediated_pmus, cpu);
+			raw_spin_lock(&pmus->lock);
+			list_del_rcu(&cpc->mediated_entry);
+			raw_spin_unlock(&pmus->lock);
+		}
+	}
+
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
 	 * synchronize against both of those.
@@ -14252,6 +14298,9 @@ static void __init perf_event_init_all_cpus(void)
 
 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 
+		INIT_LIST_HEAD(&per_cpu(mediated_pmus.list, cpu));
+		raw_spin_lock_init(&per_cpu(mediated_pmus.lock, cpu));
+
 		cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 		__perf_event_init_context(&cpuctx->ctx);
 		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
-- 
2.49.0.395.g12beb8f557-goog

