Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1CBC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8519160FD8
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbhKIJJy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:09:54 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:43098 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhKIJJx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 04:09:53 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 04:09:52 EST
IronPort-SDR: LUPFr7cE4L7q1KGCeUlhAuIr2Hm781nYLe48j7kwY3ljGOWnSLbOIhxWJnbzo323HVE8zjULAk
 Az/aHEG1h6JGtwrsX+63oDimsZ4sWxhkHpyRMFBjHmYU/mfWvEaHiE59Kw5yMLRpiXG7HgAQZs
 wQY4kzK9sB5IQ8MI0h4xqsmLNsBVte8njmuNP/dxr6saQ0DjNRdqWQYpWXyohpsbp9p8eQ/1TD
 88WrJLY3L1qf3FX1OHfeIyTmJlRO+8axVSXjP7UeLe2ql6GqklAY75aqfHGQq3ar9JeqF5LSa/
 RsEq511odAKCnst+vDGg8EzB
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="39818560"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; 
   d="scan'208";a="39818560"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 09 Nov 2021 17:58:38 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D8E7B13E0B1;
        Tue,  9 Nov 2021 17:58:37 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C3F77C9CF7;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id AE7704007DEE6;
        Tue,  9 Nov 2021 17:58:35 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v3 3/3] libperf tests: Add test_stat_multiplexing test
Date:   Tue,  9 Nov 2021 17:58:31 +0900
Message-Id: <20211109085831.3770594-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
References: <20211109085831.3770594-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds a test for a counter obtained using read() system call during
multiplexing.

Committer testing:

  $ sudo make tests -C ./tools/lib/perf/ V=1
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
  Event  0 -- Raw count = 298049842, run = 270269503, enable = 456262127
           Scaled count = 503160191 (59.24%, 270269503/456262127)
  Event  1 -- Raw count = 299134173, run = 271075173, enable = 456257234
           Scaled count = 503484435 (59.41%, 271075173/456257234)
  Event  2 -- Raw count = 300461996, run = 272069283, enable = 456253417
           Scaled count = 503867290 (59.63%, 272069283/456253417)
  Event  3 -- Raw count = 301308704, run = 273063387, enable = 456249352
           Scaled count = 503443183 (59.85%, 273063387/456249352)
  Event  4 -- Raw count = 302531164, run = 274102932, enable = 456244712
           Scaled count = 503563543 (60.08%, 274102932/456244712)
  Event  5 -- Raw count = 303710254, run = 275406214, enable = 456228165
           Scaled count = 503115633 (60.37%, 275406214/456228165)
  Event  6 -- Raw count = 304531302, run = 276396076, enable = 456221130
           Scaled count = 502661313 (60.58%, 276396076/456221130)
  Event  7 -- Raw count = 304486460, run = 276601890, enable = 456213754
           Scaled count = 502205212 (60.63%, 276601890/456213754)
  Event  8 -- Raw count = 304116681, run = 276631326, enable = 456205562
           Scaled count = 501532936 (60.64%, 276631326/456205562)
  Event  9 -- Raw count = 303567766, run = 276188567, enable = 456196839
           Scaled count = 501420666 (60.54%, 276188567/456196839)
  Event 10 -- Raw count = 302238014, run = 275144001, enable = 456185300
           Scaled count = 501106833 (60.31%, 275144001/456185300)
  Event 11 -- Raw count = 300805716, run = 273824589, enable = 456175608
           Scaled count = 501124573 (60.03%, 273824589/456175608)
  Event 12 -- Raw count = 299959051, run = 272834556, enable = 456166593
           Scaled count = 501517477 (59.81%, 272834556/456166593)
  Event 13 -- Raw count = 299037090, run = 271820805, enable = 456157086
           Scaled count = 501830195 (59.59%, 271820805/456157086)
  Event 14 -- Raw count = 298327042, run = 270784311, enable = 456147546
           Scaled count = 502544433 (59.36%, 270784311/456147546)
     Expected: 501614268
     High: 503867290   Low:  298049842   Average:  502438527
     Average Error = 0.16%
  OK
  - running tests/test-evsel.c...
          loop = 65536, count = 328182
          loop = 131072, count = 660214
          loop = 262144, count = 1315534
          loop = 524288, count = 2635364
          loop = 1048576, count = 5271971
          loop = 65536, count = 491952
          loop = 131072, count = 850061
          loop = 262144, count = 1648608
          loop = 524288, count = 3162059
          loop = 1048576, count = 6353393
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...
  Event  0 -- Raw count = 300218292, run = 297528154, enable = 496789343
           Scaled count = 501281125 (59.89%, 297528154/496789343)
  Event  1 -- Raw count = 301438606, run = 298515328, enable = 496784768
           Scaled count = 501649643 (60.09%, 298515328/496784768)
  Event  2 -- Raw count = 302342618, run = 298798983, enable = 496782015
           Scaled count = 502673648 (60.15%, 298798983/496782015)
  Event  3 -- Raw count = 303132319, run = 299230407, enable = 496778508
           Scaled count = 503256412 (60.23%, 299230407/496778508)
  Event  4 -- Raw count = 302758195, run = 299218047, enable = 496774243
           Scaled count = 502651743 (60.23%, 299218047/496774243)
  Event  5 -- Raw count = 303158458, run = 299204274, enable = 496769146
           Scaled count = 503334281 (60.23%, 299204274/496769146)
  Event  6 -- Raw count = 303471397, run = 299197479, enable = 496763124
           Scaled count = 503859189 (60.23%, 299197479/496763124)
  Event  7 -- Raw count = 303583387, run = 299196861, enable = 496756458
           Scaled count = 504039405 (60.23%, 299196861/496756458)
  Event  8 -- Raw count = 303096897, run = 299186924, enable = 496748667
           Scaled count = 503240507 (60.23%, 299186924/496748667)
  Event  9 -- Raw count = 301424173, run = 297845086, enable = 496739994
           Scaled count = 502709122 (59.96%, 297845086/496739994)
  Event 10 -- Raw count = 300876415, run = 296851339, enable = 496729034
           Scaled count = 503464297 (59.76%, 296851339/496729034)
  Event 11 -- Raw count = 300239338, run = 296547963, enable = 496719538
           Scaled count = 502902612 (59.70%, 296547963/496719538)
  Event 12 -- Raw count = 299751948, run = 296547195, enable = 496710036
           Scaled count = 502077926 (59.70%, 296547195/496710036)
  Event 13 -- Raw count = 299341883, run = 296549981, enable = 496700423
           Scaled count = 501376663 (59.70%, 296549981/496700423)
  Event 14 -- Raw count = 299145476, run = 296561684, enable = 496690949
           Scaled count = 501018366 (59.71%, 296561684/496690949)
     Expected: 501669431
     High: 504039405   Low:  300218292   Average:  502635662
     Average Error = 0.19%
  OK
  - running tests/test-evsel.c...
          loop = 65536, count = 329275
          loop = 131072, count = 664638
          loop = 262144, count = 1315367
          loop = 524288, count = 2629617
          loop = 1048576, count = 5273657
          loop = 65536, count = 459641
          loop = 131072, count = 978402
          loop = 262144, count = 1581219
          loop = 524288, count = 3774908
          loop = 1048576, count = 7694417
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux_kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 157 +++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index ce91a582f0e4..520a78267743 100644
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
@@ -413,6 +416,159 @@ static int test_mmap_cpus(void)
 	return 0;
 }
 
