Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9311514F5
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488444; cv=none; b=rOUyBAovnRC/YkxT/dnUy4ss/4XMMTg3oZxulOk1FxNFs97iAYnsQMMdUijjaLAxgDl0qIth22nG2T4SA8YhuY0gHrEoa1FIt5lrEoqz8c4MDnQ7JDFJx6r05GbxaHTSEnklbEfJEggaKMfnidLEpwTrPy9lC8usgq0Xhe8oPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488444; c=relaxed/simple;
	bh=khra115MfhwYq97yn8cJINr8xVP0oElGg1CFJMbnxbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYZ0F+WMfhL4hFtvZ6DoEin/CcwSxWcfdHDrjRUsPvllaT5ZF1MfkdlWYxnKZ93APBpNW5BNUvjBpyLyE9nm33+tZKN44XgbR1nBO1Sm1rWronrsK/JATtQcj/N9xZXpdRap9ZTTPsw43qR8e8t7GeH9ra+fGTr9ALGkx3jOI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqNU98Ef; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqNU98Ef"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1d51f3e9so7122730b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488442; x=1723093242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bMGNya1kRgnB01fzG2jSRfrVgJKNJ2jxqEMN5YgYGYs=;
        b=EqNU98Ef8l7SriLAZ0TmV7X0pKJ9EIC32pIZmehOL+SGj+9LuMmhrvQuA5FSNL7RoY
         9vnvQ8xSCZEUXimyoQSOOfqKiC9vbrBe47Aje6x18J3t8lmnbgEEoGnk4ZE05U6YBRzx
         Dn2rQAGioX6ZgQSCjsDqBQbLswArFDg14qonLSV0j3sMv7reU7SBAiIVL8W3xPeXoASW
         wBuIxseBgdDBQm1h9VHOuNRjrUc06y2XY9WDvXh3+CPnXgrifo8Jbl+jazu46TDFY6+R
         aHFodKZ4j1fYBsJ+Nn0K5R3o8uxSV06PY7ZEp/VGc8OBuQ7CjU66EQm2biizpVEFnI3d
         tvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488442; x=1723093242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMGNya1kRgnB01fzG2jSRfrVgJKNJ2jxqEMN5YgYGYs=;
        b=EUN79LR/LEk9bxxHq96RQfhfOb51SCe5FyCvhTMqbjrtOaCir6gb9duH4u2yjQnfYo
         tQRW8ZeIu4vN4IPKM9c8awmxLy0ZlvrfNg8o6crbYeLM6f8Hzf0JlMW81ZDxqtIU14sk
         jPhuGu7sJwpydtRfqrPTJChB4rTld+AFXC5KSccovq67R5/YRFTcPt0IAL6X2Hm4aIVl
         KaTYzOP+V7yo3UfQbr63/nwoqfmgJTZUlKp9+3Rf8KD7NXNyZzfhjsxwWhI5zbYvDC6G
         1+Y8YjvROhFyK5s5addwkAK5iKKGIVffWemxDXpvF/mDrdPH0Ezm/v+0I71JJFZQiNij
         5ctg==
X-Forwarded-Encrypted: i=1; AJvYcCXsq+XsJQxc1EU9GexdnS3atpRJ0HXDL9Eoa+iP0weWnGVaxk/2jgqRgjZeDQBb8+SwXqS5014u1QkgyghqrL/Yn5lOQnnEntZ+C+S2eof1SA==
X-Gm-Message-State: AOJu0Yxz45vCSeS84U/wpl8F/eVKo/yFbCX1ex08vr4vCvE8xzAlWkZ9
	bpKXsepFowby8WdAyrQQeTS/W2HfhckMrm2d/QSNuuDA0qlfwiQP2ABuwjufcyXgTwXZArxrXiY
	vcpPaUg==
X-Google-Smtp-Source: AGHT+IGfx7mO/NY4BArw2bym2Mie6tKCDGVNHh0oFe5aCqJBAueW7+HcjI5X9KNZUDZ4yiP5Y8S8ibw5gF+y
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:aa7:85cb:0:b0:70d:16a4:c34e with SMTP id
 d2e1a72fcca58-7105d807b66mr5878b3a.4.1722488442283; Wed, 31 Jul 2024 22:00:42
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:58 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-50-mizhang@google.com>
Subject: [RFC PATCH v3 49/58] KVM: x86/pmu/svm: Set passthrough capability for vcpus
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

From: Sandipan Das <sandipan.das@amd.com>

Pass on the passthrough PMU setting from kvm->arch into kvm_pmu for each
vcpu. As long as the host supports PerfMonV2, the guest PMU version does
not matter.

Note that guest vCPUs without a local APIC do not allocate an instance of
struct kvm_lapic because of which reading the guest LVTPC before switching
over to the PMI vector results in a NULL pointer dereference. Such vCPUs
also cannot receive PMIs. Hence, disable passthrough mode in such cases.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 64060cbd8210..0a16f0eb2511 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -211,6 +211,8 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+	pmu->passthrough = vcpu->kvm->arch.enable_passthrough_pmu &&
+			   lapic_in_kernel(vcpu);
 
 	if (pmu->version > 1 || guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
 		for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
-- 
2.46.0.rc1.232.g9752f9e123-goog

