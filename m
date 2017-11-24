From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Fix test 21 for s390x
Date: Fri, 24 Nov 2017 10:43:12 +0100
Message-ID: <20171124094312.55024-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752600AbdKXJnd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Nov 2017 04:43:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAO9fhmx032821
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Nov 2017 04:43:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eeex6nx4m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Nov 2017 04:43:31 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 24 Nov 2017 09:43:29 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Test case 21 (Number of exit events of a simple workload) fails
on s390x. The reason is the invalid sample frequency supplied for
this test. On s390x the minimum sample frequency is much higher
(see output of /proc/service_levels:

[root@s35lp76 linux-devel]# cat /proc/service_levels 
CPU-MF: Counter facility: version=3.5 authorization=002f
CPU-MF: Sampling facility: min_rate=18228 max_rate=170650536 cpu_speed=5208
...
[root@s35lp76 linux-devel]#
).

Supply a save sample frequency value for s390x to fix this.
The value will be adjusted by the s390x CPUMF frequency
convertion function to a value well below the
sysctl kernel.perf_event_max_sample_rate value.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/tests/task-exit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index bc4a7344e274..1073670dd1f2 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -84,7 +84,11 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 	evsel = perf_evlist__first(evlist);
 	evsel->attr.task = 1;
+#ifdef __s390x__
+	evsel->attr.sample_freq = 1000000;
+#else
 	evsel->attr.sample_freq = 1;
+#endif
 	evsel->attr.inherit = 0;
 	evsel->attr.watermark = 0;
 	evsel->attr.wakeup_events = 1;
-- 
2.13.4
