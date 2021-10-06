Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA986C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47B661184
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhJFJuP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:50:15 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:13507 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhJFJuP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 05:50:15 -0400
IronPort-SDR: KmPYAY76sY8Yhi5LjWBXgpEGI81u+ilqDL0yqHY+LRlMXPT4ZusBSCS1/ExtTU23KUsdIUxtkg
 tAGfRCjTutq0OlNVHvBNuFrJt/0/KeWx6eH/GEH4zGsfkhI+Sj5InV9KRkD6gBqROgJ6MuJaCS
 Ku/36HEfGS0WT6Z0OR3+LGOWNXbpgFyEDaOCSr0EtM2Kb6rrYZNIJKs6Yz+fUel4OHYUIbZu8O
 GtpWjXLigd27ZaohDe8j3PlXHbUwhOSOFs7VFjHUO9gXxYBQzgEAQW2nPNXlE1r3G5rvcMm+cZ
 wmHP05xL5+KFH6cL/PdCMqFm
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="47791247"
X-IronPort-AV: E=Sophos;i="5.85,350,1624287600"; 
   d="scan'208";a="47791247"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Oct 2021 18:48:22 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6132D6DAA9;
        Wed,  6 Oct 2021 18:48:20 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B19A810965;
        Wed,  6 Oct 2021 18:48:19 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id AA0A2400C07C6;
        Wed,  6 Oct 2021 18:48:19 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2] libperf tests: Fix test_stat_cpu
Date:   Wed,  6 Oct 2021 18:48:17 +0900
Message-Id: <20211006094817.477494-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

`cpu` of perf_evsel__read() must be specified the cpu index.
perf_cpu_map__for_each_cpu is for iterating the cpu number (not index)
and is not appropriate.
So, if there is an offline CPU, the cpu number specified in the argument
may point out of range because the cpu number and the cpu index are
different.

Fix test_stat_cpu.

Committer testing:

  # make tests -C tools/lib/perf/
  make: Entering directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...OK
  - running tests/test-evsel.c...OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...OK
  - running tests/test-evsel.c...OK
  make: Leaving directory '/home/nakamura/kernel_src/linux-5.15-rc4_fix/tools/lib/perf'


Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
Previous version at:
https://lore.kernel.org/lkml/20211006080456.474273-1-nakamura.shun@fujitsu.com/

Changes in v2:
 - Remove "2/2" from Patch Subject

 tools/lib/perf/tests/test-evlist.c | 6 +++---
 tools/lib/perf/tests/test-evsel.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..47badd7eabf2 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -40,7 +40,7 @@ static int test_stat_cpu(void)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config	= PERF_COUNT_SW_TASK_CLOCK,
 	};
-	int err, cpu, tmp;
+	int err, idx;
 
 	cpus = perf_cpu_map__new(NULL);
 	__T("failed to create cpus", cpus);
@@ -70,10 +70,10 @@ static int test_stat_cpu(void)
 	perf_evlist__for_each_evsel(evlist, evsel) {
 		cpus = perf_evsel__cpus(evsel);
 
-		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		for (idx = 0, idx < perf_cpu_map__nr(cpus); idx++) {
 			struct perf_counts_values counts = { .val = 0 };
 
-			perf_evsel__read(evsel, cpu, 0, &counts);
+			perf_evsel__read(evsel, idx, 0, &counts);
 			__T("failed to read value for evsel", counts.val != 0);
 		}
 	}
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 9abd4c0bf6db..33ae9334861a 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -22,7 +22,7 @@ static int test_stat_cpu(void)
 		.type	= PERF_TYPE_SOFTWARE,
 		.config	= PERF_COUNT_SW_CPU_CLOCK,
 	};
-	int err, cpu, tmp;
+	int err, idx;
 
 	cpus = perf_cpu_map__new(NULL);
 	__T("failed to create cpus", cpus);
@@ -33,10 +33,10 @@ static int test_stat_cpu(void)
 	err = perf_evsel__open(evsel, cpus, NULL);
 	__T("failed to open evsel", err == 0);
 
-	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+	for (idx = 0; idx < perf_cpu_map__nr(cpus); idx++) {
 		struct perf_counts_values counts = { .val = 0 };
 
-		perf_evsel__read(evsel, cpu, 0, &counts);
+		perf_evsel__read(evsel, idx, 0, &counts);
 		__T("failed to read value for evsel", counts.val != 0);
 	}
 
-- 
2.25.1

