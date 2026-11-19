Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114355;
	b=IY/CSZJiGDF7KfoLNWYPSWEDqL4AZIbKvYsbZFdTQ9Kr4wzWHtZgD7AFyhNUXM34RkAR
	 zMWeygnF6rByYdevn4JwiuRk/PkZurHo+xNA7Qedj+r9Wud0GjMA+Po59Ie2ftLjUgu90
	 2kj4H6aq/GgqaXYeExIJGm8ccNKgbdA5oCZkQp3Z7TSK/t7bonbAonhLo0XtLzb/+qPWU
	 5M5MzjWZlket2b04tq3ca8SCm/WKLCV7ydbGkUQATV3PDwEvzjOaHA8bgleN1XGHzuUkS
	 ZnutckYEXGWyuO9UiAaA4SOS4i6Z0NBlTPnUNNrAbtCnDEWCCK3EoW8LqbTYZs+yfeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=prmoIohS2xA8jaHyxKChBFBZwGVjZr06KfXp8bLe77w=;
	b=UMEMest2CAJ/mUpkwVNwrEB+sy+UflA6p86d96M+OSau1n/P/Pu/umo42Xnlwm3hXLMD
	 ffo+LBVV6Gm/rRQwJFCyHP61ei6BHhNsS3ppgi60fWFxmdbJ37GDJ0arbWSd69r5g0llu
	 nfDxdeU+EYQyUS1gYE/sTum/BfSQ1EpNzk6fEkbMzJpaRwVYFPF48yzvU/pJ7CUcnv3up
	 rwkCj4egK9Jl7drwEe9VjtgNZ1UvYzCjI051GPNtd1HNaw5WF9j6QyIIuYRV+kzzKe3Ee
	 96AGDXIn90hWP2sd1Vkmu+t2Wke9rYexGQQSs4xS2bSPFC1qyPUM1ugKQnF/mgJ4TNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uvnjwmfh;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3360A262F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE3360A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Uvnjwmfh
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-448d51840c4so113917fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114354; x=1795719154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prmoIohS2xA8jaHyxKChBFBZwGVjZr06KfXp8bLe77w=;
        b=Uvnjwmfh+AwaBm81oKDA6Md8sUlV5LP3/ce2otlFEis07PsTMeWROrtmJFPrGTaT4G
         kz32g7+3cbfpNvi2dF/1ygEOnkejzOI6ShxGKXaUa66AO3+USjN+H8tc8SpSMFKMyDWz
         CtCD9eAXeBqQ4qen5UAKKxy+bSb9GkRg4cqsLblxZOwIDUq9Dmcif1roKyrhGU0jl58H
         1ucZG0xh4+nrK41aY0GT2ayz9SX120jKq35dXHpNHGq+1BjwtMiIz/mfS056hn3ACAKs
         UsS8lbTRi8Sa9FB23ce/W4SANozMYnR0jXaAowRSoJwtm64fK8gM7de8JhNqNLGwJHbP
         JzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114354; x=1795719154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=prmoIohS2xA8jaHyxKChBFBZwGVjZr06KfXp8bLe77w=;
        b=byYINKQLbjhDnVtaHJxyXTo9xBbIEH226wcg6Q70HrSYLDtt6DGlUNDqCka8fXQqNg
         1TMAPmePdf6UpqxnsaVZvjCYTQQnDBCxMm5Y68iHol457gkNT5Am99aExuiR6IuAlMAQ
         NR7f7qJhq+uXiGkdxCd4y+dUvNXiVbFfCgP45L8HrRB+mAZqXIi5400QFOseAuWu3R80
         nK7539BZf1A/3mE8eUS00nWFNZWq6/mbujDvj8ZkMjw/eEyJ6PQ9N3eDE2U2+3FCrZ+3
         qtuK34raw7tMqxk8En0jI/HOndThpl09MbUh+VAXyRX/6moMVlpqJlTFphoP0M3it14I
         9JOg==
X-Forwarded-Encrypted: i=1; AL+hErHQXq7K/bUr8bf3p3+IWNDu40gziFjSdKxSSv2nBId9Y2HLv4l2jMifXjUby/B5zyjJMZAaSWP4/6FtKdQuwXBE@vger.kernel.org
X-Gm-Message-State: APuU4Z+cEZxp82OZDOp36runJIpo8y4na9zncM7PsJWT6i/C3NwV7xiq
	S4Hq9FlqU6/s/JEbnHGQaRt+tpfssfLY3Dsqe/7q9HiSSBt0n2Oouz8N0Sv+V/igVlLo1BKQW/f
	SDpccy0UMvvw232qZbrBk56Q65g==
