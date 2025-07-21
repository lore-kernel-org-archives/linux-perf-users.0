Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962862D8DA0
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103115; cv=none; b=JFLfYNccpm/okaCVRyqcsTqzYB0wZqeclTic4QHfUCArOQXnz1lZMH/SOSiT81YMJkLTFEHeaZTjwwuxTw9c6dQt4wHP1ob7o4CtkEFQSS0XOc8Zus0q/BR69GrB2a8y4fTV9ScxCGcHSoA82q1+bSq4KbRRQTd2irMDrTeSPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103115; c=relaxed/simple;
	bh=9AqTDlFlnYNqwgH8WgsUNUI/wAUjnT2DTHCTcxBObsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyGJ6ECyNKlEc5jeQRMTdb8sNzSMDIMLxhjNk6qIZMZxAmkEvuySfK776oWWTIcNnY+u40ybf9pwHUSYQAwlr3rahia9tvwg9FKyn0aNuA9SBX6fIcaUdvv4RXnEdyqdLdHnp2Nf5EaZ9q/qM/omyFf1W7lZP38g/xH6zbaqVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXgnmiK8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXgnmiK8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ab112dea41so2519603f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103112; x=1753707912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXkvCvtwQUgO1rzNPbi1g5SXwSvNrlBklFVwiaO7B+s=;
        b=GXgnmiK87pUGvIIqDHf0qAVHmMTH4+b6K+N+QNhLBjaNQ3zFTZKkwEsMPBqZRYgLyw
         N5migcPqrPqvTDeSYwkrniWbsepZjSdySv86JE/vOmWsbfOXLkmoQj0RM0mFj6J9Rb25
         qxvOlJLepz9/9YcIYDjFaWD+GBqWJxFvu1a/dxwW6m4nEqKBmkdS1EWqzCW24NWoE99q
         gyVdrkY44VVBFB1n1Bjqy9IuVLhcNoS/BH6A+9aLg+DDyb6YBZ3f1W/QmqzRVA7hcdOx
         7Ct89+vFjHbTnoV0Ng5u0vdeY1mBOQP7wZW0LrN52AhefyaXnQ1KTRF5FFodiMXyoLoB
         RRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103112; x=1753707912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXkvCvtwQUgO1rzNPbi1g5SXwSvNrlBklFVwiaO7B+s=;
        b=BQjv8td0Q/EEciTnLrg3pS8YMNQ0E5pUVVFWr6XT0vtCP9Y6/JBK/tjTAfwNhBN2zv
         S6MiuXzGawSIYBHaTwGRGt/7GbiqnioSjc8tQqmgp8OMfX/7Clek9G1dgBD1Na01poVp
         Jri9VZ9W9PSyoE/v11r0hUxFVm2B/TdHorhQYcDsJPqCHHoZx5TmJilsbxWIcOhQ5OoM
         aoPHUYLlbcDWOxeBqVph7pqG39UGXRDOcNPoNyAsUNVdJb5S/45pSyGHvjNofNqnS7wS
         4bUF69hr7BUHjZEbCvhFN3NgjtiVJ7l7U85ZgncJnv4xUC6ddquUkjtjEiRUFYJ0jalr
         PsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjRlCJIxDIcAccqvZ2qnXJ1v1cXnCRrTVU/WZOJ+ZbmfWJQEKZKalbmsSy2jIZle6nQpI1sLZkiTEoM+ykppm@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYlPp9sR2mUYaWjRpixuOaPEzgMDijVxqjl3WPIcMYfI9bUUs
	pljVKjNumPNue5xl2dga/dcNwD54Oy9v69XMOROV2+6+K2yBD8sq1Jjyqa7DOBYHNwo=
X-Gm-Gg: ASbGncua/Q8RaaoJQxCq9bklL8ZFeWn0j4Rr/j8X6VPXBINSoDCr1J3m9DxHpxqNMNq
	26DYwvPMF+Yobvs9Z83IK+uaEEyC2A05jjo34YtcQFjhqBUUQKdJUeS4k5ItKr8now/XlzWDnn6
	TZp0N3mtP9OMzuDzp/L4mQaERInzvnDJGnnTLrQ+XC6QaWvsYqgG53mhN7egTgG6Idh+Fbr+6gr
	UWeyPg8m0o9n1gydF+Qj+QY5llNhBTU0PXO40xpYFOgJBlNo45tpFsS76nfd+kp7zqBtLghNuwf
	/8bQlq+59i6VBidl1Q3u8M6ItTwrEv70DXGjxmspxZyylCbm8wh05ysJ+UTCaBLPqPf4bYyJwom
	/pfM18eNnY9PmmBZpciuViQ+F0guMIfwu5iEb0E4reA==
