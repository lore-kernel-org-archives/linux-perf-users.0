Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D9511E89
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018066; cv=none; b=jsM/bwhuCU5FhZjmrzbWggffhHtS/0X9Lo0Mv6FCnJngS3chl2zn9sgPkMPYSvqW9gUNdQsLUbplRuNsBV34kMZJ2snRo2i1uKowwd7C2/OmI3tzSDUyZhwCuzM+MylC+DrzZnRp7OoJ7FkEorN6y+VU1jGT6AMe0KMcK1KfTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018066; c=relaxed/simple;
	bh=Qjj+0HPW0riRkHPhbzLrdrBEEtTQaT4OIWyJFj/FpFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W35KNqMkzbvp37/+4ZY8uGteONakzCpRUYWw04W9ecWrqEjM4Pl+K17BI6RhBSvuaIdqrTHqRv9TjnID/6d8HNKzd1IBIW+Eo57eXHLIlRGQG9AJTfKYQAGo9c13jUSAPBL3vrXLYX7LALP2GbZuwZ1OHHMt56KNRD/zVAwZhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKvC01Xu; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKvC01Xu"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86a7bb1dd95so238524b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790018063; x=1790622863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EdixXm7Pkqs42/ccJex84fkkL/igXqkzUgzX2RWbI8M=;
        b=SKvC01XuYna3C+qdVnWYT8fcCRAZ//3iwpJyppxgJOqj+NDsQWnqYzkhyi2KtD1lyJ
         DeY0j1GA2ujxJ3x4e9uOf3S1WJYdSY4gN9D8BkEyKym3A+2skhozhbSyOjiWXWhoHoRW
         MuJvZaV/sqChx25SSS84gyjdPphHRowjUnrX60xMWznPuX9anJgy95syRpGWFOVQ0JrU
         hgsEEE41ZnVdW0Xj51T7Qw2juICR4D+ODAZr9mubxE/UkpVc3lnDn7H92KsIBfTTmAjP
         xWgDlEkH4FaE1F+x9EqXKoRS9tBSTBIFKwfCZ5VE3r/qj8KOk1xv2/oUp4oH5TBo3OE3
         QFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018063; x=1790622863;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdixXm7Pkqs42/ccJex84fkkL/igXqkzUgzX2RWbI8M=;
        b=DUTR/1X0AMaecWIuwREftj83Yk1HNEyZdLpB+I+02alwAV0Z+JwcRmKyBwVQXcR95o
         PJ0zi6OsSYp+0bV/LoQn87MHWAjx9z1eP01O/z1tD5LyNL5kaznTGGqAg5m5ia4VUHoE
         tm49ocwypiIS6tIloLEaxxQ9sGX6ln9h4oY2su6i61oWSy5hV77D4pSm3Tyye5WDNk25
         6TYz4/J1wEpwjC0I7l8LyD3aqN5vFiWdNtaB6eq7T9ZRo0d41a4mADURKmNElqF7HCVx
         SlDSMvL39pNkl8xB3FMDTF2sLwnVW3a4m9LO9MOIgTDa20CaPSozllO6TKi40zMqKoJT
         rVfg==
X-Forwarded-Encrypted: i=1; AKwUvBxszN9Ze9jKABegFWusCXU/lRg7jGol2ijsRm997A//eLQiw2qlonhH2Pju6sD8GkdXYc7f78Gr4UljT6omgXqa@vger.kernel.org
X-Gm-Message-State: AFuF++kDH9Q9KfBFIp5L7e74sQbv8XH5ShDiRhs1dROTbOmTyjdBbJLQ
	AkOnk199+0+tYo+ZTdsS9gVCqtdzxsZHt5zSi6Gi66FnxkeQn87x8gqzTw3eqenuT3quC9a8Usp
	W/1/W3g==
X-Received: from pfm18.prod.google.com ([2002:a05:6a00:732:b0:87a:c47f:44ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a489:b0:878:3705:571d
 with SMTP id d2e1a72fcca58-87bc2081a01mr428712b3a.41.1790018062595; Mon, 21
 Sep 2026 12:14:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 12:14:10 -0700
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921191418.950933-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921191418.950933-3-seanjc@google.com>
Subject: [PATCH v4 02/10] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
*never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
to prevent unwanted PEBS events in the guest (or host).  Because perf loads
PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
host and guest masks, there is no need to load different values for the
guest versus host, perf+KVM can and should simply control which counters
are enabled/disabled via PERF_GLOBAL_CTRL.

Avoiding touching PEBS_ENABLED "fixes" a bug where PEBS_ENABLED can end up
with "stuck" bits if a PEBS event is throttled between generating the list
and actually entering the guest (Intel CPUs can't arbtitrarily block NMIs).
Fixes in quotes because leaving PEBS_ENABLED as-is doesn't fix the
underlying problem of perf (via PMIs) being able to modify state after the
perf<=>KVM handoff.

But not writing PEBS_ENABLED is desirable no matter what, as stating the
obvious, leaving PEBS_ENABLED as-is avoids three MSR writes on every VMX
transition: one each on entry/exit, and one more explicit WRMSR to zero
PEBS_ENABLED before VM-Entry (KVM assumes the only reason PEBS_ENABLED is
in the load list is if the CPU lacks isolation and thus needs a quiescent
period).

Opportunistically add comments to (better) explain the rules for generating
the set of PEBS counters that will be active while the guest is running,
along with a FIXME for the suspected hack-a-fix where perf disables guest
PEBS if _any_ PEBS event is configured to count in the host (commit
854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare
situations") doesn't explain the motivation, at all).

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 55 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f4674d93a5e2..3f8d4d037b4e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5325,12 +5325,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
-	int global_ctrl, pebs_enable;
+	u64 guest_pebs_mask;
+	int global_ctrl;
 
 	/*
 	 * In addition to obeying exclude_guest/exclude_host, remove bits being
 	 * used for PEBS when running a guest, because PEBS writes to virtual
-	 * addresses (not physical addresses).
+	 * addresses (not physical addresses).  If the guest wants to utilize
+	 * PEBS, and PEBS can safely enabled in the guest, bits for the guest's
+	 * PEBS-enabled counters will be OR'd back in as appropriate.
 	 */
 	*nr = 0;
 	global_ctrl = (*nr)++;
@@ -5377,24 +5380,40 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		};
 	}
 
-	pebs_enable = (*nr)++;
-	arr[pebs_enable] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_PEBS_ENABLE,
-		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
-	};
+	/*
+	 * Restrict guest PEBS events to counters that (a) perf supports, (b)
+	 * the guest wants to use for PEBS, (c) are not excluded from counting
+	 * in the guest, and (d) _are_ excluded from counting in the host.
+	 */
+	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
+			  ~cpuc->intel_ctrl_host_mask &
+			  cpuc->intel_ctrl_guest_mask;
 
-	if (arr[pebs_enable].host) {
-		/* Disable guest PEBS if host PEBS is enabled. */
-		arr[pebs_enable].guest = 0;
-	} else {
-		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
-		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
-		arr[global_ctrl].guest |= intel_ctrl & arr[pebs_enable].guest;
-	}
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).
+	 */
+	guest_pebs_mask &= ~kvm_pmu->host_cross_mapped_mask;
 
+	/*
+	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
+	 *        of disabling guest PEBS entirely if the host is using PEBS.
+	 *        What exactly goes wrong if guest and host are using PEBS is
+	 *        unknown.
+	 */
+	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
+		guest_pebs_mask = 0;
+
+	/*
+	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
+	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
+	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
+	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
+	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
+	 */
+	arr[global_ctrl].guest |= guest_pebs_mask;
 	return arr;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

