Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF382DC76A;
	Fri, 12 Jun 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258285; cv=none; b=TE5L1/EnjlenfLOla7kpdtAZREwnSveQhBKgugA+iiPVLbSSWWub6fsntwGwDcX04b531gBqYgki4BPPjvw/t3GVBDKb5i3MtRbfJ3WlgI774O7G8aFZzN+qpKphOHbOEDwUOAAAdBWWKD1nf5O5oNAOMXfQ7vbCvxzi8XUaqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258285; c=relaxed/simple;
	bh=mnLKrOMnEeEVm/oF2HzEfh2yX1M2rurwOEMc4MgbAwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5Vt+vMsfUDJo4+0h3VC2PTqFEo5PEpduTGOWo6LTuh70Qg2VtPdtVPNOHFe4um57AQqXMVHPzfnGeud684WcLC11hhKjGX3hdg/TM1+vWkYOLovu76J4vY0Jqpf7ervwg8fAZo3LzgHPV3uBw9mnrqPLPoE4VnEH9IYjM62nRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=inISHFJF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="inISHFJF"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3AQIJ071108;
	Fri, 12 Jun 2026 02:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YYTDwwqgoZk1HElM4vdz0Zdzx
	Jn/OzQXeaTN5u+LMeQ=; b=inISHFJF7eD47qJAMjhxw9sgYoa/6LXb7FNAWhxo/
	/VSiQn8+I5RbmzONhTHJ0RKLqXioh5VVxqv6Pw9gGaxhi4m0/INLWTIIgnTRQUXQ
	qpcZB1VAigns3uI7/g8HJbCyolddCEQ+YxQsPtlaCEtCN793HQvKRzxUuFotbPFx
	mDvRnH/CkxAtk9Xq6HYaZW43qpWvsRwvxDOM+CR/Gmi3v9+va0ZW2mFKII0Wfdat
	Jw/A7A1yOAojz6WziwQSUSTE6zcZ4/5/9sczppUT+cUkZsT8Crr/m8k71awfSUEQ
	s5oHV5XyFu6+fpOY7i68VK783oFTwWcaHvofN/xcMG14w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vxrvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 02:57:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Jun 2026 02:57:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Jun 2026 02:57:56 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 9D37C3F7040;
	Fri, 12 Jun 2026 02:57:53 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v2 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Date: Fri, 12 Jun 2026 15:27:45 +0530
Message-ID: <20260612095746.19679-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260612095746.19679-1-gakula@marvell.com>
References: <20260612095746.19679-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX02kwoKCzxXPE
 b/MYipw+HrIVwpp2+Wv5GBzpeE9vbGgs4ehJaqZVHc8Va64pWzalIUghpLZ+sEufi/MHcIPWty8
 eEMp8pRqz6D0Llx0MyksuoIL9OeAva8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX/P4fDjtTH5aI
 CMvmj0iNmAWRIGI21wc5xPY1DSZ/XeHzh88n8C6ySp4N7FmTOKd/T1SxhIJJY4m34SLbvtTBvew
 JcyazerEXQK4JHOz6dYEgTbwPG35S1psbUaByuRrf2df5DTWWtjomoJX2rOqbtPKap3UDuoJhxq
 WlkvyqOwYkSEecuuuZKqSezl3sK3by0nk0LfzqctXyOW3iIG2lcF2b+4lZJTFubG+LAiaAwuYuO
 rpBRixrFZiylQueIZviDBLAwt3oo3uvkgDxAjSkW5HtKPUCPvLFVUFZ6u1ywHE4oXtho2oTTZ74
 2tDNktDjDX/y8rLwGh9tEMsroLB6X+gH1+mXnCDG7TGxdPE9Dfcd2U1rgRx/FLXMvIrN/Xg75Hn
 Qt3DpSX5YRYJwKjzw1nNdRsMvA9HAjfbvF+8lxnPNCexzJSMUDTaaQHi6bAbXIw2K4OWAqksAlT
 Gj3snHQzlbZc4MlsejA==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2bd824 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=yk21Q0SZhpILLZZ3dkMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: qTujiS5Z0aSq6Sore20qaDEeUw_pmEzW
X-Proofpoint-GUID: qTujiS5Z0aSq6Sore20qaDEeUw_pmEzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01

Add support for the LLC Tag-and-Data (TAD) PMU present in
Marvell CN20K SoCs.

The CN20K TAD PMU is based on the CN10K design but differs in the
layout of PFC/PRF register offsets relative to each TAD base, and
introduces additional events. These offsets are selected by the driver
based on the compatible string and are not described via DT properties.

Because of this, "marvell,cn10k-tad-pmu" cannot be used as a fallback
for CN20K, as it would result in incorrect register programming.

Add support for "marvell,cn20k-tad-pmu" by:
  - Introducing a TAD_PMU_V3 profile with CN20K-specific register bases
  - Extending the event map for new CN20K events
  - Matching the PMU via OF and ACPI (MRVL000F)

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---

Changelog (since v1)
--------------------
- Hide V3-only events on CN10K via sysfs is_visible and reject them in
  event_init.
- Use CN20K-specific MPAM PRF bits (MATCH_MPAMNS, partid << 10) for V3;
  software partid is limited to nine bits so this does not collide with
  the fixed bit at 25.
- Reset hwc->prev_count when starting counters so reads match cleared HW.

 drivers/perf/marvell_cn10k_tad_pmu.c | 54 ++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index af706b890bf1..e43598a52859 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -17,11 +17,14 @@
 
 #define TAD_PRF_OFFSET		0x900
 #define TAD_PFC_OFFSET		0x800
