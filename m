Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792993733;
	b=pjdDXEkCEsVAPUzKrQ166zgOicr6GvwLquZewd9fCkEppzzPDf/yCdxb1XvfcHeMP7hn
	 IWduksfYiyFruCyl8NhG07JMtKccd5yG/cSBaLaWRIucTJC8VqPeR/nhv/W41g9xBd68n
	 xuU624yIQ5ITnuxglu+tkJ9/InyWyvIVM3J1v+V8QkuULG29IkR77Hpz9m9eshoaP8JWc
	 2Wo5gLrhHw+lLpPh6OO8/uKVWNQMsyeu8+mvvIVC6MzSNipESOZSkam9HQGDwkrIDkJHS
	 FgbX8eQ/RutvrQR2f7tZtteAQjJEXCJRiOmqm7q416wdy8SpiURNcC9B/sgfMkKcg1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792993733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=Pg8Aqzf4YTWn8AZZ/pOmWTp8sl99KiLblorXjm4EBdY=;
	b=UnSMgQKYYYvGRArT/P5KHnjyuRs5Z8EkOmlBTFyVI3MQb9/56l/+5rqtJLjUoqTuPYwS
	 1DQh3xsxYdV5t4kEzYtjfMmQ9GcSlb0Rxi/sOxZ+te8iVqBPDpl1gRQN4Mwt124vfZj4C
	 RdCqUQldulr+Hhk1pcA/DEPJon74Ss1IsMm9YeXilqrZLXjhLR65FREjXbWBYg0AO0J75
	 vcMiFc+581ArbIeq8rzyCnjG6stzkCyxCX6HnuA1KjNyY7TEQ4W9hMs2sVbuE++j9jebF
	 w1jcqF3K9DbMISidhDqOacadqHU0fJqxmPto2chwyRbbll9384o2rVw8ni5wdXDfWxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nq+smAEj;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294A606A32E;
	Mon, 26 Oct 2026 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E294A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=nq+smAEj
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q39JfO2876526;
	Sun, 25 Oct 2026 22:48:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Pg8Aqzf4YTWn8AZZ/pOmWTp8sl99KiLblorXj
	m4EBdY=; b=nq+smAEjkt2fl4EJ3FfQ1odHkGMCnecuBQtA8eMsaqbZjID9e8+lS
	nWHyPxpn4e75OSXo81ci4oPw0szHHHU1336YnlnMl7oyFUvVqeIna6tgPrnje4sG
	tpUHBEpfVRN4bZNEMxfhkjW3lJ0rcS+gS00gl/G+Da1BsuQNMnd9ZePCYkHSVuWm
	JFODRkBZ6xTpn2nx0CXHkPBAPloMUk7R03LVGYvLirje0XYPkODefHS3meHOXXO8
	07HrrN01ID4HXQPnRp/g3LubVjLt8dn63tMszXErr+2jgXSpOzYamMAekS+2QJ1C
	2PiZULXKf/feA8UDTEVjfhxoKnhqZHFuA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hgtdfeycu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Oct 2026 22:48:35 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 26 Oct
 2026 05:48:34 +0000
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
Subject: [PATCH v4 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Date: Sun, 25 Oct 2026 22:48:25 -0700
Message-ID: <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
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
X-Proofpoint-ORIG-GUID: 2QSWAs-7ibO6btODkITw20GjaiJ395ov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfXxdFzOphN+o3E
 V86Xzl1ad46+uPP819/qLTSU6mLhnBNGkdoilHB8YoUNyQ2NHHBYfpEhsIYUtKhF3l25k3eenMe
 2P+Rl97BwLPPpMhl6QBKbZcXnzlnlC1ukhWorbHKD9zSFwa+AxXAmUFSryKESRM6QDFWAvs7k3Q
 UpKkG3V+b36rAUNtZVbis2CE1fvceuJmOqN902dd8InUxZV/fZrBT6MsCi6fa72G5VzReF4wQLH
 +PHsyZK9vfSbzN8xBh10ExTaRFwW09O/Z2NMYLcl8aDenq3d8QGtnxLmzDOUdwXnVuOhrT+oj9d
 ekx51B+1Fc0LcHHPa7Uzbbu2iZIPvTvSJNCUkRGRFJNk9wLGC6AJrLK8QOtEAkGqzijzUiZQJ3a
 zLl5czudNvKDTnMHOUCw28A/+mhE2hxi536Fdjql9iEbTZns0FTpUlj7K+n2UQpmc5XgOSeSiRc
 /yj0hIrxVYcVMi7jI5g==
X-Authority-Analysis: v=2.4 cv=V+noQuni c=1 sm=1 tr=0 ts=6adee9b3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=KKAkSRfTAAAA:8 a=FOH2dFAWAAAA:8
 a=Wn0yR4sTO1dwKjUQqtIA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2QSWAs-7ibO6btODkITw20GjaiJ395ov
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMiBTYWx0ZWRfX8t5jb1K2AXH2
 io1PfsYRA68iXcJpBE1ocXmZDiSq+/ZWr+zncBrAa27XMoHYloo8B++rzjaxDnC8ZfBGRev3qnI
 389vG61qPrt15v5OGHyMmFyu27JqHuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

Drivers outside the PMU driver may need to know whether the local CPU's
PMU implements a common event before relying on it, for example a trace
unit driver checking that the PMU counts its external outputs as
TRCEXTOUTn.

Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
events 0x0000-0x003f are reported in bits [31:0], and the common events
from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
linux/perf/arm_pmuv3.h so it is available without CONFIG_ARM_PMU.

Suggested-by: James Clark <james.clark@linaro.org>
Assisted-by: Devmate:Opus-5.5
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 19 +++++++++++++++++++
 include/linux/perf/arm_pmu.h       |  1 -
 include/linux/perf/arm_pmuv3.h     |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 8a777dec8d88a..acd62c4f16743 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -173,6 +173,25 @@ static inline bool pmuv3_implemented(int pmuver)
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
+	if (id >= 64 || !pmuv3_implemented(read_pmuver()))
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
index d698efba28a27..c21f185a283d6 100644
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
-- 
2.52.0

