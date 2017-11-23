From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test: fix test 21 for s390x
Date: Thu, 23 Nov 2017 12:46:11 +0100
Message-ID: <20171123114611.93397-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751799AbdKWLqT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Nov 2017 06:46:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vANBjQpW075826
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2017 06:46:19 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eduw7qm4d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Nov 2017 06:46:18 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 23 Nov 2017 11:46:16 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Test case 21 (Number of exit events of a simple workload) fails
on s390x. The reason is the invalid sample frequency supplied for
this test. On s390x the minimum sample frequency is much higher
(see output of /proc/service_levels).

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
