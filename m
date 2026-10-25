Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910377;
	b=x31tyYwk/CfYfPga3I4goXmqYgS4pb1cKY+9hDgumFMRTS4JYE7wGz3nO3QC0V+hjBsR
	 ERUbixgLZGrlJPdKlozuImE33n4NtdwrqrvClU3BemxhlljdHTagZg8WJLp5nTel3g9NO
	 hq6az5cEVxKZk/Tqd6V8aX4/ImEO5P/3fPdYGVMTEKmGQsWcrK28FDeQtRJQysmR6mXvw
	 iA4q9koN0zykU/oq6+hJ3MPcbwKlaoMw7cVAUxoPGhh2yc3Onu4UcI0T1amTPepDeVYBj
	 Ha4oUNQ74mlo4vphYJYAt6L+beiNKzKAFPxooREqwdv0Vreqx/XdB9d/25lvZJ4AAsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910377;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=eLNIW2q6eZQY3XO2w2wt1tsAR45z7skuJjJhjqBR+08=;
	b=IWzDeilQdojWnMEyncNuHQ6k6uNQ3GOspoWZgPTb0jpjXG6Mi/QcLBbsTeudngYV+8nh
	 nSnryVaPhKXA3H23mDORqjOYZirpjjHNQDSK7MHwCfjuF063WLbcObzFiZqR2uRu1BNxu
	 I0uIwfuSbaa8IF66h8H7fi3lFnn1MymSVTjpfPUXJiEfVM5Wy8wLlf7rbwGewpw3jXQbw
	 eif9fsgHifnfleNMcgP5BcCcxnOVcBodzzNojkBXg5YnOu8VCB8y+Xa63+xBQ750oBhZg
	 CYMxmfy7p6/u7zWxY21wQAINpDE7uMTLbo0dCCdNyFF4SZZIgu77x49JJZ69lshHgCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Yhq6SeHv;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370D606A328;
	Sun, 25 Oct 2026 06:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B370D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Yhq6SeHv
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69P4sXJ53859554;
	Sat, 24 Oct 2026 23:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=eLNIW2q6eZQY3XO2w2wt1tsAR45z7skuJjJhj
	qBR+08=; b=Yhq6SeHviFxz4fAfeDzpfLgFWKmYCtRmQmxkfCSJW2xJGPq3G2TmH
	9pc87K+jDuD4hY5GroBuzLpZK5kEQQlrCg6ehzDWhP7oJvmwiBPniFvbzN4izlPU
	PtehYvmMezREGL77B02qwTR4Tp+a/mPPsHsgtEwwy9d0IaDR0P6fRC9RwMNPHV1V
	BAGr+xP2TZSfqiOWY4+1scB9Vif4lfurdcesVyfXFb87V1BhqYEpfzfHdJ39+u5x
	JettdgsIuXh8P9qgfiYoQAD1sQL7FoGcrdwJQgw0v+PRJyvoxYXJ0XVOD6hC7hyz
	ektS/muhMwFru0jwGJzl8aR4cMNni5mJw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hh7ucrreq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2026 23:39:19 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sun, 25 Oct
 2026 06:39:18 +0000
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
Subject: [PATCH v3 6/7] coresight: etm4x: Report whether the PMU counts the external outputs
Date: Sat, 24 Oct 2026 23:39:06 -0700
Message-ID: <b9451758a11f18f9a566a4d4c08f4131dfcf2a0e.1792907333.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792907332.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com> <cover.1792907332.git.aaupov@fb.com>
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
X-Proofpoint-GUID: 20d6yU3GqBjSPzwFeMq0Ey6pnxiM2q4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfXzK7Zs+HeG0a6
 JVUY9Am35oEQ+99ofb5mzUhfKnF5ppUUaN2qZQ4OxDhCcT6Ec+jCu/OFrRJmNmbcRRLX1AX3kHV
 i903kUpsizzBfjqk0MPoVAcC+TlGIbU4uDTm+EFULxqiuOOJ5NbvgaVZdzjxo3+zyb0Y3vdd87t
 dIULaTUjbiDQSwgEK+rQxFVZCr+R4EHJJc63Q57J2o7MVMTXbSvw+/HGORxQtdtTYyI++8weZEP
 2/VIrNB6i9lCbI/58c/ADlhGAwE57nRKbUjdl54AQcZeEakEJwR4oCQJcBvxnxmJXyAPoqXKhbZ
 s9Zle7oNPH1VzVGIiEPeDx7jNFJtCs4j2EhKykOgUXkbu/WS+X1m+RDD8A9FlRI8fL2epWZ1uRB
 8WqdH7HXYXa9lynXv5UEntWAo4IGipRjsWiPPtFKVMMtco8Af7JW1lfA2SOLRpPqkKLSersNHTG
 VHygL8Zi3g0+Y4aEsqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfXz1xOV4DWckjx
 72lOht4MhbXQy22cld1pqwUZVoSI9jmqn41eFbJB9SCebZQd406zEfYYR163G3BD9E/6tAPqOP4
 vBMfKCTC6NfDmLaoo0et24DEsLFkwQI=
