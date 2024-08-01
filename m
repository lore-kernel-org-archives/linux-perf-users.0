Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F91422CC
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488418; cv=none; b=ZfZ2UasyzIafB+3HzoMK31tlgatg9MTbkzTagokha3KZEE4c8qTdhc527PlQPGXHRAdcouLOv3IovRfK+BknyLo+xV44FcEjL9sk8eChARuATkjDarqywSVdJZoXt8KFHliwoAAWmFQabdCYL4EXijvWtaIk6d6P6+zW4VZ5/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488418; c=relaxed/simple;
	bh=Rj2gupleinIeOJ4kMvsxNFt16M17oDTj0RlHR3E7rxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqhpzIxhqZViIqrQV2uNd2f7xStxxjZkTCN2LUvyBm20C2S/jKlpCBYHlMMPwzCWlHyIsk8CQvzIUFyZj5yONoDIzA2vyayRh7m7inM0kKJMfDUJ8uT4a/0rwLCA59UAK/I7nYHf6pnfKh4hQWrRn0POVodcqteMSt8HS1ffPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcfC3CBj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcfC3CBj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc5652f7d4so66036965ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488416; x=1723093216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pn0DNQGT68J/BKfX5XJXHgSRwinQWRsCNvIBUEjyeLQ=;
        b=ZcfC3CBjA1hOsie4lZa+xI4UR8etK+PtzytDJ1MC+lRqvva3ND9PvXaEaNkAGDskpR
         OC5VBW3uLGAAt30QaWfyZGwpin3rD1mynr4q7a5RMZXb8MYhcy0vhsSdFS5T6kor9rqx
         Q2wCsagUH9rHeGpGRdsG6Ye70qihyf1MI/b33vgPXlExhEQTNBk8jyZjmmvin0z7opWx
         VsvDCi7BOrPDR56xoSfA0G6WTypPPAjk8Fn0Ur4koPikGN0eW8NOrxjjQrrATRMR7GH8
         D0GVgPb74f/f3wpFFYFizOjMLIqzpeZzQit32N2U0b6yHodhjSmbeejSo0eakf4pkXJ+
         fq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488416; x=1723093216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn0DNQGT68J/BKfX5XJXHgSRwinQWRsCNvIBUEjyeLQ=;
        b=BLZMQso48LnPsfYyh7Lc72bmYEEmPlhKpy2vdFF+YqwT2hj6JspE7X4K76Wrw8Mpq4
         zzFpFc2sSaUz50ZC/tkl2ytRcYc6Mop1WO35pHH0cd1mNURAD5lSpsfY2MSiGQjd/DkZ
         0BrQXvHg9FNpJhnt7JNn8sshK+Ro5YkxrvengKDznmVjlGtv33SzWYJgCAWnlGMNuYWp
         nYlMNJwz7U05JnyI4+9CSo3HoI8oorgjlypITIe4shg7Kd72AiMUlj9G0Ogz/H5ihRfM
         PDtlv06URQK/7L2VUh27PATwO1UQrLHK1to0LXIrDVAMZV0oDuDlTG4bzTfNdE5AfiMo
         3NgA==
X-Forwarded-Encrypted: i=1; AJvYcCXDgvIgcDaFuFc53NfpL3Q4TjYTOubtvCIN2wKmPbL3s8lQfalCoo5pZTHH/Rj9u7mOLOTb+lOXNh/04t2VeyNrzJoq06C+VG+JgVFa0cwoNg==
X-Gm-Message-State: AOJu0YzoOtbUPtZ3j7v44bPgsIEllLOixwIVAD3c3pjiQb215ZaCTlfQ
	eGYNI+U+8YijTtz39ZQYWxaZAyS2SKdTPv23IgABdquBr7Qux6BFY3hIpPNUBnE8JanH1VhzEJZ
	RUDV5pg==
X-Google-Smtp-Source: AGHT+IFSr6KydggPLsI+JPw3CVmdbWxptejcGi1U+C/f+6hocUkPmWtWinmmFWhFFdZB9oLJOos9ql+5L8lk
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:902:f54f:b0:1ff:393f:8dcb with SMTP id
 d9443c01a7336-1ff4ce4e6f2mr1128855ad.2.1722488415706; Wed, 31 Jul 2024
 22:00:15 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:44 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-36-mizhang@google.com>
Subject: [RFC PATCH v3 35/58] KVM: x86/pmu: Allow writing to event selector
 for GP counters if event is allowed
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

Only allow writing to event selector if event is allowed in filter. Since
passthrough PMU implementation does the PMU context switch at VM Enter/Exit
boudary, even if the value of event selector passes the checking, it cannot
be written directly to HW since PMU HW is owned by the host PMU at the
moment.  Because of that, introduce eventsel_hw to cache that value which
will be assigned into HW just before VM entry.

Note that regardless of whether an event value is allowed, the value will
be cached in pmc->eventsel and guest VM can always read the cached value
back. This implementation is consistent with the HW CPU design.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              |  5 ++---
 arch/x86/kvm/vmx/pmu_intel.c    | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 603727312f9c..e5c288d4264f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -522,6 +522,7 @@ struct kvm_pmc {
 	 */
 	u64 emulated_counter;
 	u64 eventsel;
+	u64 eventsel_hw;
 	u64 msr_counter;
 	u64 msr_eventsel;
 	struct perf_event *perf_event;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9aa08472b7df..545930f743b9 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1085,10 +1085,9 @@ void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu)
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
 		pmc = &pmu->gp_counters[i];
 		rdpmcl(i, pmc->counter);
-		rdmsrl(pmc->msr_eventsel, pmc->eventsel);
 		if (pmc->counter)
 			wrmsrl(pmc->msr_counter, 0);
-		if (pmc->eventsel)
+		if (pmc->eventsel_hw)
 			wrmsrl(pmc->msr_eventsel, 0);
 	}
 
@@ -1118,7 +1117,7 @@ void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu)
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
 		pmc = &pmu->gp_counters[i];
 		wrmsrl(pmc->msr_counter, pmc->counter);
-		wrmsrl(pmc->msr_eventsel, pmu->gp_counters[i].eventsel);
+		wrmsrl(pmc->msr_eventsel, pmu->gp_counters[i].eventsel_hw);
 	}
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 89c8f73a48c8..0cd38c5632ee 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -399,7 +399,18 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if (data & reserved_bits)
 				return 1;
 
-			if (data != pmc->eventsel) {
+			if (is_passthrough_pmu_enabled(vcpu)) {
+				pmc->eventsel = data;
+				if (!check_pmu_event_filter(pmc)) {
+					if (pmc->eventsel_hw &
+					    ARCH_PERFMON_EVENTSEL_ENABLE) {
+						pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+						pmc->counter = 0;
+					}
+					return 0;
+				}
+				pmc->eventsel_hw = data;
+			} else if (data != pmc->eventsel) {
 				pmc->eventsel = data;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
-- 
2.46.0.rc1.232.g9752f9e123-goog

