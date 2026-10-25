Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910387;
	b=dYNIj/jiOBmjzG5KQr3kLcyyIi8edABX7ndUZGFTWDq9ybga10cARmBnPwtQGjHd0PG2
	 ZNd/cWnKDsEMxZ3bzVDmr+WeWcg7BgS8Zjed11tIbCkpKwZ3bh31O0UDm8N7ejPqrT7/6
	 bdkhQCAW8oTUDWai1wdKaxqCwxl1BhDLViQwiE6rRELiU5KU+Q/xd7MEURO2SefHjh0zr
	 wyEHB1hKxNDSLjTluR0P8OsnG1d0oqfRebGFiYH7lORYkm1GwsaO4hVUjyi6DCi8xeawL
	 /cYJDBccChmj/s+Eec81naxlohiwJF2Gx0GNu/8e9acNx0x7G4n6AycLPuaTUZ8gbig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910387;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=gVZ29hv4mBXSdN0ytSbR9uZGNe1W3DPBcdCDlxG+NCg=;
	b=F/l7lmhLRh2ptgjYcjRVyyBCfH/h7wn7bv/+2Y0wZ1YcO/F+AwyBvHZqtMIw5qcmRlBN
	 /a+bQfKJ3Bxbg/YYoc/+nzeyz9jx0+/uh/Zs6+ofjWoLS3Q947rZypgfwOIHQG0+6AFHg
	 d0Jet9Oug4YNMGwlILUFrq1qtswyEjdqYtAfBQgsaXIumH+6RDkD101EDv/PLsMCug5yN
	 7l1sa2qqIC4sQdn+APAMHw4LcN0I2eC6nwn7Bbma4Sf9zcb5Qp67008HdUO8be/XIEyQo
	 hiAkmkKBrHqDPYnjSSKhcmmQw+RIGEwY4Wgp3D29k2wTfaU17P5JZ8wwsmkSBkejAPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Qrt6BikO;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC606A320;
	Sun, 25 Oct 2026 06:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 161EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Qrt6BikO
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69P5VIKE3109278;
	Sat, 24 Oct 2026 23:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=gVZ29hv4mBXSdN0ytSbR9uZGNe1W3DPBcdCDl
	xG+NCg=; b=Qrt6BikOkAGNhYTAuRkKkV6Q3ige8oQYKRwkk0rP6RKm/8ABPtwU2
	CYaOXwB9Beie7T3vPxr1kURxv2/uA4DLqAg2QcXb8lg7LTDooJQKgVMFCY+sRkEZ
	jxwhV3h6xQ5YQmYwthyzL2d76pTQDRJtnTcHMGFJLGkSxEVra7MGuxoraUDEGGSq
	O2OfrN2FgxxD91BEomXlsXLjXMRz6ur0BVQGVoJXy7zmtclgfhNIEWcd2bdvSRFw
	syZHjZdwHKpymm3OOMP4Y0ZDZTb4jt/O38KGoTxdAQBUzAzLS70GywbsLGc5l1Id
	bK2Q0uZM7CyvH3AVUhOeiNSVrT8pqL1mg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hgr5muqrw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2026 23:39:21 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v3 7/7] coresight: Add pmu_pulse/extout_pulse
Date: Sat, 24 Oct 2026 23:39:07 -0700
Message-ID: <de0b4afa0952e145eae78eae2c81aa66d1247692.1792907333.git.aaupov@fb.com>
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
X-Proofpoint-ORIG-GUID: MC9H0uwnPO1vzDwI7tbGKRfqiqINzLNa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfX0L5QgHCp5gCC
 cJkgGuXALQ4duSO9JElEOOq7Vg6uYyV+qeXD5yaQlrmQPJpUd3ethNaLAKyPVPBcKG86DRfoAQJ
 9zZgOB1Q6cBF2mxeEQ28Zocu0zECVpI=
