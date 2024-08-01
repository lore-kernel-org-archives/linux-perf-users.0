Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0114F9DD
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488431; cv=none; b=iAqO0Wjci9cn6FKDXyrMWN8Er3jQeX5FDXtOwTn7ywUiYmpAnENOwzdu5vkCuCdOQX/NWY0rfwYITq0SYJ8EIOtKIT+egylbkocjWi7R058s4dKTpvHg09zsyES7/C9jTlaABAEP3Bv9/l9qUx8Fs+RpdXF6JLC6Bw+F/hzI97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488431; c=relaxed/simple;
	bh=7iFLRpxCNJxlym88F0bUoG1NCAHDJGUFPH+qNfjdvqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFyrawOKWMdoKa+ADoF6to/xZCsgLIhBhZwU04CkEzlbL4g0Q/kavFojE713XFOT2z8kasdZFmmFVaNVqnlUh5dQUCWeuxlL6T7hyPXoRt1b8nFULBjIoXZgNLyPUOluzJvFgayECVYwOWkzIG6jsCuyFounuFoaExknEds1YWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7eLXsxP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7eLXsxP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fee7c9e4a4so50475795ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488429; x=1723093229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MYIaRCJR9KXfQeP3vZxlCUD7Ptg5FAXmwROhpQn8ZNw=;
        b=w7eLXsxPjEif45C4AKIT3OrVYcjukLUvkQv/q8Qk5No4N6xmeVzRUpM3zdp5EVx1oT
         XBUrSnulc0Ma/JspKHJ+9Pz9JrYUfyCDRsOm8R19oJI1DJx+wGyYOe+wJ9/8goxQ/F+z
         A7Mxl27FH8/XqWZRR2ax5E1lBCoktU9ZDX1480gqvA1nGLcJ9c3gfY9TNBSjqvuQuheI
         JVldSX9OKkO1eRJ2Sg/7Xrxe7YohyRRW3JTBiDdb9WHQTl92YB/GFQq995HQTzces/hT
         yvAFZrwnbbreIYuLS70FZ9BFxKwCkNxECK1rgvo5BAxUp70d1TzqNYp8Rce4TGNF5UAS
         GZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488429; x=1723093229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYIaRCJR9KXfQeP3vZxlCUD7Ptg5FAXmwROhpQn8ZNw=;
        b=UBxV6fyIg+UATnqhCIMEFG9QnB9o/pluAgOBx+MOwFToC6RckAZpTZmeo41JB62WeY
         /FSKcSkUnSO79eRWnJjA89t9RvMsln+/MrFBd3Q2/8WplRszBVuJ5IG+vo21AEazyBxL
         uHP3BcKmOaePbp6Wn9UNFY3oPTjj5M9ByOkE/PnYwejqoZJjE+4cvQcd5X7ECDg46Pli
         SUtITXfWiNhuemoE7WCSyYMjoXoIRKOIqfeXDtDMYdKdeTPgS6/t+W3IPuOzl98I7iHT
         tDrdxGM3kqGZkxeF/LKYlnUiJUBaaf4lDrbdxDirjwWdbgX/8H+59IA/ti5yLojCOiRw
         hCwA==
X-Forwarded-Encrypted: i=1; AJvYcCXmb6eYxlH/ye1Nl8ySkSKYcgPeKnYl1C8IXr/RCQt1hgLXsU62GcuaHXWLe0wcxUiOjHtdgKPKLsJ3LqwSckXoUA1RqsxTQfU0TJdApHgOkA==
X-Gm-Message-State: AOJu0YzQq3IiGUFpTNFe7fygfaivyUkzYpyNQznMuxw2WCr3Mt55bEUd
	CJcW4PsbT3jnMbYljDz28bLfb3mRAyLJowyP+w2bSfqoDYE9fn8zRvWpJmi/PPgbutb5SQA3kJQ
	FBzoIlw==
X-Google-Smtp-Source: AGHT+IFTMAmfGnGK0igFx7Zv5FKwA/uTx54JxyxM0/4jv+JbOdblOvarmWsJVgiS5TVGU8XxieB3hR4Wn3IC
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:902:788c:b0:1fd:6529:7443 with SMTP id
 d9443c01a7336-1ff4d241368mr467005ad.11.1722488429024; Wed, 31 Jul 2024
 22:00:29 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:51 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-43-mizhang@google.com>
Subject: [RFC PATCH v3 42/58] KVM: x86/pmu: Introduce PMU operator to
 increment counter
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce PMU operator to increment counter because in passthrough PMU
there is no common backend implementation like host perf API. Having a PMU
operator for counter increment and overflow checking will help hiding
architectural differences.

So Introduce the operator function to make it convenient for passthrough
PMU to synthesize a PMI.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
 arch/x86/kvm/pmu.h                     |  1 +
 arch/x86/kvm/vmx/pmu_intel.c           | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 1a848ba6a7a7..72ca78df8d2b 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -27,6 +27,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL(passthrough_pmu_msrs)
 KVM_X86_PMU_OP_OPTIONAL(save_pmu_context)
 KVM_X86_PMU_OP_OPTIONAL(restore_pmu_context)
+KVM_X86_PMU_OP_OPTIONAL(incr_counter)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 9cde62f3988e..325f17673a00 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -44,6 +44,7 @@ struct kvm_pmu_ops {
 	void (*passthrough_pmu_msrs)(struct kvm_vcpu *vcpu);
 	void (*save_pmu_context)(struct kvm_vcpu *vcpu);
 	void (*restore_pmu_context)(struct kvm_vcpu *vcpu);
+	bool (*incr_counter)(struct kvm_pmc *pmc);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 40c503cd263b..42af2404bdb9 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -74,6 +74,17 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	}
 }
 
+static bool intel_incr_counter(struct kvm_pmc *pmc)
+{
+	pmc->counter += 1;
+	pmc->counter &= pmc_bitmask(pmc);
+
+	if (!pmc->counter)
+		return true;
+
+	return false;
+}
+
 static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 					    unsigned int idx, u64 *mask)
 {
@@ -885,6 +896,7 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
 	.passthrough_pmu_msrs = intel_passthrough_pmu_msrs,
 	.save_pmu_context = intel_save_guest_pmu_context,
 	.restore_pmu_context = intel_restore_guest_pmu_context,
+	.incr_counter = intel_incr_counter,
 	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
 	.MAX_NR_GP_COUNTERS = KVM_INTEL_PMC_MAX_GENERIC,
 	.MIN_NR_GP_COUNTERS = 1,
-- 
2.46.0.rc1.232.g9752f9e123-goog

