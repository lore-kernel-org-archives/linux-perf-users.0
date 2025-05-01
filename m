Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65822D4F0;
	Thu,  1 May 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746092255; cv=none; b=dYjzWyomLcZu9uYnjrNjUAXwx6J8jMlH30tH4zlZc1KxtXGEx6Zpj6RPziQP/XfbbWZ6wHAFLGfORF/rpHnRX056YXsAOLGmbAYd4cFH5+tU8qn/YGgmP/NrA8cuTDTdixOLMdVpwt7FJQHzyTSyUFgwJXNIKUt9wuxZGftsV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746092255; c=relaxed/simple;
	bh=hc7NgoslmUG4t3a9ZjQNuHyS58KdErQYl4ZgInZTw4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD1ohpy1aGvk9jxwXgqpULJhrbNLJeg5TS4iIEEeOjXxLoBU31/24TN9rmvDw7xdeGabP61LrmsFgXzc7Wu5Gyq85Atxb9cH++CoinBPGRozZwHR7wM+qoUMkezQeiVCc1v8anAxp+T9MJUXQKjEH6UrMJFtCBhASSewoWfYyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RK2iU0jp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RK2iU0jp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UL3EHd021977;
	Thu, 1 May 2025 09:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AquKFxP8l67OoaM9Z
	z0xrfQap9EJ2IiwDoc+9rWGBDo=; b=RK2iU0jp/lWTs9uSJrZgOyHwhAmVvPwNS
	hHzICziJ43LfzZ9u9APfbhBwMFJ+z8nRZOp4WOHGkVVleQb28L0S71uJNzB4n/Zo
	9gv3Kss7p+Y/ai1mugpJ8ROeR6cZchy59lrS5fw2b/HlEoODr+L0kWoiFwXdRPp9
	Q6vTcB15Bgr62ANYgEpVyEEJQaeLmJfMnaxbFGGz9a6fPlkQbJA/pBjXZgD1hmx6
	RHK2QPVp0J/ankLG22q35kGuQXWKHSPAmHP3WSsUnJiri7oFxbytIDarGWuE8K3a
	61ULi1cdJ/0TInphvP//YRzu3AOdTz0uBdzgM2OrSZg9/JVPOuDcQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekjbk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5419bOhb005184;
	Thu, 1 May 2025 09:37:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buekjbk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5419EBFk016145;
	Thu, 1 May 2025 09:37:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70mbrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 09:37:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5419bJaw21954850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 09:37:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B51220043;
	Thu,  1 May 2025 09:37:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DAF320040;
	Thu,  1 May 2025 09:37:16 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.221.47])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 09:37:15 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH 4/4] perf python: Add counting.py as example for counting perf events
Date: Thu,  1 May 2025 15:06:30 +0530
Message-ID: <20250501093633.578010-5-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501093633.578010-1-gautam@linux.ibm.com>
References: <20250501093633.578010-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3MiBTYWx0ZWRfX4ep+RS1nkGDH iQwwqG7jrir52dpfBhi2LBia4vZ2jGBSiF+B0fyNFECfwjm3JYrceivvkLS6OXVts0m0LZODuH6 r5MCMCGRA6sj1NOj9outZjj1tMKChCf28lm/jIPbfNL0TecblMR6Qy7wSP+uQFNKkRPssbLWbr/
 6gBXzoGdSD7fGwwYxpSseb2vDBObCTxIbjXQyoPvZNCYCAyJph8CO5m9nu/gtC75ER6Jx2zgv7u N/XKfXOBzQymSNjk/1VxV4in+zePqoID11SOB77uHcDpp1ETG+rHCJvltfAHnpLaeJUjbe9kKt5 bgrDBnIDqYHYElGP8RA8kmYL9as5KVwrH+37bJQowT7JplzA+USzdJ4aMhpSUqGegJT4M2GHlUy
 5VJl2IiHvYr7OKZBd5fCCOlxV1tHdMn1omm0JJsmiGU1RqLy7lOdxex+CaPYQyrBL4ybQ8Qh
X-Authority-Analysis: v=2.4 cv=Io0ecK/g c=1 sm=1 tr=0 ts=681340d5 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=YI06EguIVAnxD8KhfcAA:9
X-Proofpoint-ORIG-GUID: HZXWosbrsR__hhjxEQHClb4BplyKzekZ
X-Proofpoint-GUID: Awrz7UgddSuikCZ4ScTR0SFfKhng096F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505010072

Add counting.py - a python version of counting.c to demonstrate
measuring and reading of counts for given perf events.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/python/counting.py | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100755 tools/perf/python/counting.py

diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
new file mode 100755
index 000000000000..0c58907bd8bf
--- /dev/null
+++ b/tools/perf/python/counting.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- python -*-
+# -*- coding: utf-8 -*-
+
+import perf
+
+def main():
+        cpus = perf.cpu_map()
+        thread_map = perf.thread_map(-1)
+        evlist = perf.evlist(cpus, thread_map)
+
+        evsel1 = perf.evsel(type = perf.TYPE_SOFTWARE,
+                 config = perf.COUNT_SW_CPU_CLOCK,
+                 read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING,
+                 disabled=1)
+        evlist.add(evsel1)
+
+        evsel2 = perf.evsel(type = perf.TYPE_SOFTWARE,
+                 config = perf.COUNT_SW_TASK_CLOCK,
+                 read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING,
+                 disabled=1)
+        evlist.add(evsel2)
+
+        evlist.open()
+        evlist.enable()
+
+        count = 100000
+        while count > 0:
+            count -= 1
+
+        evlist.disable()
+        evsel = evlist.next(None)
+        while evsel != None:
+            counts = evsel.read(0, 0)
+            print(counts.val, counts.ena, counts.run)
+            evsel = evlist.next(evsel)
+        evlist.close()
+
+if __name__ == '__main__':
+    main()
-- 
2.49.0

