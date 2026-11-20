Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188324;
	b=eJMarSDZdYDQXR1UDS/xBSu03+IzdbnNRTHhou+HVmg+VQz4r3xLl7BcTLxQmaUicU3s
	 VcmoGNzVnW+cxMT3XKCyw/W1vNjScpyDVAd4Obw2Gd7b2YyUkKabKj+T/z2EspJPLSCyi
	 9M4UgXqTMLvYXH7cN7Q4G/PgBeL0yGJ/QEojPxeDfZdYGz2kKo7zLCMJlxwQ4aKoTSv2U
	 FQ4+H16Nfz9FU/6/ZBkjLwfvO/yIQnWbXOS0tXecQxTofyjH8vnlrfslB2Ke3NF7aVuto
	 4vn8GS2anaJGIhQtzCf9sCgv10GLi58sfDVjSqSITQ2Ud7oKktKqMfDqiW1sj9e2CUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=h7926tjNaBzEKmN+2n0WSpOiLds05PYiq+BYnAZbPcM=;
	b=PwgLgxwssHLmxHC/7uFJPfYrPCjKFOJLUcSSjO0expWpxjpSMr976tdBURzy0k7rwMQr
	 OKEBj0QuMHkZHyBJln8sj/dVLufPbOMHkvLIfhlenC+mzdLbSm3lIvKhs45DCWEg087Kk
	 4j6X6A/XVnGNSobs4GSe09dT55VCuMNgGCKFx63JXaswf8a0EmmZlht+Q37Tjy/PiiP3B
	 TBx5Bw4nz07M8diIkxy9+9EjgtwepOECBzImyg+awE8YHWo0BLjrKmQ8c13Orpb3LZf41
	 XPu3T/Nht+d61li/YC7HEldgEgqqeOaXoTaNhQE1PhjFJ+nyEs+QR8+RNGtchD2PjXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=DG+gEz2e;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A21606A335;
	Fri, 20 Nov 2026 15:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A21606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=DG+gEz2e
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEff2w4076665;
	Fri, 20 Nov 2026 07:24:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=h7926tjNaBzEKmN+2n0WSpOiLds05PYiq+BYn
	AZbPcM=; b=DG+gEz2ezW4obkT5x7yhcGoXZ0f7FUGvQQ7EkBJPK7zwJBj5LLgD1
	UeBzXCwun0ellG2Lf43ALR3nHkY1vWbREixet/ozIjI8ANundJ/wfTc0ffVQTs3y
	+jje0Fy8O0ptfHYRzzy6+Jx5xxWOetabnrprqB0RRi74UoQWIGNr/V8p4JlE7w/W
	GSLT/Mk8BaceuGFNvqxWSmZ6jrX9Zdu03NbnGcSKOE2HJ8HaPSET0HHTNabSYOq+
	lASFLQ+HE0aCt5qJtpeSogVVB0c+ONBNAVJ6dRIGYtQnLg5AMY5vGdkEyF/+nhcG
	pGtnQJgvtfeFitfN06EfxKBIUveQSXqyw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2kyux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:24:55 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:24:54 +0000
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
Subject: [PATCH v5 1/7] coresight: etm4x: Fix event count decoding
Date: Fri, 20 Nov 2026 07:21:14 -0800
Message-ID: <7dbbb1306371bed56e3af4dabf88d3c18f471dd8.1795182850.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <cover.1795182850.git.aaupov@fb.com>
References: <cover.1795182850.git.aaupov@fb.com>
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
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b006647 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=FOH2dFAWAAAA:8
 a=nO7UQp2L8s1CClaFxKwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX0VHbWYsVrKOU
 Ic/+Se+hNByKllIubC4J127EShjfo39NgrbPZk/R17OkNVWB6JYTcDFkl+rktHm7RmcjUQGWf+/
 DBvQXilc71d7Tm5K58FJfQDriVp1ZiwbyKMXZW+pHZtD6BGsPw5weJlCGa42lKHnkPjwIlO4DxZ
 rNATl83sMln+CQMM5RrAkH+aIdeH3KSB1JfOsOWUhOdJcI/VB65QHhvuAwzG8wPNZpVzb1gex4n
 hMivDAzaou/Gw0s6BsILQk95NhB2ZvjcOfJ8BaBaYECf8PU9+2wFK54rD65W2MRpMwZZf1VzwiP
 Gnk5o8bHIb3yYAMiOmFEJzwqACHU1RfzIfk6CmBSePgeLwCSPZ8Qx/wdyCN5gj5t+L23A2dcR4c
 Dya/cRJUpt4jO/oPz8mYbcWUhPlzEkF18lSxrgMQITFE51S6xYTddMYqM6pdmPzJcHAK/5fWQhd
 CPhWcGdTr5EOKfZIpvA==
X-Proofpoint-ORIG-GUID: X-Qt8ji8HHyb8cExJ2RQ3FZckjafV7j-
X-Proofpoint-GUID: X-Qt8ji8HHyb8cExJ2RQ3FZckjafV7j-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX63w/3sjFnQsG
 GxaQRoEAOlL8eL/mfFC0iSEwHj68/RSqqv5uphO8K7qNapsn5BcWtiikfi8Pt2cRYnsWHdBHENy
 eknklsFMdMNZgZ8YS1JkWIYxu5w9iq8=
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

