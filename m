Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479803;
	b=Nhc0Hr9S5/fJrpJLDRmkva3/U8ucy5VITqFI7AWKYWcmVkRf00TUuHxBfFKHyzt5xA2t
	 YgqbHfueIqVKgJBxn5MjRYOLNKutPIw1jBKDLjDOmB5qOG7C7zWepQVBO0CPcPw+WRr+e
	 9YqWpQtkrLiM9eVKnr/x8MZxgFH3KmDtfS/bx0NIiqsMUONBvtjutdvndsncUV2jXdX1n
	 ty6zsXSs687LBPmWjMTelVzxIHLFNt8Uw1KWp4OFa6RFuaX9RVLyJQEq9nOsfia2L5jV7
	 uh++wvLZNwevMmo+4/i0cxowVbW0I5zPd7Pf5o636tSsCC0+FYc4zdiBfwY1Kk0NApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479803;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=55q7/YabMT6GcIeWufoFNMiUpjVu8KkyHD1TJjJFzss=;
	b=edb9SNEo8hPa/UY53D1P1ne2ZcFwoLXSbsjW78bbIafNkLJtlPh6S8p9HnE4I9/zN4/2
	 RCglUFDkjgyC9SGACexFMxjEUuND4q8A9uA8llRZ2qDJPS9h99IB5z5AzyCJzkETBZhLx
	 3gAlM+zZ+JgMaJFbz51YlVMwo+WN7n63FItwEApzDPcjzJeeJFzLF+eH1OJHikWbZNDM9
	 WWmsEHRwxITl2lpdklDuQHc6w1UjjdtbWcICBj5IhUXKbbKNlDEQYJgvaxNeu/UByEM/g
	 gzxgWLQtJaopdqCXJM3qUJTbugkA08dSaB/AgNYMDFm2f0DGZohlfnh8eFXjqwwiczA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTyY8hHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AA606A69D;
	Tue, 24 Nov 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTyY8hHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688D31F000D0;
	Tue, 24 Nov 2026 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479803;
	bh=55q7/YabMT6GcIeWufoFNMiUpjVu8KkyHD1TJjJFzss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTyY8hHVwC2R0UKhiB/S6tgKtkcIm5sgC70lXBf3hgVs9KacmJaHsWJov4UEZSYYH
	 wa1FNp2dgWtL22KeRwh5+G2wr13DvvakXur+xmZc5FphaAaCT4DcGQGohpvnps3kRc
	 Nk8jbKdKP8cpxWDd/lSU18TJw6GBcr/lf/SGTEEFEYZDIYBVBI4GVdPs0ZOcleylxk
	 n/xpJ3+hGFyEa9J6/jpgSVRowj89+Dj37K0VONljZ0cNbeprjdPvUnQ6JM6lmUcVGK
	 V1MEbSwFANFMN/haloS/iWk7CyEnPNbU6cwDSii5x1KuQfSYz1KgyD7y+oekSvdKxV
	 7ao0daRo6cTfw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 10/26] perf: Track mediated PMU conflicts
Date: Tue, 24 Nov 2026 00:22:47 +0000
Message-ID: <20261124002303.1785363-11-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track perf events conflicting with the mediated PMU, which are events on
mediated-capable PMUs, or on PMUs using the same PMI delivery mechanism
as the guest PMIs (LVTPC on x86). Add a new PMU capability for the
latter, and set it for Intel PT and Intel BTS.

Whether or not perf has events conflicting with the mediated PMU will be
used by KVM to determine if putting the guest PMU context on the VM-exit
slowpath is necessary.

Intel BTS is never active while the guest runs, as KVM doesn't allow the
guest to set DEBUGCTL.TR/BTS and VM-exit clears DEBUGCTL. Today, its
interrupts can only be delivered to the guest in the short windows
between loading the guest context and VM-entry, and between VM-exit and
putting the guest context. Tracking it keeps those windows from
extending to slowpath VM-exit handling.

Intel PT (in system mode) keeps tracing while the guest runs, so its
interrupts can already be delivered to the guest today. Tracking it
keeps that from extending to slowpath VM-exit handling.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/events/intel/bts.c |  3 ++-
 arch/x86/events/intel/pt.c  |  3 ++-
 include/linux/perf_event.h  | 11 ++++++++
 kernel/events/core.c        | 54 +++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 5849392cf26d5..178fcb1bff7cc 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -627,7 +627,8 @@ static __init int bts_init(void)
 		return -ENOMEM;
 
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
-				  PERF_PMU_CAP_EXCLUSIVE;
+				  PERF_PMU_CAP_EXCLUSIVE |
+				  PERF_PMU_CAP_USES_MEDIATED_PMI;
 	bts_pmu.task_ctx_nr	= perf_sw_context;
 	bts_pmu.event_init	= bts_event_init;
 	bts_pmu.add		= bts_event_add;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 3782af40f0832..5e3cd809bcb08 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1899,7 +1899,8 @@ static __init int pt_init(void)
 
 	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
 					   PERF_PMU_CAP_ITRACE |
