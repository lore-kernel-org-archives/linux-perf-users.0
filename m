Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AC3B8BCC
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282043; cv=none; b=KkUsKIqRzSKMMlrXajGBljWWBnWNUDHYFpndroPpEVXTabTbwgRgwmRelpf3DC4i46WupWYBX3wzb+32jdnrzY7m1zSwUD9jB8snDlBLLDlpV7GIH/iJ1H7UEqUZi7CUvMttCkhvZqZKTIizTOeLAwFfnVUXwzjzyTgdNenPtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282043; c=relaxed/simple;
	bh=tFFcUCT/MCFy+fJtCQEO3MKGwK66Cka9jNQ0yPI80Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eULcNaXnr2zJhE+4GCwxOiOZIRNuR1r4vG9CqOF3Is+/R74weBb4r/1Lf+PzuuqlHpUD5IFSYWjb922rzXv5x/InvGYrtbeflqumaAe9Uii8zFbkXtWnv/PIGpkWMhAk99l+vB7bnNj6TB8tF56YD/02NTzKTqW7fOA/FcyY3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6wPquH1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6wPquH1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662eec51e0so1123855a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282041; x=1778886841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0wF4wWCedm61mWhSze2xS0e/agLsW85x4eBMYp/sCRc=;
        b=c6wPquH1tHJZDiLIQil2o7/M1vRDTYI33M50Rzp+UgMcQpY0jMeOFSftKV1Oe00x7f
         Nh+XIitWDnUb+CQ7mT6eanOb8QrSp6NOqCDmiiKk+vUEOB4ecdNcMgGoCGLaAFm/tE48
         Kt9T4PVIC8TR2R31XWZGIbR13SrIc3mMejXegEG2rUB/ho/K5bPPs/S1ZFGqwRVvsF4M
         5W3QTqgGok7D4lDcP544Y9yu0yuiyUCrRDJu+cGHgK3buJ7hHTWfqMS1ZU1cG+J8II8A
         rdEUHH3hJAeDm4nlWTppTbgwg8n3ocNBazKAS6RRhUOXzy4O2vzIeTngqAboKUnwUKpM
         fZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282041; x=1778886841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wF4wWCedm61mWhSze2xS0e/agLsW85x4eBMYp/sCRc=;
        b=g9JDmU8CKe+ESQL4KClmc+95GvL+dVakV8mPgK/t6wu9qBs0Z+IfRauFNlEnpQZIOu
         LdaWhLz4ghOCZM6iw2vMssjsT6asCfYXOoAy3bjvhCIpDkN38RKRlS9MyMqm8xO5gUFx
         jwGFiVF4XDYT3FQFg9ViiAxBKmv6sRS8kfyXPYrAf/bHc094j+sMuj+Sdc1Q3WZl9Sz+
         5DftLhOh5ImxoaKrgzTIYGlzjm4m+JJ6MRWyTjyZCDP5PXH4a6HjbypI/RvxAB4Dc2bB
         dnmgg/2VXBk3CXE5X0xIWvwYxvxNCcyJvu9NGXErKh/p1rzgIzgyoXpwRao/c8ndM/w1
         jTTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/v4Fl+5I+TGhdyXn3bMD8PGbDQeOHFB5mVG+Y/AcvCEai5eF8Hsc7ADK9VaFdzeWnb+XN5h8HCCbhbPe068iXB@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmwiMvdS7BFArsCI9E0Cr8MyvDza30bbWiz03S69PSkJ1dCsm
	Mu0FuHZX6Z3RTEhktRhc0YL6MtBVchCkftoIz9xk0d+jI7A0rG/d+Rx5PmjmuLRpne/bRlEwstL
	KRAKDDg==
X-Received: from pghi22.prod.google.com ([2002:a63:e916:0:b0:c79:7975:38ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748a:b0:3a2:d79c:4149
 with SMTP id adf61e73a8af0-3aa5ab70824mr16585267637.28.1778282040861; Fri, 08
 May 2026 16:14:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:49 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-6-seanjc@google.com>
Subject: [PATCH v3 5/9] perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename intel_ctrl_{guest,host}_mask to intel_ctrl_exclude_{host,guest}_mask
to more accurately capture what they actually track.  Specifically, an
event that is excluded from the guest is NOT guaranteed to count in the
host, and vice versa, as it legal (albeit bizarre) to configure an event to
exclude both the host and the guest, i.e. to not count at all.

Subjectively (though anyone who disagrees is wrong), aligning with
perf_event_attr.exclude_{guest,host} also makes all related code much
easier to follow.

No functional change intended.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 22 +++++++++++-----------
 arch/x86/events/intel/lbr.c  |  2 +-
 arch/x86/events/perf_event.h |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e9f5a6143e71..7f7c7927b70b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2535,7 +2535,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	}
 
 	wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL,
-	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
+	       intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
 		struct perf_event *event =
@@ -2733,9 +2733,9 @@ static inline void intel_set_masks(struct perf_event *event, int idx)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (event->attr.exclude_host)
-		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
 	if (event->attr.exclude_guest)
-		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
 	if (event_is_checkpointed(event))
 		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
 }
@@ -2744,8 +2744,8 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
-	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_exclude_guest_mask);
 	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
 }
 
@@ -3473,7 +3473,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 				      struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_host_mask;
+	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_exclude_guest_mask;
 	struct perf_event *event = NULL;
 	int bit;
 
@@ -5013,8 +5013,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	global_ctrl = (*nr)++;
 	arr[global_ctrl] = (struct perf_guest_switch_msr){
 		.msr = MSR_CORE_PERF_GLOBAL_CTRL,
-		.host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
-		.guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
+		.host = intel_ctrl & ~cpuc->intel_ctrl_exclude_host_mask,
+		.guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,
 	};
 
 	if (!x86_pmu.ds_pebs)
@@ -5051,8 +5051,8 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 * in the guest, and (d) _are_ excluded from counting in the host.
 	 */
 	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
-			  ~cpuc->intel_ctrl_host_mask &
-			  cpuc->intel_ctrl_guest_mask;
+			  ~cpuc->intel_ctrl_exclude_guest_mask &
+			  cpuc->intel_ctrl_exclude_host_mask;
 
 	/*
 	 * Disable counters where the guest PMC is different than the host PMC
@@ -5068,7 +5068,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	 *        What exactly goes wrong if guest and host are using PEBS is
 	 *        unknown.
 	 */
-	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
+	if (pebs_mask & ~cpuc->intel_ctrl_exclude_host_mask)
 		guest_pebs_mask = 0;
 
 	/*
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..1298049246d7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -713,7 +713,7 @@ static inline bool vlbr_exclude_host(void)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	return test_bit(INTEL_PMC_IDX_FIXED_VLBR,
-		(unsigned long *)&cpuc->intel_ctrl_guest_mask);
+		(unsigned long *)&cpuc->intel_ctrl_exclude_host_mask);
 }
 
 void intel_pmu_lbr_enable_all(bool pmi)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..cc0aeeb34eb5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -339,8 +339,8 @@ struct cpu_hw_events {
 	/*
 	 * Intel host/guest exclude bits
 	 */
-	u64				intel_ctrl_guest_mask;
-	u64				intel_ctrl_host_mask;
+	u64				intel_ctrl_exclude_host_mask;
+	u64				intel_ctrl_exclude_guest_mask;
 	struct perf_guest_switch_msr	guest_switch_msrs[X86_PMC_IDX_MAX];
 
 	/*
-- 
2.54.0.563.g4f69b47b94-goog

