Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6F318B96;
	Sun,  7 Jun 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836691; cv=none; b=AAG/mw44zrtBUHXw92SzsptYwT1pwWwPRw4f3qFvP6KiaQ3UnoTiM3cfp87YS2sfIgvLYYl/Iki2tm6SApTUAckiuVaAxsViErLDRpB6EklMVyD9EFS4RiQ69AKWT/P/8ewS8zdt3oxZLLCLC3BVifPRVlea4W1CqxU7/TQVFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836691; c=relaxed/simple;
	bh=y1mCNYbv4xmoA/8hPymwySCxvqNrhzdGKAkPdI9eXQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg8/bN70c1B+UBMqsVnfx4e+xCMF+kzr1e9mquYLeCO6QUUTnaDXDoRuQjqhocveSwTpjGcj4W6QnCUOt3bVEZMYJy6aU8+LBn9MueGfjTQGGbKngQajAgtZFFklVwRrmeRmsWFTzXhjSfbIh965Ova/jjJ5lHERL1ML8LT2cTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PdEFP5tG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PdEFP5tG"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BT63E3749526;
	Sun, 7 Jun 2026 05:51:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gzX90Dtqcl+cOEpVY5HErjumr
	gVIscJmmnCnneyC1iA=; b=PdEFP5tG52IQR35Xtzufx+P+vg3XbrYosIsUJDnoK
	xRe7xXrfUmf7wfA6e7oW16UXsRYJ/z5YriDu7T7G4fzb5JMqaRSt9FMfjjvZp9C8
	uknHI13bJKhXTRxAe0a/DJgHOs6LmsHW6mkquNQ95YkrfcgbRUKfoPv0fbmrZeOq
	o7FmE5CavqAKbkBQmg21A9G+aw7Zw4sf38eSt9Lk7A3VGkmq5xLSPExuugxb3wsX
	N50fVmyv3Cn44GvkRwtKOzoQebwHP1FDLN6zwfmlUrmqGgP7Rj0/Uv/u1axt7gd3
	LjKfyPriakSAkNPBwCpUELzzrZWtlqB3p3G7nykWM6/CA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8r53e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 05:51:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 05:51:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 05:51:12 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8AACA3F70BA;
	Sun,  7 Jun 2026 05:51:09 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Date: Sun, 7 Jun 2026 18:21:00 +0530
Message-ID: <20260607125101.17778-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260607125101.17778-1-gakula@marvell.com>
References: <20260607125101.17778-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEyOCBTYWx0ZWRfX9JdUTYcp82bL
 04KFZ4at+fUzy9XdhIm6QpSporQPY3PtzMkZPHLN6awae6GiTFzoKMKgP+1r7Ad++Egke5qh761
 MN2ydUVlkY0DLqDRaVKzCVc+QfnHcXBsik8iGqqIUYJ7l/EiX9nBjy67VWgrSDZVohMfTwvaCfh
 XRQmHUj6tREwbfXqq5XS4/awV1jYukX/Q0w8mUDkVboTS48nsBgH+TIpaeUfOoiBkgju8Ll2gfI
 421vsU6qLqR3UdeRHrEaUh0GMnOz91jpLeF7Ux3/xvuOmsV6ewu5918uZ9EgVj8Xo6VpjCT+4J0
 w3FdaNNpS8fGvcnsbr6ONCKb5ENsCYGz9LkIO42gtj/k+ulbt6ouU01PWldDu+7FE26t8T0dy3R
 oFGBvBR4hE11xAJBNJz/32w/AAns+DwGs3BxPAJlnz2lulfxPVbQBra3gE2MFfEd9uKLErJWJhr
 rIMkfSzHrqgJ7rVfSlQ==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a256940 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=Ye5975JmM4DBnxqCyIMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QybdIdM_cGL4jEs5nNVnnEq9doSuyz9m
X-Proofpoint-GUID: QybdIdM_cGL4jEs5nNVnnEq9doSuyz9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01

