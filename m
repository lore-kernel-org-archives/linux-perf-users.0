From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH] perf cgroup: fix cgroup for multiple events
Date: Thu, 25 Jan 2018 23:00:21 +0800
Message-ID: <20180125150017.GA15771@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:8893 "EHLO
        BJEXCAS006.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751105AbeAYPAt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Jan 2018 10:00:49 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

if use -G and with multiple events, only the first event has
correct cgroup setting, all other events have a wroung setting.

reproduce:
mkdir -p /sys/fs/cgroup/perf_event/test
perf stat -e cycles -e cache-misses  -a -I 1000 -G test

before:
     1.001007226      <not counted>      cycles                    test
     1.001007226              7,506      cache-misses

after:
     1.000834097      <not counted>      cycles                    test
     1.000834097      <not counted>      cache-misses              test

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 tools/perf/util/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index d9ffc1e..b50bfd1 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -137,7 +137,8 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 
 	return -1;
 found:
-	counter->cgrp = cgrp;
+	evlist__for_each_entry(evlist, counter)
+		counter->cgrp = cgrp;
 	return 0;
 }
 
-- 
2.9.4
