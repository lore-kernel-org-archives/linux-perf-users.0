Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08D142914
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973484; cv=none; b=d35zYp1CN8hYogJ1Uyh/VkjrKNqnMQ5wxuQWw0M5RtFmzL+kwXpJkJ8NvEQSihi8hGT/AZi3dlk7uz5XhF9DhiAhwIbPRG9mAjzqKfvptnx9xzQdUjSQ+4r3e4Fse5zvTg61vXa3Bp1DHLriAKsaMUjQ5WdVW0jiA7lvusqwcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973484; c=relaxed/simple;
	bh=YTanXM05IHphvqbUN96UEZXYNv7KIGCnmEDrWyKzy6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H983pdybyocPvobGj017hJKzwc5+mcStHfoeipmXYspkMYQb5mIQNQdNLKJxL1djabq9ku7gm3BwSHB+72NhScTFtIfc/LM4DMV1fe0cAp4s9tt86dRqS6rErnC/R6QCyomh2ONTztGnnDAO+RBS+JGkMCriYhphDvkoKWPtj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNG5i3CT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNG5i3CT"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de74a2635e2so2902609276.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973482; x=1715578282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0KnMSVPaPzVOvrVjlIbtuGaeyIlEpOBvjlGJeeiwtbA=;
        b=uNG5i3CT+otFMO4RsRU5OCf3+wUwZGSvUM8AmqB4k9PaEBuRXjfaxY0AsSnZciwglf
         VwrXYEmWz4JJ7mbyVcGJNX0/ZJ4B9f6G5Z2xHOmWNHWenmCbesavhMMhwR1d5QeQRPxX
         n8cMbXtthiLVJFVUjJIXNzFI7/4rC60SeyFEASnvWVckP6g5n6SnDC9XTDy9ANxfNkex
         o0jHG2NwMsuvJGXtDYuf6OdRg/9P5UDBdyYz6kocvJlEUHUl1j76nuJ9w1OJVcwYZ2Fi
         KjmMbFxjlPONeSzbNX68LIB6xjJUQeu06ZhBS5GZKt6/lvrcwqTSdIl1M2Kq5KM/Wtnf
         EY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973482; x=1715578282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KnMSVPaPzVOvrVjlIbtuGaeyIlEpOBvjlGJeeiwtbA=;
        b=g4B2ZoApB8SyQmBBqExmCZLL9wYeSwG1V5t2Rq091JE68j8ZZu5J/ZqwYPnUzdXlhU
         HDBO71fPZKAdnAdlbNlwe3+Hl8uMFj7k5jhciYaNsV88KsP8mo7BBRSsPWM8y/nuW85B
         AmxDTr9+gMETnI2/h73Ulg0weBB4vulMGDDo0AbEanCYuP94ymGB7/SwJUGA2R4uLbu1
         5JPu+tJCVDMfwk3JTV+FFCp7vXUMGP74CTuOWfOkTUV024sZSjjpQGwbqTLsgrAVNqfo
         BppeWj5b/IuZfhgopxXbHxVhOdNEOJcGhDeaWDQ7uNhXS6khxpu6+XIJvLhNJgW6EYas
         7ctA==
X-Forwarded-Encrypted: i=1; AJvYcCUZax03x4CYItSlKAZgulauBEzyimxlbLNun5d0t7sc1H5cQy+PlbHNz2O/DS/sSmx4Ptn93ASEZ8wV9T3JXWp4pC8JtF3NJIq6Olu7+983kQ==
X-Gm-Message-State: AOJu0Yz2cj/K0BGU7UYHRsrP5wfjUYWZhJs9JRVfcaL6MTYWW5SeTHf8
	S8YZDj/elxk6zGOom5Js2XALsms0mVaF3f0cCXGEV8iBQwKzWeTE6KSbHhSn9jyQdUTs3iebV3G
	5x+si+A==
X-Google-Smtp-Source: AGHT+IEeW7oariaEikoFS2RDwOKYRXIhJVDZHIDcuv+ayFWKAyBnYxwVe5wEiIvDG0twVXqTPSuGrbNtT86X
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:2b07:b0:de4:64c4:d90c with SMTP id
 fi7-20020a0569022b0700b00de464c4d90cmr1305649ybb.12.1714973481965; Sun, 05
 May 2024 22:31:21 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:54 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-30-mizhang@google.com>
Subject: [PATCH v2 29/54] KVM: x86/pmu: Introduce PMU operation prototypes for
 save/restore PMU context
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

Plumb through kvm_pmu_ops with these two extra functions to allow pmu
context switch.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 ++
 arch/x86/kvm/pmu.c                     | 14 ++++++++++++++
 arch/x86/kvm/pmu.h                     |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 1b7876dcb3c3..1a848ba6a7a7 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -25,6 +25,8 @@ KVM_X86_PMU_OP_OPTIONAL(reset)
 KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
 KVM_X86_PMU_OP_OPTIONAL(cleanup)
 KVM_X86_PMU_OP_OPTIONAL(passthrough_pmu_msrs)
+KVM_X86_PMU_OP_OPTIONAL(save_pmu_context)
+KVM_X86_PMU_OP_OPTIONAL(restore_pmu_context)
 
 #undef KVM_X86_PMU_OP
 #undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index e9047051489e..782b564bdf96 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1065,3 +1065,17 @@ void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu)
 {
 	static_call_cond(kvm_x86_pmu_passthrough_pmu_msrs)(vcpu);
 }
+
+void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu)
+{
+	lockdep_assert_irqs_disabled();
+
+	static_call_cond(kvm_x86_pmu_save_pmu_context)(vcpu);
+}
+
+void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu)
+{
+	lockdep_assert_irqs_disabled();
+
+	static_call_cond(kvm_x86_pmu_restore_pmu_context)(vcpu);
+}
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 63f876557716..8bd4b79e363f 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -42,6 +42,8 @@ struct kvm_pmu_ops {
 	void (*cleanup)(struct kvm_vcpu *vcpu);
 	bool (*is_rdpmc_passthru_allowed)(struct kvm_vcpu *vcpu);
 	void (*passthrough_pmu_msrs)(struct kvm_vcpu *vcpu);
+	void (*save_pmu_context)(struct kvm_vcpu *vcpu);
+	void (*restore_pmu_context)(struct kvm_vcpu *vcpu);
 
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
@@ -294,6 +296,8 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
 bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
 void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu);
+void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu);
+void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

