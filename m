Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F522DFBE
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104194; cv=none; b=EHhvsx54CTeRhZThWxugkABKVgyh6qlel5rz2f0TovtEClzZd43/FHOq2toxJIRXBUK5DoUAXEJt1StaACwNVlxn+1aiAAePJ5CARXlTzfRZeYQwTtZEfdvSRYt0If4aHssI7W6d2Jo5P8Ci2RD+muOwKbiPOZ1cc38EOAylXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104194; c=relaxed/simple;
	bh=+k2DVYrU/3PHFLX0mgF6ZpUJ/AF+t47xju4ZCAoxazQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMYLJey1nLs1jA0cayiMTClZkPk9iFJHIpoM7I7dvvgvIIejwP+usddOdoTt0Ms+ZjdD3yGGrcXBIZerJ2EemdKTSLHhiXqAS3UQTYdi31NG3eHnCmiTVfxZxt+rLOUczX6tyPOBMukNHqQ7cfXMtjDc+tdlHh/ls2aepyeVTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ThO1iKR7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ThO1iKR7"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3014ae35534so1992091a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104191; x=1743708991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZHzShkVWYCElLbYIuxl2mu1d5Dwj3bbR8it0YY9hs8=;
        b=ThO1iKR7+zU4RDrBq9Bvy2grWxipNke7qkvMx+mE9QaJ7BhgRSPEMzfHd6pSRVCkgk
         BqVcCbgxoIbxFU+gPnCgP0k6HOXsMVPYkudCa2k28W9+3XeZks6GRBNEY+ISAUeFugOW
         TgK/npB0EBgg3nCaJCOK3jFXij/DcHvluG/si9ODzxFY5Ap577fyhT7wLGPeYPV4UWfg
         YpWMCUrki66SB9UxI6E5jU52VGRLAvOFiIc/fnTmUVhZxzG915EbTfouHZuf5vcb3dcr
         FCgBkop2r5qsd47ht4QdTAyqpdoR/t1Nur5UjLis6eILaRpLhRdqxP9ZtS/eJWCXHZS3
         5h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104191; x=1743708991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZHzShkVWYCElLbYIuxl2mu1d5Dwj3bbR8it0YY9hs8=;
        b=mF+uDaO/Fw4a1/Sb+JYhcu6HBWEWuAEfoVqfzY+CQa+c3fVL7erjZDp5sDueALGKp0
         mnuZdVH4+UWuO16Lnmu3IWQ0ezFTNvOj6aPswTYaG/9vfWkZOfM9dcKdeefkm5aQP8pB
         02S7NbgAvXQcS+Y1sThw8ra4YfOdT8NzSyWky1O4ntiHpUU7iNv+jzgLwNtMu98h84bH
         wa6nyyRQWew1bAep6Chjr/RVX+c7ZbktKgAg7VlibojOIe5Tj54zLBXeeoBk4CMCIxOB
         0HtZVN8WbosJ8dePJwSwIO/KZVMIVB3zyCKYwdw/QjgC1JwUmY3oxtKe9A8BcobNFaME
         4mnA==
X-Forwarded-Encrypted: i=1; AJvYcCXg/wXgDe1QUKKEvTA4DTMCI9A2Zr8G8Fqs0zB+iMSfG5WOFxjrlRmBudPuoPLv1qB6+mfgEF65d5Ac/4RKLnUq@vger.kernel.org
X-Gm-Message-State: AOJu0YxECfcgib2X6uG2mW9AoPnw784hnYdBlnzFl+s7HEEw94t2ACuR
	HCvoom/xYNSfD0su90+osLIvPp4vAFRMVx7ONDFzhopWLBi3sf17qUYXCub2J4k=
X-Gm-Gg: ASbGncuvO9fro3n2FQ/HYNMohHCCAofBmLEGmxMO/KWUTPugziAiDa8pwtvgswAoOe9
	QginMwdtrPv30qNnyVQ/9jKUIBSjpvwFuqFFT/PLrVulreh1pRIQZ6C0OJEXuwZnM8A/eKWONin
	nje/dcIF/71exHVGBjseyc17VNE5DVjVgvt1+OH0mmvmX6lrYnw2GRUzF34nDQHq2tFKwcOrcbq
	bVSi4PEo3U82I8YZHA6Nm18CIObkA9qB7OL4k/0DTeupD2o/Vf4lixTe0sbx9YipdZ/eK0e5CY3
	bUQF5rUaJ/HOfIQV7YLhhomYgeS5cxKAFCkQ3gyB0vw11/6VDedezBU+gQ==
