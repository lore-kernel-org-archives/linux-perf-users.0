Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188331;
	b=Ss9lcagdTJGSoo7U65YWIDx+jDsIGY5desslCeDAADt7CCELnUabFrFzGSFnC8mHKCcq
	 yfFA8XmBXToVWIm1fITeG9Dy1kSb7V+1tWawKf1Hpsvxw7JTqWyVi8qoubInFlvyRhjNp
	 C2XqmSUeq/8aAIZdz2+pZn/V5lMHpzUd8y3HIsvFa/acu/BDZcvPZHwPIJjTjzPXdyb9z
	 M/78W+q9GSGZCEKKzuXTbYCLxoELmQkldE8ARFXM5Ff1PpqbCTwc5zteif/A9ABzOsuK8
	 vMzNv4W3VrQGBj7CM+HF0UNVkLOG8A5q4iDSkK5cXwbZL3rZtJ7D+F5PU1RzAHYECTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=6b5r3SQs6YNo/jt7qQ43w5y89sS6coVBUb3UfE12SIU=;
	b=Twp79tAIZTy9ZFD1IgUBp797mToj50aAu573T/andy7l6AJoTFokLteSVbdzI/e/Asz3
	 HTvvmqXedgM3R0BgtH49l4FqUH3bfxb99hNQT3jH3PvvhBVFj4ru0KgpyCME1xQR0y6sK
	 7xCQME6rzo6TR4GLbIGPX68OR6TkyoG+Oxjfy8UQ9fzjv89IXVlSbEtC5FRkxTasS/tJS
	 Lde3nxuECrFLqZFe2voQTz0zOJCd7X7hxuwB0DlPPRGuvgvqhleezJgx8eI1wmM0+nvZa
	 bopKT1f6RCrbWcXX7EpETnyycsVR1gUL/DhbN2sXxnJ4yWJvpyZepvPK8xYfw0WL0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M6inLg0B;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4160A2603;
	Fri, 20 Nov 2026 15:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D4160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M6inLg0B
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfWKA372201;
	Fri, 20 Nov 2026 07:24:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=6b5r3SQs6YNo/jt7qQ43w5y89sS6coVBUb3Uf
	E12SIU=; b=M6inLg0B5B1Y5QhepHuYF+1qcX4j/mHrG1iwToTmS5ttRJ1nZxAEz
	3lNqI8njCXjeqVxvJgAx+A3FelEB5+DlFipEIZrm9uhS5V7/+dPID/Y+n4tW7loC
	EajCQb2WCfqRyTw+IeZebzU8dQgGZrV5RXYaOTfPpEjy+i8ucrc0bIyICgyq6m04
	JkKNLB0OjwjPtc4/n0EDLFIyAARBv41qDUKoC5iZLqvq/IbocX6l+BgeQNn0gPem
	gfSwnBeB/5DRZSdIf6GecX1gbRFZQbmE/KX5GfLNuoqHVtj73FW0H11qz7JM3fT/
	tjQcE7DZxEGRl5MSWs0MyPNE+SW9nzXRg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j1y8capaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:24:59 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:24:58 +0000
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
Subject: [PATCH v5 3/7] coresight: syscfg: Match feature capabilities separately from device class
Date: Fri, 20 Nov 2026 07:21:16 -0800
Message-ID: <a78b8ca4ea1cd447b5ca3736d5e94b81c8273364.1795182850.git.aaupov@fb.com>
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
X-Proofpoint-GUID: 4NvreVDamEYyN1v7_v63eSi_gwWWez28
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX6GukGpEjPU+L
 PH0auYE0v7l5DL3i0t2AJsHyPShJtZTcT6TZjtrt6N+D0/i79vbmS7g7qmPFe7gspZa3LpEPGVh
 pxUYUcUuQWGorZeQB1nPNnKRnEh69uQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfXwpLp7Wucqu2L
 kK82WDN/gv1eIjazp/r+5OeriTrNZrfpwvMtr8YkaEAEumAT/mCXG72cOEF/lMgDlzjZkCSDdbn
 i2BD9E7RQMwo5QNss4ZcNqpEsZ2kewadiwO8etx5oYy0aCHd0EKtTz9MRpqSnYeavatb91wvgtC
 YXG7CWMistEKbW/0+nbH3oWZb+c8i8//tBjOD+lB9H7Ggz69CYrIBEWErWi5Rl6IOV5bvm6wlHw
 cVDwnVBjxDB0m4ydoi03K7Lrg8YYlasnaQa7LDTB2We65oAeQGfGmEw57B+xBpt00iwSNqHxHnG
 +1TAYMsEvdClLOaFB/26d+TrF4RU8IbisGhrBqdZekZx4WeTbQn7YlSQF4g4ng1imm+hbquP0tn
 xK9uIolRCsckOzHIP97AxC2a8N/I1TIn0wAbVWMx8S0ZP0eaFE2qWNpNTGNbSNGwl8HgRAu4oQV
 9GmBVwVNarF/HY98kog==
