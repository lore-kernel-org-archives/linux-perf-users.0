Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E6142E85
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973490; cv=none; b=bdEztU90hA2S50HNIrorBU9j9k85z8r63qMhidf//x1wJ7+ZkU6X8QEEdQ/wflgbdm+L4VTfNNHsphWiE0i8w1rk/NnpPF20BE8U9vQ3qsJfhscicu9v+GdBZZWXywRQ8r4ndv/SfLkgyexKZlSlLankBfEL/lIjltMnA42DGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973490; c=relaxed/simple;
	bh=BLXx8uYyj1FRIMy78YtCnBULOdgL7oibr0nH99nQ70U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0U6n+lHgvsem8iurd0QC0JLJcwqIBnV7jytcwPrwjH6DHd/9bytG3sPv8plq5LSfBp64vl36k+Xvvad9oah27c5l7LvtzLWJZ+MxyoPtuClrlz3/L5NZ0yGVXIz/v8Itd+885kjXr6IAGI9ArkM+2lyNAtU0yKiIFsp0K6uwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCwMWty8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCwMWty8"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be530d024so34176807b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973487; x=1715578287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lnR1RNaGsHp4ocqFRaH6kMeta9qL3hAnXs6W4H7cT+A=;
        b=LCwMWty8Qwsk8OalmnYRTaGv1s+8poJCBarIR6MrTBpEBfCyQcgswT61apiTIpvmoz
         K+WKqlLlWmoAi47OKus4BEm+6L1sFltyBT1vjFiOb9NDmBxx74mRU4TG3bJ49w46fkqm
         mwk0QfBtmaj1JBPDZpxgejPYwEgoMMJQkU9uI/+nlMjtsp7r5w2JKuwJZwLNRjplj2yK
         pj/pVnqOq2B5KiL0qBUfUwtLkB/qfI+dxKOL9yAdVL1ebhbGeMcjIxTcAzAqUxtDti/5
         Vrext+u0MJOHbLptFIOVVY76j6WF+mzcv1koWwciEJQQLNpgrTyaLwbeSpK/BMvv+oXu
         cA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973487; x=1715578287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnR1RNaGsHp4ocqFRaH6kMeta9qL3hAnXs6W4H7cT+A=;
        b=qFAsT37QzeaQ055nVsgKVOKkg0OAlnwj+/tn4ODYjEmtZiT+DcOG8oBEtoX+PWvs4m
         c96DJKU3mYMqu0TOguK+PkLCQxTn/g1bgKLakQMYq42gylHk3jlhIvdtAS0QkcS+aB8b
         xs1/ohbdMs8+C5a2KpmrLTQ7PLBVmrxNH0JhoiPhuCRxUPvvkxiSOQPXvS3c/cgvOiLr
         81ASycRueDq1K5IuDTUV6G8LjgyGjrBeDgI4FVwb7RA6C1PYUGCdVgeWTf4eBZUZ+bvy
         Mb9pHPz8qMFaPoeU2FmzK57Ixs+stk2S+yrnrRi+fMRidsenY+HwW0rfs2vVFLGi06Q8
         KEYA==
X-Forwarded-Encrypted: i=1; AJvYcCVDy8M6l+blFViJZ1FsQSiYmjgiwAc+nki60IUuhwUNwTZvRkQjx+VGzgZviCqTPWhWvRudrgHfYDxId0C3UxfVTg2Nt/ynylNtDEwx/0968Q==
X-Gm-Message-State: AOJu0Yzk4UFJDFXotMI7cSghGrEzmUx/1YHI91rUVKsGuJfHOOtFEKyU
	/LuHtNTYN7bi2dByULonAzPm0pUa4y5VAmQjF0hXA/6Px0JBV+ow62l+Xd52aiuubYAro2Nsn19
	CAexahQ==
X-Google-Smtp-Source: AGHT+IGGRWZ/m5goviLRJ9+JE9k/EfZM2/OgPaRCS6ab+NfmOSplT/7T/NCCTuOWUVJz1CFT06FlJky+4ZGy
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:a0c5:0:b0:618:8bdf:9d56 with SMTP id
 x188-20020a81a0c5000000b006188bdf9d56mr2256935ywg.7.1714973487745; Sun, 05
 May 2024 22:31:27 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:57 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-33-mizhang@google.com>
Subject: [PATCH v2 32/54] KVM: x86/pmu: Allow writing to event selector for GP
 counters if event is allowed
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
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              |  5 ++---
 arch/x86/kvm/vmx/pmu_intel.c    | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8b4ea9bdcc74..b396000b9440 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -519,6 +519,7 @@ struct kvm_pmc {
 	 */
 	u64 emulated_counter;
 	u64 eventsel;
+	u64 eventsel_hw;
 	u64 msr_counter;
 	u64 msr_eventsel;
 	struct perf_event *perf_event;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0f587651a49e..2ad71020a2c0 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1085,10 +1085,9 @@ void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu)
 	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
 		pmc = &pmu->gp_counters[i];
 		rdmsrl(pmc->msr_counter, pmc->counter);
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
index a23cf9ca224e..e706d107ff28 100644
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
2.45.0.rc1.225.g2a3ae87e7f-goog

