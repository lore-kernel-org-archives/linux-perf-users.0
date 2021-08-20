Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D79C4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3CB61075
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 09:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhHTJrX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 05:47:23 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:14538 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237085AbhHTJrX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 05:47:23 -0400
IronPort-SDR: 54WHgw8pi/EDEt0mluBoGSGEJVgSoIFYIdyctkvHIunfnrTMQ4VxQdexrETO3gC0Ic8bvi28sP
 WeGLdLC06UIKHdAbcvu75rSt5xTzVa6RhU5aCMOi61zR81s8nYC2pSSGwyaQMIWHYUuvMPTowP
 GonnC3aNlVUOh+dXj6pKXT9RmWwjoLdGXIB0a8gaUp8KXz5TyRHWjFwz97Pfxez8BO5s2wIipp
 bZzq0ZRGM4kJjVj9g5An8Do8+Pwyhwst6Ql4abf2RDnVeJwz74NBdJuvmJ7bb9aCiAjIGNy8aZ
 ZAdQAaPgzho1LcLGDEnG+LQ4
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="41008774"
X-IronPort-AV: E=Sophos;i="5.84,337,1620658800"; 
   d="scan'208";a="41008774"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Aug 2021 18:39:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 86C136ABE0;
        Fri, 20 Aug 2021 18:39:31 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CB9896CD05;
        Fri, 20 Aug 2021 18:39:30 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 7E36A4011B615;
        Fri, 20 Aug 2021 18:39:30 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] libperf tests: Add test_stat_multiplexing test
Date:   Fri, 20 Aug 2021 18:39:08 +0900
Message-Id: <20210820093908.734503-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds a test for a counter obtained using read() system call during multiplexing

Committer testing:

  $ sudo make tests V=1 -C tools/lib/perf/
  make: Entering directory '/home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/lib/perf'
  make -f /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/lib/api/ O= libapi.a
  make -f /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...
  	count = 503074578, run = 261416566, enable = 435415718
  	count = 503295562, run = 261411675, enable = 435412316
  	count = 501603369, run = 261421312, enable = 435408854
  	count = 501245546, run = 261419457, enable = 435405029
  	count = 501849603, run = 261415041, enable = 435400600
  	count = 500801298, run = 261410125, enable = 435395597
  	count = 502116997, run = 261401960, enable = 435389539
  	count = 501797294, run = 261397791, enable = 435382777
  	count = 501249740, run = 261377402, enable = 435374884
  	count = 501754502, run = 260985031, enable = 435366109
  	count = 501659788, run = 260985466, enable = 435354970
  	count = 503670502, run = 260985172, enable = 435345076
  	count = 503209138, run = 260987272, enable = 435335863
  	count = 502772845, run = 260985720, enable = 435314163
  	count = 504045922, run = 260985324, enable = 435303814
     Expected: 502005425
     High: 504045922   Low:  500801298   Average:  502276445
     Average Error = 0.05%
  OK
  - running tests/test-evsel.c...
  	loop = 65536, count = 333260
  	loop = 131072, count = 655861
  	loop = 262144, count = 1315513
  	loop = 524288, count = 2633730
  	loop = 1048576, count = 5270513
  	loop = 65536, count = 407118
  	loop = 131072, count = 786947
  	loop = 262144, count = 1859532
  	loop = 524288, count = 3849286
  	loop = 1048576, count = 7310477
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...
  	count = 502071859, run = 275961923, enable = 461897932
  	count = 501339557, run = 275959274, enable = 461895615
  	count = 501706307, run = 275912910, enable = 461892367
  	count = 501877502, run = 275906600, enable = 461888804
  	count = 501773043, run = 275905934, enable = 461884843
  	count = 502724983, run = 275884848, enable = 461880027
  	count = 502436857, run = 276864452, enable = 461874272
  	count = 502598147, run = 277873765, enable = 461867901
  	count = 502601952, run = 278872100, enable = 461860271
  	count = 502356640, run = 278933007, enable = 461851421
  	count = 503474674, run = 278930678, enable = 461840342
  	count = 503365623, run = 278976959, enable = 461830886
  	count = 503307062, run = 278004451, enable = 461821700
  	count = 502845553, run = 276988055, enable = 461812741
  	count = 501627390, run = 275995291, enable = 461803691
     Expected: 501940978
     High: 503474674   Low:  501339557   Average:  502407143
     Average Error = 0.09%
  OK
  - running tests/test-evsel.c...
  	loop = 65536, count = 328182
  	loop = 131072, count = 661219
  	loop = 262144, count = 1316712
  	loop = 524288, count = 2641030
  	loop = 1048576, count = 5267395
  	loop = 65536, count = 393675
  	loop = 131072, count = 842152
  	loop = 262144, count = 1664160
  	loop = 524288, count = 3421570
  	loop = 1048576, count = 6856783
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 138 +++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..c7184d8b6ce9 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -21,6 +21,9 @@
 #include "tests.h"
 #include <internal/evsel.h>
 
