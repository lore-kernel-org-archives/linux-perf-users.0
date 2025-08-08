Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66842749D6
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Aug 2025 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652230; cv=none; b=r6t5YOjeKtv8UVcmcRY/9WXq6TKxF4aLKj70SNd8oLAG4jxF6CKpV7rtQ2kHitlTBFS9J3FKZ6Kc0k9u3NkhI0edYb/bH5UPbvVubpjq/TuzvKoqCROIcAs7IklH5ujZcvWlPNaqjEzfExXHa4bl5B1r0j/wwRoehS2+V5n630k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652230; c=relaxed/simple;
	bh=I2wprAUjGVDo+AtRM54DvcrrnAQqpHskVecGi0/r7N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABTQgwcnLhvLgjpTPpQyXq12VjuUlwD7+7Zu1T25obCjDpIwWx4rQzpaFy74TzfJ21W/DMJYBgSDafEVyOVeh5iC4RR+ostU/+I2fIfPbO5l0+zuRW2rEk+JF++rMRlrrntFT5BVckBvWcwtbenIPx8iDsK8GpRYrFR2vAXkthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbLINEHX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbLINEHX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so21008295e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Aug 2025 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652227; x=1755257027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKNrcZ2inN0dkigrfPU+4VDLBHMGjNs6FZWiUZEa0EE=;
        b=JbLINEHXatyjJogdBZhU8DfvWWU3uVy6m4jIh+XqNXyvt+2kHIuxlKs/IeHww70s4H
         NCd+nUd3YUZ1sJWm3VMNH8m7H+KUvjqpUVtYmO359R3humMoX+vYJlNPqFL4r9eJ2Oev
         WkMjfsAwyKqBjI1gCM4/FDF14h6OvMSZvTv1sORF0W+yNchwmq2AqyC6VNGDtHoFiVA4
         nVaQzaMrYwjBY8WsMdkjUSdXivDW66lkkR9XzMiFVqSdIO9fB/+kOpeV9Tvcsj3gt/Nw
         cdU/l5UqBVkUhwVCINZOVADGJ5EIbsPqCSoV603lzHRL26nuRn7uyNvJNPBd3jswOVqw
         FYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652227; x=1755257027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKNrcZ2inN0dkigrfPU+4VDLBHMGjNs6FZWiUZEa0EE=;
        b=uhV11c+NPS1NweY66wvDHn5rpldTAvHhwyjazCZ/gEallVV3B1ZS7Q2MmJwLIpbLp7
         uTTfVxm9axAc93essBOlz8sVhbKeYfhMb7gwE74/RMBeuiAvXiP57N9PwLcuuhDdMODL
         wtE8GyBwgQ0jcuBpy3ieoHnU2CD/GKCZd8DpLj8UeGxxFj98FrpdGJ46B7NKkShQeRSC
         hZsUZZ1vFFEXX6q3M54JYD1rmlXvOmWOupVfhFrkDhw2voQRWJKg26D2kd6uGSfnAtAi
         iYX58oARA7JRzTlHHOKRkiUrOuiGIzBoM9Cqsi0ROtPVOa9OYxlA9P5lODPEo3klc6Qg
         KusQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV6iCyE8MTWcrlxQ8XLqAqO/gy4BvqEY/dfvStk1f4OkN/cray+MJqc0iXn5ISEhsvURo3mzf4NzuICMLE+OGz@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTwdhMQZUynbvfPR2tktaJbpkxAV+YhvQnd5TXYtQnwPSY2/c
	Y+kad6RigiJJiCbhkpCxO3t368PDQCTzrnHdEmdB1b2l4N+o6QvjGajlbnrVLd2q6ck=
X-Gm-Gg: ASbGncv2jjjeEKm91nKfjKNocl7OATAidmlnryVcnsTSPvORsBk4T6uWAxmgTVQih46
	+JYsCfZ3yNCT69T4LK+q0S6Z1QSH2+2UrAirRSxX4SVe4vD1WV6Ut+ShqPBADnzqdBExgApRj/4
	RHS7iy4mvKpq95myi+xbUN1yJ9vR0GR/qcctntT7JZ3Kzk/QttPSVEqWPuAW9ebxchvUNFBMtGw
	33UtjDEZU5xtvdP2J/lqc24YP72Lg/Kein4Lb62vtn1vtnt9cfIZQkaQ+cT3TayVW2X754GCIRo
	hMcvhN+KmZ1NlVZq+q6A0kiiCU9v7EC+UnEcLTiG64Qhuehx6ouRLotkuksgzB8qZqLuAWqyAt4
	wAh8PomSiIpxYHZp5qw+mZXwWJQov6y20cDxIshLX7Q==
X-Google-Smtp-Source: AGHT+IEtGnKsBCIt/bHJOIS9ohOXGTF7i3Bn62tMY3vsP7Ew4XXFQhJGD0FnbE4+ZBqeRgof8LyUmw==
X-Received: by 2002:a05:600c:3b10:b0:459:10de:551e with SMTP id 5b1f17b1804b1-459f4faf9b9mr19984585e9.27.1754652226748;
        Fri, 08 Aug 2025 04:23:46 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:22:59 +0100
Subject: [PATCH v6 02/12] perf: arm_spe: Support FEAT_SPEv1p4 filters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-2-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
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
index d5b5f2ae1afa..20cbd9860c8f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -344,15 +344,6 @@
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
index 369e77ad5f13..86c9948ab5a0 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -89,6 +89,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
+	u64					pmsevfr_res0;
 	u16					max_record_sz;
 	u16					align;
 	struct perf_output_handle __percpu	*handle;
@@ -697,20 +698,6 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
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
@@ -726,10 +713,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
-	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -1107,6 +1094,10 @@ static void __arm_spe_pmu_dev_probe(void *info)
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

