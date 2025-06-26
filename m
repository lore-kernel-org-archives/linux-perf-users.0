Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC62FCFEF
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968374; cv=none; b=extSXW6AIyOue/03z87J+S//MXxbIAWoWIDtsNyd2Q/soNGG8VTwbTLOVWLCd5nnj1pncqyIbjX4Fj3tpNW3D8+GU9UTmyMrMxwrBFxJ+YpD5ehuzzv8EBx+18xEexoT/HAyn7iBkUWwWQIfTs4y370C/+ls/fn3x1oLO8L/CJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968374; c=relaxed/simple;
	bh=JNAet3NELvRm4pw1yj+KmlMpWNsI1wPDPWHykWoXnxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OKnXETv0hQbmZXpfs0dnx/8wtTuQUcIhDsr0z/GHMu0jyb6+UJwxmQMOHoG27nviGjtiQeRddQGxqH4tr3Cud5Q0u650KTBHmYQWiK+nID+3HeE27v/qhn8V81/ftkq49oDxheMx2HnIxiI40SLnaiVRproaUTU7InZr41GzxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbrV3dnj; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbrV3dnj"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4067aeea8c0so509173b6e.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jun 2025 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968370; x=1751573170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsln9Cluh/lr4G6zFvH7bpJ9BvK8mJLYYPmhFGobydY=;
        b=nbrV3dnjrXPAORgeAn/DK5DbZGj2zGpx0tofsNLT5f+/wk+JGGZ7EbmRIBogx8MK52
         wvRJoGyxUvSlUKMLLIFl1sn5MmOUI0ExiwjYAgstCggk3ZTk7XE1aElovyZBmycJm1Zc
         LALszPYIb+T0Yn+aRcXDSvXW/m6i6xBzEtUPspCi3zHPa3+oQU6V97fBOIjv6y0yHnI4
         Vu7pyf7eodtv9TTmiS6BVOMyoaZ3YdmawACqcx+Y9snFRYOr36l4ndAPa+GhCcwTL+xO
         0zIKZezODbB400EdNCQFuqyfACIXNMq77x2TJBw+NcBYrkdN1pMUi1u3q3oCpohmyEOt
         z+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968370; x=1751573170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsln9Cluh/lr4G6zFvH7bpJ9BvK8mJLYYPmhFGobydY=;
        b=Rq8DCYSufQ+typAQ55zFWF1DMppA4r9HVOQDd8154NYY+1chQGhTZCv9pm3wpyl3yC
         Z+fzmnqz25vSNsqpEabxLl8jA/+Mep6n4Ht+3Jay0tQ9SOpxmbf2jrjPjhJaOIKMiHus
         Gwzt3ydfJ/16BmntI4VyQEEIUoJziL7/HbqQJ0JZVjOYmvjRlc/TZG4iAZ7rExkQvRt8
         buE5Ki+3PCvvtWyI/hkwW/lyvycAq2LEyDbz1BVb/R8PXzOSr/jw7/n8BgnWKhzZo2Rl
         XngKOSeT8ddJOA9ZRjTGCkeCqu0ETR3wcpQyA8pG9t5Kl5s6SSJ/vDhL+Cv/KnWOJbLl
         Y06Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuJq8rMdRs07SaNQpFgh5+jP5WxECG0W1b5Z+Iuhqbcgqh/y0AyxtpCA+I8s8nVSG3w+jLP+NkXiUH8ggd1/Vy@vger.kernel.org
X-Gm-Message-State: AOJu0YxgB1fkqi/PyILiVQHLSZRnP3u93uvTW5fLuj01Xc0LDwshHF8y
	rucaTtWpWNa+cqV+JRQsqXLft8tmbGYxMY4/ZauFqt4ygtey5UegaZONDZ6FXQs0eZNbf3Wj/l8
	iNV7lnlBcGe9clLD3SOFyMY1JgQ==
X-Google-Smtp-Source: AGHT+IGFAFvDi2PbexbAqauL7y5C7K4PGkXLqZnIMKzQ7KnS/pNLTbsU7lTkZfS0TlivdMxg6dS5ZH5rez4yi9e+5w==
X-Received: from oobbq3.prod.google.com ([2002:a05:6820:1a03:b0:60e:fcff:daa1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:151f:b0:404:2960:9b4d with SMTP id 5614622812f47-40b33e133bfmr396970b6e.25.1750968370241;
 Thu, 26 Jun 2025 13:06:10 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:54 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-19-coltonlewis@google.com>
Subject: [PATCH v3 18/22] KVM: arm64: Enforce PMU event filter at vcpu_load()
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The KVM API for event filtering says that counters do not count when
blocked by the event filter. To enforce that, the event filter must be
rechecked on every load. If the event is filtered, exclude counting at
all exception levels before writing the hardware.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-part.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 5eb53c6409e7..1451870757e1 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -196,6 +196,47 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 	return hpmn;
 }
 
+/**
+ * kvm_pmu_apply_event_filter()
+ * @vcpu: Pointer to vcpu struct
+ *
+ * To uphold the guarantee of the KVM PMU event filter, we must ensure
+ * no counter counts if the event is filtered. Accomplish this by
+ * filtering all exception levels if the event is filtered.
+ */
+static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 evtyper_set = kvm_pmu_evtyper_mask(vcpu->kvm)
+		& ~kvm_pmu_event_mask(vcpu->kvm)
+		& ~ARMV8_PMU_INCLUDE_EL2;
+	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
+	u8 i;
+	u64 val;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
+
+		if (vcpu->kvm->arch.pmu_filter &&
+		    !test_bit(val, vcpu->kvm->arch.pmu_filter)) {
+			val |= evtyper_set;
+			val &= ~evtyper_clr;
+		}
+
+		write_pmevtypern(i, val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMCCFILTR_EL0);
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, vcpu->kvm->arch.pmu_filter)) {
+		val |= evtyper_set;
+		val &= ~evtyper_clr;
+	}
+
+	write_pmccfiltr(val);
+}
+
 /**
  * kvm_pmu_load() - Load untrapped PMU registers
  * @vcpu: Pointer to struct kvm_vcpu
@@ -218,6 +259,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
 		return;
 
+	kvm_pmu_apply_event_filter(vcpu);
+
 	for (i = 0; i < pmu->hpmn_max; i++) {
 		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
 		write_pmevcntrn(i, val);
-- 
2.50.0.727.gbf7dc18ff4-goog

