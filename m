Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313B144D03
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973528; cv=none; b=pZngw3re4mrXwMV6HnY7LJVPDxlHUMYi4aF5EPCjRStlMsuJZ6rZjKnYUFTNUeETgL22b0Es/6mJ9Jp+G55m60i52E72b5coykNAmGqzSFIF3/MxYvv89CUqPN86ZJZI7R3fX/VZ9RlskWybo3h49Qnr/DdWeI/S4qiYAWL+J0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973528; c=relaxed/simple;
	bh=jBwiMX7wI5HSLPF5fi9xEqtZdEHS8PbAGIyITtauspA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BhmAYSeTfKb0rEyoZFdu3ZoY8ss477SSdIreb/tRg8HZ62wxiG8kxX7EhkdJvChVUOaHfeIsvZcbiOXo8Q0BjfO+nsxY2LCwexPZPKgL7+nwktoJtMhoJSBJf5A8IdyzIlbei0AmYJJHgS9YDJRZE3F3kE0K+bcYeeteDZLYSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YI6Sk36j; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YI6Sk36j"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3756e6333so2198094a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973526; x=1715578326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8V3t/43+VUCDBaE5V+mRBCTLjWbUoLkXSrwV9/F1T0U=;
        b=YI6Sk36jQIALMfDO8i+e9AOIHGtbmvruCQs0TA87uH3eDWzyG4SoTtAH8PBs2Jidsf
         aPmGpBmUd3nagLqT9sObwjqRU/OaWR2byn+/naFhzCFBUvX3utr+xv53FDzvAk9qjp7R
         6Ll/8M9b50UkWwdcU85s16ZnIF55XFV+PQsnSmcNBC/hcJwyCLER9iuWTNoUb/DzA+VC
         EiCKUlq9RJAmmQmiHJzNOFVEOSOzZAQweFyuqHSP3GHWz40YrrmOh/3Y2l2Xr19JYogp
         QCZWPGDgmmLc6Qv6li1W70rDUwv0jUeeDZEhHnRpdW1wNQ2toEeBEqyKmI3o8ITg03YK
         /v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973526; x=1715578326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8V3t/43+VUCDBaE5V+mRBCTLjWbUoLkXSrwV9/F1T0U=;
        b=uw8QuTRL5Qnv66NvJdFyihcgQBZYD/jeZ49B4PgK3CUCksWQMC11YGbwhUq/C0KLsg
         E3Nt3QfHrEJpAniodWkIiG7W6z9J6pooDqEEXPw6uis1NNxvdLjti1NCb+ovRvfjH1SM
         MMDNQ0ohqp4JzGjJnF7QHrl3rpCuCXOgiVdiC/Xkwkl9oKSJldlxWAL9V8VcO0krTumu
         EDiSChW93nM3O29dYYd3+OE8Nw6kHidkaf5JR/Ii8o4U7Gsj/zMuRRy9gz2sV79l+pzN
         eQ6BDHlk5scytMLI5P+DsLLlrgJHkEF6/3qnVshxI/piT400493RbK5M+Z7VpbGvLdjb
         UYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGIbjBqZXW5VglIziKB0iSUZMLhsCY8VzjH0ikMaxYfMMW/a0yKmFMRrGVDt4z7lu+8jBPbIzbiJI55OMbmaG8/ISo/px1dcp5qHgQEAluAw==
X-Gm-Message-State: AOJu0YwYl64tMCFnCzFbbYJw+bqDGIoHPNCvOXM9n8uG8cSZND9So5X8
	DzqTbAZQXt/ne9gqFLkWY5xw7QG+dbTvs0FOPCsJnCYe01BnYcd1pa4JBoq6rCNlBighkJEGxZw
	KNlgjsQ==
X-Google-Smtp-Source: AGHT+IHCD7D1gafdXvnIaWh5MkPYdDClrelpiWTXntnXJIQreciZAWpYD5dSVRqOOaEkmZpIEOG7CsdVjTmf
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:124e:b0:2b2:b00b:a342 with SMTP id
 gx14-20020a17090b124e00b002b2b00ba342mr29501pjb.4.1714973526441; Sun, 05 May
 2024 22:32:06 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:18 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-54-mizhang@google.com>
Subject: [PATCH v2 53/54] KVM: x86/pmu/svm: Implement handlers to save and
 restore context
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

From: Sandipan Das <sandipan.das@amd.com>

Implement the AMD-specific handlers to save and restore the state of
PMU-related MSRs when using passthrough PMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/svm/pmu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index bed0acfaf34d..9629a172aa1b 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -295,6 +295,36 @@ static void amd_passthrough_pmu_msrs(struct kvm_vcpu *vcpu)
 	set_msr_interception(vcpu, svm->msrpm, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, msr_clear, msr_clear);
 }
 
+static void amd_save_pmu_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, pmu->global_status);
+
+	/* Clear global status bits if non-zero */
+	if (pmu->global_status)
+		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
+}
+
+static void amd_restore_pmu_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	u64 global_status;
+
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+	rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, global_status);
+
+	/* Clear host global_status MSR if non-zero. */
+	if (global_status)
+		wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, global_status);
+
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, pmu->global_status);
+
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, pmu->global_ctrl);
+}
+
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
 	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
@@ -306,6 +336,8 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.init = amd_pmu_init,
 	.is_rdpmc_passthru_allowed = amd_is_rdpmc_passthru_allowed,
 	.passthrough_pmu_msrs = amd_passthrough_pmu_msrs,
+	.save_pmu_context = amd_save_pmu_context,
+	.restore_pmu_context = amd_restore_pmu_context,
 	.EVENTSEL_EVENT = AMD64_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_AMD_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = AMD64_NUM_COUNTERS,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