X-Proofpoint-GUID: MC9H0uwnPO1vzDwI7tbGKRfqiqINzLNa
X-Authority-Analysis: v=2.4 cv=Vr62kO2n c=1 sm=1 tr=0 ts=6adda419 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=FOH2dFAWAAAA:8 a=pGLkceISAAAA:8
 a=KoH9M_b8ny-f6M6y6wgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfX2fGDbQB/LEeL
 6rBXrMo/LPQX8yB2MSmUw8+a5lXxR/x81+4D2y4yaN67i268K+utDZ6Md5prBStbUBLTdc3TmcY
 uxg+xs5ELmr6zouSMDycz1hXZ3XJzDBZ70LKIALtcySExCtGYVOLcUb60llDRdBpnXZcxlolL5X
 O1CW1e6KWpVfiVvMI4MViLLwT+HplD1EgDPT5dfT2w7hSsw/8ekwcMzhEFsLp1cc4ITzFisUqx+
 Vbqhq42YpTmrJUUHEauH3ZwhOquNYl8RjEqN/R4w6r81whWs/kl4l2rXw6crdu0PM5W/UcZnExU
 95u4Dn8dB6MMarEk1bIrxUs6BRe1k1z48zruoMi7LG/TXo24UYb9JbwWo4AI5UHEYskmyPNUVe9
 4mFxYZud8Yk7yMLIdnHL1L+YJJtjBdgTU58w1xUsL55YKrS9shXuuodwvtciG2/nMs5zPd6D6Pm
 F3LGcoCSQGhfTs9/6pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_02,2026-10-21_02,2025-10-01_01

Add ETMv4 configuration 'pmu_pulse' with 'extout_pulse' feature which
requires an ETE whose PMU counts its external outputs
(CS_CFG_MATCH_CAP_TRCEXTOUT): event 1 selects the always-true
resource and drives TRCEXTOUT1 PMU event which pulses on every cycle
while the trace unit is enabled.

Assisted-by: Devmate:Opus-5.5
Signed-off-by: Amir Ayupov <aaupov@fb.com>
Reviewed-by: Daniel Pereira <danielmaraboo@gmail.com>
---
 .../trace/coresight/coresight-config.rst      |  5 ++
 .../trace/coresight/coresight-perf.rst        | 15 +++++
 drivers/hwtracing/coresight/Makefile          |  1 +
 .../coresight/coresight-cfg-pmu-pulse.c       | 55 +++++++++++++++++++
 .../coresight/coresight-cfg-preload.c         |  2 +
 .../coresight/coresight-cfg-preload.h         |  2 +
 6 files changed, 80 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c

diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
index 6d5ffa6f73471..3eed728bf0de1 100644
--- a/Documentation/trace/coresight/coresight-config.rst
+++ b/Documentation/trace/coresight/coresight-config.rst
@@ -129,6 +129,11 @@ The following steps take place in the operation of a configuration.
 
 5) At the end of the perf session, the configuration will be disabled.
 
+The built-in 'pmu_pulse' configuration pulses ETM external output 1 for a PMU
+event to count. It only pulses while the ETM is enabled, so combined with AUX
+pause and resume the PMU event can time each trace window (see
+coresight-perf.rst).
+
 
 Viewing Configurations and Features
 ===================================
diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index 0a77741a431ef..6770a455c6b59 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -109,6 +109,21 @@ Example for triggering AUX pause and resume with PMU event::
         -e cycles/aux-action=pause,period=10000000/ \
         -e cycles/aux-action=resume,period=1050000/ -- sleep 1
 
