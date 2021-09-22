Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F816C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A6061178
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhIVKSP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:18:15 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:11225 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234531AbhIVKSN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 06:18:13 -0400
IronPort-SDR: 5Fq6LHzmrxNg/1n0ZnbDtKoK8WWl0oWIgJcmtV+1HyxSeh840PEklyii7CeNO/kU4jMZUlUSC7
 QQYsyiiHriacfUDf0qVTr3BvWAcu/1LLcxYw9jtgLhsafKBprlu4dFo8Bm/5WcZmxnii1Akx2n
 C7rQ8xCcYrTL3kF3zp5eZyxrWvXNEU6MaskVxLzjqX7+GGapkOBTL8WZnhelrnmgwKBIPAPKv/
 zCs7fIUQuBKJOB0QWfrSHe5NQSPNzQ+ytJ5hydM/HY+fGyuALCQVSPaEmpUKArshh9s+kIU4HB
 zM9V03yJBX5eD04wFXdWxB93
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="25707508"
X-IronPort-AV: E=Sophos;i="5.85,313,1624287600"; 
   d="scan'208";a="25707508"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Sep 2021 19:16:32 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A022BEE086;
        Wed, 22 Sep 2021 19:16:31 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CB652DAA0C;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id B3A54400C007E;
        Wed, 22 Sep 2021 19:16:30 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/2] libperf tests: Add test_stat_multiplexing test
Date:   Wed, 22 Sep 2021 19:16:27 +0900
Message-Id: <20210922101627.3396398-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: nakamura shunsuke <nakamura.shun@fujitsu.com>

Adds a test for a counter obtained using read() system call during multiplexing

Committer testing:

  $ sudo make tests -C tools/lib/perf/ V=1
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
  	count = 502273264, run = 264105562, enable = 444092845
  	count = 501850699, run = 264100505, enable = 444088400
  	count = 499613780, run = 264096660, enable = 444085073
  	count = 499569398, run = 264501528, enable = 444081268
  	count = 500717228, run = 265495387, enable = 444077029
  	count = 501260539, run = 266488226, enable = 444071569
  	count = 501023910, run = 267469613, enable = 444065303
  	count = 501188267, run = 268461294, enable = 444058413
  	count = 503096683, run = 269450511, enable = 444050567
  	count = 503141904, run = 269587790, enable = 444041735
  	count = 503454490, run = 268590361, enable = 444030544
  	count = 504838207, run = 267592624, enable = 444021005
  	count = 505458594, run = 266594648, enable = 444001280
  	count = 504269433, run = 265595795, enable = 443991377
  	count = 502625858, run = 264599374, enable = 443982141
     Expected: 502065774
     High: 505458594   Low:  499569398   Average:  502292150
     Average Error = 0.05%
  	count = 26129, run = 134550, enable = 134550
  	count = 34035, run = 140540, enable = 140540
  	count = 40189, run = 141126, enable = 141126
  	count = 45263, run = 138290, enable = 138290
  	count = 51381, run = 136966, enable = 136966
  	count = 57499, run = 134993, enable = 134993
  	count = 63617, run = 132320, enable = 132320
  	count = 71714, run = 132047, enable = 132047
  	count = 77832, run = 128157, enable = 128157
  	count = 0, run = 0, enable = 123662
  	count = 0, run = 0, enable = 116753
  	count = 0, run = 0, enable = 110304
  	count = 0, run = 0, enable = 103834
  	count = 0, run = 0, enable = 97465
  	count = 0, run = 0, enable = 91110
  OK
  - running tests/test-evsel.c...
  	loop = 65536, count = 334303
  	loop = 131072, count = 656954
  	loop = 262144, count = 1321090
  	loop = 524288, count = 2652616
  	loop = 1048576, count = 5262140
  	loop = 65536, count = 393726
  	loop = 131072, count = 989345
  	loop = 262144, count = 1986206
  	loop = 524288, count = 3831652
  	loop = 1048576, count = 7747957
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...
  	count = 501975838, run = 247092568, enable = 415093723
  	count = 502491858, run = 247087145, enable = 415088830
  	count = 502571026, run = 247083574, enable = 415085139
  	count = 502743767, run = 247080183, enable = 415081197
  	count = 503259008, run = 247779561, enable = 415076990
  	count = 503169622, run = 248773141, enable = 415072091
  	count = 503430373, run = 249816445, enable = 415066529
  	count = 502597951, run = 250808797, enable = 415059863
  	count = 502211776, run = 251799199, enable = 415051831
  	count = 501921896, run = 252000721, enable = 415042717
  	count = 501441904, run = 251309399, enable = 415031152
  	count = 501224474, run = 250311107, enable = 415021479
  	count = 500502827, run = 249260579, enable = 415012168
  	count = 500775622, run = 248259621, enable = 415002830
  	count = 501377375, run = 247261134, enable = 414993890
     Expected: 501953755
     High: 503430373   Low:  500502827   Average:  502113021
     Average Error = 0.03%
  	count = 26098, run = 131826, enable = 131826
  	count = 33689, run = 138284, enable = 138284
  	count = 39808, run = 139152, enable = 139152
  	count = 45927, run = 138880, enable = 138880
  	count = 51049, run = 135405, enable = 135405
  	count = 57168, run = 133406, enable = 133406
  	count = 63287, run = 130736, enable = 130736
  	count = 71392, run = 130474, enable = 130474
  	count = 77794, run = 127203, enable = 127203
  	count = 0, run = 0, enable = 123172
  	count = 0, run = 0, enable = 116856
  	count = 0, run = 0, enable = 110557
  	count = 0, run = 0, enable = 104282
  	count = 0, run = 0, enable = 97929
  	count = 0, run = 0, enable = 91792
  OK
  - running tests/test-evsel.c...
  	loop = 65536, count = 334400
  	loop = 131072, count = 656908
  	loop = 262144, count = 1315441
  	loop = 524288, count = 2657481
  	loop = 1048576, count = 5258193
  	loop = 65536, count = 491938
  	loop = 131072, count = 965755
  	loop = 262144, count = 1666277
  	loop = 524288, count = 3516123
  	loop = 1048576, count = 6759204
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/lib/perf'


Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 183 +++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..ca7a9542f40e 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -21,6 +21,10 @@
 #include "tests.h"
 #include <internal/evsel.h>
 
