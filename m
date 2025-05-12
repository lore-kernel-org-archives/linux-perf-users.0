Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B716255233;
	Mon, 12 May 2025 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747029522; cv=none; b=KauOQuqQxHvgFtwY28QIOyzTxX0WMa9u2o4DBkmJPL7+ZM/JsJMtlNfEm7Bd6SWUUR/ISPLs+V7lvSwQeIs4wDh4BIkAW4vFXjh6vaVjSSxQymiq4iSc3q+7xLok/9B9vwCc08MkTRKSry9/OeRZmdeFlznuddlh/wllMkal7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747029522; c=relaxed/simple;
	bh=Lo3GnRfc0Ap9DHKs3wjbilSYLc2fLc9r6Rzs609IcdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amx+UzLN6oee97IlJT1znKfQ+WOna/pQ35BonFYRT9rIwjxQzM8Pqh9T8y/1NQsxb3IpWMrhTL/tsIXlYICP3esuXNjIP1DH5QVhGubXAce09llbWho4SGs7JeG8yUX8uVYlFo6w8G7zyseKe6b3nUil3M+r19M5QHBSGMieFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k/ppYClM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k/ppYClM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BBtDjw026345;
	Mon, 12 May 2025 05:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i3pyHwr1EPnBiwUGt
	QyrLU15YzaSR/dxTm5nKo+84M4=; b=k/ppYClMOi4EH270SLjyvuS31vqHaTSZH
	A+zxjndSBawupTM5bsT9m91A67W4dbBlGmHFZPSJ8zU9zwRKwXJJckwKC2Q2zDF/
	oUtLgZLbtuoKWuG2fFJwBIBFechXX62o4t9vpjQxbQ7/nzqryZIaU1VzW4HzAiYy
	vyQx5g2uqvxKGCI0C924HYuKp7WLAmQq/x3SVlNi4ibnKJyAeR8t07S9Ex8TjxSr
	QjvmfdMiSuhr55+SgxnlCZ1oHhGM8TIDWhFfWpb0naATQ67/B95hPWYhsI2OpbiA
	jfkECLJnsSvr0DmeSAF9HDrPQLK7/QlmD8XwyU2B+qBaWNHVP1q7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6aear-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:58:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C5rrWM026055;
	Mon, 12 May 2025 05:58:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6aeak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:58:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0sLfr003815;
	Mon, 12 May 2025 05:58:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkcbc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 05:58:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C5wN2m54788444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 05:58:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83BC7200E2;
	Mon, 12 May 2025 05:58:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACABA200E8;
	Mon, 12 May 2025 05:58:20 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.39.26.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 05:58:20 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Subject: [PATCH v2 4/4] perf python: Add counting.py as example for counting perf events
Date: Mon, 12 May 2025 11:27:45 +0530
Message-ID: <20250512055748.479786-5-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512055748.479786-1-gautam@linux.ibm.com>
References: <20250512055748.479786-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PnoiPDaCmddBqYYd_vKzMHJI0zpZqIqZ
X-Authority-Analysis: v=2.4 cv=TbmWtQQh c=1 sm=1 tr=0 ts=68218e04 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=b2wzPbE2oFXK_2wXMnoA:9
X-Proofpoint-GUID: rClI6BJapn-2IirsOtdbkpOBK7ky1XFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1OCBTYWx0ZWRfXxxnjx6Iy67MS 3HZgyi6yWkMT+Ji6h1/CcBn2SdgtpZkt+5hxwL+io3tcbTmeBGOUV4m0+Y/GRGmkMwwOUFe7PeO 5J12Kuq2TPIhovQ10HUGU5gODA/nFcR27UmJ53pjlMkt59tZ9/XSb7cNKTv64w2TKiH7gwz2m+y
 M+7jOFS9Ro9gXatZST0Xchz96CP3rcIf8PfwKxJDYDG3RAvKDzEp/dvrgYylJYz/bftXEsGXGut sWTYbcFE8UN0KSujSOTAuJk1InrIEAfv4Rx9Ju4lG2F5I6YpvNIONxinCL4k8T1SgFlEP+frplM 5knYwA+uorgapUSHwBbhZhxvnp/WyU5+tK7Kz9wVH+4mzHQQXWzIGtHx+Nnueowdl6k3zxmqY6E
 M4O99EfIh0FQCc+wY/vP7BDCvKzBRWEInl3l8BZ2Jauo20zasAWCU1CKMPR/OZK9Y1jMAAsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_02,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120058

Add counting.py - a python version of counting.c to demonstrate
measuring and reading of counts for given perf events.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Use existing iteration support instead of next
2. Read the counters on all cpus
3. Use existing helper functions

 tools/perf/python/counting.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 tools/perf/python/counting.py

diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
new file mode 100755
index 000000000000..e535e3ae8bdf
--- /dev/null
+++ b/tools/perf/python/counting.py
@@ -0,0 +1,34 @@
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
+        evlist = perf.parse_events("cpu-clock,task-clock", cpus, thread_map)
+
+        for ev in evlist:
+            ev.read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
+
+        evlist.open()
+        evlist.enable()
+
+        count = 100000
+        while count > 0:
+            count -= 1
+
+        evlist.disable()
+
+        for evsel in evlist:
+            for cpu in cpus:
+                for thread in range(len(thread_map)):
+                    counts = evsel.read(cpu, thread)
+                    print(f"For {evsel} val: {counts.val} enable: {counts.ena} run: {counts.run}")
+
+        evlist.close()
+
+if __name__ == '__main__':
+    main()
-- 
2.49.0

