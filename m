Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79371428F8
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973480; cv=none; b=AxXISveda3RipucuR7mM8nnDqieBO8MB60js0Xn3JO6OnHu6whN75FHIqqXGL6KhM8nU+uwIaCM+leWEGfVp+un8B2UO9L6Vr4j6Z1RbWaH0sYVHhalHvX1if15151MpKT6vr0MYYhZgwRjvDrgSsGbvcPNpSnhNV7Dsmw3OEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973480; c=relaxed/simple;
	bh=mgV4iQYEUpIq1ZGL8LbFGyx/G7gFSg7LSNlU7Q94wB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dB50YY3t27y1aWbXTXEJlUSkSquJYuSSk4qOwzgFsjkbAs65fwRm6xaBE4wCrFe/WOCDqg0BljWS5WgJRXWXnWNbIORAUygxq+NFHLfYZv5dG/oFLHs75AyZugNOU05to3BwzRXayqJgxK9hFJyUi0pcF7TMCCYQeFfIxK6OLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kchosGnY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kchosGnY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61c6560f50bso1539593a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973478; x=1715578278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/70yXGs8th+YCT4gcj5wv3kYv7sjWJLxbxlTcSwLxIE=;
        b=kchosGnYPuoWGEPD0iWUVm0w8OSTG9JlrnvefpOpKgJ6jKI1+YuXIL+fJxfoWZJOu3
         99o11du2D0kTDB3VAGo0Kpy86merkax4UiuQH6TVy6g3go8tWHVIiO6f1ICL4n2ZgMKZ
         gKELzPqonxrVTgekf/8V8i6iorFwEQPzHMzCeVX7dHP7L1byzEOUy1vEWqMphb309jIs
         gNKth2lklwbf2uXLSps94AAwuVmxSdU1+Y+sJ8qwrgvcWrVKaHmOlgcPvan89iAEDolv
         HJCbxAiLolYu2NIdHvMClkcU3rothHrbEsh5rLerhRVMUC1E2xBTgc67kWLlUtvcbWDQ
         uB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973478; x=1715578278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/70yXGs8th+YCT4gcj5wv3kYv7sjWJLxbxlTcSwLxIE=;
        b=IFD7fJPuy7I8NlyqIXc9612mGVLRLr9j6KNvPY/kXpjTO7QVuAAbYMorSVPA19DxbP
         CDyX5mgcA42rdWHxcdRATflfFiECn8b3ZIAisAGNW+IiPfIokl2z7dfTAt1vp3OfzQR2
         K/c5Xtyy79149zWtRgUA6MrrPeY9ilVyPjYUS96eKeqwA+mihhsxeHdjDJtX4NqiONOq
         ihhzK3PhF7IPNt2uUhjAyb1yYiXYT5MNyxDq7mWsyJE3Eqo/0nLo9UwGBn18YAQcIyhx
         wrQX5Re8TNcK3h27Cc8kztdhBGfAD+oThv3VSRLD/vVuw2HOFBYDJar2vh0eHFJQ9r+/
         RT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI4obpIblRRYltzrSE7pXXb8X/PU7YDA66ZBYa1VQOT2IPFGkDOiLmsE//4JaQrl7cJCjr2wROJIQh3o1LITabEuMazdP/DYKxmBobXSIyow==
X-Gm-Message-State: AOJu0YwREQNdXc9Bl1B+ZH9r7U0s6z96zgthAdDQ2lQw50ksiUByEFI+
	9pyPzdJsNZdpLdlXsqyOOX6fh4OaC1BKSF0sChyS1ccjvh8OaEICPo4oqz/tX8z6LTNV3cJ+Bag
	hTtyd4Q==
X-Google-Smtp-Source: AGHT+IGmigk3vBnW7SnpRMwSoZkgDc4bh9EamVvfQF1uS77a7Lmp6JCTvus9kRCVQsScSgZ+HIaoTD+fJiMu
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a02:592:b0:5dc:6127:e8b6 with SMTP id
 by18-20020a056a02059200b005dc6127e8b6mr24957pgb.3.1714973478215; Sun, 05 May
 2024 22:31:18 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:52 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-28-mizhang@google.com>
Subject: [PATCH v2 27/54] KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
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

Reject PMU MSRs interception explicitly in
vmx_get_passthrough_msr_slot() since interception of PMU MSRs are
specially handled in intel_passthrough_pmu_msrs().

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c9de7d2623b8..62b5913abdd6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -164,7 +164,7 @@ module_param(enable_passthrough_pmu, bool, 0444);
 
 /*
  * List of MSRs that can be directly passed to the guest.
- * In addition to these x2apic, PT and LBR MSRs are handled specially.
+ * In addition to these x2apic, PMU, PT and LBR MSRs are handled specially.
  */
 static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_IA32_SPEC_CTRL,
@@ -694,6 +694,13 @@ static int vmx_get_passthrough_msr_slot(u32 msr)
 	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 8:
 	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 8:
 		/* LBR MSRs. These are handled in vmx_update_intercept_for_lbr_msrs() */
+	case MSR_IA32_PMC0 ... MSR_IA32_PMC0 + 7:
+	case MSR_IA32_PERFCTR0 ... MSR_IA32_PERFCTR0 + 7:
+	case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + 2:
+	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+		/* PMU MSRs. These are handled in intel_passthrough_pmu_msrs() */
 		return -ENOENT;
 	}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