+#define EVENT_NUM 15
+#define WAIT_COUNT 100000000UL
+
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -413,6 +417,184 @@ static int test_mmap_cpus(void)
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
+	struct perf_counts_values multiplexing_counts[EVENT_NUM] = {{ .val = 0 },};
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
+	/* wait loop */
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
+	/* wait loop */
+	count = WAIT_COUNT;
+	while(count--);
+
+	i = 0;
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &multiplexing_counts[i]);
+		__T("failed to read value for evsel", multiplexing_counts[i].val != 0);
+		i++;
+	}
+
+	perf_evlist__disable(evlist);
+
+
+	min = multiplexing_counts[0].val;
+	for (i = 0; i < EVENT_NUM; i++) {
+		__T_VERBOSE("\tcount = %lu, run = %lu, enable = %lu\n",
+			    multiplexing_counts[i].val, multiplexing_counts[i].run,
+			    multiplexing_counts[i].ena);
+
+		if (multiplexing_counts[i].val > max)
+			max = multiplexing_counts[i].val;
+
+		if (multiplexing_counts[i].val < min)
+			min = multiplexing_counts[i].val;
+
+		avg += multiplexing_counts[i].val;
+
+		if (multiplexing_counts[i].val != 0)
+			nonzero++;
+	}
+
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
+
+
+	/* Verify that no division by zero occurs */
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
+	/* Reproduce run=0 by not executing wait loop. */
+
+	i = 0;
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &multiplexing_counts[i]);
+		__T_VERBOSE("\tcount = %lu, run = %lu, enable = %lu\n",
+			    multiplexing_counts[i].val, multiplexing_counts[i].run,
+			    multiplexing_counts[i].ena);
+		i++;
+	}
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
@@ -424,6 +606,7 @@ int test_evlist(int argc, char **argv)
 	test_stat_thread_enable();
 	test_mmap_thread();
 	test_mmap_cpus();
+	test_stat_multiplexing();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.27.0

