Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802693A641E
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282039; cv=none; b=Y8wLQmsXOrdTPd/jZyDTwZIIa0D0hGi6wF44MVDbmYQfxP+CFbXEqTiCP/PE7rWtNVyM+6C/Gk3w5A5A9UBVK66jSEt2YSPNozu0WTs2845qhx0COPha/T18a/OTNkVq1TsgANUoGT15HC6L5mr/kcf+Ftt1SBj88AeaBHTlnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282039; c=relaxed/simple;
	bh=iJzNfQSCA5VjS8Kr8kZpQXZ0VSjA9HwsvTs8Uq9Dfvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk1xmlxTkc6uACuvAoXZu9xyWqjyeqCdPNzabf5fvWN0IUZls2FzqwzOmIjEGCEJ9Pc5kl2iIowyffFj4meKVNYMbrbAf1PEOsvroxhP7XPI8J5ZejvHnaJpY+mrpcifLyPaKLpfseJJpbeis5xxZ1i+Givg6liv96idFbudG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPefgnhk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPefgnhk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so2498284b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282038; x=1778886838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nL2nuU0zBSPyTxPi7rivKlYOUZruT8VJE95GVfuQzuo=;
        b=DPefgnhkR5NDDbYo/PwWMfqwoxdIrExi54zgNbN4GwfKDTgIBusszGsNHnuC6sl4FW
         vDijxANNFATAy28/ASkOajt85R8Kp2es+TChXb1TvxD8v+Ef/qPgQ4AVvTuumBS1UOmR
         kHWh8Gq5qD5Mm/y0Jq48Ns8ETdQb4vmW6ciarRu6pYJfCGmk60EjpA3dUgeVEFAa+6/N
         GK7qG2bUGGxu3vTqTg1b0v1VGhM3sTqEyJRscEGjpsweQkQu6MuwuZ9l3Fdl7qtiFd57
         2kNmxevUxXfloxWExu7SCxETmWL31sm5VAZ3siscKSYe2/Zt3rYCEOIFbYNtMIv3/A/O
         cvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282038; x=1778886838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL2nuU0zBSPyTxPi7rivKlYOUZruT8VJE95GVfuQzuo=;
        b=qTMmRplrA18BO38HBdRI4GjFo9ev/PrdPd96pDP9L3mPli4WMgQ2fAZpEaADklSjR9
         tSByObMobSiyJ0KMlBNb4vTb0cxehXq5UMSrA81G+6nn5g16bTDo0aPMiut13VDqKLJ0
         9Yjm/gatdTTS+jKYG45Ga/+zLLL44t7RlxXeIPy1kMs6xyNd2zk+kl/uGIboLXQeDhtF
         QDZMdMxPW7OukGoG1iQUpCkUJjqmMkCjmqbXZCI2O/eoHG2AdsFCP4nm/ZbSSvgpFK7+
         98m23GVFKvx2MNFCUMi5HFL+2KVdOSM6enUJSBNjJmh6NdJwSH9M3sYq3fJwiaTtdFTI
         3V/g==
X-Forwarded-Encrypted: i=1; AFNElJ9rY1G8Rq2CRTNLhDjn8y0a6oBkPcWX2VgQZnRF0pzU7jEkm1j20ONtLMLHu6cZGcYXSkz/o003WzH9iU3mpjZj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0WSTfmu+CYdRKwqPyaik9UhazNjf8NcXB2FQ4M0LGOyS9jmLS
	kpt8VL97u5jHKq8tektLoPEHXc+bLcmgLRpvY8gpYvg8gE/XyzQMew7soRAo1rnoOvr8UhFIrIQ
	9/qxc6w==
X-Received: from pfjt21.prod.google.com ([2002:a05:6a00:21d5:b0:82f:a2bb:a7cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8009:b0:835:cc47:6ff7
 with SMTP id d2e1a72fcca58-83a5eb3a49bmr14404275b3a.50.1778282037655; Fri, 08
 May 2026 16:13:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:46 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-3-seanjc@google.com>
Subject: [PATCH v3 2/9] perf/x86/intel: Don't write PEBS_ENABLED on
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
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 55 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b70dc35fcceb..13cd12d3eeee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
@@ -5051,24 +5054,40 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
2.54.0.563.g4f69b47b94-goog

