Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201109;
	b=fKyYSpX2R2tPtWDruKIIVYtOi3ZWfnI4NMkEFz36IcFw0GGu9M8lzEHxYHhNcwORosMN
	 iArMhruB71u53MvwAtc2Ai2pAGlb3VQdD9Kh0NRACkr265JzKnmxl8Vp6LEMC8EZk3VKp
	 hSA9bXPpHCl9wvMpGnOS1CjAVixxkwHn1SVfe6Bcrzux2Q0ccT7Y6LArv82DvkeLci7X6
	 hsPNJHEQTrnq6OkTtcML/e7aPA9gJPqZ8v/kMKhGx/ImQPF2jlEF6j3Ap3hEJ8/QmmC43
	 6dnAvDxfFDiUuh4TteOHUFgx7WOGYTUfMx1EvzWGFsprOcwPMnBxkz7UCtoSvHbBYRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201109;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=c4cJuGRDPq2SRF+Xb4HVkJbkljyXZ7Jcu3TG0wY9/iI=;
	b=2LrY+ucMkHXwxSOe+wmb16C5tb5IglruQLmHrKKsj1TWaJVxRJ4ROu0lTzC+HLNi13dv
	 EdTr9rUKmYtrWL3r5LC5Q1qyxKC3WuV//aFUD+M3RXtGLvkE7AwTwSidZss0SaeOCIRiQ
	 Y3PxjttekS51EFAVq0XD2mNI678LvN9AZ3OjsC1gN+pcqNTgO4yKyFFqFq4uvwhajWkRd
	 koCb7G8mQNJIGx3p4b4czhL5nWmIa+Lawrko0pMzNsuvAJm3OXb8zCpqboiBxJIekVmUe
	 dq9OeEeQpKmpmawir0eWYDx19VAyGUPCLZBXgdgr32AKni6cDl3pa0h+rOUBz0aa5Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EeGeZHtZ;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D760A262B;
	Fri, 20 Nov 2026 18:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B8D760A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EeGeZHtZ
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAfjg2337709;
	Fri, 20 Nov 2026 10:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=c4cJuGRDPq2SRF+Xb4HVkJbkljyXZ7Jcu3TG0
	wY9/iI=; b=EeGeZHtZ6aEAPC9hr0nkUvcnsYAlk9+a1sf0qToMp1AorIRoYVz9E
	W6/tCeWVSbpvUMjOr/hMgjEV3o8S+jex3JqceqtpuH5yJkh6TaAXCHxY6FcDWnne
	+9wvAHrDCBgPruwyNHx2gbNnSGuM6DqzEtoA1aTwa7AY/ABAg1zdNE1voSfaQJOU
	fAVaWC83Wu0e6o/JYRioEHS8+zWK9qPX2B89TWJNqrsycwI/mj8WynAAz3EDA4DS
	/NFjr1kUNsyDcTCdv5z2CWOVW1ebHmjzyzBzCF1ghei9vukFMVhnoz5Odt3jPX43
	vSK++qJlM265nI0s6DxPO+4r3Glb6xHeQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjrwe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 10:57:43 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 18:57:42 +0000
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
Subject: [PATCH v6 2/4] coresight: etm4x: Skip features requiring unavailable events
Date: Fri, 20 Nov 2026 10:54:32 -0800
Message-ID: <af7838ccf521e6317dbc3ef706dd4b8c979740fa.1795196854.git.aaupov@fb.com>
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
X-Proofpoint-GUID: Nck0hWUczks0x0kzFsGH5VrlgIVXcof-
X-Proofpoint-ORIG-GUID: Nck0hWUczks0x0kzFsGH5VrlgIVXcof-
X-Authority-Analysis: v=2.4 cv=JYcpPkKV c=1 sm=1 tr=0 ts=6b009827 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=FuLfpA1pA47yQFY1QDEA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX4cI5gNdLllqk
 +yZFbSkZbTpF5c8tHXpmN3pvcqz3ZUyvtsSvKTTR6MbsNXeQgtPyxv1JTBuSTKJtiDRbrJns2wA
 EitbTzbJFa6kmDtv0OijN4VEyemqtIY7LTIbmc622gUuchW42e0vU+1y6jrCZgZC6U0ur2E0v0H
 hOv9Q/QwmBn6Dme2DHeQQyptCtRi3KjTWF+3flsCXVd8Zut4YlZ7alvsOGHWbaRMJBxqYDsieji
 MOQ+5qgnZtkOjFUoerwxqJcoCUFM9s80pWsLjS3TU+Q2fWSKUyh5g+tdcKT3jlU2k6wKrSfvpMO
 EFcuzxtGX3wlXwfsGR9NBdijiecNRUN3ct+5skT4NeO/xis0UXFrLzrvAHEjbArPCOKHgmPOosy
 JkAeb/IF03f0nNhJmZKzXjePMFuulia8G+1K63oXT7NMYQqOCIN06xHc51jvNROw1P+JVZvgWc/
 YNdSldmBDIpGRdxF0tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NSBTYWx0ZWRfX0wEHBkSvwZiD
 +NcoM6ZOM38cB6trtXbWK67oQ+CDjYBEfzfThweUeFHz0rqjV/ZtPODgkNv3orXJkEAEN+RGBAC
 wYnLHf1g54nyAV3TH3RRFNxF/ftUCrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