+static double display_error(long long average,
+			    long long high,
+			    long long low,
+			    long long expected)
+{
+	double error;
+
+	error = (((double)average - expected) / expected) * 100.0;
+
+	__T_VERBOSE("   Expected: %lld\n", expected);
+	__T_VERBOSE("   High: %lld   Low:  %lld   Average:  %lld\n",
+		    high, low, average);
+
+	__T_VERBOSE("   Average Error = %.2f%%\n", error);
+
+	return error;
+}
+
+static int test_stat_multiplexing(void)
+{
+	struct perf_counts_values expected_counts = { .val = 0 };
+	struct perf_counts_values counts[EVENT_NUM] = {{ .val = 0 },};
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
+	int err, i, nonzero = 0;
+	unsigned long count;
+	long long max = 0, min = 0, avg = 0;
+	double error = 0.0;
+	s8 scaled = 0;
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
+	while (count--)
+		;
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
+		__T("failed to create evsel", evsel);
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
+	while (count--)
+		;
+
+	i = 0;
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts[i]);
+		__T("failed to read value for evsel", counts[i].val != 0);
+		i++;
+	}
+
+	perf_evlist__disable(evlist);
+
+	min = counts[0].val;
+	for (i = 0; i < EVENT_NUM; i++) {
+		__T_VERBOSE("Event %2d -- Raw count = %lu, run = %lu, enable = %lu\n",
+			    i, counts[i].val, counts[i].run, counts[i].ena);
+
+		perf_counts_values__scale(&counts[i], true, &scaled);
+		if (scaled == 1) {
+			__T_VERBOSE("\t Scaled count = %lu (%.2lf%%, %lu/%lu)\n",
+				    counts[i].val,
+				    (double)counts[i].run / (double)counts[i].ena * 100.0,
+				    counts[i].run, counts[i].ena);
+		} else if (scaled == -1) {
+			__T_VERBOSE("\t Not Runnnig\n");
+		} else {
+			__T_VERBOSE("\t Not Scaling\n");
+		}
+
+		if (counts[i].val > max)
+			max = counts[i].val;
+
+		if (counts[i].val < min)
+			min = counts[i].val;
+
+		avg += counts[i].val;
+
+		if (counts[i].val != 0)
+			nonzero++;
+	}
+
+	if (nonzero != 0)
+		avg = avg / nonzero;
+	else
+		avg = 0;
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
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -424,6 +580,7 @@ int test_evlist(int argc, char **argv)
 	test_stat_thread_enable();
 	test_mmap_thread();
 	test_mmap_cpus();
+	test_stat_multiplexing();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.27.0

