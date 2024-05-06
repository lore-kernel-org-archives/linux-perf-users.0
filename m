Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B081411F4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973458; cv=none; b=C4xwm8qrgRFmBNuSI9LBaXakRRx7b1KBikoWBhKn7ekkIVgt61RNPPikT1ES+j3CxX4+N9Yg836GQptD3qS2qROwfpCwoJmFrmdcyvB4UEwFZCV5fS2ko0qOjjfEFa0rI2TXhAIVyzhAogRi8YmDQBK4fEQfhZOyXv0Zori8ESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973458; c=relaxed/simple;
	bh=TcuhI6YtfRV8vZ0wePM12+ttkjHXtSSxEaKOd1hHJh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NzVKM2Uui5RIXRrOOSAIzSXc25nxZOmdtAcwcXE0xQxrFg4l7sjj6Bkl+yGPeHRG7PRH8YKAFigzZY8yItdtO4ATgDba0+2oTQHKN+84hTbtqD/8F4PKHMSEwS/xjglKaysVdEXyFOKimtP+tHdDmCBQCMy7ozvoP31UnF84/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRKEEHKp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRKEEHKp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61a9f6c869dso1412159a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973456; x=1715578256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NKvAH+qt7PJktsvfzUqbHRpuo0JxEbz4NGbgsjYf9UU=;
        b=hRKEEHKpZCuO+/B8yJDSqHLopW4ABbTBwwDWtq+mr5v7WRJ9BIRmRvkUKrCSFPd255
         Rlc97zDDCZfgFHBfWCab/HXU0rRnMoim28GdwMJDGYfJ6Co1nfW+/SujmBzFxpIpy+6X
         aADrTMzHpw1FlexQ+gc0oyCY9xISSudPxb7a3DyZp8WqCS5NH4x+ntPruf6ne8+E8O0D
         e3EmrXVLUNz/JakFfaFDkZsLEXY+aRcEVSIp6/c3lvbXmIMKPBsgHr/Q8VKFGcD3heFZ
         wzEfE1aU5PSrXIBpJ5gR4AHYG0uSOFj/ks/DPqNjHjLvGviq2mvls8fhjYd3EJbc9UM8
         6aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973456; x=1715578256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKvAH+qt7PJktsvfzUqbHRpuo0JxEbz4NGbgsjYf9UU=;
        b=fYPBRTg/SP5mV2x5Gm+31j13UJnxrWz4RsiDAqjh72SQ4F5WrClxz/frFl6PJZLrwR
         EAI4T/90Q13YMID2CGhPa502+T8IPK1sNvBF2X3LPzBo2cWUDu+VeCyqWZsHePDIFlo2
         VW3TlTvPLl/c/i/TNzKzUzYX3aExQmNXRLiWT92iUQhm7BiFbYUZxyAqT65GOtE9i+uU
         qiTCUWAZAYJBpc3Vx3/96uGUnXughuP0AJhcB8mr4NfGi/H5yPz1BmDFgv0FKFDyTOIi
         psy6SMVsZzRdyiISrGLJtqAKVJf/lVwhB/AUtd+QwOPhNwv82cLhFcyayGN9J6tPOB8J
         dH/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGm+eAn2Z+j5PscicqfWuy5lW0mYPV7/MfdAmc2hKSz/j7BgPds/sciBuZxFArkhEI7KAL8StjPSZPRmjFcc1TBOUSEYop3hE02aX9byF7Ug==
X-Gm-Message-State: AOJu0Yy6aVc+KO5uf0YYLfIEuzIxDYM1LmJ71CaKc3YeYD7aYdaR5r3X
	7y2jDMRAZAuPt58eqef52OCWHWWQsJPzNA2f/jiDNcAXcdjjleHTHlUJ+xDJ5Gg5SD8+gsmIt7t
	VlJd4eA==
X-Google-Smtp-Source: AGHT+IHljudBrb+DXXqGDN/Sxw1D8P+it3fJKjcYYX55YSsiQYP7KW59ypVe3sa4y6oLZ9DWsNYC41uXPScd
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a65:6090:0:b0:629:af1b:f853 with SMTP id
 t16-20020a656090000000b00629af1bf853mr284pgu.9.1714973456405; Sun, 05 May
 2024 22:30:56 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:41 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-17-mizhang@google.com>
Subject: [PATCH v2 16/54] KVM: x86/pmu: Plumb through pass-through PMU to vcpu
 for Intel CPUs
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

Plumb through pass-through PMU setting from kvm->arch into kvm_pmu on each
vcpu created. Note that enabling PMU is decided by VMM when it sets the
CPUID bits exposed to guest VM. So plumb through the enabling for each pmu
in intel_pmu_refresh().

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/pmu.c              |  1 +
 arch/x86/kvm/vmx/pmu_intel.c    | 12 +++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9851f0c8e91b..19b924c3bd85 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -592,6 +592,8 @@ struct kvm_pmu {
 	 * redundant check before cleanup if guest don't use vPMU at all.
 	 */
 	u8 event_count;
+
+	bool passthrough;
 };
 
 struct kvm_pmu_ops;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a593b03c9aed..5768ea2935e9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -797,6 +797,7 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 
 	memset(pmu, 0, sizeof(*pmu));
 	static_call(kvm_x86_pmu_init)(vcpu);
+	pmu->passthrough = false;
 	kvm_pmu_refresh(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 12ade343a17e..0ed71f825e6b 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -470,15 +470,21 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		return;
 
 	entry = kvm_find_cpuid_entry(vcpu, 0xa);
-	if (!entry)
+	if (!entry || !vcpu->kvm->arch.enable_pmu) {
+		pmu->passthrough = false;
 		return;
-
+	}
 	eax.full = entry->eax;
 	edx.full = entry->edx;
 
 	pmu->version = eax.split.version_id;
-	if (!pmu->version)
+	if (!pmu->version) {
+		pmu->passthrough = false;
 		return;
+	}
+
+	pmu->passthrough = vcpu->kvm->arch.enable_passthrough_pmu &&
+			   lapic_in_kernel(vcpu);
 
 	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
 					 kvm_pmu_cap.num_counters_gp);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