Feature register mappings accept TRCEVENTCTL0R without checking which
event fields the trace unit implements. A feature that drives EVENT1 can
therefore load on a trace unit with only EVENT0 and silently produce no
pulses.

Validate the descriptors before checking their requested EVENT fields
against the decoded event count. Parameterized writes are checked against
every writable field because parameter values may change after loading.
Let the configuration manager treat -EOPNOTSUPP as a per-device skip and
release the unlinked feature instance, while malformed descriptions and
other errors still abort loading.

Suggested-by: Mike Leach <mike.leach@arm.com>
Assisted-by: Devmate:GPT-6.1-Sol
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../hwtracing/coresight/coresight-config.h    |  3 ++
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 47 +++++++++++++++++--
 .../hwtracing/coresight/coresight-syscfg.c    |  7 +++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index ae6295e3081319..8f3c37b0421e24 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -245,6 +245,9 @@ struct cscfg_config_csdev {
  *
  * @load_feat:	Pass a feature descriptor into the device and create the
  *		loaded feature instance (struct cscfg_feature_csdev).
+ *		Return -EOPNOTSUPP if the device lacks required resources; the
+ *		manager skips that device. Other errors abort loading. An
+ *		unsupported feature must leave device state unchanged.
  */
 struct cscfg_csdev_feat_ops {
 	int (*load_feat)(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index 52cb036bb04b96..278329075f380d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -127,6 +127,28 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
 	return err;
 }
 
+static int etm4_cfg_check_eventctl0_support(const struct cscfg_regval_desc *reg_desc,
+					    unsigned int nr_event)
+{
+	u32 requested;
+
+	if (reg_desc->offset != TRCEVENTCTL0R)
+		return 0;
+
+	/* Parameters can change after loading, so check all writable fields. */
+	if (reg_desc->type & CS_CFG_REG_TYPE_VAL_PARAM)
+		requested = reg_desc->type & CS_CFG_REG_TYPE_VAL_MASK ?
+			    reg_desc->mask32 : U32_MAX;
+	else
+		requested = reg_desc->type & CS_CFG_REG_TYPE_VAL_MASK ?
+			    reg_desc->val32 & reg_desc->mask32 : reg_desc->val32;
+
+	/* Four events use the full register: do not shift a u32 by 32. */
+	if (nr_event < 4 && (requested >> (8 * nr_event)))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 /**
  * etm4_cfg_load_feature - load a feature into a device instance.
  *
@@ -149,6 +171,7 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
 	struct device *dev = csdev->dev.parent;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 	const struct cscfg_feature_desc *feat_desc = feat_csdev->feat_desc;
+	const struct cscfg_regval_desc *reg_desc;
 	u32 offset;
 	int i = 0, err = 0;
 
@@ -162,12 +185,28 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
 	 */
 	feat_csdev->drv_spinlock = NULL;
 
-	/* process the register descriptions */
-	for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
-		offset = feat_desc->regs_desc[i].offset;
+	/* Validate every description before deciding whether to skip a device. */
+	for (i = 0; i < feat_csdev->nr_regs; i++) {
+		reg_desc = &feat_desc->regs_desc[i];
+		offset = reg_desc->offset;
+		if ((reg_desc->type & CS_CFG_REG_TYPE_VAL_PARAM) &&
+		    reg_desc->param_idx >= (u32)feat_csdev->nr_params)
+			return -EINVAL;
+		if (offset == TRCEVENTCTL0R &&
+		    (reg_desc->type & CS_CFG_REG_TYPE_VAL_64BIT))
+			return -EINVAL;
 		err = etm4_cfg_map_reg_offset(drvdata, &feat_csdev->regs_csdev[i], offset);
+		if (err)
+			return err;
 	}
-	return err;
+
+	for (i = 0; i < feat_csdev->nr_regs; i++) {
+		err = etm4_cfg_check_eventctl0_support(&feat_desc->regs_desc[i],
+						       drvdata->caps.nr_event);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 /* match information when loading configurations */
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 2bfdd7b45e49c8..11946e5718fc5e 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -176,6 +176,7 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 				 struct cscfg_feature_desc *feat_desc,
 				 struct cscfg_csdev_feat_ops *ops)
 {
+	struct device *dev = csdev->dev.parent;
 	struct cscfg_feature_csdev *feat_csdev;
 	unsigned long flags;
 	int err;
@@ -189,6 +190,12 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
 
 	/* load the feature into the device */
 	err = ops->load_feat(csdev, feat_csdev);
+	if (err == -EOPNOTSUPP) {
+		devm_kfree(dev, feat_csdev->regs_csdev);
+		devm_kfree(dev, feat_csdev->params_csdev);
+		devm_kfree(dev, feat_csdev);
+		return 0;
+	}
 	if (err)
 		return err;
 
-- 
2.52.1