X-Authority-Analysis: v=2.4 cv=Pr0G/AM3 c=1 sm=1 tr=0 ts=6b00664b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=mif2P4nyd6mfzKxTjdEA:9 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 4NvreVDamEYyN1v7_v63eSi_gwWWez28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

A feature loads on a device when the two share any match flag. That works
for device classes, where a feature wants any one of them, but not for
capabilities a device may or may not have: a feature that sets a class
and a capability would still load on a device of that class without the
capability.

Split the match flags into CS_CFG_MATCH_CLASS_MASK for device classes and
CS_CFG_MATCH_CAP_MASK for capabilities. A feature now loads on a device
that shares one of its classes and has all of its capabilities. Check
this once in cscfg_load_feat_csdev(), which both the feature and the
device registration paths call. No capability flags are defined yet, so
matching is unchanged.

Assisted-by: Devmate:Opus-5.5
Reviewed-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../hwtracing/coresight/coresight-config.h    |  8 ++++
 .../hwtracing/coresight/coresight-syscfg.c    | 40 ++++++++++++++-----
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index ae6295e3081319..f04e73b91d9a63 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -7,6 +7,7 @@
 #ifndef _CORESIGHT_CORESIGHT_CONFIG_H
 #define _CORESIGHT_CORESIGHT_CONFIG_H
 
+#include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/coresight.h>
 #include <linux/types.h>
@@ -30,6 +31,13 @@
  */
 #define CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
 #define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
+#define CS_CFG_MATCH_CLASS_MASK		GENMASK_U32(7, 0)
+
+/*
+ * flags defining device capabilities a feature can require. A feature loads on
+ * a device that matches one of its classes and has all of its capabilities.
+ */
+#define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
 
 /* flags defining device instance matching - used in config match desc data. */
 #define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index a816c22c87bc87..65116b09cbc96c 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -4,6 +4,7 @@
  * Author: Mike Leach <mike.leach@linaro.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -171,8 +172,24 @@ cscfg_alloc_csdev_feat(struct coresight_device *csdev, struct cscfg_feature_desc
 	return feat_csdev;
 }
 
-/* load one feature into one coresight device */
+static bool cscfg_match_feat_csdev(u32 feat_flags, u32 csdev_flags)
+{
+	/* The device must be in one of the feature's classes */
+	if (!(FIELD_GET(CS_CFG_MATCH_CLASS_MASK, feat_flags) &
+	      FIELD_GET(CS_CFG_MATCH_CLASS_MASK, csdev_flags)))
+		return false;
+
+	/* The device must have every capability the feature requires */
+	if (FIELD_GET(CS_CFG_MATCH_CAP_MASK, feat_flags) &
+	    ~FIELD_GET(CS_CFG_MATCH_CAP_MASK, csdev_flags))
+		return false;
+
+	return true;
+}
+
+/* Load the feature into the device if it matches, otherwise skip it. */
 static int cscfg_load_feat_csdev(struct coresight_device *csdev,
+				 u32 match_flags,
 				 struct cscfg_feature_desc *feat_desc,
 				 struct cscfg_csdev_feat_ops *ops)
 {
@@ -183,6 +200,9 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 	if (!ops->load_feat)
 		return -EINVAL;
 
+	if (!cscfg_match_feat_csdev(feat_desc->match_flags, match_flags))
+		return 0;
+
 	feat_csdev = cscfg_alloc_csdev_feat(csdev, feat_desc);
 	if (!feat_csdev)
 		return -ENOMEM;
@@ -212,11 +232,11 @@ static int cscfg_add_feat_to_csdevs(struct cscfg_feature_desc *feat_desc)
 	int err;
 
 	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
-		if (csdev_item->match_flags & feat_desc->match_flags) {
-			err = cscfg_load_feat_csdev(csdev_item->csdev, feat_desc, &csdev_item->ops);
-			if (err)
-				return err;
-		}
+		err = cscfg_load_feat_csdev(csdev_item->csdev,
+					    csdev_item->match_flags, feat_desc,
+					    &csdev_item->ops);
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -739,11 +759,9 @@ static int cscfg_add_feats_csdev(struct coresight_device *csdev,
 		return -EINVAL;
 
 	list_for_each_entry(feat_desc, &cscfg_mgr->feat_desc_list, item) {
-		if (feat_desc->match_flags & match_flags) {
-			err = cscfg_load_feat_csdev(csdev, feat_desc, ops);
-			if (err)
-				break;
-		}
+		err = cscfg_load_feat_csdev(csdev, match_flags, feat_desc, ops);
+		if (err)
+			break;
 	}
 	return err;
 }
-- 
2.52.1

