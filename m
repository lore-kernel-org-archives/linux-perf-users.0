Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF738F252
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115568; cv=none; b=E6mqoQ3igHSZvCVGYHOnWswAI4HY1kLaZILfbGfUfiYQzWMGTuRgDsmEFz0Q2uf+w8ZZlCFkdNXzcQs96oy+iT8yCPdClEhJiWLIrK9LWxTIgiT8vVyJPNVt26wIIWM0QqWFiCOo6lPnuK8I/nQsrdiMhAGrS8diYi56Y9Iy+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115568; c=relaxed/simple;
	bh=rIfgybBkl+9idDIz+8ZNrQ+oypT/jiebc7S1Fds6R2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WzmMf1V9NLXd0B0L7lLi1C4MU5gNkzL8LKG/mvYp7E3pjFaDU+N7QQ6BjFOXo8YWvmFAa7jPpd9fgvAEIm043+uO/FIsIqWEpaK6FexM7dbl+Q8ovyDtrMel1sAvlaoEaGD/ACSFT52ZLuXSZXCsmRDF/BN1P6uD4BAxdJVr51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KUAQeBDJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUAQeBDJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782115565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAtxv8GjmcFtFqxDou1ZS76JopDGVWlAHx2uOo1Xz+c=;
	b=KUAQeBDJfdVb9GdFzGOYNLfwSR1CfuWg7peKFf38oTapGuGYzN2WaGbLYQqptDYG3h05Ur
	p+vVr7Wxe+qAw3izEzcYVw1Azf/3bnAUnk2mG4KV5XQ11kE5wIUM9zm95UrZWat/A4pxcu
	O1Oj2CP0hXR2QwcuIJTtBHRJMYkrj6c=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 22 Jun 2026 01:04:27 -0700
Subject: [PATCH v7 15/22] RISC-V: perf: Skip PMU SBI extension when not
 implemented
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-counter_delegation-v7-15-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
In-Reply-To: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Rob Herring <robh@kernel.org>, 
 Ian Rogers <irogers@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Namhyung Kim <namhyung@kernel.org>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Charlie Jenkins <charlie@rivosinc.com>

When the PMU SBI extension is not implemented, sbi_v2_available should
not be set to true. The SBI implementation for counter config matching
and firmware counter read  should also be skipped when the SBI extension
is not implemented.

Signed-off-by: Atish Patra <atishp@meta.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 49 ++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 6407e229c2c3..4f3a30143db1 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -495,27 +495,32 @@ static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 	}
 }
 
-static void rvpmu_sbi_check_std_events(struct work_struct *work)
+static void rvpmu_check_std_events(struct work_struct *work)
 {
 	int ret;
 
-	if (sbi_v3_available) {
-		ret = pmu_sbi_check_event_info();
-		if (ret)
-			pr_err("pmu_sbi_check_event_info failed with error %d\n", ret);
-		return;
-	}
+	if (riscv_pmu_sbi_available()) {
+		if (sbi_v3_available) {
+			ret = pmu_sbi_check_event_info();
+			if (ret)
+				pr_err("pmu_sbi_check_event_info failed with error %d\n", ret);
+			return;
+		}
 
-	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
-		rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
+		for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
+			rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
 
-	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
-		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
-			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
-				rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
+		for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
+			for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
+				for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
+					rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
+	} else {
+		DO_ONCE_LITE_IF(1, pr_info,
+				"Boot time config matching not required for smcdeleg\n");
+	}
 }
 
-static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
+static DECLARE_WORK(check_std_events_work, rvpmu_check_std_events);
 
 static ssize_t rvpmu_format_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -708,6 +713,9 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
 
 	cflags = rvpmu_sbi_get_filter_flags(event);
 
+	if (!riscv_pmu_sbi_available())
+		return -ENOENT;
+
 	/*
 	 * In legacy mode, we have to force the fixed counters for those events
 	 * but not in the user access mode as we want to use the other counters
@@ -985,7 +993,7 @@ static u64 rvpmu_ctr_read(struct perf_event *event)
 		return val;
 	}
 
-	if (pmu_sbi_is_fw_event(event)) {
+	if (pmu_sbi_is_fw_event(event) && riscv_pmu_sbi_available()) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
 		if (ret.error)
@@ -2084,12 +2092,13 @@ static int __init rvpmu_devinit(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
-	    sbi_probe_extension(SBI_EXT_PMU))
-		static_branch_enable(&riscv_pmu_sbi_available);
+	if (sbi_probe_extension(SBI_EXT_PMU)) {
+		if (sbi_spec_version >= sbi_mk_version(0, 3))
+			static_branch_enable(&riscv_pmu_sbi_available);
+		if (sbi_spec_version >= sbi_mk_version(2, 0))
+			sbi_v2_available = true;
+	}
 
-	if (sbi_spec_version >= sbi_mk_version(2, 0))
-		sbi_v2_available = true;
 	/*
 	 * We need all three extensions to be present to access the counters
 	 * in S-mode via Supervisor Counter delegation.

-- 
2.53.0-Meta

