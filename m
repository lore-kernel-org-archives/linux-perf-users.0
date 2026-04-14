Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215483112C0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194073; cv=none; b=hNMzGB/QfGyLvo6p/sDJZfYWhfRYpW9JpcB6vGBJf6YSuMrXpIiyelKxf+JppN4EgeAp1wW99NcfyVSpqE54zJSVfIy1AcJMp8FMon90v54d68pL7XTgzUaZn1xjkYsOQbyxnhrzZedJpPc0t5SO+ka8DaNToJaY5wvVfqycyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194073; c=relaxed/simple;
	bh=uiGyZyPT5hlzy1iTKDD7iGlyzr3ZC4NXS8HayNsphJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxU1FZJAREJDfkZotgwrfUBxinHZTjZqVYZx3ChRWMLeeFFCP0yr1VfwY//5sa86Fasp954XXd+rS7kovD5cDEfC+15Sxob40qWtHf34H3nSnoCPjZ6DriXmxFBseSYxVqbw0kWnSTUjUKLKPZjSr39IKtL9E0s+pg54sfNNxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzY2Q1r3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzY2Q1r3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so3991015b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194071; x=1776798871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xz+UZ8XCmjNlzGjmh5Kd0VePfg/dEcfDpAcdkqpwPgc=;
        b=HzY2Q1r3T3VtH36PW3hsGoX+oFMl2X+pjFIV6ZDwObKDiPAOiLw/cLaGSF2CLdUJMo
         6+DmxyarAhbWvzxdz5QOgUZc4krHvSl4cTicPUhZeW/G8fXMk7KAtWJZ40nF3P1iuS1z
         2KdDR6YMgBjEb8qpKcr++2o8brdU7wgY3JCgxcN/VQEr8Y+AUf2yO5qECSa0v4JqZMrk
         NQAMItn0TfjTkahQ8x/aARisDeWRZGZQERgoX68/O3nn9DhsNJ2k2EVvTHg9dj9c/4Ao
         QzPuiHPftG8hnveBNav8bRQSyHIRv9iJQLawVQHGcsYGiVQiqkOvT4vvTM+96GMgdDDR
         xWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194071; x=1776798871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xz+UZ8XCmjNlzGjmh5Kd0VePfg/dEcfDpAcdkqpwPgc=;
        b=OPKkA5E5kWtFB7ZQ4Tr8LLupLl2XH8G31DkmWZK32SZ/ntm9R5R1W3nbj0zCzbzqk3
         LBCi50AKyiRidH71EI3YUmfbaCjgYDhCp3VRGQyB7vOPu6aMz9f9TGCkhR3mKv+dfjog
         0I9pdRXM36JGJJUvC+EODKYWysroPPmM0B8WfcBMuU0bHP2fmR+LQg64r5FpW2T4oAGg
         K59PahyvnK4BsMoEVz7qzH1tPmCDMd9qolZpBB7KW6JyyMFcOu3cA10+nPbb+ymYdzXI
         YbxByjYSXf5BF+d1PJl9D6u+4db9bcj9V3wKXiJyIEyLFPG+MZcM7GaAwVbTt4myeukL
         4oww==
X-Gm-Message-State: AOJu0Yz2qayM+BrqgUC/RAlYl+cmlCYdtuOGp2sdniSvRTTKo4Ech8AS
	EaU/UoBjuEnsCcO5WHgp4QnV7I6BNbSRQaCOyOJokQKV97Rzdr9F97jj6OtBlRFv/g2sgNrNqFX
	k+iBxkg==
X-Received: from pfbna39.prod.google.com ([2002:a05:6a00:3e27:b0:82f:6c3:2b84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1946:b0:82c:dde3:f2ef
 with SMTP id d2e1a72fcca58-82f0c35f7c9mr18298797b3a.50.1776194071225; Tue, 14
 Apr 2026 12:14:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:22 -0700
In-Reply-To: <20260414191425.2697918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-2-seanjc@google.com>
Subject: [PATCH 1/4] perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest
 xfers if CPU has isolation
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
*never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
to prevent unwanted PEBS events in the guest (or host).  Because perf loads
PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
host and guest masks, there is no need to load different values for the
guest versus host, perf+KVM can and should simply control which counters
are enabled/disabled via PERF_GLOBAL_CTRL.

Avoiding touching PEBS_ENABLED fixes a bug where PEBS_ENABLED can end up
with "stuck" bits if a PEBS event is throttled better generating the list
and actually entering the guest (Intel CPUs can't arbtitrarily block NMIs).
And stating the obvious, leaving PEBS_ENABLED as-is avoids two MSR writes
on every VMX transition.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 793335c3ce78..002d809f82ef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
-	int global_ctrl, pebs_enable;
+	u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
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
@@ -5051,24 +5054,25 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		};
 	}
 
-	pebs_enable = (*nr)++;
-	arr[pebs_enable] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_PEBS_ENABLE,
-		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
-	};
-
-	if (arr[pebs_enable].host) {
-		/* Disable guest PEBS if host PEBS is enabled. */
-		arr[pebs_enable].guest = 0;
-	} else {
-		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
-		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
-		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
-		arr[global_ctrl].guest |= arr[pebs_enable].guest;
-	}
+	/*
+	 * Disable counters where the guest PMC is different than the host PMC
+	 * being used on behalf of the guest, as the PEBS record includes
+	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
+	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
+	 * is using PEBS, to avoid bleeding host state into PEBS records.
+	 */
+	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
+	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
+		guest_pebs_mask = 0;
 
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
2.54.0.rc0.605.g598a273b03-goog