CN20K LLC-TAD uses non-standard PFC/PRF page offsets relative to each
TAD region base. Add a TAD_PMU_V3 profile with per-platform register bases,
extend the CN10K event map for new counters, and match the block via OF and
ACPI.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 33 +++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 7a3b659c999a..4daf109b89ee 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -17,6 +17,8 @@
 
 #define TAD_PRF_OFFSET		0x900
 #define TAD_PFC_OFFSET		0x800
+#define TAD_PRF_NS_OFFSET	0x30900
+#define TAD_PFC_NS_OFFSET	0x30800
 #define TAD_PFC(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF(base, counter)	((base) | ((u64)(counter) << 3))
 #define TAD_PRF_CNTSEL_MASK	0xFF
@@ -33,6 +35,7 @@ struct tad_region {
 enum mrvl_tad_pmu_version {
 	TAD_PMU_V1 = 1,
 	TAD_PMU_V2,
+	TAD_PMU_V3,
 };
 
 struct tad_pmu_data {
@@ -80,8 +83,14 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
 	if (partid && event_idx > 0x19 && event_idx < 0x21) {
 		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
 				((u64)partid << 11);
+
+		if (pdata->id == TAD_PMU_V3)
+			partid_filter = TAD_PRF_MATCH_PARTID | BIT_ULL(25) |
+				((u64)partid << 10);
 	}
 
+	if (pdata->id == TAD_PMU_V1 && event_idx > 0x24)
+		return;
 
 	for (i = 0; i < pmu->region_cnt; i++) {
 		reg_val = event_idx & 0xFF;
@@ -261,6 +270,18 @@ static struct attribute *tad_pmu_event_attrs[] = {
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
 
@@ -426,7 +447,6 @@ static int tad_pmu_probe(struct platform_device *pdev)
 	tad_pmu->region_cnt = tad_cnt;
 
 	tad_pmu->pmu = (struct pmu) {
-
 		.module		= THIS_MODULE,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
 				  PERF_PMU_CAP_NO_INTERRUPT,
@@ -440,7 +460,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		.read		= tad_pmu_event_counter_read,
 	};
 
-	if (version == TAD_PMU_V1) {
+	if (version == TAD_PMU_V1 || version == TAD_PMU_V3) {
 		tad_pmu->pmu.attr_groups = tad_pmu_attr_groups;
 		tad_pmu->ops		 = &tad_pmu_ops;
 	} else {
@@ -482,6 +502,11 @@ static const struct tad_pmu_data tad_pmu_data = {
 	.tad_pfc_offset = TAD_PFC_OFFSET,
 };
 
+static const struct tad_pmu_data tad_pmu_cn20k_data = {
+	.id   = TAD_PMU_V3,
+	.tad_prf_offset = TAD_PRF_NS_OFFSET,
+	.tad_pfc_offset = TAD_PFC_NS_OFFSET,
+};
 #endif
 
 #ifdef CONFIG_ACPI
@@ -495,6 +520,7 @@ static const struct tad_pmu_data tad_pmu_v2_data = {
 #ifdef CONFIG_OF
 static const struct of_device_id tad_pmu_of_match[] = {
 	{ .compatible = "marvell,cn10k-tad-pmu", .data = &tad_pmu_data },
+	{ .compatible = "marvell,cn20k-tad-pmu", .data = &tad_pmu_cn20k_data },
 	{},
 };
 #endif
@@ -503,6 +529,7 @@ static const struct of_device_id tad_pmu_of_match[] = {
 static const struct acpi_device_id tad_pmu_acpi_match[] = {
 	{"MRVL000B", (kernel_ulong_t)&tad_pmu_data},
 	{"MRVL000D", (kernel_ulong_t)&tad_pmu_v2_data},
+	{"MRVL000F", (kernel_ulong_t)&tad_pmu_cn20k_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tad_pmu_acpi_match);
@@ -564,6 +591,6 @@ static void __exit tad_pmu_exit(void)
 module_init(tad_pmu_init);
 module_exit(tad_pmu_exit);
 
-MODULE_DESCRIPTION("Marvell CN10K LLC-TAD Perf driver");
+MODULE_DESCRIPTION("Marvell CN10K/CN20K LLC-TAD Perf driver");
 MODULE_AUTHOR("Bhaskara Budiredla <bbudiredla@marvell.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

