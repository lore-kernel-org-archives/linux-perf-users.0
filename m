Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845F1C68A5
	for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008879; cv=none; b=Ab2bNcdfJnLDEHTxiaY87LbUAfLiu8bw72vWY1YSxdiHJ0qFcQoZRN5OQs5mO22ui1Wbn1uJiLB5y5vgtr0nNRKPYJ59ZphoqHY3TDDlecKoSJbGnZiPeeQriiaqvJpBiD88zap/Req0WbqHYi1rURyV86rslt735pgMML9JDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008879; c=relaxed/simple;
	bh=fhyOW32KF7x1nOg5NvGrhHnYTYAqHGUN810iLS+POK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Br1y4J8a9PwvpXiS5ptflKi3p1ihSkYEGkbc3c1DxD3WyfKpwdXR1Y76b4CIybQyeCQQbECeGsyBPMUG5bNYWvTYqsDag8QAZ94lImjEZH8UcmSEkMwZRT+f5nKG9/hKAgntc5YpgQHAwNeLP4kKsV/HVShVo3bhoEbSOZDAD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q8dA1usY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q8dA1usY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42120fc8cbfso358215e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008876; x=1717613676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+2U8h+2rvtM/KDIv8ZmxGGBqHz1DJ98r4cPzpRskE8=;
        b=Q8dA1usY15b8WQ+g36JDmCaqZrRlLcNcwX+fkhSDvbQ4jMTMiZOfZZTYuLpRGTm3kE
         8p2jfSzp3bm5nk6yzXQyB/zk8gbTi8M8c3x/oE8Lmm6+Qhws8kd5+qSKkVR56WWDaF7a
         D751SZznnFXI21jvW5Or8VJ+bgmCD2JaO2y+aSnIvznWM3RINVvkd7q+Mqmj9rmXXD9s
         rXj/GqrsjZAOG6HIuTcz0iCi5O8isXLQ1bHSjkTQ7RVfD66sKp+mYvnKwvBipPcw4Z61
         aJobQE+UWSFfqkojekkPMO/nC1o+t/ZlkqjGPxOHuv72GwCUw8tqYyk73bVYF7EA8z1F
         h5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008876; x=1717613676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+2U8h+2rvtM/KDIv8ZmxGGBqHz1DJ98r4cPzpRskE8=;
        b=G2e2UpSAAlYTMmYggrwYiYnwK7tEkvGDy87Yo1Ww/nhOe8Vw0h7UUfh4hUs4AImgGk
         QfnO6dOaVc5t1emm2pQf+OIdhqpykQLBfq65y3qthfv1PoxlPNOJN9YVMLG9C+hHwk+m
         ifSaS07JillOfb3yTUcZJqf7ANV6sJDRHOedoFD66KRFKzP+mE/Rr4+PgRPCdB06QrMq
         B4nO81AJkwXDcEC/iSPiAOdd59j/m0nhTkOsiXpSK7winqZ1pP4RC5gasHSb0S9z7JX5
         xq+xdy/4Raww3lIxNMllbnX5FOyfU86OXh1MV+Gj1r0FE+PWI1mdtiL4ebev2A2UO/SM
         58Zg==
X-Gm-Message-State: AOJu0YyhBct8213s9kjCTREycPNmHjI3/msNYZQ+pb6EKDESoi6hYQU5
	6imMoAMduWFq4jzx6qn+vpQ//7JJePBZHEpS8nbWgr7hB6iZaYoC92bwAB+xaCs=
X-Google-Smtp-Source: AGHT+IHyilA5pn7bTk5wG0if56ayFdi//JSBq/3E0JiJr67lveFf/JA8ZYRTkFP5SiaOqO8femclbQ==
X-Received: by 2002:a7b:c391:0:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-421279375bamr150315e9.41.1717008876402;
        Wed, 29 May 2024 11:54:36 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:35 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
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
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 6/6] riscv: perf: Integrate CTR Ext support in riscv_pmu_dev driver
Date: Wed, 29 May 2024 19:53:37 +0100
Message-Id: <20240529185337.182722-7-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529185337.182722-1-rkanwal@rivosinc.com>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
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
 drivers/perf/riscv_pmu_dev.c    | 77 +++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/riscv_pmu_common.c b/drivers/perf/riscv_pmu_common.c
index e794675e4944..e1f3a33b479f 100644
--- a/drivers/perf/riscv_pmu_common.c
+++ b/drivers/perf/riscv_pmu_common.c
@@ -326,8 +326,7 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	u64 event_config = 0;
 	uint64_t cmask;
 
