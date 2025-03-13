Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF825FA10;
	Thu, 13 Mar 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852339; cv=none; b=ZfgxIzH8SyEm0TVGXR2OZjb759mhj6kahs3GxrIl9a32D3N+Zr5PdJ/SCrhM/8R2iaP5ZD1T2ZUAX5mFhs3JgvA1a/3tI82Xsd/JH8XvJ2epFjKHpdRK+QzQ3AaqVM8mYkSrT911pMOZoOZWg6iyje1nBet1lbVBtNWXfYAUOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852339; c=relaxed/simple;
	bh=gedR1dtFtnCRn8w58vk7alcMu7KQkECnS+oo3tCjlq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/Inwyp3T3Qx8gITPpotpnMdvccwjPd9N5H2TuOnxYMAVNyLRup727MpCr8EvV8OI549vWn2e/1FHNwurP6h8beck4f1y+qDw94YXCHWH1XRjDJ91rT9HluSg8ZLLlql6zN+t+LzIL8Rgri0S9VpK07k4F6MR219Ez54H40IY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WDEFS6hE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WDEFS6hE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CMWFGT023024;
	Thu, 13 Mar 2025 07:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jH+b7pTyfpjSwAnXy
	JyeBmChyDlRKjpWN/yUwvVGuSg=; b=WDEFS6hEoXghrrRjjTaezGoLFmTZ/3+U8
	zYYUF8rIMyonwNUCvu5UlUHWfrfrkTpCZKQUWZn6xGsE5gOhRsKGgHITRzzmYdpS
	/UIrxHiRKKJfrwho5EpWkiwS/6zBLkHM/sd7XEEuTeg0HIjPQwpone4mxSruchlp
	5AWbmO7ei+RJ4RrA3vJwcKGsmyBXLZUVaVxEqs4K66R/3wtjIlqrDBQLw6Yj0K7p
	wep9OvkIHrLb3qseDchXpVVlrc9M4p0j2lDjJd2JhCoo7JmnRc3ECG1R0urm1G9D
	R+o3AAdxiG39U7bKFgTCUkvtDiASveCUGl911t/Xklx9ds3sZsrNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppvck4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:52:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D7pwU8004301;
	Thu, 13 Mar 2025 07:52:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bbppvck0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:52:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D51FwV026021;
	Thu, 13 Mar 2025 07:52:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspgkar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 07:52:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D7q1D536897066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:52:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0EC2004B;
	Thu, 13 Mar 2025 07:52:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA35320043;
	Thu, 13 Mar 2025 07:51:58 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.206.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 07:51:58 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] libperf: Add counting.py example to demonstrate libperf usage from python
Date: Thu, 13 Mar 2025 13:21:24 +0530
Message-ID: <20250313075126.547881-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250313075126.547881-1-gautam@linux.ibm.com>
References: <20250313075126.547881-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DoCVUCURExpo5HknrM-ne3o0IVx3GuDv
X-Proofpoint-GUID: j8dguHwLuVYkULisaGTlJsFbJjefrhfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130058

Add a counting.py example to demonstrate usage of libperf from python
using the C extension module support.

Example usage:
$ sudo ./counting.py
count 7903256, enabled 7903670, run 7903670
count 7902787, enabled 7902787, run 7902787

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 .../perf/Documentation/examples/counting.py   | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 tools/lib/perf/Documentation/examples/counting.py

diff --git a/tools/lib/perf/Documentation/examples/counting.py b/tools/lib/perf/Documentation/examples/counting.py
new file mode 100755
index 000000000000..887111bf2e04
--- /dev/null
+++ b/tools/lib/perf/Documentation/examples/counting.py
@@ -0,0 +1,74 @@
+#!/usr/bin/python3
+
+import sys
+sys.path.append('../../')
+from libperf import *
+
+# software ids
+PERF_COUNT_SW_CPU_CLOCK = 0
+PERF_COUNT_SW_TASK_CLOCK = 1
+
+# Perf event types
+PERF_TYPE_HARDWARE = 0
+PERF_TYPE_SOFTWARE = 1
+PERF_TYPE_TRACEPOINT = 2
+PERF_TYPE_HW_CACHE = 3
+
+# perf_event_attr_read format
+PERF_FORMAT_TOTAL_TIME_ENABLED = 1 << 0
+PERF_FORMAT_TOTAL_TIME_RUNNING = 1 << 1
+PERF_FORMAT_ID = 1 << 2
+PERF_FORMAT_GROUP = 1 << 3
+PERF_FORMAT_LOST = 1 << 4
+
+# Perf sample identifier
+PERF_SAMPLE_IDENTIFIER = 1 << 16
+
+def get_attr(config):
+    attr = perf_event_attr()
+    attr.type = PERF_TYPE_SOFTWARE
+    attr.config = config
+    attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING
+    attr.disabled = 1
+    attr.size = 136
+    attr.sample_type = PERF_SAMPLE_IDENTIFIER
+    return attr
+
+libperf_init(None)
+threads = perf_thread_map__new_dummy()
+assert(threads)
+perf_thread_map__set_pid(threads, 0, 0)
+
+evlist = perf_evlist__new()
+assert(evlist)
+
+attr1 = get_attr(PERF_COUNT_SW_CPU_CLOCK)
+evsel = perf_evsel__new(attr1)
+assert(evsel)
+perf_evlist__add(evlist, evsel)
+
+attr2 = get_attr(PERF_COUNT_SW_TASK_CLOCK)
+evsel = perf_evsel__new(attr2)
+assert(evsel)
+perf_evlist__add(evlist, evsel)
+
+perf_evlist__set_maps(evlist, None, threads)
+rc = perf_evlist__open(evlist)
+if rc != 0:
+    print("failed to open evsel: ", rc)
+
+perf_evlist__enable(evlist)
+
+count = 100000
+while count >= 0:
+    count-=1
+
+perf_evlist__disable(evlist)
+c = perf_counts_values()
+for sel  in evlist:
+		perf_evsel__read(sel, 0, 0, c);
+		print("count %lu, enabled %lu, run %lu" %(c.val, c.ena, c.run))
+
+perf_evlist__close(evlist);
+perf_evlist__delete(evlist);
+perf_thread_map__put(threads);
-- 
2.47.0