X-Google-Smtp-Source: AGHT+IHryvstoDG5DrSeDXDSapLeAgCYTwHsrcOUlvaO1B8etrboSauEluFhB4Sgyta7kM0W+4VnLA==
X-Received: by 2002:a17:90b:2650:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-303a87b2f9dmr7620322a91.28.1743104191392;
        Thu, 27 Mar 2025 12:36:31 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:31 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:53 -0700
Subject: [PATCH v5 12/21] RISC-V: perf: Modify the counter discovery
 mechanism
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-12-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

If both counter delegation and SBI PMU is present, the counter
delegation will be used for hardware pmu counters while the SBI PMU
will be used for firmware counters. Thus, the driver has to probe
the counters info via SBI PMU to distinguish the firmware counters.

The hybrid scheme also requires improvements of the informational
logging messages to indicate the user about underlying interface
used for each use case.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c | 130 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 6cebbc16bfe4..c0397bd68b91 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -66,6 +66,20 @@ static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
+static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
+static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
+
+/* Avoid unnecessary code patching in the one time booting path*/
+#define riscv_pmu_cdeleg_available_boot() \
+	static_key_enabled(&riscv_pmu_cdeleg_available)
+#define riscv_pmu_sbi_available_boot() \
+	static_key_enabled(&riscv_pmu_sbi_available)
+
+/* Perform a runtime code patching with static key */
+#define riscv_pmu_cdeleg_available() \
+	static_branch_unlikely(&riscv_pmu_cdeleg_available)
+#define riscv_pmu_sbi_available() \
+		static_branch_likely(&riscv_pmu_sbi_available)
 
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -88,7 +102,8 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 
 /*
  * This structure is SBI specific but counter delegation also require counter
- * width, csr mapping. Reuse it for now.
+ * width, csr mapping. Reuse it for now we can have firmware counters for
+ * platfroms with counter delegation support.
  * RISC-V doesn't have heterogeneous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
  */
@@ -100,6 +115,8 @@ static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
 static unsigned long cmask;
+/* Cache the available firmware counters in another bitmask */
+static unsigned long firmware_cmask;
 
 struct sbi_pmu_event_data {
 	union {
@@ -780,34 +797,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
 		return sbi_err_map_linux_errno(ret.error);
 }
 
-static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
+static u32 rvpmu_deleg_find_ctrs(void)
+{
+	/* TODO */
+	return 0;
+}
+
+static int rvpmu_sbi_get_ctrinfo(u32 nsbi_ctr, u32 *num_fw_ctr, u32 *num_hw_ctr)
 {
 	struct sbiret ret;
-	int i, num_hw_ctr = 0, num_fw_ctr = 0;
+	int i;
 	union sbi_pmu_ctr_info cinfo;
 
-	pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
-	if (!pmu_ctr_list)
-		return -ENOMEM;
-
-	for (i = 0; i < nctr; i++) {
+	for (i = 0; i < nsbi_ctr; i++) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
 		if (ret.error)
 			/* The logical counter ids are not expected to be contiguous */
 			continue;
 
-		*mask |= BIT(i);
-
 		cinfo.value = ret.value;
-		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
-			num_fw_ctr++;
-		else
-			num_hw_ctr++;
-		pmu_ctr_list[i].value = cinfo.value;
+		if (cinfo.type == SBI_PMU_CTR_TYPE_FW) {
+			/* Track firmware counters in a different mask */
+			firmware_cmask |= BIT(i);
+			pmu_ctr_list[i].value = cinfo.value;
+			*num_fw_ctr = *num_fw_ctr + 1;
+		} else if (cinfo.type == SBI_PMU_CTR_TYPE_HW &&
+			   !riscv_pmu_cdeleg_available_boot()) {
+			*num_hw_ctr = *num_hw_ctr + 1;
+			cmask |= BIT(i);
+			pmu_ctr_list[i].value = cinfo.value;
+		}
 	}
 
-	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
-
 	return 0;
 }
 
@@ -1069,16 +1090,41 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
 	/* TODO: Counter delegation implementation */
 }
 
