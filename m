Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C2243867
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069038; cv=none; b=fl/8t+7CwRmkLDXNcC0DWKD3RcPQv8i51jyYq13e8FdG7xnUBEbwYwmwzjyDFuS/6EO4shn9DNqb5p3HK1x31fyetyJkR8ZvcpbaAMq3p2GZaonASmHq54EE+SNDYlGJuJm5R6rhfqUOowTF4BgKJggjfq598lNODSk9yLPXZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069038; c=relaxed/simple;
	bh=en3osisonvml/lgF+LtGxrhewyYz8KPgAh9/6KZlsO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6BSyN4XNfvrf7Zu5nkS6ciFnc4tTrzMJF8QvAHPOsmJTZyMPEVxeklHC/gbtx6c8toWtUJqpRUjFVRheFYUSzMP9WnUZ+qyknAvX2aOCtGFSfWpk7Vrey5KvQsng9/+fAZ5GMF+MVNcmAQ3uiSxyugeSQW4Qy55bVur0Vytbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VUoAzm2Z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VUoAzm2Z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1605208f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069035; x=1737673835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEkq9sMQTY0nBcBSdfXe/oLw7i/Fvb8myFij4FR9Lmw=;
        b=VUoAzm2ZPy38FIWPeaUDpKC+1ZHxetZDnaegrk+X2uBBcrlykEurb9fZrtRAaH1/uW
         k93TnBFLucuoEBw/syfclvCGGWozMokAiJJ8DMWjZ43N34W+IG92whowbTpZaJwh7NYo
         Zy07trwIABOj0n5GnbjxyhqRzdnxt6timXFPX2Fs0tfplJCZ+qadOyva0/s9qwfSGT3R
         kOuz94LfqasSP4prLl57kmU9IyOYv0Hbs9X6HqihP8Xgt1oPi4FrI3ZJ3wNnqbLsLJYZ
         m5bXhcLDXpVuB8E4IEP8lptYZ4iTcThBHDnppUGxlRNw7a1EhQEDRDaTJINPgcABHALM
         tFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069035; x=1737673835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkq9sMQTY0nBcBSdfXe/oLw7i/Fvb8myFij4FR9Lmw=;
        b=rti9rI5eTxS080N5vHkOhICmnxWQnFCWctus8bE6FxE6vGJxijQ98Hxbyb1ZMlP7LR
         7sFBxhxhG8aQoNakb6RojdPCtgndTF/0GHKeFSOrjMF/Bv1T3Z5ZbPwhjL/5qW4Oo0j9
         3vLbsn7nf7zbmVmQ/kY8Fved+141849JqB+6uussWHtdsk0NwYQ6swJICkGFIjy6ex08
         CkHyDtrELQtqE05V1kIEtKj9mQAEYs0c3cBdel2sFS4sRe/9ZbANB422qQziJONuuziB
         aUKL3YxRF2IN51T5x4Kv9cO/U5RaEV3jenPmcviMqpEtXZaGqHQre916Vk1KtQ1oAUt9
         H0xA==
X-Gm-Message-State: AOJu0Yxc8B/Gqiphg9aYr+FLIktXvJTDqKMUCBpE+2ZGCP16IlUwEpOO
	Pyvy3komn1cCLPPmabkVdov9Yb0mvD1uop0IF8j7cw7vjGR7V4syOTeRSu7XrMs=
X-Gm-Gg: ASbGncsZEN+0bfHu7h9/2VOrR+M2mTeIx2qNl+R9loF3TTLFDmv9FXMJEqQp7nLdSmZ
	0wZ7L6+KdETSARNtidh12vB2ro5qHbduUIidS+zvAfVy1UvZGa1LF7yfduVKWjxN/u6WLUpe0kC
	IUDPVl4O4OUsiJ0Iv6fkXeT/A+JBLpLiHjo5YzAHSXvHl9TAkinISt7EdWPRGVG+B+/eXYXIZzl
	jtBvWuu50qLZRkclBumK/Txsilwsz47fGkxd4scJlsLFLD5DSFcgUSNWRtpSmrKHeDBHzrxrYoW
	cOVlLqdaCnZfBXXd
X-Google-Smtp-Source: AGHT+IGuu6zWay2mqSvZNm4qasvF1tOh4RKXx4XbpxtExBqMV1QOAm0F3fvLQN9z0J/WkxXd0ISjQg==
X-Received: by 2002:a05:6000:1548:b0:385:e328:8908 with SMTP id ffacd0b85a97d-38bf5b0b67bmr204983f8f.29.1737069035166;
        Thu, 16 Jan 2025 15:10:35 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:34 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 7/7] riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver
Date: Thu, 16 Jan 2025 23:09:55 +0000
Message-Id: <20250116230955.867152-8-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116230955.867152-1-rkanwal@rivosinc.com>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This integrates recently added CTR ext support in riscv_pmu_dev driver
to enable branch stack sampling using PMU events.

This mainly adds CTR enable/disable callbacks in rvpmu_ctr_stop()
and rvpmu_ctr_start() function to start/stop branch recording along
with the event.