+#define TAD_PRF_NS_OFFSET	0x30900
+#define TAD_PFC_NS_OFFSET	0x30800
 #define TAD_PFC(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF_CNTSEL_MASK	0xFF
 #define TAD_PRF_MATCH_PARTID	BIT(8)
 #define TAD_PRF_PARTID_NS	BIT(10)
+#define TAD_PRF_MATCH_MPAMNS	BIT(25)
 /*
  * config1: bits 0..8 MPAM partition id (including 0); bit 9 requests
  * filtering for MPAM-capable events. All-zero config1 means no filter.
@@ -38,6 +41,7 @@ struct tad_region {
 enum mrvl_tad_pmu_version {
 	TAD_PMU_V1 = 1,
 	TAD_PMU_V2,
+	TAD_PMU_V3,
 };
 
 struct tad_pmu_data {
@@ -85,8 +89,15 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
 	if (use_mpam && event_idx > 0x19 && event_idx < 0x21) {
 		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
 				((u64)partid << 11);
+
+		if (pdata->id == TAD_PMU_V3)
+			partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_MATCH_MPAMNS |
+				((u64)partid << 10);
 	}
 
+	/* CN10K support events 0:24*/
+	if (pdata->id == TAD_PMU_V1 && event_idx >= 0x25)
+		return;
 
 	for (i = 0; i < pmu->region_cnt; i++) {
 		reg_val = event_idx & 0xFF;
@@ -159,6 +170,7 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 
 	hwc->state = 0;
+	local64_set(&hwc->prev_count, 0);
 
 	tad_pmu->ops->start_counter(tad_pmu, event);
 }
@@ -216,6 +228,8 @@ static int tad_pmu_event_init(struct perf_event *event)
 		if (cfg1)
 			return -EINVAL;
 	} else {
+		if (pdata->id == TAD_PMU_V1 && event_idx >= 0x25)
+			return -EINVAL;
 		if ((cfg1 & GENMASK(8, 0)) && !(cfg1 & TAD_PARTID_FILTER_EN))
 			return -EINVAL;
 		if (cfg1 & TAD_PARTID_FILTER_EN) {
@@ -242,6 +256,22 @@ static ssize_t tad_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+static umode_t tad_pmu_event_attr_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct tad_pmu *t = to_tad_pmu(pmu);
+	struct device_attribute *da = container_of(attr, struct device_attribute,
+						   attr);
+	struct perf_pmu_events_attr *e = container_of(da, struct perf_pmu_events_attr,
+						      attr);
+	u64 id = e->id;
+
+	if (t->pdata->id != TAD_PMU_V3 && id >= 0x25)
+		return 0;
+	return attr->mode;
+}
+
 #define TAD_PMU_EVENT_ATTR(name, config)			\
 	PMU_EVENT_ATTR_ID(name, tad_pmu_event_show, config)
 
@@ -283,12 +313,25 @@ static struct attribute *tad_pmu_event_attrs[] = {
 	TAD_PMU_EVENT_ATTR(tad_dat_rd_byp, 0x22),
 	TAD_PMU_EVENT_ATTR(tad_ifb_occ, 0x23),
 	TAD_PMU_EVENT_ATTR(tad_req_occ, 0x24),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dtg_evict, 0x25),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_ltg_evict, 0x26),
+	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_mpam, 0x28),
+	TAD_PMU_EVENT_ATTR(tad_replays, 0x29),
+	TAD_PMU_EVENT_ATTR(tad_req_byp0, 0x2a),
+	TAD_PMU_EVENT_ATTR(tad_req_byp1, 0x2b),
+	TAD_PMU_EVENT_ATTR(tad_txreq_byp, 0x2c),
+	TAD_PMU_EVENT_ATTR(tad_time_in_dslp, 0x2d),
+	TAD_PMU_EVENT_ATTR(tad_time_elapsed, 0x2e),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_rd_128mrg, 0x2f),
+	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_wr_128mrg, 0x30),
+	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
 	NULL
 };
 
 static const struct attribute_group tad_pmu_events_attr_group = {
 	.name = "events",
 	.attrs = tad_pmu_event_attrs,
+	.is_visible = tad_pmu_event_attr_is_visible,
 };
 
 static struct attribute *ody_tad_pmu_event_attrs[] = {
@@ -474,7 +517,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
-	if (version == TAD_PMU_V1) {
+	if (version == TAD_PMU_V1 || version == TAD_PMU_V3) {
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
 		tad_pmu->ops		 = &tad_pmu_ops;
 	} else {
@@ -517,6 +560,11 @@ static const struct tad_pmu_data tad_pmu_data = {
 	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
 
+static const struct tad_pmu_data tad_pmu_cn20k_data = {
+	.id   = TAD_PMU_V3,
+	.tad_prf_offset = TAD_PRF_NS_OFFSET,
+	.tad_pfc_offset = TAD_PFC_NS_OFFSET,
+};
 #endif
 
 #ifdef CONFIG_ACPI
@@ -530,6 +578,7 @@ static const struct tad_pmu_data tad_pmu_v2_data = {
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
+	{ .compatible = "marvell,cn20k-tad-pmu", .data = &tad_pmu_cn20k_data },
 	{},
 };
 #endif
@@ -538,6 +587,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
 	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
+	{"MRVL000F", (kernel_ulong_t)&tad_pmu_cn20k_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
@@ -599,6 +649,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD perf driver");
+MODULE_DESCRIPTION("Marvell CN10K/CN20K LLC-TAD perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

