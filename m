Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993734;
	b=cz5kkJt6gE/bqySPkNnlsUWfF8iKYwgX8Fl6YR7JnmYAM5+d0cF+o/H/B1HRaGHMWpDK
	 5yHiMahXnhtVXr5Mtb00i0AQUHxLTD2//1bSF/gbZ6fU/XjXOQ7imyJMI8iK79aOi8RsU
	 2PJ4JLo4OVPRm0brXyokI4W8jJ7oZXFSUxzsULL59G4xa3njrIz8c+dP07bHCEV3SpV9I
	 CjFubGsjWujXNIBj6VYH8MsN0hWAnsUDSLt3w1pgLeM2mDAmSrte1cy9gpTgD3HDw7E6r
	 FGJYOnps9LkbpdcyhNJlicfe6CudzbgFsTga/FRhV7x0sALFCmmZKzkOZRXK/KB4ZUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993734;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=i2QrinkU+yR8MbSvKb5Nl4SmWTgXlkF2S8BMMSrGkmE=;
	b=5qwA+/qipoMPOZIAgGfuOUqBMFekXquNqgBJXPvcG6VPMRBzj5xtoMPcwNsUBcYzV6j2
	 EBYPksdZWemHMy/3/zeXSL6RqT9MZ0cTxbeU8OLXZMXJCDle/sxsEY8Le8asEgNioM7SP
	 9C0sOMtD5GyxGM3jOzCw2Xiu80f0lMJc+VwlHRVZNA0c5lgvk1pYvRBPwOVOukQsn5k8i
	 7jN5/hqTZubSP06O0SfvQYGdTwTH0YrbEWNIqttTYbGAsbcKH/XsFPxYLkLqCdcl28Z28
	 4u4wzbONSib9xGEK9AJfLODijtaSSye/6q7reif3gZmoMCJYHhRKeEP5iOhcJ/X8IYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=sPklDkqo;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C48606A323;
	Mon, 26 Oct 2026 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=sPklDkqo
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q38eQK2161310;
	Sun, 25 Oct 2026 22:48:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=i2QrinkU+yR8MbSvKb5Nl4SmWTgXlkF2S8BMM
	SrGkmE=; b=sPklDkqoimkWAy3v6AzfX2hmpJbyEvx4x2rd0Vr6rhzVPj30l6uwQ
	9Oiw+OEnKTJ0iwkfz1jdUFqYBuOkLWKaSnwxdxCxSq/W06tCjyY5TOu/HXeL8+OS
	3tJwSFWqEKKrxQ8Pjm5j3ZiXN1FsVFKJSXocYAidt4jz8pVTUSkO3RMQytRMPSSe
	3jpRXpNspcUMqI0UZZEkq8BoxiNd4c8MxovZ6TnrPPmGIAat7uL8jCEeBdlS1M7v
	X4i8RCk91mE2BLAQikR/gbTfj8vv34VdeFf0Blor18g7PfHVvVxC2cGOZryO1DrK
	clxq68yJx6umx/9+Gej3CgkuAwquWPrOg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hhe8h3bgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Oct 2026 22:48:31 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 26 Oct
 2026 05:48:31 +0000
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
Subject: [PATCH v4 1/7] coresight: etm4x: Fix event count decoding
Date: Sun, 25 Oct 2026 22:48:21 -0700
Message-ID: <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792989860.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com> <cover.1792989860.git.aaupov@fb.com>
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
X-Proofpoint-GUID: IAQOOmHtbXtxyY9YiqNhswxvkqJr6OAG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX5j7tw+MaSaqH
 iB+aoKS4JMhLl9bCyOHG/e3gt3TBnembiV+MzEoCVDlFEmYKMqbm5YOfEA20s7ySyNFqFyti/ZP
 FBpbvVYocLkN8ePUrlaxlIBcplH+bm8=
X-Authority-Analysis: v=2.4 cv=MbD5KJ/f c=1 sm=1 tr=0 ts=6adee9af cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=7CQSdrXTAAAA:8 a=nO7UQp2L8s1CClaFxKwA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX9sZmDLLfWYzk
 2Z1FAJYhS3RWQR1ushzKoVfhsvJEUxUHvZ+AdLdmrbXzDElyptYfxyafwiNbUF/pfUsD5345Qpi
 3c0NcpIdQbpfM9qkXlY7bOZfZl/Bzd0N0Vj81QynpfnjyvJF4podoSt8I0koN50mb1PBqZ+B5Eo
 nl555h8D9G31oZ7zMJfKugYWlOMn6V0thypJhalFX1V3NiUw5rqk88ahMDeL5b/S+Eo7Rf3ojTK
 xkkR0gWFUk6/qANwSFJW647IkgY0ODbCmilBI+MpbYQvESot1bvo+iz+FXtow842qpXNqG3k/ys
 ICuxrUKmrfYxFCnhWB7WqOLO3hVk9EgG+asSH0q7LNzP46pJCmuvKupMubNWIaHIm3dfT4gDWn6
 CvMhDElk2E96dNSkSQwoVZYAY0WV68OVKAKWlx/Eb+LigjmHM5pJ4KHoSjsdBBHoJB8WyOIpVkB
 vUYLR4cQc2J+dWjyu8g==
X-Proofpoint-ORIG-GUID: IAQOOmHtbXtxyY9YiqNhswxvkqJr6OAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

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
---
 .../coresight/coresight-etm4x-core.c          | 13 +++++++--
 .../coresight/coresight-etm4x-sysfs.c         | 29 ++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e21be6468e954..af017bd8a5477 100644
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
index db9e603f97ba8..fb38f0102290a 100644
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
2.52.0

