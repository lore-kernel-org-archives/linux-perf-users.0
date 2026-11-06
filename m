Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986893;
	b=glRSXeGHbvB1QAUNQnZg0I+HhBkEBpQFDJmeLDL4ebBJftQTdFnr9diFzqL1AoVvJpXJ
	 a5hQC3TI7Aou5+WEtPAhG+zKeYsn5oCHZ+N4nuKS2i4zPDpLBL1QsAy6M0xDFdJymPrRE
	 K1abzOYhiL6aA+COWhiw8YkU7Kzkz38Jz7/WHGdIOmCJxEHkAoWhHDFIkVTgM8/XDixQq
	 UZ20ntMAM7Jxa6QcpiHhYt+AEuY4QSyvoDENDP5QBKzHMpEnBZnGGoUl3FWm0LrkeLoho
	 q+P3VBpWSrPRYBpSpbSnrHXYwxKss7E/Vh9uCU9oBEaQB7bPtOctyYerIC+qKgAtjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986893;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ts+DqzLxFR8TI6RsQv7hKRjDDcPqTV1DKJzs7FV/2Bo=;
	b=14AO92D01qYuvbxj3jxw48YiuMlgG5R+biIz0Vlbp5CDR5m4E1X81Oh9QU1X+L0YU8Tm
	 43Q/kTwW6YMEWr8o7eMEeOwksbf1BjtwAKBvEqZzdWhpTNSoWtpvSDs9uSraI/2FGuVsX
	 pYfRWWZu61h2X2BZsGl7U6N2z8tb9AD3CmaSGb8QGYofEdWUpi/IyXnecaL07O2am0cN7
	 i+8y6ymNwcIZtvZYELHJkO7CxioJ95aNaUfCL+0W9+VszpaTrUg+w8pjuMOwdYtAsCb8M
	 PfnmdYadvx23k17ZhgmpOEl2VRSkxZLakCBDR4pLyqSDWKrbkXCDiohz1cLEm/xt+4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bD9QnDyB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E94606A326;
	Fri,  6 Nov 2026 17:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bD9QnDyB
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F00F7044181;
	Fri, 6 Nov 2026 17:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ts+DqzLxFR8
	TI6RsQv7hKRjDDcPqTV1DKJzs7FV/2Bo=; b=bD9QnDyBBwz8CVQc57Tz3c2/Cbc
	02jbZ7wKRuWFUdL1fjbW1v0iEdoIseczUWJDDWQyIF990pS1Ti3BjBElw1hEvsZY
	5M6BnCOiKUYwexltCtR2CKQ4HEH6vR6XC0ZO/NDU0EELNKLA+U6yPL+rS58X0PZj
	4pFyqGjTvrdkzc6dfyLP85OeGH3NS7rbjVC2d66WEYUMm4OTzagmBJnQEJHuudQk
	DjzviSCMN7W+PNBOD38Jwoeb3IB2fD5JdLYJfpcpbXPpK5Q4czpINJiESDPMW6QZ
	eag2qjxZzyxr85v5PneZjWQYuaxaVbgAPtFpIr23nL8Lx22PeWnpgDHcI6A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3wpp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:40:58 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HetqT1892176;
	Fri, 6 Nov 2026 17:40:55 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A6HetSQ1892170
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:40:55 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 8CF06248C6; Fri,  6 Nov 2026 23:10:54 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Beeman Strong <beeman@rivosinc.com>
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 6/7] riscv: pmu: Integrate CTR Ext support in riscv_pmu_dev driver
Date: Fri,  6 Nov 2026 23:09:41 +0530
Message-ID: <20261106173942.3175069-7-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
References: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aee112a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=JYbPudkZx6Tu0gzNZToA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX3lgE6bptFqtl
 i/umDMK6+7oYq2yew0x8ULt99kHjWAOl3PJjW4VdInkL1Q3+bBVr1q2g4khLYq9qBqaa5w2Hfdi
 vAMRDTu9zJzc/0pbhCV6YnF4E5Z4yDA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXzHHaU2oSj4Gk
 Q8lLR3qQucBfLo3J1oxl1ldAdUrOexhAvj0fMEYfy18BmWISq1Exdu6JknvBUWi3yll8sKUaaag
 tAWprkj+bPSul/QQaSpO1rw6DrlJDZLCpV+TBu+It0tYXJcEJ7nVxzWnirhhhM85fTebrTFSsF4
 OyckS7iGgUh1OqlSpgPDRckmMO7Gwn9wsWENwuhHTR/RAYVsTO9Y4QICcLtqkaxSkb1RH5gnl89
 0hw7H6CM1CmeuAxyz4WCQPdQHTO1pj/gb6LsXxxWHcGUb2tV64qA/F1bJOXePkpH11VDqDLcGp1
 P88vACaM0l3KVrOwYGF5V7MQrM7+S01H86JcL6mIcT3yeU2IrZCsMGlFaHrWfEeja3yyoFu4Pxe
 7TA09azik+WnVFvYsOWePqvnOJIBfL9XKdYRnuhOA+IHqcDQuod7dWm7MCR6mA7H4ilDMvtAh5E
 TxaekJnbm7j2mSoff2g==
