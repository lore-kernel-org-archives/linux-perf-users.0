Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09B4779B0
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329080; cv=none; b=s2Tsc7z+fnsA8Yi5wQzbB/o8FdxAW7tNrK/I3MqRgc8VEsv2j38NYQaWjYsdVN0PGDVjbcDMV3bySpsDnJjGRrMzNHGlHRByN5wRzGnO/foE/5197ltNrKqp4zz8rWglh5/Ay4P8WjajkENfen98XB/lr4mTxzhMLyzZUssRu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329080; c=relaxed/simple;
	bh=fZFX3P9jZOXRzAtEL+HImhwtRWbCxbVAyNx50zlbyF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Os/y/pu+Y51aBsIs76UQPMllZTl+NxNiV2koermmVwK1JKSihEoZwq6VbRkMYRT16uDSZZqwyREcMzPAFlwszmk3WKgN5opdC0Is/qJ4eVz31eV4/36lAMOpbf7kt7WiqhR7BeCsIred9Fil2/RL70DsjxQBQ+B7WKMAZt8KX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pvAUbq3j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pvAUbq3j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHl5F4063650;
	Wed, 29 Jul 2026 12:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CwNBgyhGuh2UPePac
	IbYbdnR3+jGFbqitWxP85iob1E=; b=pvAUbq3jjPNGmyiIj4maVOZ10eTWUMGpi
	1Qzz8wC4jIsQ/sbcC9N2HMuWCh39bKP5i2a7zGMfdPMOYSbiSSaLTTGGIf21JYKI
	tNDlaMYUDi7jOphkV2qV1/BBJwfJiT+2o5Y/yJCEiaERGFoEWQ9mWxA/Hg1Unfew
	bA+fG5Xbspl8WZcfErIiY95jjzxkp0NCvz54wOGpv1RYUo4Cr40nF8r3PhK1AKDQ
	0ICFfhjdlt+A13MTI6hv4U+0Rvv6fr/r5kGa4Vn0qxNq321snnGCLODpUjIJnaDl
	ho0G+MYqqG0IGhVnHfdp+xtTFZq0SM1S/tdUaEE0N149EsEDK6Eiw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtq5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfFbv028627;
	Wed, 29 Jul 2026 12:44:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhembx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCiLCc44499282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC30820043;
	Wed, 29 Jul 2026 12:44:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C9FC20040;
	Wed, 29 Jul 2026 12:44:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:17 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 4/6] tools/perf: Add powerpc callback support for arch_perf_record__need_read
Date: Wed, 29 Jul 2026 18:13:58 +0530
Message-Id: <20260729124400.65009-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729124400.65009-1-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yKkqyDsanbV4YTcFOJzybeHed-lFTJ55
X-Proofpoint-ORIG-GUID: db7ozRr7RlcFb8Flj9k2mopAl55_NhwN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX80WQJEu3/XCA
 uvPtzShNW4OW1OUEknLylfXRA+JP//DLehHcKDWUDYMxmI9qnXOic5GdcjKFUmMhydIloVoJTuF
 WUyA8eS+QuOSc2ixQ00CgT7auU6ghXM=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69f5aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=2CLxpyUa9fGFCfGWS_AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX64dRXdmyKEFc
 Kk20503P05dEmamyWv3owLK0z2mv/78YukfezHI2Znq8uxPpxUE0H6S/YOtZeShKr/tDmDf5whq
 nXHAipThv/FOF6zdS6A6K2vvEAHUo+rj6WqRc0Va/MIxTLFyugHNfJypymLP4nw9HRaWMgimf5L
 edJF9eo6gBoNoxjayJ6F8KG7KSaZ8l0Ee9u/viG6PwQTscwZ5TAqeC5kG0HPiRRwpFyGGOArEKA
 ZVWSbAJ5sB1+fPcH8dht0t79oL/tFPk2On4gEIjsIE67HRvyaAZtos1UR+9UFgFKawjscWpl3fo
 oHUbxVKuHELHqLNbXRcYiBKTH1wD00suJOqBidLK2eVIQ6whnsjzzmAmjHLsF6bs1Fj42BeJonc
 FJju9KjbrmlEiAr6WdA0zguNyT6ofPMEnsctjBrvhjAsLY51LbQmATpfjwfJwxM8JuuuCTrmaFd
 a8R2Z+wZKzA8RbTakbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

