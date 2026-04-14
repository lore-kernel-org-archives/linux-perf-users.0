Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C92313E07
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194076; cv=none; b=ixM2wV4ligKnBjnuVRTyDl+544LsIwZWwqNWKwlBT2xJ+mcFX3QJKgZnFWak/0tNNvo3wSumy6oTsTWz6EbeCUGmXDTllDiqc2tsVRgwSTLo1MlNdFMl3SuKdCm1hZH4MxlcIbOHA8EHwe6V0bBQy8YHrR+gF1/tZIszc6sZTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194076; c=relaxed/simple;
	bh=KvIG1l/WweA6fzYjmK6M8jEGrTyoO4PTSmR+fEG8fq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gRDRsvCZZ0d8/52Q+F4OW6u7R1XB5kN4U4BCLvOyqyWZLi9SWAB0mOb9MlvbBJovejnSgG5gW26sbP+eiMXdp8rObtpggvcDAnSE3y+Xxh0muCjAZGRNjMM7hW8Xrn0M2QAS9vjSidfLsguVZWZqa8h4ncBXzJMILaCk3+z2opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bpg3D5eC; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bpg3D5eC"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82ce34a78edso6097755b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194073; x=1776798873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zD3eOn27bjJqO09iUaVSsE+WSP9GPb4HLOOe5wuJNrI=;
        b=Bpg3D5eCNq2Hm8PSmF3I6MT/t5SnpRJGPSFyuo5vbwmCJSsvg22BnJZtCzrEjox8jk
         Sr9ovUI8PuDDfUm1gdJ70tukRqq508V1hL0+IT2FWTngaP/yApbhTdSxsIaAxXlqbvDo
         RpmE/e4KTrWRThj7WtEkWL6EIXkbtWGWnC0Aeqi4l0Dfyy4MQ6QTym4dRmivlfEGzO3b
         y8BIgDVVrPWvXHP+m8aRLs6NeKjgqKkqjMTyimwLmltglXW8zPv7qzrCQWNqzDpGd43e
         vO7i81RrCYXCm4OpUg1yOoeQxuL3kmWXkf3/+GxrARyTMdokrQU4txnX12j0sK7SwEi1
         sQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194073; x=1776798873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD3eOn27bjJqO09iUaVSsE+WSP9GPb4HLOOe5wuJNrI=;
        b=TLdTE/69kLWrM3Zh7IlDk715Vz0F54R5PbXCb1Dzny6zqye9rJrnqr4733CM22gqb3
         xnsaiU2AbC2KsPqVIybn8Uw6mKVsYj7TY5xHraKJ5YewPzEMTDrz0ftEGP9mkTzkMt86
         KEPD9Ei87yve+Xodua2uxBxUXWwapSpAXpvg9WeozdE180e491PbuULsZ1eedWWi8Ru2
         wTyYpJ2zabScRer8/3r6HbG0SbXnsK358arNbafCp9hwIVHrzLthlnQ7NiWynB0SK9+f
         9XTJANT3z/2XEvKwriCixhlofua+6uHFWGJKFr+2sSK1rwsfdw7DJXobvF3w4GPNWipM
         rIGg==
X-Gm-Message-State: AOJu0Yy6y2+yr+IKbFINln+2MEy2vWJ4aCnJiHEkWEF1THz7xVPQaFP/
	EycZPBXZSZEOnpZ5hyNxFgmPt2FynJKgm5xEgjILDB2PqMd0fHp9u2DhnjfR5kfLY37fEDkwKHe
	lalUZEA==
X-Received: from pfgs24.prod.google.com ([2002:a05:6a00:1798:b0:7fb:ed58:5e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1306:b0:823:d2c:b156
 with SMTP id d2e1a72fcca58-82f0c2691e2mr19192062b3a.5.1776194073165; Tue, 14
 Apr 2026 12:14:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:23 -0700
In-Reply-To: <20260414191425.2697918-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-3-seanjc@google.com>
Subject: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and PEBS
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
insert DS_AREA and (conditionally) MSR_PEBS_DATA_CFG into the list if and
only if PEBS will be active in the guest, i.e. only if a PEBS record may be
generated while running the guest.  As shown by the !x86_pmu.pebs_ept path,
it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabled
counters are disabled via PERF_GLOBAL_CTRL.

Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
writes per MSR on each VMX transition, i.e. eliminates two/four pointless
MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 002d809f82ef..20a153aa33cb 100644
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
@@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
 		guest_pebs_mask = 0;
 
+	/*
+	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
+	 * active in the guest; if no records will be generated while the guest
+	 * is running, then running with host values is safe (see above).
+	 */
+	if (!guest_pebs_mask)
+		return arr;
+
+	arr[(*nr)++] = (struct perf_guest_switch_msr){
+		.msr = MSR_IA32_DS_AREA,
+		.host = (unsigned long)cpuc->ds,
+		.guest = kvm_pmu->ds_area,
+	};
+
+	if (x86_pmu.intel_cap.pebs_baseline) {
+		arr[(*nr)++] = (struct perf_guest_switch_msr){
+			.msr = MSR_PEBS_DATA_CFG,
+			.host = cpuc->active_pebs_data_cfg,
+			.guest = kvm_pmu->pebs_data_cfg,
+		};
+	}
+
 	/*
 	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
 	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
-- 
2.54.0.rc0.605.g598a273b03-goog

