Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479800;
	b=OUkd+b3Oz+f35nPRc1hy8DrsIW0k2n1sy3RvHC1IXF0sNAro7M9s+4Zt+nrEImwxjvdS
	 n+lhpBZLR8pNBE6v5yOXayn8YANcEtS72m+zPJ3wyFgFVp+Y7DNUmk8U6500igLbykrJD
	 hjlr4qKRH1A/BM3Jgv+E7tVS7NUAB9bczJF9ufq80pu01/b+APfkrA86FFCi2vI7VGF9x
	 uM0vgQGNHZFF8ZOI6zYllzL79Nib/BdZgmRP6/uKMyY0EVjDVw0hiPCnSu9ek/WzrH2gy
	 7pPbDbguQej9UGu6E5N3XiGv+/IFkrGChYonVV/6teF3lE7cxZgv8IliItxzbyf61lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479800;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xFvE0DCvEHDj+qLd4i+4KJkbPjTNneU63S+KuhNDWvU=;
	b=WGkI7ckMGz/qEjLfkO5gwoT/mSQ/fiGLEx2Ofq2gnpxPICpHOsqc77QrghQFh+5nqfoY
	 pNjP0jYTaktnxQGRWUkCCROzlmFWyOSfwe8TqNNP9Ce0tsSSym3p1hD2fnAESe5+TCdgZ
	 Ia/mwDuPaRAq4mv4BzmnHJWni+E5JmO+X3vonpJW/CxAHTKe3HWIaMdTsJFohV5eORnUb
	 Y+hluB5uRtfiGeF1GNPzlT3/RhQJ/Zt0WvYPuNRNMPvLsg3YNpVfSzC+HJVh0xewBJE/c
	 AcSjCnVsC5qZaY2VRAKUOSpT6l80ISSENWaTIpN0oETF95t8nTPRIFQ10jYqNKT1O4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE2Qo8Hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB8606A6B5;
	Tue, 24 Nov 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE2Qo8Hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C151F000E6;
	Tue, 24 Nov 2026 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479800;
	bh=xFvE0DCvEHDj+qLd4i+4KJkbPjTNneU63S+KuhNDWvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aE2Qo8HzqmmzgpXMf7MlHhU0JRhHl4Qvty+ATTsEh1GcT555U8zQG3pZm1D0kiY/4
	 eItKqt+lERBECGhH/te9xm4aSLpAF1YcoQkZOCxX5325yPFYCUgaBbTK89Hdo3Vl9g
	 pkcNwokjTAv7PxjK0sYMTTaEXRODO40jblfoN1/eN2rBz36y7QizJ55LetGddqfHhD
	 c+mwWpPKRUhZOndi3f0tJfo6aZ0MvTzZuXfRqD76hS92/FfNpMNmeFdOOWmmn0lM+i
	 Jd+XSgG6s1N4NGW8Zp7pHzXnw0D2oam7Ulnik4cU+NPNDb9wOM3kfwe2hplrnI1Eg5
	 868DIKL3Gtjtg==
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
Subject: [RFC PATCH 08/26] perf/core: Reclaim the mediated PMU before executing remote calls
Date: Tue, 24 Nov 2026 00:22:45 +0000
Message-ID: <20261124002303.1785363-9-yosry@kernel.org>
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

Remote function calls (e.g. installing, enabling or disabling events) may
alter the PMU state, which would clobber the guest's state if a guest's
mediated PMU context is loaded on the target CPU. In preparation for KVM
leaving the guest context loaded with IRQs enabled (where host events
may get scheduled), reclaim the PMU before executing any remote call.

Hooking remote_function() is conservative, as only installing events
through __perf_install_in_context() strictly needs to reclaim the PMU.
However, hooking only event installation would be less future-proof, and
would require perf_install_in_context() to not skip the IPI when
installing a disabled event on a mediated-capable PMU, as the event
could otherwise be enabled later through perf_event_enable() while the
guest context is still loaded.

The PMU reclaim callback must be called with IRQs disabled and without
perf context locks held (and hence isn't NMI-safe), as putting the guest
context takes them. WARN if the guest context is still loaded after the
callback.

No functional change intended, as the guest context is currently only
loaded with IRQs disabled, so remote_function() never runs while it's
loaded.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a83b9f2785301..50b625f1aff20 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1938,6 +1938,7 @@ extern u64 perf_event_pause(struct perf_event *event, bool reset);
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
 int perf_create_mediated_pmu(void);
 void perf_release_mediated_pmu(void);
+void perf_reclaim_mediated_pmu(void);
 void perf_load_guest_context(void);
 void perf_put_guest_context(void);
 
@@ -1953,6 +1954,8 @@ static __always_inline bool is_guest_mediated_pmu_loaded(void)
 {
 	return false;
 }
+
+static __always_inline void perf_reclaim_mediated_pmu(void) { }
 #endif
 
 #else /* !CONFIG_PERF_EVENTS: */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2f301ef0bd26a..99aa56ced8253 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -93,6 +93,13 @@ static void remote_function(void *data)
 			return;
 	}
 
+	/*
+	 * Reclaim the mediated vPMU from any potentially loaded guest context
+	 * before executing the remote function call, as it may alter the PMU
+	 * state (e.g. by installing new events).
+	 */
+	perf_reclaim_mediated_pmu();
+
 	tfc->ret = tfc->func(tfc->info);
 }
 
@@ -6425,6 +6432,27 @@ static void mediated_pmu_unaccount_event(struct perf_event *event)
 	atomic_dec(&nr_include_guest_events);
 }
 
+/*
+ * Reclaim the mediated vPMU from any loaded guest context on this CPU. This
+ * must be called with IRQs disabled and without any perf ctx locks held, and is
+ * not NMI-safe.
+ */
+void perf_reclaim_mediated_pmu(void)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+
+	WARN_ON_ONCE(in_nmi());
+	lockdep_assert_irqs_disabled();
+	lockdep_assert_not_held(&cpuctx->ctx.lock);
+	if (cpuctx->task_ctx)
+		lockdep_assert_not_held(&cpuctx->task_ctx->lock);
+
+	if (is_guest_mediated_pmu_loaded()) {
+		perf_guest_reclaim_mediated_pmu();
+		WARN_ON_ONCE(is_guest_mediated_pmu_loaded());
+	}
+}
+
 /*
  * Currently invoked at VM creation to
  * - Check whether there are existing !exclude_guest events of PMU with
-- 
2.56.1.809.ga0b61035b5-goog

