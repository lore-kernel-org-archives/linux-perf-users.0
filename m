Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393122F177
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826618; cv=none; b=lfhB7F+auFNCFRI2nlnZnJHaCz0FHmDgKRpCQlgCPTrL8zLlASYymAyfaJhcTT3Xp7mTc55TTwnAAYGoeiB8r8saUTCm0Cfl267c6e3w3UPNF5vEaxy+0m1Om9kRmUwNyq92G+MsMocmpCC29+8imtvetQ5M1TY9nttUJ5koDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826618; c=relaxed/simple;
	bh=AjmlUszmIAM0hsET4uvLYnIUkTJXpOQKsvtvLTI/8xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUHErYtYBbP7A95syT7pPc1pG+Mnn0kbJdSW3kzwy286EswNSsBQ4TbGttPimJUyMx9iD/XSnENO64oEHnSHNMgDGQZqjcf43Wkh9BCy8ZT0dBUwFIS1t2h9/2Eup1YGGJFUgVF2S4Z04AWXBFWX/NaXdXhsORbWPU89SsZxZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dFDsocPq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dFDsocPq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so790416a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826615; x=1739431415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEmj8DVMBSDONaOAMSnkme1snOH35jPSjqon+nV/oLM=;
        b=dFDsocPqqyriLsvdHWkk5uBnS8Cl09C7UEmoqFd/VpaBpSLg6iJlbR2o0CqsW8T4ho
         kL+s6oKdAek9Fb9dnFzQSNC/Cq0ODZKtxjQi2WOJz44rBjOcmmN4by+8gcga9urv04fG
         eTuqv1d+fQx2PoxnwN+VEhqJVnmDvVNYdaaOaZXUlUMQfz8WJBhk90YFx6dHtBfveeGk
         L3So6WDtPchdmU1EoStwdZp8ubritH+vZ/6AyMR2ax7ISS41NZU5PG9Pc0kW57fve9P1
         JowE2SL8KyKozHr/ZS7hPqFWoX4Um+vSa6RbRYyrX/C9L13+4aQ8ubvi0VACoN4kJbF8
         2p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826615; x=1739431415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEmj8DVMBSDONaOAMSnkme1snOH35jPSjqon+nV/oLM=;
        b=Ae8laD3aSZ4UTgEq1NOz8UghLE5mkqEf94WIPbJvmiucVIlOnqIw3YqGx11DJy0yWP
         SE9l2MsZuZhINrA16bxHGS2G5372vz1XWuFIAVgpm0wKtkUAiUQtxLTynYUtV7SKGqQH
         8AaZ4OeS3nzqGIs1DJuQ74u+dqv3npCbZ1KYIt8Olh6Tu6e65tjDSOdj0orXBQ4MtlHu
         OBEWk2nYg/RzjzvLVJMt3LkYfY8cuhWtXTYeG0ElQAX3L0Dbnnk3WpPEAprnKYByeg0E
         UpKzmOC+k1WxVLT/Q5jzONfrji28CzmyzPokBTnFT2trDyNPY97a1TpJqocXPNrD32eq
         +FHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGYryBKKF6mQf0uSM7FbdgGyCuwuEmEe+fkKDq09JCzyRcuMRGYxY1+HxHy/pU5V61waKE9+1mQeaOKE3TDm/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6kYXeW4K1IaV5AiSkTJn5dVMNgw6MlJtY4qbRu9aOeLfDhgG
	rg5CzNGfBBWv0Y+CVTKvbhQWBiRairLBFrS3qONeUW35itUG5SvCMrWx2KoDK2k=
X-Gm-Gg: ASbGncuVv5Y6msnnxSuuU6oiDLOCeA0PlyitXiK5am+NPua4wcOmx8UHT9dzQ8mOw7s
	Ls8yN6RJU3IWxw/wFaLhQDWl0tBt54INyWYOGOufKi7kvHdF2JkhZOHehkIxdsQE2AT5l5TQlDr
	Tu30SLe9GBKvEj2dWsoVv84MXXJh9t9wbstbaoW8nesBF9rzspSK6ELsCYKq2mOEtnqDiLk0yy4
	XnNd2WJ2CUTlGXmcIN5AZDV3N0HuhK5oVwgETypGQMVR0Nnm8qg35dAX7Ui5iDC/y/ha729H2mT
	SCKXQCD5hfK2M9ZbsMebnujsVKBv
X-Google-Smtp-Source: AGHT+IGj8B7K0A3SeZQU+rxnVnMyUu5PFTc58BZIXIzUWOA7tBSdLa1HA/cppXNHnn2s7VfTdqOU4Q==
X-Received: by 2002:a17:90b:1d44:b0:2ee:cdea:ad91 with SMTP id 98e67ed59e1d1-2f9e0785075mr9990255a91.15.1738826615039;
        Wed, 05 Feb 2025 23:23:35 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:34 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:17 -0800
Subject: [PATCH v4 12/21] RISC-V: perf: Modify the counter discovery
 mechanism
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-12-835cfa88e3b1@rivosinc.com>
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
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
X-Mailer: b4 0.15-dev-13183

If both counter delegation and SBI PMU is present, the counter
delegation will be used for hardware pmu counters while the SBI PMU
will be used for firmware counters. Thus, the driver has to probe
the counters info via SBI PMU to distinguish the firmware counters.