+#define EVENT_NUM 15
+#define WAIT_COUNT 100000000UL
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -413,6 +416,140 @@ static int test_mmap_cpus(void)
 	return 0;
 }
 
+static double display_error(long long average,
+		     long long high,
+		     long long low,
+		     long long expected) {
+
+	double error;
+
+	error = (((double)average - expected) / expected) * 100.0;
+
+	__T_VERBOSE("   Expected: %lld\n", expected);
+	__T_VERBOSE("   High: %lld   Low:  %lld   Average:  %lld\n",
+			high, low, average);
+
+	__T_VERBOSE("   Average Error = %.2f%%\n",error);
+
+	return error;
+
+}
+
+static int test_stat_multiplexing(void)
+{
+	struct perf_counts_values expected_counts = { .val = 0 };
+	struct perf_counts_values multi_counts[EVENT_NUM] = {{ .val = 0 },};
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	     = PERF_TYPE_HARDWARE,
+		.config	     = PERF_COUNT_HW_INSTRUCTIONS,
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			       PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled    = 1,
+	};
+	int err, i, nonzero=0;
+	unsigned long count;
+	long long max = 0, min = 0, avg = 0;
+	double error = 0.0;
+
+	/* read for non-multiplexing event count */
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	err = perf_evsel__enable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	count = WAIT_COUNT;
+	while(count--);
+
+	perf_evsel__read(evsel, 0, 0, &expected_counts);
+	__T("failed to read value for evsel", expected_counts.val != 0);
+	__T("failed to read non-multiplexing event count",
+	    expected_counts.ena == expected_counts.run);
+
+	err = perf_evsel__disable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+
+
+	/* read for multiplexing event count */
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	for (i = 0; i < EVENT_NUM; i++) {
+		evsel = perf_evsel__new(&attr);
+		__T("failed to create evsel1", evsel);
+
+		perf_evlist__add(evlist, evsel);
+	}
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	count = WAIT_COUNT;
+	while (count--);
+
+	i = 0;
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &multi_counts[i]);
+		__T("failed to read value for evsel", multi_counts[i].val != 0);
+		i++;
+	}
+
+	perf_evlist__disable(evlist);
+
+
+	min = multi_counts[0].val;
+	for (i = 0; i < EVENT_NUM; i++) {
+		__T_VERBOSE("\tcount = %lu, run = %lu, enable = %lu\n",
+			    multi_counts[i].val, multi_counts[i].run, multi_counts[i].ena);
+
+		if (multi_counts[i].val > max)
+			max = multi_counts[i].val;
+
+		if (multi_counts[i].val < min)
+			min = multi_counts[i].val;
+
+		avg += multi_counts[i].val;
+
+		if (multi_counts[i].val != 0)
+			nonzero++;
+	}
+	avg = avg / nonzero;
+
+	error = display_error(avg, max, min, expected_counts.val);
+
+	__T("Error out of range!", ((error <= 1.0) && (error >= -1.0)));
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -424,6 +561,7 @@ int test_evlist(int argc, char **argv)
 	test_stat_thread_enable();
 	test_mmap_thread();
 	test_mmap_cpus();
+	test_stat_multiplexing();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.25.1

