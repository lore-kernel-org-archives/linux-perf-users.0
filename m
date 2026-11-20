Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188341;
	b=dxsvwKzMy5vhevPOmphZW52ND2fwM/e3HqMIWe8W+mE2g2CfeSPHWTpIOOjc0WDORGXI
	 CqUObVJkiI91rznUnmRIX1SEheV8GU2/eiyh0f2kpq2FqJS7heDDnt77X8s5eLCnxitXw
	 K20dzkeJxi0/bf/n4pox3SbhEOY/jMPWWN8YCBzxCZqHBDo4szD2ZAioHok7qbQK2mI0y
	 Lg74HbPh5srrTSlgFghYy3uf4vQeSG20k5es0TjfwmzwI6nOob2wfobj/K5TpZud0FNii
	 Km/oUVBJNrdY/ksDAP6dUkB57BQW+v9bdVWI1c8kJ3ScdS5LQXknl17t6eVZIeOESKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=tvO1v00MKFZbgF6KSCFJYyOa1CwNkFl6XFGg7HJK/+I=;
	b=3yaphO99HBRv+6KsJmkbtakcWvTKXxDYJMzvqXF2dZSa4GqdTQ2Q8gLuD9vI5Odgqqhz
	 R+VFU9PhpnHsKWcH5Sh9UqnM90G9dGn+VX5pCNREY8fnyWZlCRdtOSkiRlXk5kNhXffI9
	 J7a7Npg+YGYGScfysqG3231RL+tSUDKCdplHxUoNlTUhW7UDPQVcIMrdcKR36nnbFa1DU
	 cb8JNIASuDwwaUD0bmA5WdF7ZsztA8HDkGnF9biCRJB214q20AR4H+wyrCEZK4+ikx39A
	 fTFCaF4FXHtPuTt6NmOYlFc+0E7FbfQceji+KK+YvODXriUzLVeqkJmajtsxUahKZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SlLn7HHW;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCF60A3806;
	Fri, 20 Nov 2026 15:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1CCF60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=SlLn7HHW
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfgql1560959;
	Fri, 20 Nov 2026 07:25:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=tvO1v00MKFZbgF6KSCFJYyOa1CwNkFl6XFGg7
	HJK/+I=; b=SlLn7HHWMtXIhoWFM6wT8gbl4fLmGsBQE7gjKjvsKG8HR/Vyo8Wlv
	Nm7mKmuZhS3Ibuh5unsTkYpBA3uBWMoFNL/Qkm3nGWYFXSFdkDvBleDiEKu6Dqde
	cFjdf21Vzrf3wbb3FBtg4K/oaNgBWiNGsCZubEUpUPX6qt8nBmYFEs+GiseOjT7o
	zltbitq/bx0XD4SVmaaOS62ywmTa36LwMhMTjEZ+83mjS955Izp/OlKhtO4Rlo4K
	ZeAN4zdqYrigjzHvs6mYcKYTQihVrNGoqvwbS9N4a8pDMMZhMQdc4ddzWM15kw9B
	DK+RyQuToMtWwVorpdfd2wI2MNzdHxtzw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j22w7965j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:25:12 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:25:12 +0000
From: Amir Ayupov <aaupov@fb.com>
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
        Suzuki K
 Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel
 Pereira <danielmaraboo@gmail.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Date: Fri, 20 Nov 2026 07:21:18 -0800
Message-ID: <a0472c58f855a9bd358f7faf8e88e44207c90fc4.1795182850.git.aaupov@fb.com>
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
X-Authority-Analysis: v=2.4 cv=Ia0Symqa c=1 sm=1 tr=0 ts=6b006659 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=FOH2dFAWAAAA:8
 a=Jk1ypKxpNml08E-81-wA:9 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: SH3OuBtvwXKBoztDjcU-AJwErOhn10y2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX8+Ep96mHTmeu
 4kRwJdQtHEie2zmmoIQabNPXprSoFeCT/woN2pfvfkQNXSMHMEhd8iGSeJDWYaJixMontDbtKQ6
 fqwFzmQdEJj847m26HAJDjwHaXBwKp8=
