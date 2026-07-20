Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBC3F0A9A
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545472; cv=none; b=gRLomr2j/2jSXu86hHXMSX6fDL2hHXQLtlzj8xw8QwNc5f3VSa3wlXApDgRoLLOFrTHlMKAcwLNS0QgBiulQjLtioLGCKExcImECJslfejPDMkck3tH17Vv3LIhNpnAJ672seQ6qk3ULgSlxztU6OdL2g7kNxptf2a+prpJ9wVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545472; c=relaxed/simple;
	bh=hdyIpP0qZ6H398mLu2UIlglGTlIbmd+Rf3WJXZZDFAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIk86KXdyWO/F53PHDdFX8SvgAVirqeKcnodo3S3z8Bdstmn/g0QFcOdNzc9ah6Piv/hfLlFgVNk+USuUxpTrKvaVvs1+3Tk4adJqe6Sqb3y6LeINAkZ/bHnP/h/EoENINaRvK7i9lgSthfdI6suAtp6pcfR44JJqEQDBdoaw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4P6dnk1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4P6dnk1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABqhc026970;
	Mon, 20 Jul 2026 11:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5XYA6lCnilZj3nb9C
	HRg5XzJ9Trph6eYytLLNjm0yIk=; b=N4P6dnk1Gbf7w6Nok8VDGbj3tS9TVxR1b
	HPeTJMsv88JuI93ZiOL84Co2oT+NnT6YOGp1aJWy141B3iWN5U9q9Hip5HidL7JP
	n+C3psysl5PUgrAUEJe46b49VNOSO2YHB4kTC3Jwt7D5RfQgJQzLeT6ee6E2JvgZ
	5cMtAACoNs9N5bOswOjoQoNVoEEGb4P0eXG5Wg85Hb0H88nPbhPTOw+Gf77AruPi
	Ntj1ErtRwO1ScZnzQUVxAJlLkeQPp+hSjU8RkdfeBEzncnuC8L3sKcEngV5XRnMR
	SbnqvIBAMIezLxmW22XE26Yr/wOqJ7yt7U3E2wr3xEadmEncAYo7Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a732e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAniYa028105;
	Mon, 20 Jul 2026 11:04:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g530j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB4FBK50331960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB1D2004E;
	Mon, 20 Jul 2026 11:04:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D50B20040;
	Mon, 20 Jul 2026 11:04:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:12 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 4/6] tools/perf: Add powerpc callback support for arch_perf_record__need_read
Date: Mon, 20 Jul 2026 16:22:16 +0530
Message-Id: <20260720105218.14277-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720105218.14277-1-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 4HKZwJF8FT1vs3MfdBrTqFq4fn92qQMf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX+4AuqeiWcG3e
 atb0nd2H/GVtsHwEUFThJb8E6fYQIwlUHze3add0MihAJ255almxpTmd+ZR9trCsWhaoocvhaCY
 ueWzMtFLfXVWSnCKs+D+Y1A3+zD7iiI=
X-Proofpoint-GUID: L0wgDz86u2YFHurcdQfZXlxNAhsLFjBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX2KTb8TfpLJpT
 V8Ex57yzEB61HTk9dyhodXc1ydzzdlWUMG70hptG1GlXrr9mbiHdm6x8tYRr4LRj60ulbu/ZvUB
 w7yc/4dflZCptdsJiBPwAoRrnsBzs41DbYKvv+qpJDstyl4a0BziduqoFCk+tMz5Hg2w61U/JWL
 JAEkjPfoAMgn/m2jVfXgrt0bXULqFA41QtB2HNMHrkFRIaDXrTo5k/tR/KYdeLt1uoIJjUUwXaL
 v3WEivFVJvuv/KDWA+iwsdm/jdxGbd0Fqo6gaPd0YB+c8ml5Pi2yA2/8yo3hYWFFSqVhRYSTs87
 +Db/3DvqzRg6SE1FrUS0D5xWwdnBkOGs4whlH5x9flTf9I7RP6cufBBLReZDPCM/nCumJWju3Lt
 ovMrLQCLjnvai5gIrJvTdyw/jZtQ2/ii3pSmNUlbBuFT3awFyn+ZIL6UBx+3BJMOK203/+1okMT
 XmCLlVL6BUKwraWaF5w==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e00b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=cmUufiQGUpTYaFsbEW4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

Implement the arch_perf_record__need_read() architecture-specific hook
for powerpc in arch/powerpc/util/evsel.c.

The HTM kernel driver sets event->count to 1 while data is staged in
its internal buffers and to 0 once the stream is exhausted.  This hook
reads that count for every open htm evsel via perf_evsel__read() and
accumulates the values.  A non-zero total means at least one HTM target
still has data pending; the recording loop added in the previous patch
will perform another mmap-read pass.

The implementation scans the evlist for htm events, iterates the fd/
sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
mismatched to avoid reading stale state.  When the accumulated count
reaches zero the hook returns 0 and the recording loop proceeds to
disable and close the events.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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

 tools/perf/arch/powerpc/util/evsel.c | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
index 2f733cdc8dbb..8f2805a68026 100644
--- a/tools/perf/arch/powerpc/util/evsel.c
+++ b/tools/perf/arch/powerpc/util/evsel.c
@@ -1,8 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
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
+	bool found_htm = false;
+	u64 total_pending_bytes = 0;
+	int x, y;
+
+	/* there was an error during record__open */
+	if (!evlist)
+		return 0;
+
+	/* First, check if any HTM events exist */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->name && strstarts(evsel->name, "htm")) {
+			found_htm = true;
+			break;
+		}
+	}
+
+	if (!found_htm)
+		return 0;
+
+	/* Read HTM event counts to check if more data is available */
+	evlist__for_each_entry(evlist, evsel) {
+		struct xyarray *xy = evsel->core.sample_id;
+
+		if (!evsel->name || !strstarts(evsel->name, "htm"))
+			continue;
+
+		if (!strcmp(evsel->name, "dummy:u"))
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
+					total_pending_bytes += count.val;
+			}
+		}
+	}
+
+	/* Collection is complete only when ALL hardware queues match 0 */
+	return (total_pending_bytes > 0) ? 1 : 0;
+}
-- 
2.43.0

