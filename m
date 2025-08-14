Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA812EACED
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163563; cv=none; b=bBTHObP8t54RW4q5s5mYVMYuqFCMDg/kfPzH38BW/EfK4oUQO1W1S/r+H2IHuwFssha3s79lucANSCmrMmXJql1loZhnEtF1rzbFMLcGzHGN1uBFf2YI7LSRQmY4Qci8V+okuYZmW+a07y/gyhzZHbxqsfTlSX6ta0IoLxREmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163563; c=relaxed/simple;
	bh=MJ4HAF1ujEaX4WWG33h1bzdaHdgxbBRIaAA8EKMlhq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFz4GRCl6M9/APDrG/uhjHhyriWcePQWbEWmwgw6QBAiDSyEQlxNSIABETApVwp6lU6hrsaxiVdwDUq5vVKfP2KNsSf+YD+Qa9olhHIZL2lVNPWtkdT47bVf2HLosGB2SnvtEu37Y0gMMA9EsEbGH0CiILZgsUkLqHTfTpvrImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmVVqCkp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmVVqCkp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so5645445e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163560; x=1755768360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBCwCeMPq8Yt3PwfMa3l8mtDD8QogBIfg4uFSkaUtvA=;
        b=ZmVVqCkpZ4ZBp/ZEIjGiloIvluCsx2czb0PZnaMeFg717bk5uz3mU2AXs2905RFrfv
         x1icYkn2/hGv/D+tThrXVnYN+z7qnCX2GjzeLs85jOD2exX5ApRIwN/kPf59VwP39sZu
         BhMtLDPaIXsNSw6OLLGurzQ4in6KlwFqByk5i+j3HF8F/T0hFLuqWckxLbt2zMdB2A+e
         xkvwR630NWPITEpgqZ1pWev6E/SEKzSnf9Nq2NpuH6godSkrKCF58DtGOE6cMmzY0JHJ
         EmWwMgK9dW9CBhIVg224BoXN3FThJZvNzsi2/nOnJ2rtkYzEKFNPrPJiQnAGjGDN59LX
         ov/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163560; x=1755768360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBCwCeMPq8Yt3PwfMa3l8mtDD8QogBIfg4uFSkaUtvA=;
        b=kQSKTS/DdjoF+8HI5QNEO5gwqia3yf0hp0XIGA0RKN9WC5547ZRMG1k4zhXwOKCH5P
         hsIaecMqtC/Jekmx3/20KGOBLmvZRcTkHORgN9jJaavSVHacL9+piXZ+LzNn0vcppyIk
         WwDbIhTm8q6JlaUNX5G9z88yyv1RlWp2xrpHHKI+lWyJDpP6HAp/NjM74Tdp4Ezk5PSd
         E9stjKFfHAdinW/aNgy+5a8cgWlY1tV5ZgVLLaaJGbWeE+XyhARH0L5Q4B5r1ea4YSQl
         ZZKHXKybFUHBhfPqZTjEhvERU9wlTw3nJvw9vkZEBG6a36WSKimMVSk0Hg+ZCsxQu351
         qAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQvXJcmZZrZe1ebiSYmpDKlFX1zGHXzIy7FnYin4trXR46VhKkiir+kXN+SnXDEbfi4c7NXf+H3aJb/U+7tOZM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQa07PqPMhE4GfQiLfHwHD7CDBd3DITNA0yrsFYTLznjGGjaH
	A3QAxJantd/Ui6TqyGaoWI8PYa2NoVEqBf38VbfGXkXLLcbyoW3neIISASVJK312I1I=
X-Gm-Gg: ASbGnct9mQe8fRrbsiTra4o7/od7RJJ5yEoDTf08Lws8zYa2IST/eWgrbVfy6Qby3TZ
	Ql7VXuQWSGTr1fBEWN/aeD85AFf7kUhZRw3BAUqlxLzDYYCVDSiJXid8ehkfr4LWcoZBZdfgi6k
	S9Hlzx56KmEdwqcdOcJ0mpdHX1wKCosI+p790PEVbKeH3xjKDXRTDSUndXtdUV1yoyTg5PxGGxD
	jcSoILiKF31KIIYYxdq+wealQf9qA+ds7RcSiZ09UGtXouOMqzgAPvhYkNjodsuFirRwoc7rIHR
	30QWJ/256D1a8Izj/5FguZ/kcTQKdiLdUdQIG3KmJLMPMw/R24pAMpH098TLRLmzfNBt/YhoSel
	LL+7s/UsZf32WiM2HmIzp2f/eEOEfVP8=
X-Google-Smtp-Source: AGHT+IEY/vBBsMat/zDRtGVwETN+EInUSQGpLUXfrAhbT2usXhxgsQh4b8EMvcN2GhmxPcLHpgwORw==
X-Received: by 2002:a05:600c:3b8e:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-45a1b605866mr20364335e9.4.1755163560021;
        Thu, 14 Aug 2025 02:26:00 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:25:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:24 +0100
Subject: [PATCH v7 02/12] perf: arm_spe: Support FEAT_SPEv1p4 filters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-2-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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

Tested-by: Leo Yan <leo.yan@arm.com>
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

