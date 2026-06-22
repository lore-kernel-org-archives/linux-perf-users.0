Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACED38E8A2
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115469; cv=none; b=KLpHgQRJPEoKclhYTZxubJXyAyPLe1iGbMiBf1LcGDoJErZ9bicqI4BhvQa6tz3/2lLPunBP6/pezkkAWUuSJjTctRsh3+l35kwD8a6OJsFXhaMeBAwOAaoR2R7QWM2XkaRIXSmlG8NBrpBw7/ER5QzuF3R5Jgp5F5Z3W6Tx8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115469; c=relaxed/simple;
	bh=9Tk+BjDMZVLgUkQD9/m8RvzVlg/d0pDQ+TwUx3JZ3AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyVcH2pA9g7vBJC06oOtfMG04wypHz+YXGS8S7+Hzn+wumP6Leh1NUhJNpfmxWnS9McmCULDpr7ObJckx/AIswdQHqn/qYRO5Gb2/1Zp6keUENLatYNhtA7VeR1BVNsF+uBrR9vcPm5o8FjibnWLpZWPBBtvAaEbthi5VjtpYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIPacT9L; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIPacT9L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782115466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v62h5jXmmPgvQdyVU89RGQkLc6ReYrJW9QcdYlcnl1s=;
	b=oIPacT9Lz4/fnsnqclJUcIdL5JYt78goTvHHcxVnY3JyTxFwB6WIVcRgxLZdgrEVuKOcjK
	EIKKZXitc5H1EtSSz37N+7DkT86VZTFd93gzatYrtTDplcBLU27t9V5AchyTisc+3M50Dw
	zo4lBUuX/HyZ3BRKFGdssr0SZeN81eo=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 22 Jun 2026 01:04:13 -0700
Subject: [PATCH v7 01/22] RISC-V: perf: fix resource cleanup on driver
 probe failure
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-counter_delegation-v7-1-0ba2fd34614e@meta.com>
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

From: Atish Patra <atishp@meta.com>

Sashiko pointed out various UAF and memory leak issues around
pmu_sbi_device_probe() error paths.

If the probe fails, here are list of cleanups needed.
a. Already registered pmu must be freed
b. per cpu IRQ must be released
c. pmu_ctr_list data structure must be freed
d. cpu hotplug state must be cleaned up only if added.

Fix the resource cleanup by reorganizing the code around probe failure.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Atish Patra <atishp@meta.com>
---
 drivers/perf/riscv_pmu_sbi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 385af5e6e6d0..8753007cc57e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1302,7 +1302,8 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 		}
 	}
 	riscv_pm_pmu_unregister(pmu);
-	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (!hlist_unhashed(&pmu->node))
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
 static void pmu_sbi_event_init(struct perf_event *event)
@@ -1424,6 +1425,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	struct riscv_pmu *pmu = NULL;
 	int ret = -ENODEV;
 	int num_counters;
+	bool irq_requested = false;
 
 	pr_info("SBI PMU extension is available\n");
 	pmu = riscv_pmu_alloc();
@@ -1452,6 +1454,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 	}
+	irq_requested = (ret == 0);
 
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
@@ -1470,11 +1473,11 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
-		goto out_unregister;
+		goto out_destroy;
 
 	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 	if (ret)
-		goto out_unregister;
+		goto out_destroy;
 
 	/* SBI PMU Snapsphot is only available in SBI v2.0 */
 	if (sbi_v2_available) {
@@ -1515,9 +1518,17 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	return 0;
 
 out_unregister:
+	perf_pmu_unregister(&pmu->pmu);
+
+out_destroy:
 	riscv_pmu_destroy(pmu);
+	if (irq_requested)
+		free_percpu_irq(riscv_pmu_irq, pmu->hw_events);
 
 out_free:
+	free_percpu(pmu->hw_events);
+	kfree(pmu_ctr_list);
+	pmu_ctr_list = NULL;
 	kfree(pmu);
 	return ret;
 }

-- 
2.53.0-Meta

