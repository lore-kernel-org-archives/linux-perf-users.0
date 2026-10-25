Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910375;
	b=yvota41EUg8tezQxnHtZHWC2B318HmeFCj55VYisI2P067S8JDAF8MEOTsvvxXqMDi0C
	 JKSkPcyVxkJYZVQVy/kPPg3kL98F5xGu4lmT1HU4MV6+Zdy+b6+9zKQcFQeTMqBgDLL+i
	 5v2Jrar38+lMKkTVFVWzSyZo+SMT5s3dv/UjN1HgpN+fk4oVjQcCZGCTnyYkOthu2j72I
	 V/Cbf6CJcoIoGh/X8fowWeWOZ+pduS6E0jVCqeoucqHhZ1xHbo3QusDxRVFbwJPAN2A99
	 dWoyHy+eywpKuSa4sUNKzQmGx3DbHIzm38eLgumJ4BGMoeeOb8D0sYDvuxRRxu/CuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=jw5VuQf1ANvsD9FFFvRp8AlB3r45zUeN3fSTLXP6SlM=;
	b=GxpnFDhjxCWsvFdsENiZ3c9xifuoabC9Q+2HFZJS06f5UcTlmqV5zs3SEODtQBi2NMES
	 Gh5+c8S3iJfM7GE6XyKl/PqXJSAPBJyt3S0WxAhQH9VvTF7H4TknbxuLi73jR3d2kFIzZ
	 YL1f3VAKx7V4RikRz7tA13WlDgFohFG4VQ78LFAy5zBDgnpPsVSyC+s9UL7FxBpAX83Fp
	 luAvbVEdwlhRlHOQR+0ZGoQUhVlo/y9RgxGcmE+zLRf72IuobSLUakcr2Vjcei010w34e
	 y/GO9qpBR/P9FN0EJ7du3NwdIr5dnH5D6r88WduPPPgZlNRekUZN3r1nu1O/BGyjP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=tGc83Fo9;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA37606A32D;
	Sun, 25 Oct 2026 06:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA37606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=tGc83Fo9
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69P4sOTE544352;
	Sat, 24 Oct 2026 23:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=jw5VuQf1ANvsD9FFFvRp8AlB3r45zUeN3fSTL
	XP6SlM=; b=tGc83Fo9azP9Hld1MGo4oT9nIU4PWshaC7wLq6VFFboPQtyqmwGvW
	CkunPXf3yX9aldKbUUrJ1O+pNjhN19H4ahoZyLCqKOmKAfWQChPFTUcR19Qd+d9o
	cT6Eq0x7ePKKZ14h5lMFxLc2a5kCdHcVrkrT+SeLBFKAd+1ymYQ+thwn88bgSvyx
	pa6E2UwRxiFGpOoCDhVwXfxWTkqRaIa7zvsULib/wcWhCo7JY1K8U1gp5Ot3jkci
	kXLmNcseO4wGFsqhkxw8WOidb297uknJ9gUS11S8JKYOW0kTLpH7wCQ6SMZZ78MT
	dTgie5XEGdhYWOGE59ANb9WL1mZMFTIMQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hguyh32kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2026 23:39:19 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sun, 25 Oct
 2026 06:39:17 +0000
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
Subject: [PATCH v3 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Date: Sat, 24 Oct 2026 23:39:05 -0700
Message-ID: <cd3e622681f7254216b0488f09d2cb2d91a2d8ca.1792907333.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfX3HpC6ZmlsThT
 W54cJt5/0v7bB4BoRwEQauwZbrIsCgdYT3B6ceYi3edHzFAE76EMiovNjOsok3q9OxbaIDcBtY3
 d9MFvBkNNKdxYY8Vv/TzGTn9aPekKsJJwICssCQWx/FOmPEhVmBvH1Gvrv+45uKO4PLgJZp+0rF
 MDyHDpamEizJ9nug4so42zctRjHqQ71MVIlNQo6A8Wd9C4hJoQOtbN1FXhtVL5bHJg3Gw/+Pqka
 U2i3DwQEUKa9AkBS/QYQYW6x1ywf7wFb056llmVpEURG94GEsauehr83jzl3VWOmjBL+m5+rYHU
 kjJFpBfpzvqBkWy4XtWYPJVaRZGVHjWcPapns8wqvARmfmD9BvHMP0cXZX5DT9etkypE9bRg/oe
 s6nJ/QFleJHl5gTLNFjXfBNrqasd0vzyrBYb6St0Jd2++lokKP4aK4wEuXiBjQ0/ObdETgVK1ur
 5DWYyYD6VTuaAIENp8w==
X-Proofpoint-GUID: K2LKffOrXNyFHYQrvV1nbHrNZ-TI8Yx5
X-Proofpoint-ORIG-GUID: K2LKffOrXNyFHYQrvV1nbHrNZ-TI8Yx5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAyNiBTYWx0ZWRfXwwWf5fIaDzp8
 kfqlN4UavRsctlzP/hrDzA92SDzyBSuzB8pmHwzPMGZ7kYW8wW3CFv69l6LcvMC7f9iRDcrmYma
 H5MyE3nrYNsi68TEEAAtAA5FY+6ml7E=
X-Authority-Analysis: v=2.4 cv=FY+iV5+6 c=1 sm=1 tr=0 ts=6adda417 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=KKAkSRfTAAAA:8 a=FOH2dFAWAAAA:8
 a=zNmvvb9I2tHsirClY3sA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_02,2026-10-21_02,2025-10-01_01

Drivers outside the PMU driver may need to know whether the local CPU's
PMU implements a common event before relying on it, for example a trace
unit driver checking that the PMU counts its external outputs as
TRCEXTOUTn.

Add pmuv3_event_implemented(), which reads PMCEID0/1 on the calling CPU:
events 0x0000-0x003f are reported in bits [31:0], and the common events
from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
arm_pmuv3.h so it is available without CONFIG_ARM_PMU.

Suggested-by: James Clark <james.clark@linaro.org>
Assisted-by: Devmate:Opus-5.5
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 include/linux/perf/arm_pmu.h   |  1 -
 include/linux/perf/arm_pmuv3.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02d2c7f45b527..792283d29d7b5 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -124,7 +124,6 @@ struct arm_pmu {
 	u64		reg_brbidr;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
 	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* Only to be used by ACPI probing code */
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a27..965c40b28dd77 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -78,6 +78,9 @@
 #define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
 #define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
 
+/* Base of the common events reported in PMCEID{0,1}[63:32] from PMUv3p1 */
+#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE			0x4000
+
 /* Statistical profiling extension microarchitectural events */
 #define ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
 #define ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
@@ -315,4 +318,23 @@
 
 #include <asm/arm_pmuv3.h>
 
+/*
+ * Whether this CPU's PMU implements a common event, as reported by
+ * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 events
+ * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
+ * Must run on the CPU whose PMU is queried.
+ */
+static inline bool pmuv3_event_implemented(u16 event)
+{
+	bool ext = event >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
+	u16 id = ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
+	u64 pmceid;
+
+	if (id >= 64 || !pmuv3_implemented(read_pmuver()))
+		return false;
+
+	pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
+	return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
+}
+
 #endif
-- 
2.52.0

