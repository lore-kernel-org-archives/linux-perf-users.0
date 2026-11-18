Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995518;
	b=cHhCrFuwRc6lsZnCadKvuiAASOFxeKljO3cQ2dTl2lESbdpMMVN1d3oxqTYJvE2jpMq5
	 n2/SWV/jWKdFo6JTG6lCg7r5PmLpmJrJ9S0DMp6BWVbkI6r1+73G/7O5NjpFTCbG/4VyW
	 BKNtoBJSCd8o0tV0jVZYN3m6r7VUzafW9FJLx1c0y101pS0fLmNDYx5AufTSALzjyCUFR
	 MpKQmx30mabHeoGr2FWKJxfk4uGMp08P4/GtoAw0khrRgPb3auXDdWb6aB/oSblEhQBvC
	 GOwpj/M3idPtBNRrINDdsVXUVPUyhydkOJV87hc09GdBT7P5fHwQkEQFrv/bZFPPFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995518;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Bewxt931damu2Zp5tiUiHwRaRgjW+teUIJZRAgklsTg=;
	b=SJcGgIzRIxskjH4RGaMcIzIUI4dUH8n40yrIUnmIfUCnoYbPuttVs7Va7ufUiAtxs72/
	 rFuBy05BQp8RELP6lVa11eFoKuo2QvfbQKvgrTd3WU3o1PX6WrO5axNMxCDKjW0Twlu4C
	 f5fji5laDwA1eIMwNWbfcQxK3G63aot48DM06LTjx5ftsa7JUtfh9oCPtcLYqJKO1E1nx
	 qtHPGijJubb1Fcn1cz7/jZvc9l22Vqtv8q0SD9UNbyEFMnbBC5FlrLfRxdgnH1LzvhMqX
	 hRGI+29y6HNWdAyZ4Zdr0SOE8ytMjGy7VsWgfd/NEm8KDiIH0/ZtK5GeNIpcVtfUXPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e18QlcLD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD27606A886;
	Wed, 18 Nov 2026 09:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD27606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e18QlcLD
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9k3Gf3353923;
	Wed, 18 Nov 2026 09:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Bewxt931dam
	u2Zp5tiUiHwRaRgjW+teUIJZRAgklsTg=; b=e18QlcLDrUWTasWujWDQyCU29Bl
	2e1TAuwHNeGybh6UAXWrw3MDiAxsfQPrptaKndTw6rZ3i2kxCCMTkCRg6XeyL7Vg
	kSYvtDalj/6pATn8ZmN2oG7Fq1nz9f3m2+tcCD8U41mXutEDJvkKNKPjgRh34ilc
	4jwPO/MIQyj4xNyBMXMEWtlVZZ5xtAOWFSB7PDdj5DbPN6Yqf83ZdgaHN5TKipLn
	qmgP+Dg2/5cHwr0OaVbrRHjO7OD6wd38aalcwu7cgALodaiHe0MsBmZuX1ZyKzeW
	Ke3g0Y1T+yCO+O4TT31XaCKjB8mTrHZEERxRFpQxjDVgmh74oArFZ5noyOA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvatebx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:20 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9pCUl375656;
	Wed, 18 Nov 2026 09:51:17 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AI9pHA6376027
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:17 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id D845524931; Wed, 18 Nov 2026 15:21:16 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        atishp@rivosinc.com, anup.patel@oss.qualcomm.com, will@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        beeman@rivosinc.com
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v5 6/7] riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver
Date: Wed, 18 Nov 2026 15:20:52 +0530
Message-ID: <20261118095053.3871267-7-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd7518 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-_n0kkjAAAA:8 a=iWbneAD1chnm1hOrfXEA:9 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-GUID: kseD-_QRA31zTc9c3_NSqNUQhxKLzO7T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfXxYCbLzDo8ILF
 pOuIOy2mwC5m8MZB2BDCd6+9BrIHcYo31AFlq9bCHHFHSOlb/KJN0VKVQezn78UIWl3JeiOzRa0
 oqt7KR3vBOWa1rzjxzILyvpDvAyXX4Pq/cLk+VEZH/ML8iUbjtdx59vjmn4MUyGsqHe38+M+2Qv
 dLD7iFuzSZcr0wKXj2UAdwN+1rqQnQoenjunxwKdZ1wmCxmtY3C92Vtfd2lIQn6TnyN4Etoap0n
 RbKpfGvIK/acAW7s2Ep3HQb4HdNsnyhNZNsOhw4k/gAhvUgsfl64mFv8SZUiMajddgM6sYX0g9a
 h6Uh7Sn/afaHokHA6I00yNxSUbbS9vaHrl9OQLBS/n0zZlqpLtoZvCwkgdlJ6USB3/NROl07Wpi
 tHc+9nK2ngxyFPbLFlt0FhnLJ+SuiePr3ndY6dCqGHOD4eSHBBvaMvBCnKimHoTguuCTqzqn0f+
 lrTb9bFGffaenq+fhng==