X-Proofpoint-GUID: YiKnVIFJUuB1Qj2zSLXHRRPraT8YRhuX
X-Proofpoint-ORIG-GUID: YiKnVIFJUuB1Qj2zSLXHRRPraT8YRhuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060070

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
---
 drivers/perf/riscv_pmu.c     |  2 +-
 drivers/perf/riscv_pmu_sbi.c | 68 +++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index a1ae490d94c9..407028f24674 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -310,7 +310,7 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	uint64_t cmask;
 
 	/* driver does not support branch stack sampling */
-	if (has_branch_stack(event))
+	if (has_branch_stack(event) && !riscv_pmu_ctr_supported(rvpmu))
 		return -EOPNOTSUPP;
 
 	hwc->flags = 0;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 400de6bed369..684f02122f68 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -650,6 +650,9 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 	 */
 	flush_work(&check_std_events_work);
 
+	if (needs_branch_stack(event) && !riscv_pmu_ctr_valid(event))
+		return -EOPNOTSUPP;
+
 	return riscv_pmu_get_event_info(type, config, econfig);
 }
 
@@ -798,10 +801,14 @@ static void pmu_sbi_reset_scounteren(void *arg)
 
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
@@ -818,6 +825,10 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, hwc->idx,
 			1, flag, ival, 0, 0);
 #endif
+
+	if (needs_branch_stack(event))
+		riscv_pmu_ctr_enable(event);
+
 	if (ret.error && (ret.error != SBI_ERR_ALREADY_STARTED))
 		pr_err("Starting counter idx %d failed with error %d\n",
 			hwc->idx, sbi_err_map_linux_errno(ret.error));
@@ -835,6 +846,9 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
 
+	if (needs_branch_stack(event) && flag != RISCV_PMU_STOP_FLAG_RESET)
+		riscv_pmu_ctr_disable(event);
+
 	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
 	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		pmu_sbi_reset_scounteren((void *)event);
@@ -866,7 +880,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
 static void pmu_sbi_sched_task(struct perf_event_pmu_context *pmu_ctx, struct task_struct *task,
 			       bool sched_in)
 {
-       /* Call CTR specific Sched hook. */
+	riscv_pmu_ctr_sched_task(pmu_ctx, task, sched_in);
 }
 
 static int pmu_sbi_find_num_ctrs(void)
@@ -1140,6 +1154,12 @@ static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
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
@@ -1228,6 +1248,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
+	riscv_pmu_ctr_starting_cpu();
+
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_setup(pmu, cpu);
 
@@ -1243,6 +1265,8 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 	/* Disable all counters access for user mode now */
 	csr_write(CSR_SCOUNTEREN, 0x0);
 
+	riscv_pmu_ctr_dying_cpu();
+
 	if (sbi_pmu_snapshot_available())
 		return pmu_sbi_snapshot_disable();
 
@@ -1369,6 +1393,29 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
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
 static void pmu_sbi_event_init(struct perf_event *event)
 {
 	/*
@@ -1381,6 +1428,9 @@ static void pmu_sbi_event_init(struct perf_event *event)
 		event->hw.flags |= PERF_EVENT_FLAG_USER_ACCESS;
 	else
 		event->hw.flags |= PERF_EVENT_FLAG_LEGACY;
+
+	if (branch_sample_call_stack(event))
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
 }
 
 static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
@@ -1519,6 +1569,15 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
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
 		goto out_unregister;
@@ -1584,6 +1647,9 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 out_unregister:
 	riscv_pmu_destroy(pmu);
 
+out_ctr_finish:
+	riscv_pmu_ctr_finish(pmu);
+
 out_free:
 	kfree(pmu);
 	return ret;
-- 
2.43.0

