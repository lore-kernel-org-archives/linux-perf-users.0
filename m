Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B383CF200
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984956; cv=none; b=ABDLqiQnoH8FqrwYXcWbZowCAkoAEhKnoPG9H2JXK4I/z3RxVjiHPkgwmKIUjKjw86/TSt+5PTSREnHi+0Ke+CNA6XpJ7q4PAHS0o1zDcTYCzBe4LngoNmoO9xRA4DDUUVsZCAAhBZqXjcv30hWhIy1FrsS362+EmmdMeTmbelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984956; c=relaxed/simple;
	bh=sFfAeDDeGl8gLoArKOzWNGFy+xUUDQO5VChXif10Xxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2nHSAg+2AHG/1jnrX30VWDC931k3xMK2toeOVmNd1f9RG1p82tWFJ4Squ1u/muO3Vd6wK/Wm/e1DsQ86hTR1rmMVeGsVbIOmXTvjdXgvMQV8kZ/fuLIH8rMLlSMQZTMUN3jQNb8JPX1Wi16i88E2nFVTGTzMalGHQEqo4x8de8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRS79nQv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRS79nQv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780984952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTMFJ4P46JbQ3PbG4ipLuwyTV2alsEa1iaAZ3bXyziU=;
	b=kRS79nQvYNTJuSshHzAQY1/Emb/IQJY0QR0c6nCauWNla/TRa8I9VM3okgCJ1LlpahjTlr
	TyHp3gOt1WVi/RVw2PgsCWs+hqWQshkvN1TDf+5hYIu5oITML5Il2XQaYNgjTUEdLl5cg9
	Wmrb9fTFSPfe+7i+j9LPEXF7e8ulEuU=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 08 Jun 2026 23:01:25 -0700
Subject: [PATCH v6 11/21] RISC-V: perf: Modify the counter discovery
 mechanism
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-counter_delegation-v6-11-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
In-Reply-To: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
To: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

If both counter delegation and SBI PMU is present, the counter
delegation will be used for hardware pmu counters while the SBI PMU
will be used for firmware counters. Thus, the driver has to probe
the counters info via SBI PMU to distinguish the firmware counters.

The hybrid scheme also requires improvements of the informational
logging messages to indicate the user about underlying interface
used for each use case.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 131 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7f21c16003f0..57ab15beab3e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -67,6 +67,20 @@ static bool sbi_v3_available;
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
@@ -89,7 +103,8 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 
 /*
  * This structure is SBI specific but counter delegation also require counter
- * width, csr mapping. Reuse it for now.
+ * width, csr mapping. Reuse it for now we can have firmware counters for
+ * platfroms with counter delegation support.
  * RISC-V doesn't have heterogeneous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
  */
@@ -101,6 +116,8 @@ static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
 static unsigned long cmask;
+/* Cache the available firmware counters in another bitmask */
+static unsigned long firmware_cmask;
 
 static int sbi_pmu_event_find_cache(u64 config);
 struct sbi_pmu_event_data {
@@ -868,34 +885,38 @@ static int rvpmu_sbi_find_num_ctrs(void)
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
 
-	pmu_ctr_list = kzalloc_objs(*pmu_ctr_list, nctr);
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
 
@@ -1159,16 +1180,42 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
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
+	if (riscv_pmu_sbi_available_boot())
+		num_sbi_counters = rvpmu_sbi_find_num_ctrs();
+
+	if (num_sbi_counters > RISCV_MAX_COUNTERS || num_deleg_counters > RISCV_MAX_COUNTERS)
+		return -ENOSPC;
+
+	/* cache all the information about counters now */
+	if (riscv_pmu_sbi_available_boot())
+		rvpmu_sbi_get_ctrinfo(num_sbi_counters, &num_fw_ctr, &num_hw_ctr);
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
@@ -1469,12 +1516,21 @@ static int rvpmu_device_probe(struct platform_device *pdev)
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
@@ -1486,9 +1542,6 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 		pr_info("SBI returned more than maximum number of counters. Limiting the number of counters to %d\n", num_counters);
 	}
 
-	/* cache all the information about counters now */
-	if (rvpmu_get_ctrinfo(num_counters, &cmask))
-		goto out_free;
 
 	ret = rvpmu_setup_irqs(pmu, pdev);
 	if (ret < 0) {
@@ -1578,13 +1631,23 @@ static int __init rvpmu_devinit(void)
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
 
 	if (sbi_spec_version >= sbi_mk_version(3, 0))
 		sbi_v3_available = true;

-- 
2.53.0-Meta

