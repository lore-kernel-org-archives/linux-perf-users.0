Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479798;
	b=KU6tyzIdzTVaEj21YQyMG1r1rE6MgwscqThExQOxkSfIFylb45cRxBHDpPGRlGtC3pXY
	 wFcnQZciYa1tv9Z81Tb66gfXfTyfeuP4GaYxlePi2V0JheTBamPIM0d/qBiY2V0MjmKqy
	 +Mm4RHV15EAD+8j3+I5NanygNH/RJ82eKjEWBIU5p5GyGHnX8rUC4ysRBhxH6Wmm09TSh
	 G3wIp4jgDw5b9E6Rf/WcGMepv1HvGd2IIlwiT+gokAeYJbdAJbK8sXVWtjBs8TSDAYlGg
	 jZ4Rcsb7oVfzCuo+fOaJw/meZZuBSXyrUTLGpodSaNwya8z8j36EpkKvq0gR63Pvx0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+bTraHWrkXkEO985xY8ZwDTNz2qDRYoiFOGFRC9niZQ=;
	b=bZL+kjreGixPhlpv03hWcXxvGjhDe7yRvgj62uwO3SwHtLRq27ZT8GkPI4ag7oVK2f23
	 Sq8Cq7buXIjyk3VJ/hBPGTp31iLhzVI18snny8x/hmMnO+HbZd14UsyjpY2Rcf2LHHGRH
	 C3hR3n/gvnprdqCflJ9cD3UTpyQNk8xyfHl8oQ0LTJFPhIJ/Z6YFQ1WZbl8vpVvlLX+8j
	 ckm0n/eDTH97kSso6mUq0Id9Hazj45IClIn55Qf6yfO9f6P+o0mXTeqbdDWbmoK2v25ll
	 f6rtwUOHexQO4WllG3ooagja3GSnXXDkgRyu9zbPwXulm+8VAkU2PUruE2sWrq7jUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLJBhqcH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8460A262E;
	Tue, 24 Nov 2026 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLJBhqcH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22AD1F000EB;
	Tue, 24 Nov 2026 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479797;
	bh=+bTraHWrkXkEO985xY8ZwDTNz2qDRYoiFOGFRC9niZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLJBhqcHNaBMMCOXgo4bBfpirQhpdMo90+iQQIzNvRybtq0VAK2pxyK8pty2HCBkO
	 qac4nnFnXE8FIEmKtah8Sa7aFi/dl74NO3+ozC8+MNutvFzv081nL7ZAv2JcqBMBVH
	 ZG1yD8SbKt+wN/2X3zhD+hvExDCLiD2T/4mvD2a9SsJFrgCVcTPEfSkJPDa1qIPttV
	 nyatupR0df/TbiP39/nrZPuv2YwuZpXlrCLC+EUMjWvW0pUTKDOQUaIUTVCyjMl4oY
	 qWP2gUuC1QRq80VFO1anPJ3RojC05jsJP3+GnEDQZjJdEyv7AgJMzpA6BkP4l9TvMw
	 wqLuxumcWgCLA==
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
Subject: [RFC PATCH 06/26] perf/core: Guard against accessing guest mediated vPMU state
Date: Tue, 24 Nov 2026 00:22:43 +0000
Message-ID: <20261124002303.1785363-7-yosry@kernel.org>
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

While iterating PMU contexts (i.e. using for_each_epc()) for purposes
other than switching to/from guest context (i.e. other than
EVENT_GUEST), skip contexts of mediated PMUs if the guest context is
loaded, to avoid clobbering guest state (e.g. disabling/enabling the
core PMU would overwrite the guest GLOBAL_CTRL on x86). The guest
context should be put before any host events on those PMUs are
activated, so WARN if the skipped PMUs have any active events.

In merge_sched_in(), WARN if the check for events on mediated PMUs is
true, as that shouldn't happen anymore. merge_sched_in() is only
reachable through:

- ctx_sched_in(): Uses for_each_epc(), which now skips such contexts.

- perf_rotate_context(): Rotation is never necessary for such PMUs while
  the guest context is loaded. rotate_necessary is cleared when the host
  contexts are scheduled out before loading the guest context, and only
  set again when the contexts are scheduled back in after the guest
  context is put.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 kernel/events/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8fd1e19cf5ab9..78441df572487 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -802,6 +802,18 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
 	if ((event_type & EVENT_GUEST) &&
 	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
 		return true;
+
+	/*
+	 * Except when loading/putting the guest vPMU context, accessing a
+	 * mediated PMU while the guest vPMU context is loaded would clobber
+	 * guest state.
+	 */
+	if (!(event_type & EVENT_GUEST) && is_guest_mediated_pmu_loaded() &&
+	    (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU)) {
+		WARN_ON_ONCE(perf_pmu_ctx_is_active(pmu_ctx));
+		return true;
+	}
+
 	return false;
 }
 
@@ -4139,13 +4151,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		return 0;
 
 	/*
-	 * Don't schedule in any host events from PMU with
-	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
+	 * perf_skip_pmu_ctx() skips mediated PMUs while the guest vPMU context
+	 * is loaded, except when loading/putting it.
 	 */
 	if (is_guest_mediated_pmu_loaded() &&
 	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
-	    !(msd->event_type & EVENT_GUEST))
+	    !(msd->event_type & EVENT_GUEST)) {
+		WARN_ON_ONCE(1);
 		return 0;
+	}
 
 	if (group_can_go_on(event, msd->can_add_hw)) {
 		if (!group_sched_in(event, ctx))
-- 
2.56.1.809.ga0b61035b5-goog

