Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631447F53
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973432; cv=none; b=B2lHXyZbznFhuIBb0paB/+UdyH6Z63xAT32V/NNy97mzpcZLgkgYomquJ5B3UKgtKMFBfKWSi27Ydz2yN5KJGiSNXl7BpvYF6a3Bja34c4+UcLnAw/X3mcngnCTNntgaUKiuaYzNWNJerEnVjL0Xs6q94TRcotrz6YZNBtGTRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973432; c=relaxed/simple;
	bh=lgGol9X9PrvDjavTqlM9a/BDUdJpyT52hF22FchYLKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pckO0NJsI0tidElykOlHbjJhfOOSNGdS41TEB++wVHZbEio64whTX2Naulkq7lyGKkET0DGzV3lSmrAs9jE5sx2xgX21bRIwyN0zprfaz7OZlQXeF7wIauNyWLTjKHg6kQnJRtKeuDZ+a1y3rZ+W5haHPbDU+WK+q7j75JN0aeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOGx83fE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOGx83fE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f45484830fso1414823b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973429; x=1715578229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ACCDkCRlD9tBHoUvBKfn0tCSNmu+4uS3hC8KCTfss/M=;
        b=hOGx83fEoY1D3j5dH5nXeAYnSSNbIHiu/SvDYf4O6jwsVCO6ksiKH08/6jlK8iAYvw
         P5XCZHAklkjM6tNRx96JUFyporoJaitOQWx6fdtTwGsW0bBscaY75ciCTwcUN/6SFsVC
         72xkMRhneBxiKVtfovZRIw2sAwcTMuS/wQ5Fw2NPQStUcPxePdbeWoGImSjMfQQONxWc
         Es1hB+QxTJxNzxWH62YXL5xUCDGM4bCY8fHs0dB1CChazCrGNnX2jRRL57L7Sy340+Qp
         zwnrf3Game/2DmdR+KXd/6xHjtnJdWt8QlCqucXE98Ou323+mTPsfweto+bnN7NmNiyl
         hErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973429; x=1715578229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACCDkCRlD9tBHoUvBKfn0tCSNmu+4uS3hC8KCTfss/M=;
        b=Cz0AAnbGD1NNWv8kIPooX3UMJIPa2qENeTbUof/jP3N53wWR11bX0D6Ebf20ajQ3eC
         Dn/usiW9KBNTdDKqMkyherxGDSDpghfRvocGLtJm3wZsDnVTtTGA4MSG/d2LWDnCAKEE
         v4wxbAvaUHUVPNNHmQwHt9wHYxfTD6airlaO5tcz6EkX7mVWdsKliDIo+F0mR0re5ktA
         x8siXeRseJ4EIM3NkSc8wVTWbhWi5O7jBAscjgKFQ4PFFuxZTbxDel7t/PqtxQ655G5G
         oez61rsx26grKQsOTST39EmfHhx6YYADcvlf6Q6e2H0CxTWJ1ks//+K6pI6vVOErQgP1
         22GA==
X-Forwarded-Encrypted: i=1; AJvYcCUnxayVtTydOV3ykYiTv30Wi2sTLzSUoOmS25sL7Mzs20hPEf5mTyr05Hj9D/kjilwiZMgToMVAWcrxiHM+VvG3BI91TB5ue73KSOK+YVl2Kg==
X-Gm-Message-State: AOJu0Yx4MpQeCuKH00oji45zoVpWEzbtmtg54hUzbQVdSK5ISaIQN5uD
	XX4ikcfkUJOtelIEviiDyuLOL0+9toDEt44WoXJ1n9ELchtv61VgBr92wioosV+T8N5iv2nULFZ
	LVKTLJg==
X-Google-Smtp-Source: AGHT+IEYX4QtJtZ/gu/SdroIPQpUpze1OVtX91ab7uVt7OcHA79QmRucTrnpzZmqcXaHZl7kYfEN/QektcBg
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:992:b0:6eb:1d5:a3a with SMTP id
 u18-20020a056a00099200b006eb01d50a3amr187533pfg.1.1714973428832; Sun, 05 May
 2024 22:30:28 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:26 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-2-mizhang@google.com>
Subject: [PATCH v2 01/54] KVM: x86/pmu: Set enable bits for GP counters in
 PERF_GLOBAL_CTRL at "RESET"
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Set the enable bits for general purpose counters in IA32_PERF_GLOBAL_CTRL
when refreshing the PMU to emulate the MSR's architecturally defined
post-RESET behavior.  Per Intel's SDM:

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and

  Where "n" is the number of general-purpose counters available in the processor.