X-Received: from iljy19.prod.google.com ([2002:a05:6e02:f53:b0:54e:9371:e0d7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:244d:b0:55b:f88d:6e8b with SMTP id 5614622812f47-57a0a10c8b9mr1106549b6e.13.1795114353687;
 Thu, 19 Nov 2026 10:52:33 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:00 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-19-coltonlewis@google.com>
Subject: [PATCH v10 18/33] KVM: arm64: Enforce PMU event filter at vcpu_load()
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The KVM PMU event filter uAPI requires disallowed events not to count.
Because userspace can install or update the event filter independently
of guest register writes, re-apply the filter on every vCPU load as well
as on trapped PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 writes, excluding all
exception levels in hardware whenever the selected event is blocked.

When running in a nested hypervisor context (is_hyp_ctxt(vcpu)), L1
vEL2 executes at physical NS-EL1: remap guest ARMV8_PMU_INCLUDE_EL2 onto
physical EL1 (clearing ARMV8_PMU_EXCLUDE_NS_EL1 so P == NSK) and honor
guest MDCR_EL2.HPMD for event counters 0..HPMN-1 and MDCR_EL2.HCCD for
PMCCNTR_EL0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-direct.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 5c8a8c42e353d..ace3e8e781538 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -242,6 +242,67 @@ u64 kvm_pmu_direct_reg_read(struct kvm_vcpu *vcpu, unsigned int reg)
 	}
 }
 
+static void kvm_pmu_apply_single_event_filter(struct kvm_vcpu *vcpu, u8 idx)
+{
+	u64 guest_counters;
+	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
+		ARMV8_PMU_EXCLUDE_EL1;
+	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
+	bool guest_include_el2;
+	u64 val;
+	u64 evsel;
+
+	guard(preempt)();
+
+	if (!kvm_pmu_part_on_cpu(vcpu))
+		return;
+
+	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+	if (!test_bit(idx, (unsigned long *)&guest_counters))
+		return;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX) {
+		val = __vcpu_sys_reg(vcpu, PMCCFILTR_EL0);
+		val &= kvm_pmu_evtyper_mask(vcpu->kvm) &
+		       ~kvm_pmu_event_mask(vcpu->kvm);
+		evsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+	} else {
+		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + idx);
+		val &= kvm_pmu_evtyper_mask(vcpu->kvm);
+		evsel = val & kvm_pmu_event_mask(vcpu->kvm);
+	}
+
+	guest_include_el2 = (val & ARMV8_PMU_INCLUDE_EL2);
+	val &= ~evtyper_clr;
+
+	if (unlikely(is_hyp_ctxt(vcpu))) {
+		u64 mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
+		bool hpmd = (idx == ARMV8_PMU_CYCLE_IDX) ?
+			    (mdcr & MDCR_EL2_HCCD) :
+			    (!kvm_pmu_counter_is_hyp(vcpu, idx) &&
+			     (mdcr & MDCR_EL2_HPMD));
+
+		val &= ~ARMV8_PMU_EXCLUDE_NS_EL1;
+		if (guest_include_el2 && !hpmd)
+			val &= ~ARMV8_PMU_EXCLUDE_EL1;
+		else
+			val |= ARMV8_PMU_EXCLUDE_EL1;
+	}
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    evsel != ARMV8_PMUV3_PERFCTR_SW_INCR &&
+	    evsel != ARMV8_PMUV3_PERFCTR_CHAIN &&
+	    !test_bit(evsel, vcpu->kvm->arch.pmu_filter)) {
+		val |= evtyper_set;
+		val &= ~(ARMV8_PMU_EXCLUDE_NS_EL0 | ARMV8_PMU_EXCLUDE_NS_EL1);
+	}
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(val);
+	else
+		write_pmevtypern(idx, val);
+}
+
 /**
  * kvm_pmu_direct_reg_write() - Write a guest PMU register for Partitioned PMU
  * @vcpu: Pointer to vcpu struct
@@ -281,6 +342,7 @@ void kvm_pmu_direct_reg_write(struct kvm_vcpu *vcpu, unsigned int reg,
 		if (reg == PMCCFILTR_EL0)
 			mask &= ~kvm_pmu_event_mask(vcpu->kvm);
 		__vcpu_assign_sys_reg(vcpu, reg, val & mask);
+		kvm_pmu_apply_single_event_filter(vcpu, reg - PMEVTYPER0_EL0);
 		break;
 	case PMCNTENSET_EL0:
 		val &= kvm_vcpu_pmu_guest_counter_mask(vcpu);
@@ -345,6 +407,21 @@ u64 kvm_pmu_guest_counter_mask(void)
 	return kvm_vcpu_pmu_guest_counter_mask(kvm_get_running_vcpu());
 }
 
+static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	unsigned long guest_counters;
+	u8 i;
+
+	if (!pmu)
+		return;
+
+	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+
+	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS)
+		kvm_pmu_apply_single_event_filter(vcpu, i);
+}
+
 /**
  * kvm_pmu_load() - Load untrapped PMU registers
  * @vcpu: Pointer to struct kvm_vcpu
@@ -376,6 +453,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	}
 
 	guest_counters = kvm_vcpu_pmu_guest_counter_mask(vcpu);
+	kvm_pmu_apply_event_filter(vcpu);
 
 	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
 		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
-- 
2.56.1.708.g77570a6a1d-goog