+ETM-timed pause events
+~~~~~~~~~~~~~~~~~~~~~~
+
+The built-in ``pmu_pulse`` configuration pulses ETM external output 1 on every
+cycle of allowed trace, and a PMU event counting that output pauses trace after
+``N`` pulses, here 1000 cycles::
+
+  perf record -a -e cs_etm/pmu_pulse,aux-action=start-paused/u \
+    -e cycles/aux-action=resume,period=10000000/u \
+    -e trcextout1/aux-action=pause,period=1000/u \
+    -- sleep 1
+
+Each window is about ``N`` traced cycles plus the pause interrupt latency.
+The configuration only loads on an ETE whose PMU counts its external outputs.
+
 Perf test - Verify kernel and userspace perf CoreSight work
 -----------------------------------------------------------
 
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index ab16d06783a57..568e797ac5a17 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
 		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
 		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
+		coresight-cfg-pmu-pulse.o \
 		coresight-syscfg-configfs.o coresight-trace-id.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
diff --git a/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
new file mode 100644
index 0000000000000..61472154dd02a
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pulse ETM external output 1 on every traced cycle for a PMU event to count.
+ * Based on coresight-cfg-afdo.c
+ */
+
+#include "coresight-config.h"
+
+/* ETMv4 includes and features */
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#include "coresight-etm4x-cfg.h"
+
+/*
+ * extout_pulse feature: event 1 selects the always-true resource, so ETM
+ * external output 1 pulses on every cycle while the trace unit is enabled. A
+ * PMU event counting that output (TRCEXTOUT1), for example with
+ * aux-action=pause, then fires after as many traced cycles as its sample
+ * period. Event 0 is avoided because it is the trace unit trigger, and the
+ * TRBE driver treats a detected trigger as fatal.
+ */
+static struct cscfg_regval_desc extout_pulse_regs[] = {
+	/* event 1: resource selector 1 (always true), drives external output 1 */
+	{
+		.type = CS_CFG_REG_TYPE_STD | CS_CFG_REG_TYPE_VAL_MASK,
+		.offset = TRCEVENTCTL0R,
+		.val32 = 0x0100,
+		.mask32 = 0xff00,
+	},
+	/* end of regs */
+};
+
+struct cscfg_feature_desc extout_pulse_etm4x = {
+	.name = "extout_pulse",
+	.description = "Pulse external output 1 on every traced cycle.\n",
+	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4 | CS_CFG_MATCH_CAP_TRCEXTOUT,
+	.nr_regs = ARRAY_SIZE(extout_pulse_regs),
+	.regs_desc = extout_pulse_regs,
+};
+
+/* create a pmu_pulse configuration */
+
+static const char *pmu_pulse_ref_names[] = {
+	"extout_pulse",
+};
+
+struct cscfg_config_desc pmu_pulse_etm4x = {
+	.name = "pmu_pulse",
+	.description = "Pulse ETM external output 1 on every traced cycle for the PMU\n"
+	"to count as TRCEXTOUT1\n",
+	.nr_feat_refs = ARRAY_SIZE(pmu_pulse_ref_names),
+	.feat_ref_names = pmu_pulse_ref_names,
+};
+
+/* end of ETM4x configurations */
+#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
index 4980e68483c5b..a9a60a1c40845 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
@@ -14,6 +14,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&strobe_etm4x,
 	&gen_etrig_etm4x,
+	&extout_pulse_etm4x,
 #endif
 	NULL
 };
@@ -22,6 +23,7 @@ static struct cscfg_config_desc *preload_cfgs[] = {
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	&afdo_etm4x,
 	&pstop_etm4x,
+	&pmu_pulse_etm4x,
 #endif
 	NULL
 };
diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
index 291ba530a6a52..0058627f65ae5 100644
--- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
+++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
@@ -12,4 +12,6 @@ extern struct cscfg_feature_desc strobe_etm4x;
 extern struct cscfg_config_desc afdo_etm4x;
 extern struct cscfg_feature_desc gen_etrig_etm4x;
 extern struct cscfg_config_desc pstop_etm4x;
+extern struct cscfg_feature_desc extout_pulse_etm4x;
+extern struct cscfg_config_desc pmu_pulse_etm4x;
 #endif
-- 
2.52.0

