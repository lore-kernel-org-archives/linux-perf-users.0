Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175F216E26;
	Mon, 28 Jul 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682434; cv=none; b=RcHlP3Ov8Oh71C5sj4zWWdHpZRSGx6aM8e6veaQJVM+Nxeccb/sfes2xWEe97YuaVKfGmpuiBkqmT7d6RUScRriTEdVzinfqfGKznn5dou+Gvm092nHvU8fse9KKJRFYoCW5wwxHFS65bBvbYrgTiuhq1NEBfp2ciefX7HBJriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682434; c=relaxed/simple;
	bh=Ah3R0v2rYJ487XEMoZp7KO92f0egugJX8Gzr7UGw6Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibsmG7TEQjXZMc44KQdE0TfOwh0W8E4KZbgHoIilQgq4Wz5LZrblqJmLzx6FDqf2SMRoS5g9dkkZNiYX7jV2SDAl8aDUzOSKMUXBiOs1hb1rfc7RioGfBYqCuL5H30beEYbCtHqY8woUn6EAVtsN2AHal45SZnDYUw5gheJavyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYQLNztU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYQLNztU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4kjKQ025384;
	Mon, 28 Jul 2025 06:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r8k5c8iqL9I/tfdQ1
	FuVzFOAu7J/hlKtF00ZSuzsfbM=; b=FYQLNztUYaw2UDspktLsvL9xbmdVlOf5y
	TGyaoHYar47SrlzDdymkOTtxtmx03CcCx1lG1lnhxfVv/3W1kLghuRERCB44X26s
	a3jWyTxxt2xdG+z/LPZLFoPLsT8uRyRp4Y4Zz+BJ2LUBFLah5QVEEhHIkohh1ESU
	spBGZJAACCzbtIBcvU8gurXal3xkkt3Yh7lEFsOJFpbIoCXHSRKySJrye1NKnAme
	yCKP7cfz8nuU0IdTnxkvbgqf9MMkUHMW9sqxRJ0nt217+WDmZKIEWEpV/c8+wUC5
	mZqwwk7Nw84BySNeYqCLrT5xDukg8r2pAJ+JAr4YQJ2qSahkvlZUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqf7yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S5ux9I013615;
	Mon, 28 Jul 2025 06:00:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqf7yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4iE6P017275;
	Mon, 28 Jul 2025 06:00:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859qyvhry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 06:00:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S60Gej58917174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 06:00:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF4520040;
	Mon, 28 Jul 2025 06:00:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A62220043;
	Mon, 28 Jul 2025 06:00:12 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.124.209.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 06:00:12 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf python: Add sampling.py as example for sampling
Date: Mon, 28 Jul 2025 11:29:28 +0530
Message-ID: <20250728055937.58531-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250728055937.58531-1-gautam@linux.ibm.com>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MiBTYWx0ZWRfX/lguueOOtgfM
 Wh7mzELm9hp9A23ZxkM+xfBT9QBQGLzxnRYQafLigDAdJClFtRvxo6gza7EWWKGfosF0ZVV8NVX
 Ffi+f0WA+jIDviodcGRVq7Yb29FWlPFbk2oOqAfSUyZIfszIdpBZWOPC9+qGUBnRPqh1si735U4
 NJgJqczbADFe717U+Djq2pa4jvcqvU6VXecNZN0bvmM2q9WmoCsuvsmcUigRxuatk/loqVXwa8c
 t2u/+At8Pmse54Z/IsbdJhlkV0LCXVhIWfr35+JusxG+LDXWAmXdxqb2I3uy0thKVU4kpS35Xn7
 hW/zFo11WVMebphkfCMHLCkuxGl5N0op8KDRAfm6EuDRZ/DCHBgxPwG0A8UWEXZ50PlHUd7FLn6
 q2jLOLDNXOX0Q4J/wMBVbY62rbjhM+lAyNufJHU7HQGu+1Ep1MS1WkKqqyegvp8hYg5WCn9o
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688711f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=BcAa_kQfSTLkdWV7I_sA:9
X-Proofpoint-GUID: 7scDrOH8zODaMPoVWUNU5haszRnReSlp
X-Proofpoint-ORIG-GUID: Fipa9eN_SySQPQOVzDWZXk-TX3sy7xnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280042

Add sampling.py - a python version of sampling.c to demonstrate sampling
events.

Sample output:
```
$ sudo ./sampling.py
libperf: mmap_per_cpu: nr cpu values 8 nr threads 1
libperf: idx 0: mmapping fd 3
libperf: idx 1: mmapping fd 4
libperf: idx 2: mmapping fd 5
libperf: idx 3: mmapping fd 6
libperf: idx 4: mmapping fd 7
libperf: idx 5: mmapping fd 8
libperf: idx 6: mmapping fd 9
libperf: idx 7: mmapping fd 10
cpu: 0   pid: 4168   tid: 4168   ip: 0x7fb274150c15       period: 345012
cpu: 1   pid: 57137  tid: 57137  ip: 0xffffffffc0745a2c   period: 286666
cpu: 2   pid: 6247   tid: 6247   ip: 0x7fe10a883988       period: 391180
cpu: 3   pid: 0      tid: 0      ip: 0xffffffffa5413e67   period: 245301
cpu: 4   pid: 4168   tid: 4194   ip: 0xffffffffc086a1cc   period: 269605
cpu: 5   pid: 0      tid: 0      ip: 0xffffffffa53bfcb1   period: 90978
cpu: 6   pid: 0      tid: 0      ip: 0xffffffffa6469333   period: 309112
```

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 tools/perf/python/sampling.py | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 tools/perf/python/sampling.py

diff --git a/tools/perf/python/sampling.py b/tools/perf/python/sampling.py
new file mode 100755
index 000000000000..b5f4e1362c63
--- /dev/null
+++ b/tools/perf/python/sampling.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- python -*-
+# -*- coding: utf-8 -*-
+
+import perf
+import time
+
+def main():
+    cpus    = perf.cpu_map()
+    threads = perf.thread_map(-1)
+
+    evlist = perf.parse_events('cpu-cycles', cpus, threads)
+
+    tgt = perf.target(uses_mmap = True, default_per_cpu = True)
+    opts = perf.record_opts(freq=1000, target=tgt, sample_time=True,
+                            sample_cpu=True, no_buffering=True, no_inherit=True)
+    for ev in evlist:
+        ev.tracking = False
+        ev.read_format = 0
+        ev.sample_type = perf.SAMPLE_IP|perf.SAMPLE_TID|perf.SAMPLE_CPU|perf.SAMPLE_PERIOD
+    evlist.config(opts)
+
+    evlist.open()
+    evlist.mmap()
+
+    evlist.enable()
+    time.sleep(2)
+    evlist.disable()
+
+    done = False
+    while done is False:
+        for cpu in cpus:
+            event = evlist.read_on_cpu(cpu)
+            if event is None:
+                done = True
+                break
+
+            if not isinstance(event, perf.sample_event):
+                continue
+
+            print(f"cpu: {event.sample_cpu:<3} pid: {event.sample_pid:<6} "
+                    f"tid: {event.sample_tid:<6} ip: {hex(event.sample_ip):<20} "
+                    f"period: {event.sample_period:<20}")
+
+    evlist.close()
+
+if __name__ == '__main__':
+    main()
-- 
2.49.0