X-Proofpoint-ORIG-GUID: 20d6yU3GqBjSPzwFeMq0Ey6pnxiM2q4p
X-Authority-Analysis: v=2.4 cv=SN3Xx+vH c=1 sm=1 tr=0 ts=6adda417 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=FOH2dFAWAAAA:8 a=-Z3dWT6n0Uiql5SQPSEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_02,2026-10-21_02,2025-10-01_01

Some CPUs count the trace unit's external outputs as the PMU common
events TRCEXTOUT0-3 (0x4010-0x4013), which lets a configuration drive a
PMU event from trace unit events. Other CPUs, Neoverse N1 for example,
have no such events, and a feature relying on them would silently do
nothing there.

Detect at probe, on the trace unit's CPU, whether the PMU counts every
external output: the trace unit has an external output for each of its
events (caps.nr_event), and pmuv3_event_implemented() reports whether
the PMU implements TRCEXTOUTn. Only check ETE: per its specification, an
implemented TRCEXTOUTn event counts external output n, while whether that
output is also an external input is IMPLEMENTATION DEFINED.

Add a CS_CFG_MATCH_CAP_TRCEXTOUT capability match flag, set it on those
trace units, and show it in the feature's configfs 'matches' attribute.
With capabilities matched separately from the device class, a feature
that requires it only loads on those trace units.

Assisted-by: Devmate:Opus-5.5
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../hwtracing/coresight/coresight-config.h    |  2 ++
 .../hwtracing/coresight/coresight-etm4x-cfg.c |  6 ++++-
 .../coresight/coresight-etm4x-core.c          | 26 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
 .../coresight/coresight-syscfg-configfs.c     |  3 +++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 220bc54f8e5e1..4cf53230854d0 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -38,6 +38,8 @@
  * a device that matches one of its classes and has all of its capabilities.
  */
 #define CS_CFG_MATCH_CAP_MASK		GENMASK_U32(15, 8)
+/* the PMU counts the trace unit's external outputs as TRCEXTOUTn */
+#define CS_CFG_MATCH_CAP_TRCEXTOUT	BIT(8)
 
 /*
  * Limit number of presets in a configuration
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index 52cb036bb04b9..9e4dc5950c13d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -176,9 +176,13 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
 
 int etm4_cscfg_register(struct coresight_device *csdev)
 {
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct cscfg_csdev_feat_ops ops;
+	u32 match_flags = CS_CFG_ETM4_MATCH_FLAGS;
 
 	ops.load_feat = &etm4_cfg_load_feature;
+	if (drvdata->caps.trcextout)
+		match_flags |= CS_CFG_MATCH_CAP_TRCEXTOUT;
 
-	return cscfg_register_csdev(csdev, CS_CFG_ETM4_MATCH_FLAGS, &ops);
+	return cscfg_register_csdev(csdev, match_flags, &ops);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index af017bd8a5477..cb5fbb0279b88 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -1399,6 +1400,29 @@ static void etm4_fixup_wrong_ccitmin(struct etmv4_caps *caps)
 	}
 }
 
+/*
+ * Whether the PMU counts each external output of this trace unit as
+ * TRCEXTOUTn. The trace unit has an external output for each of its events.
+ * Only ETE is checked: per its specification, an implemented TRCEXTOUTn event
+ * counts external output n.
+ *
+ * Must run on the CPU that owns the trace unit.
+ */
+static bool etm4_pmu_counts_extout(struct etmv4_drvdata *drvdata)
+{
+	int n;
+
+	if (!etm4x_is_ete(drvdata) || !drvdata->caps.nr_event)
+		return false;
+
+	for (n = 0; n < drvdata->caps.nr_event; n++) {
+		if (!pmuv3_event_implemented(ARMV8_PMUV3_PERFCTR_TRCEXTOUT0 + n))
+			return false;
+	}
+
+	return true;
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -1562,6 +1586,8 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	caps->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
 
+	caps->trcextout = etm4_pmu_counts_extout(drvdata);
+
 	coresight_clear_self_claim_tag_unlocked(csa);
 	etm4_cs_lock(drvdata, csa);
 	cpu_detect_trace_filtering(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5417280cdb274..33994ad4b2641 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -868,6 +868,8 @@ enum etm_impdef_type {
  * @lpoverride:	If the implementation can support low-power state over.
  * @skip_power_up: Indicates if an implementation can skip powering up
  *		   the trace unit.
+ * @trcextout:	The trace unit is an ETE whose PMU counts its external
+ *		outputs as TRCEXTOUTn.
  */
 struct etmv4_caps {
 	u8	nr_pe;
@@ -907,6 +909,7 @@ struct etmv4_caps {
 	bool	atbtrig : 1;
 	bool	lpoverride : 1;
 	bool	skip_power_up : 1;
+	bool	trcextout : 1;
 };
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 2b40e556be872..7b3800138f625 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -250,6 +250,9 @@ static ssize_t cscfg_feat_matches_show(struct config_item *item, char *page)
 	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ETM4)
 		used += scnprintf(page + used, PAGE_SIZE - used, "SRC_ETMV4 ");
 
+	if (match_flags & CS_CFG_MATCH_CAP_TRCEXTOUT)
+		used += scnprintf(page + used, PAGE_SIZE - used, "TRCEXTOUT ");
+
 	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
 	return used;
 }
-- 
2.52.0