The hybrid scheme also requires improvements of the informational
logging messages to indicate the user about underlying interface
used for each use case.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c | 118 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 30 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 6b43d844eaea..5ddf4924c5b3 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -66,6 +66,10 @@ static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
+static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
+static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
+static bool cdeleg_available;
+static bool sbi_available;
 
 static struct attribute *riscv_arch_formats_attr[] = {
 	&format_attr_event.attr,
@@ -88,7 +92,8 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 
 /*
  * This structure is SBI specific but counter delegation also require counter
- * width, csr mapping. Reuse it for now.
+ * width, csr mapping. Reuse it for now we can have firmware counters for
+ * platfroms with counter delegation support.
  * RISC-V doesn't have heterogeneous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
  */
@@ -100,6 +105,8 @@ static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
 static unsigned long cmask;
+/* Cache the available firmware counters in another bitmask */
+static unsigned long firmware_cmask;
 
 struct sbi_pmu_event_data {
 	union {
@@ -778,35 +785,49 @@ static int rvpmu_sbi_find_num_ctrs(void)
 		return sbi_err_map_linux_errno(ret.error);
 }
 
-static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
+static int rvpmu_deleg_find_ctrs(void)
+{
+	/* TODO */
+	return -1;
+}
+
+static int rvpmu_sbi_get_ctrinfo(int nsbi_ctr, int ndeleg_ctr)
 {
 	struct sbiret ret;
-	int i, num_hw_ctr = 0, num_fw_ctr = 0;
+	int i, num_hw_ctr = 0, num_fw_ctr = 0, num_ctr = 0;
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
 		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
 			num_fw_ctr++;
-		else
+
+		if (!cdeleg_available) {
 			num_hw_ctr++;
-		pmu_ctr_list[i].value = cinfo.value;
+			cmask |= BIT(i);
+			pmu_ctr_list[i].value = cinfo.value;
+		} else if (cinfo.type == SBI_PMU_CTR_TYPE_FW) {
+			/* Track firmware counters in a different mask */
+			firmware_cmask |= BIT(i);
+			pmu_ctr_list[i].value = cinfo.value;
+		}
+
 	}
 
-	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
+	if (cdeleg_available) {
+		pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, ndeleg_ctr);
+		num_ctr = num_fw_ctr + ndeleg_ctr;
+	} else {
+		pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
+		num_ctr = nsbi_ctr;
+	}
 
-	return 0;
+	return num_ctr;
 }
 
 static inline void rvpmu_sbi_stop_all(struct riscv_pmu *pmu)
@@ -1067,16 +1088,33 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
 	/* TODO: Counter delegation implementation */
 }
 
-static int rvpmu_find_num_ctrs(void)
+static int rvpmu_find_ctrs(void)
 {
-	return rvpmu_sbi_find_num_ctrs();
-	/* TODO: Counter delegation implementation */
-}
+	int num_sbi_counters = 0, num_deleg_counters = 0, num_counters = 0;
 
-static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
-{
-	return rvpmu_sbi_get_ctrinfo(nctr, mask);
-	/* TODO: Counter delegation implementation */
+	/*
+	 * We don't know how many firmware counters available. Just allocate
+	 * for maximum counters driver can support. The default is 64 anyways.
+	 */
+	pmu_ctr_list = kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list),
+			       GFP_KERNEL);
+	if (!pmu_ctr_list)
+		return -ENOMEM;
+
+	if (cdeleg_available)
+		num_deleg_counters = rvpmu_deleg_find_ctrs();
+
+	/* This is required for firmware counters even if the above is true */
+	if (sbi_available)
+		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
+
+	if (num_sbi_counters >= RISCV_MAX_COUNTERS || num_deleg_counters >= RISCV_MAX_COUNTERS)
+		return -ENOSPC;
+
+	/* cache all the information about counters now */
+	num_counters = rvpmu_sbi_get_ctrinfo(num_sbi_counters, num_deleg_counters);
+
+	return num_counters;
 }
 
 static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
@@ -1377,12 +1415,21 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	int num_counters;
 
-	pr_info("SBI PMU extension is available\n");
+	if (cdeleg_available) {
+		pr_info("hpmcounters will use the counter delegation ISA extension\n");
+		if (sbi_available)
+			pr_info("Firmware counters will be use SBI PMU extension\n");
+		else
+			pr_info("Firmware counters will be not available as SBI PMU extension is not present\n");
+	} else if (sbi_available) {
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
@@ -1394,9 +1441,6 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 		pr_info("SBI returned more than maximum number of counters. Limiting the number of counters to %d\n", num_counters);
 	}
 
-	/* cache all the information about counters now */
-	if (rvpmu_get_ctrinfo(num_counters, &cmask))
-		goto out_free;
 
 	ret = rvpmu_setup_irqs(pmu, pdev);
 	if (ret < 0) {
@@ -1486,13 +1530,27 @@ static int __init rvpmu_devinit(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (sbi_spec_version < sbi_mk_version(0, 3) ||
-	    !sbi_probe_extension(SBI_EXT_PMU)) {
-		return 0;
+	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
+	    sbi_probe_extension(SBI_EXT_PMU)) {
+		static_branch_enable(&riscv_pmu_sbi_available);
+		sbi_available = true;
 	}
 
 	if (sbi_spec_version >= sbi_mk_version(2, 0))
 		sbi_v2_available = true;
+	/*
+	 * We need all three extensions to be present to access the counters
+	 * in S-mode via Supervisor Counter delegation.
+	 */
+	if (riscv_isa_extension_available(NULL, SSCCFG) &&
+	    riscv_isa_extension_available(NULL, SMCDELEG) &&
+	    riscv_isa_extension_available(NULL, SSCSRIND)) {
+		static_branch_enable(&riscv_pmu_cdeleg_available);
+		cdeleg_available = true;
+	}
+
+	if (!(sbi_available || cdeleg_available))
+		return 0;
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
 				      "perf/riscv/pmu:starting",

-- 
2.43.0

