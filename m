Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201095;
	b=pEauwqrXqIB38V75NC03z7mKsC9X2M80d+w5AmPUX4wIFMobCiedJHnou9uL+YqwEmt7
	 S+Shf2ZrinBmTNdjFEub3VDjJQXZPbDh0/uZQpphTRq7z7mtNjQg+MZbtHSZCFrI50nzt
	 IMSyuDPRbz9dIzaOFXrdegg0rWtsQh7vntDaMUYtUT9C4A0w3D/pBEysjGkYc/mt+rXHB
	 Omwp6QVWDPrOQq1Gbk9iKkCJRwLxSX39SwLcXr6mkw9wioe/nly+XkiyNjke2UHYMB0rq
	 XfxEpgaWEy2YlsvXAesxSzor608nBFWPUCn4Lfmm6rVaJ/ZyDKg/sfK2Pwa3G2mVCHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201095;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=h7926tjNaBzEKmN+2n0WSpOiLds05PYiq+BYnAZbPcM=;
	b=pOYEOmDdeK5rYYQi9DlBO80cqHdgWQOjCfiaVbWNPFmpten2NjnMJqa4PWynBqxU6Xn7
	 ed+y52zQD3DEdCIHnBwdgUi0Sl6Za5FO4DHm7BGpiMrLt26uAbpkP3ALmcW/HSAhZaKy7
	 1pR02XnwX8af8ugvcwCIFUUC+quwJb+Uomr6eyrqB3nMO1W4zHX0XlVUIuzu8YE0Hfs80
	 zialT83RHbmjlpDvXNTa67eNZCNkl3gAYp+Zx4hIhzu1+VR2PVXeyyJsD9BCfN/A4+7Sr
	 jskrLcI6UL8908rytqTg9f+KZCS4Sp+2XXx6Leq7HxVuvoAUoN21MCPZnDmGePgiyrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=rRMx4XDW;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223660A2600;
	Fri, 20 Nov 2026 18:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9223660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=rRMx4XDW
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKH3dMK2027799;
	Fri, 20 Nov 2026 10:57:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=h7926tjNaBzEKmN+2n0WSpOiLds05PYiq+BYn
	AZbPcM=; b=rRMx4XDWXaiqjhY6GFvQvVY4lCMI6yz9d5r9gYiupbG0U2JveFm16
	rOfL3L8aY8j2khQNOaJRNZS8IYqgj+y8f5BBMBa0v7Q6LhRzB2VK+YW+ViQ8ozp5
	seGFB95SZRpEnKNIvw1Jar0x8g+GJp0+KAhilCz4FOK3C3QcjttgBdGkiHNNe1sc
	LZmrZRSgy7CQlORdEzhhJ9JljNTCvxW7SmEdMr4LOnYEz+h3s8BDwQ/8FnCzitFh
	4d7oLYLXw/Pm92e8ttCMdetGrnbCS5lEP071c+KYOXrZ4w0rFEFp5KB5qO1A0m91
	HKdfRUCrr6pxJ3U/Yfe8lU5CrkiJS7RUQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2t99ryh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 10:57:39 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 18:57:38 +0000
From: Amir Ayupov <aaupov@fb.com>
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
        Suzuki K
 Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel
 Pereira <danielmaraboo@gmail.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] coresight: etm4x: Fix event count decoding
Date: Fri, 20 Nov 2026 10:54:31 -0800
Message-ID: <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795196854.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <cover.1795196854.git.aaupov@fb.com>
References: <cover.1795196854.git.aaupov@fb.com>
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
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=LvQHWXdc c=1 sm=1 tr=0 ts=6b009823 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=FOH2dFAWAAAA:8
 a=nO7UQp2L8s1CClaFxKwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pkagRf47_O5J1yTQE88O4qQ0dMsMkujU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX7Le/D8bVFi9j
 rmyhMtbgf449VUDpSe+GaSxjcstEEOBeXPtURh3mqjoSvNxNQl/LIoGFt33ccrz/Ofgm3mBvN/K
 NnGA7OYKpXG7biJ61ELT2QgxX5Cxec9bO/hazDstKYtW54vF6nChlid+0IQFylG3RhKf0NukCY1
 aeHNJ4oLovkodTzDR6qKNKrEb1weqLMcUe5v0Hz362x4R0tT+6alwL2PZ1QkO5gadmPidaBz1Tb
 sZVZ9oB504WaUZGnI7JxLlx66W6kQbqXUuP70oWpQ4M2Pwo5JDvmTaT7V0DvoMq9LjAGZDdJq3b
 fxlBqqVRcYi7nqjJPka0FBNCb0KP5D0rZWO9C8zRnq0cIt+Flu4J1WvXLLbSN2gm6MV+zhsTbPl
 KHNKfp8OCVDixFsWKLpEiBW5UzC7CvrB9F/91v2CvZz/WVErG4sv5neZixb88E3leLMC+HhHMeD
 QPwmXj/fMs23ZlkXUVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX8JEW35zy4lpC
 P0fTTbLJCK7dUMxT3X9rLwiA+KsImFBLaNayvUtXlngST/yE7IVmXdpGo6D/ZVcPCtX6ziVplRO
 35SyWhP+M3lTZCQKh90Qma+jhc17Ui8=