AMD also documents this behavior for PerfMonV2 CPUs in one of AMD's many
PPRs.

Do not set any PERF_GLOBAL_CTRL bits if there are no general purpose
counters, although a literal reading of the SDM would require the CPU to
set either bits 63:0 or 31:0.  The intent of the behavior is to globally
enable all GP counters; honor the intent, if not the letter of the law.

Leaving PERF_GLOBAL_CTRL '0' effectively breaks PMU usage in guests that
haven't been updated to work with PMUs that support PERF_GLOBAL_CTRL.
This bug was recently exposed when KVM added supported for AMD's
PerfMonV2, i.e. when KVM started exposing a vPMU with PERF_GLOBAL_CTRL to
guest software that only knew how to program v1 PMUs (that don't support
PERF_GLOBAL_CTRL).

Failure to emulate the post-RESET behavior results in such guests
unknowingly leaving all general purpose counters globally disabled (the
entire reason the post-RESET value sets the GP counter enable bits is to
maintain backwards compatibility).

The bug has likely gone unnoticed because PERF_GLOBAL_CTRL has been
supported on Intel CPUs for as long as KVM has existed, i.e. hardly anyone
is running guest software that isn't aware of PERF_GLOBAL_CTRL on Intel
PMUs.  And because up until v6.0, KVM _did_ emulate the behavior for Intel
CPUs, although the old behavior was likely dumb luck.

Because (a) that old code was also broken in its own way (the history of
this code is a comedy of errors), and (b) PERF_GLOBAL_CTRL was documented
as having a value of '0' post-RESET in all SDMs before March 2023.

Initial vPMU support in commit f5132b01386b ("KVM: Expose a version 2
architectural PMU to a guests") *almost* got it right (again likely by
dumb luck), but for some reason only set the bits if the guest PMU was
advertised as v1:

        if (pmu->version == 1) {
                pmu->global_ctrl = (1 << pmu->nr_arch_gp_counters) - 1;
                return;
        }

Commit f19a0c2c2e6a ("KVM: PMU emulation: GLOBAL_CTRL MSR should be
enabled on reset") then tried to remedy that goof, presumably because
guest PMUs were leaving PERF_GLOBAL_CTRL '0', i.e. weren't enabling
counters.

        pmu->global_ctrl = ((1 << pmu->nr_arch_gp_counters) - 1) |
                (((1ull << pmu->nr_arch_fixed_counters) - 1) << X86_PMC_IDX_FIXED);
        pmu->global_ctrl_mask = ~pmu->global_ctrl;

That was KVM's behavior up until commit c49467a45fe0 ("KVM: x86/pmu:
Don't overwrite the pmu->global_ctrl when refreshing") removed
*everything*.  However, it did so based on the behavior defined by the
SDM , which at the time stated that "Global Perf Counter Controls" is
'0' at Power-Up and RESET.

But then the March 2023 SDM (325462-079US), stealthily changed its
"IA-32 and Intel 64 Processor States Following Power-up, Reset, or INIT"
table to say:

  IA32_PERF_GLOBAL_CTRL: Sets bits n-1:0 and clears the upper bits.

Note, kvm_pmu_refresh() can be invoked multiple times, i.e. it's not a
"pure" RESET flow.  But it can only be called prior to the first KVM_RUN,
i.e. the guest will only ever observe the final value.

Note #2, KVM has always cleared global_ctrl during refresh (see commit
f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")),
i.e. there is no danger of breaking existing setups by clobbering a value
set by userspace.

Reported-by: Babu Moger <babu.moger@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20240309013641.1413400-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c397b28e3d1b..a593b03c9aed 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -775,8 +775,20 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_data_cfg_mask = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
-	if (vcpu->kvm->arch.enable_pmu)
-		static_call(kvm_x86_pmu_refresh)(vcpu);
+	if (!vcpu->kvm->arch.enable_pmu)
+		return;
+
+	static_call(kvm_x86_pmu_refresh)(vcpu);
+
+	/*
+	 * At RESET, both Intel and AMD CPUs set all enable bits for general
+	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
+	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
+	 * in the global controls).  Emulate that behavior when refreshing the
+	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
+	 */
+	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
+		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