X-Proofpoint-ORIG-GUID: kseD-_QRA31zTc9c3_NSqNUQhxKLzO7T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX2IiGgNaKz3SL
 7oWJHHnACnnFul1bqtBJUans+xcJ+CWeXZinPVKByGogzlhanMNJ00PMbngfItOQ3t2m7qtxpja
 iTAAw+37SjdacfQdumt0XjXn720+svE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180039

This integrates recently added CTR ext support in riscv_pmu_dev driver
to enable branch stack sampling using PMU events.

This mainly adds CTR enable/disable callbacks in rvpmu_ctr_stop()
and rvpmu_ctr_start() function to start/stop branch recording along
with the event.

PMU overflow handler rvpmu_ovf_handler() is also updated to sample
CTR entries in case of the overflow for the particular event programmed
to records branches. The recorded entries are fed to core perf for
further processing.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20261106173942.3175069-7-vikram.singh3@oss.qualcomm.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/perf/riscv_pmu.c     |  2 +-
 drivers/perf/riscv_pmu_sbi.c | 72 ++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index d4826eb73b16..fa9ae4e659d2 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -327,7 +327,7 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	uint64_t cmask;
 
 	/* driver does not support branch stack sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
 		return -EOPNOTSUPP;
 
 	hwc->flags = 0;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index b14b3acf7567..637b9d97e20a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -678,6 +678,9 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	 */
 	flush_work(&check_std_events_work);
 
+	if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
+		return -EOPNOTSUPP;
+
 	return riscv_pmu_get_event_info(type, config, econfig);
 }
 
@@ -827,10 +830,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
 
 static void pmu_sbi_ctr_add(struct perf_event *event, int flags)
 {
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_add(event);
 }
 
 static void pmu_sbi_ctr_del(struct perf_event *event, int flags)
 {
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_del(event);
 }
 
 static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
@@ -847,6 +854,10 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
 			1, flag, ival);
 #endif
+
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_enable(event);
+
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
 		pr_err("Starting counter idx %d failed with error %d\n",
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
@@ -864,6 +875,9 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
+	if (needs_branch_stack(event) && flag != RISCV_PMU_STOP_FLAG_RESET)
+		riscv_pmu_ctr_disable(event);
+
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		pmu_sbi_reset_scounteren((void *)event);
@@ -896,7 +910,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 static void pmu_sbi_sched_task(struct perf_event_pmu_context *pmu_ctx, struct task_struct *task,
 			       bool sched_in)
 {
-	/* Call CTR specific Sched hook. */
+	riscv_pmu_ctr_sched_task(pmu_ctx, task, sched_in);
 }
 
 static int pmu_sbi_find_num_ctrs(void)
@@ -1179,6 +1193,12 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		hw_evt->state |= PERF_HES_UPTODATE;
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
 		if (riscv_pmu_event_set_period(event)) {
+			if (needs_branch_stack(event)) {
+				riscv_pmu_ctr_consume(cpu_hw_evt, event);
+				perf_sample_save_brstack(&data, event,
+							 &cpu_hw_evt->branches->branch_stack, NULL);
+			}
+
 			/*
 			 * Unlike other ISAs, RISC-V don't have to disable interrupts
 			 * to avoid throttling here. As per the specification, the
@@ -1222,6 +1242,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
+	riscv_pmu_ctr_starting_cpu();
+
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_setup(pmu, cpu);
 
@@ -1237,6 +1259,8 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
+	riscv_pmu_ctr_dying_cpu();
+
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_disable();
 
@@ -1367,7 +1391,30 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 		cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
-static void pmu_sbi_event_init(struct perf_event *event)
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
+static int pmu_sbi_event_init(struct perf_event *event)
 {
 	/*
 	 * The permissions are set at event_init so that we do not depend
@@ -1379,6 +1426,11 @@ static void pmu_sbi_event_init(struct perf_event *event)
 		event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
 	else
 		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
+
+	if (branch_sample_call_stack(event))
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
+
+	return 0;
 }
 
 static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
@@ -1516,9 +1568,16 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 	}
 	irq_requested = (ret == 0);
-
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
+	ret = riscv_pmu_ctr_init(pmu);
+	if (ret)
+		goto out_free;
+
+	ret = branch_records_alloc(pmu);
+	if (ret)
+		goto out_ctr_finish;
+
 	bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
 	pmu->ctr_add = pmu_sbi_ctr_add;
 	pmu->ctr_del = pmu_sbi_ctr_del;
@@ -1535,6 +1594,10 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	pmu->csr_index = pmu_sbi_csr_index;
 	pmu->sched_task = pmu_sbi_sched_task;
 
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
+	if (ret)
+		goto out_ctr_finish;
+
 	ret = riscv_pm_pmu_register(pmu);
 	if (ret)
 		goto out_destroy;
@@ -1592,6 +1655,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		riscv_pmu_irq = 0;
 	}
 
+out_ctr_finish:
+	riscv_pmu_ctr_finish(pmu);
+
 out_free:
 	free_percpu(pmu->hw_events);
 	kfree(pmu_ctr_list);
-- 
2.43.0