-	/* driver does not support branch stack sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
 		return -EOPNOTSUPP;
 
 	hwc->flags = 0;
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 40ae5fc897a3..1b2c04c35bed 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -675,7 +675,7 @@ static void pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 {
 	struct riscv_pmu *pmu = to_riscv_pmu(pmu_ctx->pmu);
 
-	/* Call CTR specific Sched hook. */
+	riscv_pmu_ctr_sched_task(pmu_ctx, sched_in);
 }
 
 static int rvpmu_sbi_find_num_ctrs(void)
@@ -935,17 +935,25 @@ static irqreturn_t rvpmu_ovf_handler(int irq, void *dev)
 		hw_evt = &event->hw;
 		riscv_pmu_event_update(event);
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
-		if (riscv_pmu_event_set_period(event)) {
-			/*
-			 * Unlike other ISAs, RISC-V don't have to disable interrupts
-			 * to avoid throttling here. As per the specification, the
-			 * interrupt remains disabled until the OF bit is set.
-			 * Interrupts are enabled again only during the start.
-			 * TODO: We will need to stop the guest counters once
-			 * virtualization support is added.
-			 */
-			perf_event_overflow(event, &data, regs);
+		if (!riscv_pmu_event_set_period(event))
+			continue;
+
+		if (needs_branch_stack(event)) {
+			riscv_pmu_ctr_consume(cpu_hw_evt, event);
+			perf_sample_save_brstack(
+				&data, event,
+				&cpu_hw_evt->branches->branch_stack, NULL);
 		}
+
+		/*
+		 * Unlike other ISAs, RISC-V don't have to disable interrupts
+		 * to avoid throttling here. As per the specification, the
+		 * interrupt remains disabled until the OF bit is set.
+		 * Interrupts are enabled again only during the start.
+		 * TODO: We will need to stop the guest counters once
+		 * virtualization support is added.
+		 */
+		perf_event_overflow(event, &data, regs);
 	}
 
 	rvpmu_start_overflow_mask(pmu, overflowed_ctrs);
@@ -1103,10 +1111,12 @@ static void rvpmu_ctr_start(struct perf_event *event, u64 ival)
 	else
 		rvpmu_sbi_ctr_start(event, ival);
 
-
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		rvpmu_set_scounteren((void *)event);
+
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_enable(event);
 }
 
 static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
@@ -1128,6 +1138,9 @@ static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
 	} else {
 		rvpmu_sbi_ctr_stop(event, flag);
 	}
+
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_disable(event);
 }
 
 static int rvpmu_find_ctrs(void)
@@ -1161,6 +1174,9 @@ static int rvpmu_find_ctrs(void)
 
 static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
 {
+	if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
+		return -EOPNOTSUPP;
+
 	if (static_branch_likely(&riscv_pmu_cdeleg_available) && !pmu_sbi_is_fw_event(event))
 		return rvpmu_deleg_event_map(event, econfig);
 	else
@@ -1207,6 +1223,8 @@ static int rvpmu_starting_cpu(unsigned int cpu, struct hlist_node *node)
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
+	riscv_pmu_ctr_starting_cpu();
+
 	return 0;
 }
 
@@ -1218,6 +1236,7 @@ static int rvpmu_dying_cpu(unsigned int cpu, struct hlist_node *node)
 
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
+	riscv_pmu_ctr_dying_cpu();
 
 	return 0;
 }
@@ -1331,6 +1350,29 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
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
@@ -1490,6 +1532,12 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 		pmu->pmu.attr_groups = riscv_cdeleg_pmu_attr_groups;
 	else
 		pmu->pmu.attr_groups = riscv_sbi_pmu_attr_groups;
+
+	riscv_pmu_ctr_init(pmu);
+	ret = branch_records_alloc(pmu);
+	if (ret)
+		goto out_ctr_finish;
+
 	pmu->cmask = cmask;
 	pmu->ctr_start = rvpmu_ctr_start;
 	pmu->ctr_stop = rvpmu_ctr_stop;
@@ -1506,7 +1554,7 @@ static int rvpmu_device_probe(struct platform_device *pdev)
 
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 	if (ret)
-		return ret;
+		goto out_ctr_finish;
 
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
@@ -1523,6 +1571,9 @@ static int rvpmu_device_probe(struct platform_device *pdev)
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

