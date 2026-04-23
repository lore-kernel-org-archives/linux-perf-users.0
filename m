Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58236A022
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956631; cv=none; b=pE8us2NHlY0mVAE9SeSru3r7Gq18LVqdl1LJRaZuzvk1FaKQLmhnqrZ42GG/34sNwI/+oHrpvXnDKX0ZMtJLBIz9TZ/pHO2xSks25jjRY5gtZkKT04GfSqo/zmpvUZIZxZdpTrcVmLUvhUheAV21uGC5Dj0oeIypEHYNeUQkxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956631; c=relaxed/simple;
	bh=CkcrXIw1Eem4o4QbNMX/btWn5w25geAaYmxE9sQm1Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3IS0vpr1J8KNFCn7FcoWJVYOKwMcWf9dC4pt46HKdJ1aY3ZpIKK8r16vEtWhOOer/+7xSCnTGrJYY7wC3FAr9Iq3Shh5jwDPmbXdv3iTtEAr8zlovi+xzX7OmYZYgv3CorwwMZtgA8yDSUn40DrlMcm1xD0hbms/j2beOWMc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSkf3hxb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSkf3hxb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7977177675so3455649a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776956630; x=1777561430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i2vqUKmveKZlZolMhgpBRxhYsBG7B/PvclnkTlsDmdw=;
        b=iSkf3hxbMio8zWPrUs0d6Oii4d4M/OBc6e1jxtR0aWJ+jo9yt1eFuxilHcQuKf++fQ
         NiR+vVWgYl8bDnbbtm5g5yllpZYUaJuRdXaTENH0gPSDijS4h1mM3NR3fI7zjMITrmjZ
         87hknsmpaZeuSI7IxGNONRC4rkQWuNxuzci6yBAO+V4w3DiVyQD51szwEfClKpJi0LNe
         jPBcK+rNGswiGFC/SA4hIMXJPVE1tsgFlut+TyFHZsU97mdhMA4044Q+NGUvs8yt+kBZ
         YyLt3kkvGHX92bemSTLqU4qdtnVf8dE4pET3gpmyACNIIq6KUXeGJ2F0yi8IlaLgM25d
         fHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956630; x=1777561430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2vqUKmveKZlZolMhgpBRxhYsBG7B/PvclnkTlsDmdw=;
        b=jXzXMpV0x+iAMjUicx/ZYAdIVDgeRuMOYdQXyd41V7O7IXZ1bqNlshvAHZtfRQjbCi
         Df9Kqf02lU8nLpZ8C4iV8ComFI5d+46HlACaCKfpnK7F7RIg0CRtrCf3rgycoMHujOaO
         +38oRe4ktVOtmxFblBQHFKXSgDYoc1ZFpn/OJhaPt1C6gfiPAk41AMlLwdmIjWGqLeIF
         mur6HhEUTDGqNJq/aBJcnsy4vIiX4KRtbQfjeptckeb5O5iYS/3CRu3zUrfcIyuQzbIp
         J/Rof62wCAkm/BrijnqZM2dJ1lJha45FGTi/E2wZwhpKvXcVDV73mMWqdkMjrybj4qjH
         EhJw==
X-Gm-Message-State: AOJu0Yz+LmIhMVy2tOtUEkpYQAfoWAjU7oLkI1Ql0Q0ql0E1EPe1aHMi
	IkeTi6A/cSfXP4R4izvZLEkDT0lvQf8XMOnRIO3ESezPk4YD9Kn7+1YTRLIAJj0x3jZoU7Jkhi3
	j9qTB0Q==
X-Received: from pgnp16.prod.google.com ([2002:a63:7f50:0:b0:c79:66d7:2ed5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7285:b0:39b:e321:67ea
 with SMTP id adf61e73a8af0-3a08d8fba25mr30645370637.45.1776956627069; Thu, 23
 Apr 2026 08:03:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 08:03:38 -0700
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423150340.463896-3-seanjc@google.com>
Subject: [PATCH v2 2/4] perf/x86/intel: Don't context switch DS_AREA (and PEBS
 config) if PEBS is unused
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 002d809f82ef..407fd392fd46 100644
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
 	 * Disable counters where the guest PMC is different than the host PMC
 	 * being used on behalf of the guest, as the PEBS record includes
@@ -5065,6 +5056,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
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
2.54.0.545.g6539524ca2-goog