Implement the arch_perf_record__need_read() architecture-specific hook
for powerpc in arch/powerpc/util/evsel.c.

The HTM kernel driver sets event->count to the number of records still
staged in its internal buffers (total_size / record_size), and to 0
once the stream is exhausted.  This hook reads that count for every open
htm evsel via perf_evsel__read() and accumulates the values into
total_pending_records.  A non-zero total means at least one HTM target
still has records pending; the recording loop added in the previous
patch will perform another mmap-read pass.

The drain uses a two-layer safety check: event->count detects records
staged by the driver, and record__bytes_written() in the drain loop
confirms data was actually moved into perf.data.  This combination
handles the case where the driver count is briefly stale while hardware
is still flushing.

The implementation scans the evlist using evsel__pmu_name() to identify
HTM events by their kernel-assigned PMU name rather than the
user-visible event name, preventing false matches.  It iterates the fd/
sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
mismatched to avoid reading stale state.  When the accumulated record
count reaches zero the hook returns 0 and the recording loop proceeds to
disable and close the events.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- No changes from V3.

Changes in V3:
- Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
to identify HTM events, matching by kernel-assigned PMU name rather
than user-visible event name.
- Remove the redundant two-pass loop (first pass to set found_htm,
second to accumulate counts); a single pass with evsel__pmu_name()
is sufficient. if no HTM event exists total_pending_records stays 0
and the function returns 0.
- Remove the dead !strcmp(evsel->name, "dummy:u") check;
- evsel__pmu_name() will never return "htm" for a dummy:u software
event.
- Rename total_pending_bytes -> total_pending_records to match what
the driver actually reports (event->count = total_size / record_size,
a record count, not a byte count).
- Add #include <string.h> for musl compatibility (strcmp() without
it warns on some toolchains).

Changes in V2:
- Implements the renamed arch_perf_record__need_read() hook (V1
  implemented arch_record__collect_final_data()).
- Skips evsels whose fd and sample-id xyarrays are mismatched, avoiding
  stale-state reads.  V1 had no such guard.
- evlist__enable cycling is removed; that responsibility now belongs to
  the drain loop in builtin-record.c added in patch 3.
- File location changed to arch/powerpc/util/evsel.c (V1 used
  arch/powerpc/util/powerpc-htm.c).
- Patch is now 4/6 instead of 4/9.

 tools/perf/arch/powerpc/util/evsel.c | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
index 2f733cdc8dbb..3c7ccc955b0a 100644
--- a/tools/perf/arch/powerpc/util/evsel.c
+++ b/tools/perf/arch/powerpc/util/evsel.c
@@ -1,8 +1,63 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <string.h>
+#include <linux/string.h>
 #include "util/evsel.h"
+#include "util/record.h"
+#include "util/evlist.h"
+#include "util/debug.h"
+#include <internal/xyarray.h>
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
 }
+
+/*
+ * Check if HTM events have more data to collect.
+ *
+ * This function reads the HTM event counts. When the kernel driver
+ * has more data available, it returns a non-zero count. When all
+ * data has been collected, it returns zero.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+int arch_perf_record__need_read(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	u64 total_pending_records = 0;
+	int x, y;
+
+	/* there was an error during record__open */
+	if (!evlist)
+		return 0;
+
+	/* Read HTM event counts to check if more data is available */
+	evlist__for_each_entry(evlist, evsel) {
+		struct xyarray *xy = evsel->core.sample_id;
+
+		if (strcmp(evsel__pmu_name(evsel), "htm"))
+			continue;
+
+		if (xy == NULL || evsel->core.fd == NULL)
+			continue;
+
+		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
+		    xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
+			pr_debug("Unmatched FD vs sample ID array for HTM event\n");
+			continue;
+		}
+
+		for (x = 0; x < xyarray__max_x(xy); x++) {
+			for (y = 0; y < xyarray__max_y(xy); y++) {
+				struct perf_counts_values count = { .val = 0 };
+
+				if (perf_evsel__read(&evsel->core, x, y, &count) == 0)
+					total_pending_records += count.val;
+			}
+		}
+	}
+
+	/* Collection is complete only when ALL hardware queues have no pending records */
+	return (total_pending_records > 0) ? 1 : 0;
+}
-- 
2.43.0

