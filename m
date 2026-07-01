Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA53B19B5
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895646; cv=none; b=gMryKtdEN3723QTC4O6iDOQ6aj5ILc6eHrgMpjZW462LsvEnJAP9Qcf31zDW6FKOZPIACrVjSi53v9ynlIOc0ZFiT4/HsntrsSHZrHouWC83tCp6toYC7p0YRZ1JxQtH0Ia8ZUwJ/jojoFo/6ueRBw7cVLSiwVtj+j0iyVAeEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895646; c=relaxed/simple;
	bh=9VOnVvzjsZzR8hJplWz7LMgbcZ7QnXk10tohv83NyKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwWy+cjTIfxtJu+XIrYDWGx5NtIQArAxR2UvDSWmuVGzGcek0DhODAc9a8DL5pzAm/lhBfl2NvwLHXONQ4uXoivBdMsul5PP9oT14DDAKar7dihSz2GCSnMD24qkUi7mqsuGkzlv2heLHKkvRK7G+D8NnVKOce3eopf4BUtIHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=viR8aRra; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="viR8aRra"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782895642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jkYTJZ76o1QfeUeruk/BApgLfDf2mjQsJprrfSgBCQ=;
	b=viR8aRra2txaWnJTugOoW7+0kM9QWgabNryKjWO2M3CkuQ5Fxi/WApRf8MqOM3omSVqx8U
	8yq/pM6cTJhEXNkauymsk1cZ7x8YNrpEOb5kfQeKBUV349+tUy0AMs5/15VmmvIgQEAVGe
	QfG6yuER74q3Tt+b/Qsk/bmlP27zJUI=
From: Atish Patra <atish.patra@linux.dev>
Date: Wed, 01 Jul 2026 01:46:49 -0700
Subject: [PATCH v8 01/22] RISC-V: perf: fix resource cleanup on driver
 probe failure
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
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
 drivers/perf/riscv_pmu_sbi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 385af5e6e6d0..5c8924ce1f38 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1220,22 +1220,29 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 					  DOMAIN_BUS_ANY);
 	if (!domain) {
 		pr_err("Failed to find INTC IRQ root domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
 	if (!riscv_pmu_irq) {
 		pr_err("Failed to map PMU interrupt for node\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err;
 	}
 
 	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
-		return ret;
+		irq_dispose_mapping(riscv_pmu_irq);
+		riscv_pmu_irq = 0;
+		goto err;
 	}
 
 	return 0;
+err:
+	riscv_pmu_use_irq = false;
+	return ret;
 }
 
 #ifdef CONFIG_CPU_PM
@@ -1302,7 +1309,8 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 		}
 	}
 	riscv_pm_pmu_unregister(pmu);
-	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (!hlist_unhashed(&pmu->node))
+		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
 static void pmu_sbi_event_init(struct perf_event *event)
@@ -1424,6 +1432,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	struct riscv_pmu *pmu = NULL;
 	int ret = -ENODEV;
 	int num_counters;
+	bool irq_requested = false;
 
 	pr_info("SBI PMU extension is available\n");
 	pmu = riscv_pmu_alloc();
@@ -1452,6 +1461,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 	}
+	irq_requested = (ret == 0);
 
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
@@ -1470,11 +1480,11 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
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
@@ -1515,9 +1525,20 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	return 0;
 
 out_unregister:
+	perf_pmu_unregister(&pmu->pmu);
+
+out_destroy:
 	riscv_pmu_destroy(pmu);
+	if (irq_requested) {
+		free_percpu_irq(riscv_pmu_irq, pmu->hw_events);
+		irq_dispose_mapping(riscv_pmu_irq);
+		riscv_pmu_irq = 0;
+	}
 
 out_free:
+	free_percpu(pmu->hw_events);
+	kfree(pmu_ctr_list);
+	pmu_ctr_list = NULL;
 	kfree(pmu);
 	return ret;
 }

-- 
2.53.0-Meta

