Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258F2D7814
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982580; cv=none; b=ayZbGjzSmC8vzjXrsBAYZaaElCzJYyXicTYyroLVN+P4DapT1p0J1qIaGS8FMpKnX/PPoogQMt/hj8XaPye1U0VWmo9/GA1c3vnkoPPAi+A3pZSh+TVhJ3wWhpyq/rD+E3HuGAYvNYJiD2YvnJyyVRMpFj3YJlPjlmek2wUV8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982580; c=relaxed/simple;
	bh=M6H+5+WGpHEi5r6mOlGtwEPevCMR/DHVnCMlOvmCboI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUpmUO/OEGYA5a8VFymDOKheNCbkm1iZvQYXo4XLXeHfGFjzr0+ve5k1JsCfJmdmaopcQB89PUr78hVt3eYa4gvJV7dXfaRJD07phY8XIbgVyVU7C3KFllqQAGIZmgJ7VC7P9om5NmIuRLfP4k4pb3xRsbqPlwP/TIboyfxdE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPT/5c0u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J92lFlGt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPT/5c0u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J92lFlGt"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYwfn2345766
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ng3FijRp7I1
	2WAwMSQi0FE70hZNC0tRMMCgODOQaLkM=; b=nPT/5c0uXgYWQ9t8JF3j0jpaaTf
	Eb7og9Oga/oxdL6IfdKfPu5yciI7otrPoHl1xd6otFTPyGSp+aACdQtnvSDv+GCt
	TeD4ha2YxLM2WB7DwpRG6Vl1nwNONGRPgruSbnx3iChie3TKnKLeLp12a8DVhXLf
	9X3XL0cbTuHwqNDVRdh6THPvSr7b1uelRWd4hqGnC40fbB3+8sRPQpbCbMpRIuGY
	jW0pfH5us1PnmGsVpr9GsGWvNjhk7ISAlHe5e+09WCavuC8jmsixEjDdH6yJzcan
	wDyUq1F1dMpDoVatDSp1h6W9oVJ4u2aYCRpHvTX0ViU5QJftYBfgCq3guTg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8hs33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:02:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848474825ffso40901b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786982577; x=1787587377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ng3FijRp7I12WAwMSQi0FE70hZNC0tRMMCgODOQaLkM=;
        b=J92lFlGt/7n0OrQrPv7dTLuTan+bQX6XxevnRdyTAUTGEbZtfQVBft5jznaCuDWc4a
         C+2UWPKVfymdza3azUs4WXaT1K3oxKLe62cQDjYgbzmw9L4HJ+Z3enFI80SheMcFUVOP
         Rc76eXT5BWEF25OUt1FkqnksrDGIQIlN1HV5nkwUYfpBQ+Uq3YEUR2S0mDt4TMSo+Pif
         08VUG543H3isLxda76I5dvW1UYeFlvO63MDcvyPKblm0QOlFDyKmDR5dZiDkbu2Je0Oc
         YEWH5PiPUdGqy7TTCWm8o1cn+BZA5XvXgtjfsAxCNnBDtLIrryZoxTR2Nr++UxrrwDoT
         +03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786982577; x=1787587377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ng3FijRp7I12WAwMSQi0FE70hZNC0tRMMCgODOQaLkM=;
        b=nJoJtHZ9yea18U/kXY35sAjVCkSvTGCUCpMQ69V0jfFy3KuFJEs2XWp2jBq9U3fNdX
         5/AOhPCBpkYf/Ywyydbd6+Sr2xA2vDrB1zInrKEBh7HN/4jwmzAjXNJS9ajNdr/kuB/j
         hvbTTsrZQHt40zt34iQZlvR2bvjq+XUBELdacmUXiDyNsiR0kxLblCfstrAFFMnaMO4I
         Jq/sqcMiZTKl6Y4H4GpXrDL0nDoYNENjsgEAzyKI2LKUPBsI1HoatNE5Paa4aDoorKhh
         l+Y4TYzFrp8921qOmGwT06f1K0pDnSEhiyR5EYvexYQ4jXeVwb55x3L4Ud+jGVhQg6Fb
         wayg==
X-Forwarded-Encrypted: i=1; AHgh+Rpti4va/s0uoQjsgMS/zLYgxvHqKbzmSmOAMkLyYl3hYdOeInDtRK5txWTjlzqwho9D8bZYhwKRm/2crDmpXcU9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7ldIcWT5tGmlqFb95Rry6ZqbCIPcg7wPf++7fioXIgkgdoid
	aRWmYP0aCjP8qp5Q6oyol9NrN0PeAqTlElsE5nYsYpUtOnUum2zRvdfNbOds3V6cyfWBQDEFDK0
	5xN5bPtfXqPdMLh92pxC7t2aZx6S2gAmmCjB0zEyb6yEZ3HOIkfeDG+hfuAIlZ+BQTc/KFkp6
X-Gm-Gg: AR+sD12cGeuUMHNAOuT1g16Ve34en0ID0HJcDtCNw7r2Pxm/fzQNffNrc5VHVnjd1qI
	/yD+Iu9f+FIz1WstDcl+24e93IbWU2Snim0FVQ+MJ98ghRlBeG7ZHyn+rC25KYhzzz1V9K7RKqQ
	2yZ9FEEr8HWalBEKA1je2dChyaYzFgL398mMG1qlTL0dj/id3j2VEdkGv+4dyurf8ez/b3UoGGF
	XvPcm26uAIC08iMZdU2HYSJhBLI7qJxHUm3vmEUHvTzCj99mlWpYBkN8rSyoywJQ0rPVQ8U9vXM
	Ljyh2q+naQ1nnQWpiH3M02Wg7gNUybm2W3SoZMmwye+Hw4ZQyRM+qTgSheuiAv+qD4MOK52Vg6E
	ViS+xmN8sPC8ULLLDIG3251bZ4zXj4Q+ix6jLIhkZ+JmEaBDJ3w3gBsXY1R96f+Ird8gNJ4tSBi
	kVVXDIcTU0hCaE36xnU3RQuzckhw==
