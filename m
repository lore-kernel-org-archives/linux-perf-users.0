Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9123B2FE9
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282040; cv=none; b=Do4GAczvhz6xHk7v518HDMiqxtyNGmAnQs9mJ/8v/D4yxiCDvN2LzHU/LfWKdpmkzoXe1zD/AihdSQj9pazYtDhu2BrC/0o6O3x/9wSlPzbjEMBi6cxJMlxe/vOTJ9NS3V+FCyHBousoPSQ0XJ5uO0JAmhxjvohpM9my1xpUcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282040; c=relaxed/simple;
	bh=Cs8x6xkY1ZiIqH1MFpLULYp8Rr4Fz288wc2+f1BQbdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQ6HSQZAsgtGkPEQ4GA2gqVN4WxSlYRYTe88ffxsy5+rJ7MgxBeXr4apm3MexsYvw3yxN2Fpta54CwcnOAL8bVzXGzWFkEeUnzEu1+dQVmD436ZHR5CdEKB32YR3vscW4pJlE4sIjt63NM1oVWNQcEidGsCNQQBbsZhKH4v0WhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjkp0TZ0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjkp0TZ0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso3703169a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282039; x=1778886839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4v9hsAEokHAnzUckzAwcqgBfPt3hYzElKEYLdatb1h4=;
        b=hjkp0TZ0I4XPp44zECGIxveGN0+23QkyFIZvoZawuGh8hxRy4sAPjF9D4jwuT/vcdW
         5bS0hr0qki+7LjXj9duiPKIr8i5pvY/HIFDipYqQ0vCNAvnADLhu6kzPWJsJ0bWXCr3W
         kAM27OkUd7edk8LAkya4iEu+y8LKVtfi4PeoRnxUZF/I/gg/D+EmAKCFLxFbK8VNGHJc
         PXjTsZYAhnStd6wj32I1Vk78V/m9RBmIey3dSU9I6nXA4i5nJ+52vv+8EXwmbK2QWjuI
         ok9X/jjC5ZhH+6F5r1DVHjnYyyYKXULNHH+KqFURd7LXMLaBtPM4KZSHvhMhrA9wztUK
         N1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282039; x=1778886839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4v9hsAEokHAnzUckzAwcqgBfPt3hYzElKEYLdatb1h4=;
        b=rjmmUnOGugImXOGiSGMAdtJHoJO038zyfHdEsG9x5CFfQYsmvj9PUwH2FYbiXJnM4q
         /NnuuXcESKKyRYjSHWAk8GPAmidG9kSKMfcvxhDQXTkHGD8yVjjwvvE3xFm3IwALbG9i
         eLtF1iVuczzDT/evsgGKZan2/4gK0A6uanKHK/Y1jGoh3BfwWzM+Q3RHJAok+Fqg6bJv
         uyqVIjTzo9z00a83f9LH/hMMLvOC9LvLN/G7fQlGMOFkCWCYuhEA/JV1RXnsqX3dKoKD
         3yJN15K33sailZw00nBDmpcj30Lrm0iLJg9oa0MSHbD3WrmpgObunTZZfyLPfBKHw4oz
         cFBg==
X-Forwarded-Encrypted: i=1; AFNElJ8GMxqtTeJyj2EQnfT2qDk2mqvGJ9JphD9WLt/NxLRGxqALF1LOI0PKm1p+KLAITiP1fBvjjy3XRbHD8n9y/jta@vger.kernel.org
X-Gm-Message-State: AOJu0YyomRyioE/6eXTTldTYIuAHlJrCeAbut0pnO4wAm3iC7DhzZTFY
	HWlMDr5IpRuL++9J1uzYnc3qu6hUb/h9bl+632pSXXUJzfb2czCTrSlUzCFK8Ub24gGZ6uiiWsy
	6H+nKRQ==
X-Received: from pgbfq18.prod.google.com ([2002:a05:6a02:2992:b0:c7b:acc3:8dec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c7:b0:398:a060:a967
 with SMTP id adf61e73a8af0-3aad426e435mr199226637.11.1778282038735; Fri, 08
 May 2026 16:13:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:47 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-4-seanjc@google.com>
Subject: [PATCH v3 3/9] perf/x86/intel: Don't context switch DS_AREA (and PEBS
 config) if PEBS is unused
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
load the guest values for DS_AREA and (conditionally) MSR_PEBS_DATA_CFG if
and only if PEBS will be active in the guest, i.e. only if a PEBS record
may be generated while running the guest.  As shown by the !pebs_ept path,
it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabled
counters are disabled via PERF_GLOBAL_CTRL.

Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
writes per MSR on each VMX transition, i.e. eliminates two/four pointless
MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 13cd12d3eeee..0e9ac2e9b5e7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		return arr;
 	}
 
+	/*
+	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
+	 * guest, then there's nothing more to do as disabling PMCs via
+	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 */
 	if (!kvm_pmu || !x86_pmu.pebs_ept)
 		return arr;
 
-	arr[(*nr)++] = (struct perf_guest_switch_msr){
-		.msr = MSR_IA32_DS_AREA,
-		.host = (unsigned long)cpuc->ds,
-		.guest = kvm_pmu->ds_area,
-	};
-
-	if (x86_pmu.intel_cap.pebs_baseline) {
-		arr[(*nr)++] = (struct perf_guest_switch_msr){
-			.msr = MSR_PEBS_DATA_CFG,
-			.host = cpuc->active_pebs_data_cfg,
-			.guest = kvm_pmu->pebs_data_cfg,
-		};
-	}
-
 	/*
 	 * Restrict guest PEBS events to counters that (a) perf supports, (b)
 	 * the guest wants to use for PEBS, (c) are not excluded from counting
@@ -5080,6 +5071,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
 		guest_pebs_mask = 0;
 
+	/*
+	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
+	 * active in the guest; if no records will be generated while the guest
+	 * is running, then simply keep the host values resident in hardware.
+	 */
+	arr[(*nr)++] = (struct perf_guest_switch_msr){
+		.msr = MSR_IA32_DS_AREA,
+		.host = (unsigned long)cpuc->ds,
+		.guest = guest_pebs_mask ? kvm_pmu->ds_area : (unsigned long)cpuc->ds,
+	};
+
+	if (x86_pmu.intel_cap.pebs_baseline) {
+		arr[(*nr)++] = (struct perf_guest_switch_msr){
+			.msr = MSR_PEBS_DATA_CFG,
+			.host = cpuc->active_pebs_data_cfg,
+			.guest = guest_pebs_mask ? kvm_pmu->pebs_data_cfg :
+						   cpuc->active_pebs_data_cfg,
+		};
+	}
+
 	/*
 	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
 	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
-- 
2.54.0.563.g4f69b47b94-goog