-					   PERF_PMU_CAP_AUX_PAUSE;
+					   PERF_PMU_CAP_AUX_PAUSE |
+					   PERF_PMU_CAP_USES_MEDIATED_PMI;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 50b625f1aff20..1308b99a0abb6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -306,6 +306,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
 #define PERF_PMU_CAP_MEDIATED_VPMU	0x0400
 #define PERF_PMU_CAP_SIMD_REGS		0x0800
+#define PERF_PMU_CAP_USES_MEDIATED_PMI	0x1000
 
 /**
  * pmu::scope
@@ -1032,6 +1033,10 @@ struct perf_event_context {
 	int				nr_user;
 	int				is_active;
 
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+	int				nr_mediated_pmu_conflicts;
+#endif
+
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
@@ -1939,6 +1944,7 @@ extern u64 perf_event_pause(struct perf_event *event, bool reset);
 int perf_create_mediated_pmu(void);
 void perf_release_mediated_pmu(void);
 void perf_reclaim_mediated_pmu(void);
+bool perf_has_mediated_pmu_conflicts(void);
 void perf_load_guest_context(void);
 void perf_put_guest_context(void);
 
@@ -1956,6 +1962,11 @@ static __always_inline bool is_guest_mediated_pmu_loaded(void)
 }
 
 static __always_inline void perf_reclaim_mediated_pmu(void) { }
+
+static __always_inline bool perf_has_mediated_pmu_conflicts(void)
+{
+	return false;
+}
 #endif
 
 #else /* !CONFIG_PERF_EVENTS: */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 99aa56ced8253..33422b92dc0db 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1989,6 +1989,22 @@ static inline bool has_inherit_and_sample_read(struct perf_event_attr *attr)
 	return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
 }
 
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+static void account_mediated_pmu_conflicts(struct perf_event *event,
+					   struct perf_event_context *ctx,
+					   int nr)
+{
+	if (event->pmu_ctx->pmu->capabilities &
+	    (PERF_PMU_CAP_MEDIATED_VPMU | PERF_PMU_CAP_USES_MEDIATED_PMI))
+		WRITE_ONCE(ctx->nr_mediated_pmu_conflicts,
+			   ctx->nr_mediated_pmu_conflicts + nr);
+}
+#else
+static inline void account_mediated_pmu_conflicts(struct perf_event *event,
+						  struct perf_event_context *ctx,
+						  int nr) { }
+#endif
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -2027,6 +2043,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	ctx->generation++;
 	event->pmu_ctx->nr_events++;
+
+	account_mediated_pmu_conflicts(event, ctx, 1);
 }
 
 /*
@@ -2255,6 +2273,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
+
+	account_mediated_pmu_conflicts(event, ctx, -1);
 }
 
 static int
@@ -6537,6 +6557,40 @@ void perf_put_guest_context(void)
 	__this_cpu_write(perf_guest_ctx_loaded, false);
 }
 EXPORT_SYMBOL_GPL(perf_put_guest_context);
+
+/*
+ * Return true if this CPU's or the current task's perf context has events that
+ * conflict with a loaded guest context: events on PMUs with
+ * PERF_PMU_CAP_MEDIATED_VPMU, whose state is guest state while a guest context
+ * is loaded, or on PMUs with PERF_PMU_CAP_USES_MEDIATED_PMI, which deliver
+ * interrupts through the same mechanism as guest PMIs (the LVTPC on x86).  The
+ * latter should not raise interrupts while a guest context is loaded, or they
+ * would be delivered to the guest.  KVM uses this to determine whether the
+ * guest context needs to be put before running host code.
+ *
+ * Note, Intel PT and BTS events are not scheduled out when a guest context is
+ * loaded, so interrupts they raise while it is loaded are still delivered to
+ * the guest.
+ *
+ * Must be called with IRQs disabled.
+ */
+bool perf_has_mediated_pmu_conflicts(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * nr_mediated_pmu_conflicts is read locklessly, and can be updated
+	 * remotely without an IPI when a disabled event is installed. A stale
+	 * read is fine: such an event is disabled, and enabling it reclaims the
+	 * PMU first. A stale non-zero read only causes an unnecessary put.
+	 */
+	return READ_ONCE(cpuctx->ctx.nr_mediated_pmu_conflicts) ||
+	       (task_ctx && READ_ONCE(task_ctx->nr_mediated_pmu_conflicts));
+}
+EXPORT_SYMBOL_FOR_KVM(perf_has_mediated_pmu_conflicts);
 #else
 static int mediated_pmu_account_event(struct perf_event *event) { return 0; }
 static void mediated_pmu_unaccount_event(struct perf_event *event) {}
-- 
2.56.1.809.ga0b61035b5-goog