X-Proofpoint-GUID: pkagRf47_O5J1yTQE88O4qQ0dMsMkujU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

From: Leo Yan <leo.yan@arm.com>

TRCIDR0.NUMEVENT normally encodes the number of events minus one.
From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
means that no events are implemented and NUMEVENT is zero. The sysfs
event controls currently interpret this combination as one event and
allow writes to unsupported event fields.

Decode NUMEVENT after NUMRSPAIR and store the actual number of events
in nr_event. Use the decoded resource count so that older ETM versions,
where a zero NUMRSPAIR represents one resource pair, still report at
least one event. Update both sysfs event controls to use the actual
count and clear their event fields when no events are implemented.

Also correct the instruction event enable mask for the single-event
case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
event 0 from being enabled.

This change depends on the recent driver refactoring. With no reported
failures, it is not intended for stable backporting.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../coresight/coresight-etm4x-core.c          | 13 +++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 29 ++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e21be6468e9544..af017bd8a54773 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1451,8 +1451,6 @@ static void etm4_init_arch_data(void *info)
 	caps->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
 	/* RETSTACK, bit[9] Return stack bit */
 	caps->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
-	/* NUMEVENT, bits[11:10] Number of events field */
-	caps->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
 	caps->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
 	if (caps->q_support)
@@ -1519,6 +1517,17 @@ static void etm4_init_arch_data(void *info)
 	caps->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
 	if ((drvdata->arch < ETM_ARCH_V4_3) || (caps->nr_resource > 0))
 		caps->nr_resource += 1;
+
+	/*
+	 * NUMEVENT encodes the number of events minus one. From ETMv4.3,
+	 * including ETE, NUMRSPAIR == 0 means no events are implemented.
+	 * nr_resource already accounts for the pre-ETMv4.3 encoding.
+	 */
+	if (caps->nr_resource)
+		caps->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0) + 1;
+	else
+		caps->nr_event = 0;
+
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
 	 * comparator control for tracing. Read any status regs as these
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index db9e603f97ba82..fb38f0102290a5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -513,19 +513,22 @@ static ssize_t event_store(struct device *dev,
 
 	raw_spin_lock(&drvdata->spinlock);
 	switch (caps->nr_event) {
-	case 0x0:
+	case 0:
+		sysfs_config->eventctrl0 = 0;
+		break;
+	case 1:
 		/* EVENT0, bits[7:0] */
 		sysfs_config->eventctrl0 = val & 0xFF;
 		break;
-	case 0x1:
-		 /* EVENT1, bits[15:8] */
+	case 2:
+		/* EVENT1, bits[15:8] */
 		sysfs_config->eventctrl0 = val & 0xFFFF;
 		break;
-	case 0x2:
+	case 3:
 		/* EVENT2, bits[23:16] */
 		sysfs_config->eventctrl0 = val & 0xFFFFFF;
 		break;
-	case 0x3:
+	case 4:
 		/* EVENT3, bits[31:24] */
 		sysfs_config->eventctrl0 = val;
 		break;
@@ -565,22 +568,22 @@ static ssize_t event_instren_store(struct device *dev,
 	/* start by clearing all instruction event enable bits */
 	sysfs_config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
 	switch (caps->nr_event) {
-	case 0x0:
-		/* generate Event element for event 1 */
-		sysfs_config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
+	case 1:
+		/* generate Event element for event 0 */
+		sysfs_config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_0;
 		break;
-	case 0x1:
-		/* generate Event element for event 1 and 2 */
+	case 2:
+		/* generate Event element for events 0 and 1 */
 		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
 						   TRCEVENTCTL1R_INSTEN_1);
 		break;
-	case 0x2:
-		/* generate Event element for event 1, 2 and 3 */
+	case 3:
+		/* generate Event element for events 0, 1 and 2 */
 		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
 					     TRCEVENTCTL1R_INSTEN_1 |
 					     TRCEVENTCTL1R_INSTEN_2);
 		break;
-	case 0x3:
+	case 4:
 		/* generate Event element for all 4 events */
 		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
 					     TRCEVENTCTL1R_INSTEN_1 |
-- 
2.52.1