X-Proofpoint-GUID: SH3OuBtvwXKBoztDjcU-AJwErOhn10y2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX5yFIGHXnKmkd
 LCGntlyjQFJcovzfEu5Vk1DYx1GG0S9u81maPNt6I4GtdlP1wdYLycb/v+KL3MBn4esCgUTuU8z
 ThAHrq4QDQDvViCdXrz6wMNH64Irpybm+/EWfc5AYCBnQ3NyPJq7KEiVccMOY5koic30XSP/NUA
 ZfUqou9K8EAd12W4PyYlR7/cGcHdlR9bqBNJWx1Eu8PbxTnGF7Ho1clwJhS/x8S0yb7H93KCcuQ
 wwXuSX6NaHQNEW9rfyjLZMFpfC1wi0vZBXGOf3Wudyh5MCmEbRUtiUIVFISLazJg4+FR1GEwWCg
 txTzugATzfV58DM7trVXNHezourwS/LePg5Q/Lym0tQc8+UlwIGap8qk9BzRzXcy6T5gEIMbqcm
 z6Re0ztWwMpnoL0BVlZgRHoq/CH9L4GT4TumXwwKpKbCaiIh3+r60A4E+/y+Pqo02QHMhuvgcst
 XWqS9Y0DtmF6Hmw0alw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

Drivers outside the PMU driver may need to know whether the local CPU's
PMU implements a common event before relying on it, for example a trace
unit driver checking that the PMU counts its external outputs as
TRCEXTOUTn.

Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
the first ARMV8_PMUV3_MAX_COMMON_EVENTS events are reported in bits
[31:0], and as many from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits
[63:32] from PMUv3p1.

Move ARMV8_PMUV3_MAX_COMMON_EVENTS and ARMV8_PMUV3_EXT_COMMON_EVENT_BASE
next to the event numbers in linux/perf/arm_pmuv3.h, so that both are
available without CONFIG_ARM_PMU, and include it from
linux/perf/arm_pmu.h, which sizes the PMCEID bitmaps with the former.

Suggested-by: James Clark <james.clark@linaro.org>
Assisted-by: Devmate:Opus-5.5
Reviewed-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
Will, Mark: could you Ack this so Suzuki can take it through the
CoreSight tree with the rest of the series?

 arch/arm64/include/asm/arm_pmuv3.h | 20 ++++++++++++++++++++
 include/linux/perf/arm_pmu.h       |  3 +--
 include/linux/perf/arm_pmuv3.h     |  8 ++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 8a777dec8d88ab..f6882771ec7970 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -173,6 +173,26 @@ static inline bool pmuv3_implemented(int pmuver)
 		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
 }
 
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
+	if (id >= ARMV8_PMUV3_MAX_COMMON_EVENTS ||
+	    !pmuv3_implemented(read_pmuver()))
+		return false;
+
+	pmceid = id < 32 ? read_pmceid0() : read_pmceid1();
+	return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
+}
+
 static inline bool is_pmuv3p4(int pmuver)
 {
 	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02d2c7f45b527d..a90867c9774c74 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
@@ -122,9 +123,7 @@ struct arm_pmu {
 	bool		avoid_pmccntr;
 	u64		reg_pmmir;
 	u64		reg_brbidr;
-#define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
 	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* Only to be used by ACPI probing code */
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a276..5bab0f952fd59c 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -78,6 +78,14 @@
 #define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
 #define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
 
+/*
+ * PMCEID{0,1} report ARMV8_PMUV3_MAX_COMMON_EVENTS common events from 0 in
+ * bits [31:0], and as many from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits
+ * [63:32] from PMUv3p1.
+ */
+#define ARMV8_PMUV3_MAX_COMMON_EVENTS				0x40
+#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE			0x4000
+
 /* Statistical profiling extension microarchitectural events */
 #define ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
 #define ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
-- 
2.52.1