X-Received: by 2002:a05:6a00:330f:b0:842:63f5:d097 with SMTP id d2e1a72fcca58-851bc233c3amr156031b3a.3.1786982575532;
        Mon, 17 Aug 2026 09:02:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:330f:b0:842:63f5:d097 with SMTP id d2e1a72fcca58-851bc233c3amr155973b3a.3.1786982574962;
        Mon, 17 Aug 2026 09:02:54 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-851b6f8b189sm562883b3a.34.2026.08.17.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:02:53 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] perf/riscv: Use Sspesa for precise sample attribution
Date: Mon, 17 Aug 2026 21:32:19 +0530
Message-ID: <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
References: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vYcmbCUoG_uZ88KzHh8uC52AuSdu0hi9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX7EJrg5uQ2fK6
 EtiYQ200lmf1JZasWrx3s2PPOzj52iQJhW7bRSSebzSN5rWbmuNsZXu99foOqQMKQ7MB/p+2jX0
 /CgJv5NhC9NVEe+wOYrKgabDRr1YCxI=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a8330b2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7H5guYdma6xEYB3B6BcA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: vYcmbCUoG_uZ88KzHh8uC52AuSdu0hi9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX7qJwomJh8KIe
 ByxyWuuAiKXyEaHf394fr8U5sqGdEjnjCNPICAmWEuQzsBm+T5npEcKOG1FSUn8VTeICSDC0BE2
 7jbKS6/aDhG3IoN+64+7HERUDdBZgEioAKdMtjyiBARn+6c5QMwS+lLgHlckkA/aHj7BS1fK3v8
 Ps3hvQBIJmsfmEavA4mGW1+u0nlGg9ZohWhMbuJZBhhJ6UKlXbfpZOBfRGO4M9RouEjRhj+QijQ
 6y/Ci/UqzxY8OzxONLVYO1SUrJRbmF2JIs3I5uEj3AmKcG+pAXlD1QDMsUxpTTr4E0kLNAZkd+4
 /SAHSw1ly5mVzcuplb4U0MVdb0qf9AraBKJjtNj5+y0QMI0e/EKFFDwgVuGZqSFXbehvM/EnQIb
 f/de2bcuNTI/7KuK6NblkLr6X4Hg2n9qO1lILFV0mAzjqEvjEHD/dnqLj7kl26jxQanjWZnudPu
 qN0gUPSEZy22QoXFSyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170123

When the Sspesa (Precise Event Sample Attribution) extension is
available and a counter overflows, the hardware records a sample PC in
shpmspc register and the counter ID and additional implementation-defined
data in shpmsdata register.

In the SBI PMU overflow handler, use shpmspc to report sample PC via
PERF_SAMPLE_IP for the counter that caused the overflow. Shpmsdata is
exported as raw data to userspace when events request PERF_SAMPLE_RAW
sample type and it assists in deriving the sample PC from shpmspc if
precise attribution is not supported for the event.

If sspesa is not available or for counters that don't match
shpmsdata.CNTRID, fallback to epc for PERF_SAMPLE_IP.

Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 drivers/perf/riscv_pmu_sbi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dfc886dee5ad..1b0b1cc612de 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -63,6 +63,8 @@ PMU_FORMAT_ATTR(firmware, "config:62-63");
 
 static bool sbi_v2_available;
 static bool sbi_v3_available;
+static bool sspesa_available;
+
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
 #define sbi_pmu_snapshot_available() \
 	static_branch_unlikely(&sbi_pmu_snapshot_available)
@@ -1051,6 +1053,11 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
 	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
+	unsigned long sample_pc = 0;
+	unsigned long sample_data = 0;
+	int sample_cntrid = -1;
+	u64 raw_sample;
+	struct perf_raw_record raw = { 0 };
 
 	if (WARN_ON_ONCE(!cpu_hw_evt))
 		return IRQ_NONE;
@@ -1088,6 +1095,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		return IRQ_NONE;
 
 	regs = get_irq_regs();
+	/*
+	 * Sspesa records the PC and metadata of the overflowing counter in
+	 * hardware. The PC is precise only for events that support precise
+	 * attribution; otherwise it is best-effort.
+	 */
+	if (sspesa_available) {
+		sample_pc = csr_read(CSR_SHPMSPC);
+		sample_data = csr_read(CSR_SHPMSDATA);
+		sample_cntrid = sample_data & SHPMSDATA_CNTRID;
+	}
 
 	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
 		struct perf_event *event = cpu_hw_evt->events[lidx];
@@ -1123,6 +1140,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 		riscv_pmu_event_update(event);
 		hw_evt->state |= PERF_HES_UPTODATE;
 		perf_sample_data_init(&data, 0, hw_evt->last_period);
+		if (sspesa_available && hidx == sample_cntrid) {
+			data.ip = sample_pc;
+			data.sample_flags |= PERF_SAMPLE_IP;
+
+			raw_sample = sample_data;
+			raw.frag.size = sizeof(raw_sample);
+			raw.frag.data = &raw_sample;
+			perf_sample_save_raw_data(&data, event, &raw);
+		}
 		if (riscv_pmu_event_set_period(event)) {
 			/*
 			 * Unlike other ISAs, RISC-V don't have to disable interrupts
@@ -1194,6 +1220,9 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 	struct irq_domain *domain = NULL;
 
+	if (riscv_isa_extension_available(NULL, SSPESA))
+		sspesa_available = true;
+
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-- 
2.43.0