-static int rvpmu_find_num_ctrs(void)
+static int rvpmu_find_ctrs(void)
 {
-	return rvpmu_sbi_find_num_ctrs();
-	/* TODO: Counter delegation implementation */
-}
+	u32 num_sbi_counters = 0, num_deleg_counters = 0;
+	u32 num_hw_ctr = 0, num_fw_ctr = 0, num_ctr = 0;
+	/*
+	 * We don't know how many firmware counters are available. Just allocate
+	 * for maximum counters the driver can support. The default is 64 anyways.
+	 */
+	pmu_ctr_list = kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
+			       GFP_KERNEL);
+	if (!pmu_ctr_list)
+		return -ENOMEM;
 
-static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
-{
-	return rvpmu_sbi_get_ctrinfo(nctr, mask);
-	/* TODO: Counter delegation implementation */
+	if (riscv_pmu_cdeleg_available_boot())
+		num_deleg_counters = rvpmu_deleg_find_ctrs();
+
+	/* This is required for firmware counters even if the above is true */
+	if (riscv_pmu_sbi_available_boot()) {
+		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
+		/* cache all the information about counters now */
+		rvpmu_sbi_get_ctrinfo(num_sbi_counters, &num_hw_ctr, &num_fw_ctr);
+	}
+
+	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV_MAX_COUNTERS)
+		return -ENOSPC;
+
+	if (riscv_pmu_cdeleg_available_boot()) {
+		pr_info("%u firmware and %u hardware counters\n", num_fw_ctr, num_deleg_counters);
+		num_ctr = num_fw_ctr + num_deleg_counters;
+	} else {
+		pr_info("%u firmware and %u hardware counters\n", num_fw_ctr, num_hw_ctr);
+		num_ctr = num_sbi_counters;
+	}
+
+	return num_ctr;
 }
 
 static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
@@ -1379,12 +1425,21 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	int num_counters;
 
-	pr_info("SBI PMU extension is available\n");
+	if (riscv_pmu_cdeleg_available_boot()) {
+		pr_info("hpmcounters will use the counter delegation ISA extension\n");
+		if (riscv_pmu_sbi_available_boot())
+			pr_info("Firmware counters will use SBI PMU extension\n");
+		else
+			pr_info("Firmware counters will not be available as SBI PMU extension is not present\n");
+	} else if (riscv_pmu_sbi_available_boot()) {
+		pr_info("Both hpmcounters and firmware counters will use SBI PMU extension\n");
+	}
+
 	pmu = riscv_pmu_alloc();
 	if (!pmu)
 		return -ENOMEM;
 
-	num_counters = rvpmu_find_num_ctrs();
+	num_counters = rvpmu_find_ctrs();
 	if (num_counters < 0) {
 		pr_err("SBI PMU extension doesn't provide any counters\n");
 		goto out_free;
@@ -1396,9 +1451,6 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 		pr_info("SBI returned more than maximum number of counters. Limiting the number of counters to %d\n", num_counters);
 	}
 
-	/* cache all the information about counters now */
-	if (rvpmu_get_ctrinfo(num_counters, &cmask))
-		goto out_free;
 
 	ret = rvpmu_setup_irqs(pmu, pdev);
 	if (ret < 0) {
@@ -1488,13 +1540,23 @@ static int __init rvpmu_devinit(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (sbi_spec_version < sbi_mk_version(0, 3) ||
-	    !sbi_probe_extension(SBI_EXT_PMU)) {
-		return 0;
-	}
+	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
+	    sbi_probe_extension(SBI_EXT_PMU))
+		static_branch_enable(&riscv_pmu_sbi_available);
 
 	if (sbi_spec_version >= sbi_mk_version(2, 0))
 		sbi_v2_available = true;
+	/*
+	 * We need all three extensions to be present to access the counters
+	 * in S-mode via Supervisor Counter delegation.
+	 */
+	if (riscv_isa_extension_available(NULL, SSCCFG) &&
+	    riscv_isa_extension_available(NULL, SMCDELEG) &&
+	    riscv_isa_extension_available(NULL, SSCSRIND))
+		static_branch_enable(&riscv_pmu_cdeleg_available);
+
+	if (!(riscv_pmu_sbi_available_boot() || riscv_pmu_cdeleg_available_boot()))
+		return 0;
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",

-- 
2.43.0