PMU overflow handler rvpmu_ovf_handler() is also updated to sample
CTR entries in case of the overflow for the particular event programmed
to records branches. The recorded entries are fed to core perf for
further processing.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 drivers/perf/riscv_pmu_common.c |  3 +-
 drivers/perf/riscv_pmu_dev.c    | 67 ++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_common.c b/drivers/perf/riscv_pmu_common.c
index c4c4b5d6bed0..23077a6c4931 100644
--- a/drivers/perf/riscv_pmu_common.c
+++ b/drivers/perf/riscv_pmu_common.c
@@ -327,8 +327,7 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	u64 event_config = 0;
 	uint64_t cmask;
 
-	/* driver does not support branch stack sampling */
-	if (has_branch_stack(event))
+	if (needs_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
 		return -EOPNOTSUPP;
 
 	hwc->flags = 0;
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index b9b257607b76..10697deb1d26 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -1030,7 +1030,7 @@ static void rvpmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 static void pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 			   bool sched_in)
 {
-	/* Call CTR specific Sched hook. */
+	riscv_pmu_ctr_sched_task(pmu_ctx, sched_in);
 }
 
 static int rvpmu_sbi_find_num_ctrs(void)
@@ -1379,6 +1379,13 @@ static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
 		hw_evt->state |= PERF_HES_UPTODATE;
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
 		if (riscv_pmu_event_set_period(event)) {
+			if (needs_branch_stack(event)) {
+				riscv_pmu_ctr_consume(cpu_hw_evt, event);
+				perf_sample_save_brstack(
+					&data, event,
+					&cpu_hw_evt->branches->branch_stack, NULL);
+			}
+
 			/*
 			 * Unlike other ISAs, RISC-V don't have to disable interrupts
 			 * to avoid throttling here. As per the specification, the
@@ -1577,10 +1584,14 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 
 static void rvpmu_ctr_add(struct perf_event *event, int flags)
 {
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_add(event);
 }
 
 static void rvpmu_ctr_del(struct perf_event *event, int flags)
 {
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_del(event);
 }
 
 static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
@@ -1595,6 +1606,9 @@ static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		rvpmu_set_scounteren((void *)event);
+
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_enable(event);
 }
 
 static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
@@ -1617,6 +1631,9 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
 	} else {
 		rvpmu_sbi_ctr_stop(event, flag);
 	}
+
+	if (needs_branch_stack(event) && flag != RISCV_PMU_STOP_FLAG_RESET)
+		riscv_pmu_ctr_disable(event);
 }
 
 static int rvpmu_find_ctrs(void)
@@ -1652,6 +1669,9 @@ static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
 {
 	u64 config1;
 
+	if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
+		return -EOPNOTSUPP;
+
 	config1 = event->attr.config1;
 	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event) &&
 	    !(config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS)) { /* GUEST events rely on SBI encoding */
@@ -1701,6 +1721,8 @@ static int rvpmu_starting_cpu(unsigned int cpu, struct hlist_node *node)
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
+	riscv_pmu_ctr_starting_cpu();
+
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_setup(pmu, cpu);
 
@@ -1715,6 +1737,7 @@ static int rvpmu_dying_cpu(unsigned int cpu, struct hlist_node *node)
 
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
+	riscv_pmu_ctr_dying_cpu();
 
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_disable();
@@ -1838,6 +1861,29 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
+static int branch_records_alloc(struct riscv_pmu *pmu)
+{
+	struct branch_records __percpu *tmp_alloc_ptr;
+	struct branch_records *records;
+	struct cpu_hw_events *events;
+	int cpu;
+
+	if (!riscv_pmu_ctr_supported(pmu))
+		return 0;
+
+	tmp_alloc_ptr = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
+	if (!tmp_alloc_ptr)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		events = per_cpu_ptr(pmu->hw_events, cpu);
+		records = per_cpu_ptr(tmp_alloc_ptr, cpu);
+		events->branches = records;
+	}
+
+	return 0;
+}
+
 static void rvpmu_event_init(struct perf_event *event)
 {
 	/*
@@ -1850,6 +1896,9 @@ static void rvpmu_event_init(struct perf_event *event)
 		event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
 	else
 		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
+
+	if (branch_sample_call_stack(event))
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
 }
 
 static void rvpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
@@ -1997,6 +2046,15 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 		pmu->pmu.attr_groups = riscv_cdeleg_pmu_attr_groups;
 	else
 		pmu->pmu.attr_groups = riscv_sbi_pmu_attr_groups;
+
+	ret = riscv_pmu_ctr_init(pmu);
+	if (ret)
+		goto out_free;
+
+	ret = branch_records_alloc(pmu);
+	if (ret)
+		goto out_ctr_finish;
+
 	pmu->cmask = cmask;
 	pmu->ctr_add = rvpmu_ctr_add;
 	pmu->ctr_del = rvpmu_ctr_del;
@@ -2013,6 +2071,10 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 	pmu->csr_index = rvpmu_csr_index;
 	pmu->sched_task = pmu_sched_task;
 
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (ret)
+		goto out_ctr_finish;
+
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
 		goto out_unregister;
@@ -2062,6 +2124,9 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 out_unregister:
 	riscv_pmu_destroy(pmu);
 
+out_ctr_finish:
+	riscv_pmu_ctr_finish(pmu);
+
 out_free:
 	kfree(pmu);
 	return ret;
-- 
2.34.1