X-Google-Smtp-Source: AGHT+IEOKee5OpuGt7tH1bwQK4v8AaIvDjs15a7GCVyi12HJzHIaJCx8hnFkkTJ8CZZ7zhxcjRVi2w==
X-Received: by 2002:a05:6000:2489:b0:3b5:e244:52f9 with SMTP id ffacd0b85a97d-3b60dd994d3mr15491057f8f.40.1753103111565;
        Mon, 21 Jul 2025 06:05:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:04:56 +0100
Subject: [PATCH v5 02/12] perf: arm_spe: Support FEAT_SPEv1p4 filters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-2-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

FEAT_SPEv1p4 (optional from Armv8.8) adds some new filter bits and also
makes some previously available bits unavailable again e.g:

  E[30], bit [30]
  When FEAT_SPEv1p4 is _not_ implemented ...

Continuing to hard code the valid filter bits for each version isn't
scalable, and it also doesn't work for filter bits that aren't related
to SPE version. For example most bits have a further condition:

  E[15], bit [15]
  When ... and filtering on event 15 is supported:

Whether "filtering on event 15" is implemented or not is only
discoverable from the TRM of that specific CPU or by probing
PMSEVFR_EL1.

Instead of hard coding them, write all 1s to the PMSEVFR_EL1 register
and read it back to discover the RES0 bits. Unsupported bits are RAZ/WI
so should read as 0s.

For any hardware that doesn't strictly follow RAZ/WI for unsupported
filters: Any bits that should have been supported in a specific SPE
version but now incorrectly appear to be RES0 wouldn't have worked
anyway, so it's better to fail to open events that request them rather
than behaving unexpectedly. Bits that aren't implemented but also aren't
RAZ/WI will be incorrectly reported as supported, but allowing them to
be used is harmless.

Testing on N1SDP shows the probed RES0 bits to be the same as the hard
coded ones. The FVP with SPEv1p4 shows only additional new RES0 bits,
i.e. no previously hard coded RES0 bits are missing.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/sysreg.h |  9 ---------
 drivers/perf/arm_spe_pmu.c      | 23 +++++++----------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f1bb0d10c39a..e80207572786 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -350,15 +350,6 @@
 #define SYS_PAR_EL1_ATTR		GENMASK_ULL(63, 56)
 #define SYS_PAR_EL1_F0_RES0		(GENMASK_ULL(6, 1) | GENMASK_ULL(55, 52))
 
-/*** Statistical Profiling Extension ***/
-#define PMSEVFR_EL1_RES0_IMP	\
-	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
-	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
-#define PMSEVFR_EL1_RES0_V1P1	\
-	(PMSEVFR_EL1_RES0_IMP & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
-#define PMSEVFR_EL1_RES0_V1P2	\
-	(PMSEVFR_EL1_RES0_V1P1 & ~BIT_ULL(6))
-
 /* Buffer error reporting */
 #define PMBSR_EL1_FAULT_FSC_SHIFT	PMBSR_EL1_MSS_SHIFT
 #define PMBSR_EL1_FAULT_FSC_MASK	PMBSR_EL1_MSS_MASK
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..051ec885318d 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -89,6 +89,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
+	u64					pmsevfr_res0;
 	u16					max_record_sz;
 	u16					align;
 	struct perf_output_handle __percpu	*handle;
@@ -693,20 +694,6 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static u64 arm_spe_pmsevfr_res0(u16 pmsver)
-{
-	switch (pmsver) {
-	case ID_AA64DFR0_EL1_PMSVer_IMP:
-		return PMSEVFR_EL1_RES0_IMP;
-	case ID_AA64DFR0_EL1_PMSVer_V1P1:
-		return PMSEVFR_EL1_RES0_V1P1;
-	case ID_AA64DFR0_EL1_PMSVer_V1P2:
-	/* Return the highest version we support in default */
-	default:
-		return PMSEVFR_EL1_RES0_V1P2;
-	}
-}
-
 /* Perf callbacks */
 static int arm_spe_pmu_event_init(struct perf_event *event)
 {
@@ -722,10 +709,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
-	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -1103,6 +1090,10 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		spe_pmu->counter_sz = 16;
 	}
 
+	/* Write all 1s and then read back. Unsupported filter bits are RAZ/WI. */
+	write_sysreg_s(U64_MAX, SYS_PMSEVFR_EL1);
+	spe_pmu->pmsevfr_res0 = ~read_sysreg_s(SYS_PMSEVFR_EL1);
+
 	dev_info(dev,
 		 "probed SPEv1.%d for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
 		 spe_pmu->pmsver - 1, cpumask_pr_args(&spe_pmu->supported_cpus),

-- 
2.34.1

