Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479794;
	b=1Lk+yHLdah1HlF8XDwTu6SGVRl4RIU1OmU+0lNXoGhnEh4miij/WlKUseh0/+NcLmx7f
	 MOp5wF1Ia3hX/j1ukQreqvWD7pgWBpgf2yNYZvqBxAVlnnzyA2PUxlDAu8zWwrbkLW1nL
	 MoF6MUjUpo+LpQcVH/wu0DZhMFigR+a0qEP9avo0JWaUfLuVhnmDnJB7I9/B0nKnfsmN/
	 0745Q2YV84GXbRhBJWh1ioJFNeqpyDOpUM/U6Kwpp3iR+Bwte/XlezqDw6P4yG2ipuxH4
	 GVCMTPnmARI6MdULJL4dkFNQKpfgT4zHr4+RCk6Lx1iZveFhqRhIqKhxWMbaB/AoG6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Nd4DPU5GUnoPk5SX46wEPjH4KNWe5Ep973OTAijr8W8=;
	b=Avh6SRF3MSFZYBnSHlt+St2UiWdkEI75jNy1MNiloEf7Cp7ROzUiAWnc44llTYOw4RdN
	 7FGye9T+SAO0F4ZNKTlQ0sU5e9yGAaKcj0pYX5WnqVMrt/2Tr32DwYCUJQ/+Y/r3uNTXA
	 lkwgn5NF+fkIFaQSPMYtJGKbPvWv7qx8XWf/aJZwZaW09tX1mXRYnAO+CyBCz6mSRzWW5
	 nmSZON3ZVvV+FoFB3cJ/OegiSOjIUVlTM/E732avI6wJQhptFAZ5KE3HX0NNMPOMYJpqh
	 GYWGztB4vgp48+YQKTg5N8kD55scIyK+MxxOl9fuIrMUWb5XUSfakW67FboU/JhmOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYsWkrK9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA94606A682;
	Tue, 24 Nov 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYsWkrK9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DED1F000EC;
	Tue, 24 Nov 2026 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479794;
	bh=Nd4DPU5GUnoPk5SX46wEPjH4KNWe5Ep973OTAijr8W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYsWkrK93A2RQitVtAPAn9WIr4GiENuqanvZZcB9O5YQufIX41DoUuX+rEDthQ6Mn
	 96VV5dtGZ/CMnOtK/QF3NMxOYS2SRoRxm3debxxAEwIhsyrgMa9jTZ8peicE6F0D+s
	 mibEvcw4uZsCFLb7JPh/R5skFg7aEXXB4RMYYEji169Ybpm95H6QkZOVvuk1ZHmdHh
	 D5Riz6x2j0vm0Lq2w5XGpihQsAUx/MXzZ8/OTHV34Jazl1JsxTOwCDKjvLfwkdVA54
	 SfNvjQYswZJ5VV6wX9adyo84LiSSnSVuhWf5DrPYUPqFICrfXnzhCB+IefXpy8kCWn
	 2a2BML1tY3JyQ==
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
Subject: [RFC PATCH 03/26] perf/core: Move is_guest_mediated_pmu_loaded() to the header
Date: Tue, 24 Nov 2026 00:22:40 +0000
Message-ID: <20261124002303.1785363-4-yosry@kernel.org>
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

In preparation for using is_guest_mediated_pmu_loaded() in x86 perf code
and in KVM, move it to perf_event.h. Make the per-CPU flag it reads
global, renaming it to perf_guest_ctx_loaded to avoid polluting the
global namespace, and export it to KVM.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 include/linux/perf_event.h | 13 +++++++++++++
 kernel/events/core.c       | 25 +++++++------------------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df097..5ecd477bd6969 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1933,6 +1933,19 @@ int perf_create_mediated_pmu(void);
 void perf_release_mediated_pmu(void);
 void perf_load_guest_context(void);
 void perf_put_guest_context(void);
+
+DECLARE_PER_CPU(bool, perf_guest_ctx_loaded);
+
+static __always_inline bool is_guest_mediated_pmu_loaded(void)
+{
+	return __this_cpu_read(perf_guest_ctx_loaded);
+}
+
+#else /* !CONFIG_PERF_GUEST_MEDIATED_PMU */
+static __always_inline bool is_guest_mediated_pmu_loaded(void)
+{
+	return false;
+}
 #endif
 
 #else /* !CONFIG_PERF_EVENTS: */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a3e40155ce70..8fd1e19cf5ab9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -473,20 +473,6 @@ static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
 
-#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
-static DEFINE_PER_CPU(bool, guest_ctx_loaded);
-
-static __always_inline bool is_guest_mediated_pmu_loaded(void)
-{
-	return __this_cpu_read(guest_ctx_loaded);
-}
-#else
-static __always_inline bool is_guest_mediated_pmu_loaded(void)
-{
-	return false;
-}
-#endif
-
 /*
  * perf event paranoia level:
  *  -1 - not paranoid at all
@@ -6377,6 +6363,9 @@ u64 perf_event_pause(struct perf_event *event, bool reset)
 EXPORT_SYMBOL_GPL(perf_event_pause);
 
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+DEFINE_PER_CPU(bool, perf_guest_ctx_loaded);
+EXPORT_SYMBOL_FOR_KVM(perf_guest_ctx_loaded);
+
 static atomic_t nr_include_guest_events __read_mostly;
 
 static atomic_t nr_mediated_pmu_vms __read_mostly;
@@ -6464,7 +6453,7 @@ void perf_load_guest_context(void)
 
 	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
 
-	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
+	if (WARN_ON_ONCE(__this_cpu_read(perf_guest_ctx_loaded)))
 		return;
 
 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
@@ -6478,7 +6467,7 @@ void perf_load_guest_context(void)
 	if (cpuctx->task_ctx)
 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
 
-	__this_cpu_write(guest_ctx_loaded, true);
+	__this_cpu_write(perf_guest_ctx_loaded, true);
 }
 EXPORT_SYMBOL_GPL(perf_load_guest_context);
 
@@ -6490,7 +6479,7 @@ void perf_put_guest_context(void)
 
 	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
 
-	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
+	if (WARN_ON_ONCE(!__this_cpu_read(perf_guest_ctx_loaded)))
 		return;
 
 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
@@ -6503,7 +6492,7 @@ void perf_put_guest_context(void)
 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
 
-	__this_cpu_write(guest_ctx_loaded, false);
+	__this_cpu_write(perf_guest_ctx_loaded, false);
 }
 EXPORT_SYMBOL_GPL(perf_put_guest_context);
 #else
-- 
2.56.1.809.ga0b61035b5-goog

