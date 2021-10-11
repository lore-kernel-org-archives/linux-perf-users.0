Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F474C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7D60C49
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhJKIjR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:39:17 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:30335 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234885AbhJKIjQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 04:39:16 -0400
IronPort-SDR: U0VjdClWbSGtL1ulqKHnOxVlsXjCx8+fLEl3lakAdsdlmEYSJSB2PcCEuNHJk9+qSKiy4x/atV
 O373nA8/Vk4G209ArQLurqdo3Ti96fGpsnxIse1myYoXuScHTqr2KXws1pTYY7Ew/LtBx3tkPo
 ZdJA8kcEfqOpSmAAGwY3yP7VU7Qlv9WSeNPsqXe2jc7wJ1oTnO6Ozr/plqtiUO5OmfpAdhH625
 tnDA+A/mZbQzG8EQHFRse6aupF2mRVu00jcUqpkI2amFEEU+n1wpsXGEucY5fO7JdFi/fgA1Pb
 5JN5FqvyU9ETt/OS3zoyHPuV
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="28062049"
X-IronPort-AV: E=Sophos;i="5.85,364,1624287600"; 
   d="scan'208";a="28062049"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Oct 2021 17:37:14 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D892AE6800;
        Mon, 11 Oct 2021 17:37:13 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 170AECA703;
        Mon, 11 Oct 2021 17:37:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id F3F584005EA44;
        Mon, 11 Oct 2021 17:37:12 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v3] libperf tests: Fix test_stat_cpu
Date:   Mon, 11 Oct 2021 17:37:04 +0900
Message-Id: <20211011083704.4108720-1-nakamura.shun@fujitsu.com>
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
https://lore.kernel.org/lkml/20211006094817.477494-1-nakamura.shun@fujitsu.com/

Changes in v3:
  - Fix build error

Changes in v2:
  - Remove "2/2" from Patch Subject

 tools/lib/perf/tests/test-evlist.c | 6 +++---
 tools/lib/perf/tests/test-evsel.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..ce91a582f0e4 100644
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
+		for (idx = 0; idx < perf_cpu_map__nr(cpus); idx++) {
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

