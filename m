From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [RFC PATCH] perf cgroup: simplify arguments if track multiple events
 for a cgroup
Date: Sun, 28 Jan 2018 13:31:48 +0800
Message-ID: <20180128053143.GA13597@localhost.didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.didichuxing.com ([36.110.17.22]:10232 "EHLO
        BJEXCAS007.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751032AbeA1FcI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Jan 2018 00:32:08 -0500
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

if use -G with one cgroup and -e with multiple events, only the first
event has correct cgroup setting, all events from the second will track
system-wide events.

if user want track multiple events for a specific cgroup, user must give
parameters like follow:
$ perf stat -e e1 -e e2 -e e3 -G test,test,test
this patch simplify this case, just type one cgroup, like following:
$ perf stat -e e1 -e e2 -e e3 -G test

reproduce:
$ mkdir -p /sys/fs/cgroup/perf_event/test
$ perf stat -e cycles -e cache-misses  -a -I 1000 -G test

before:
     1.001007226      <not counted>      cycles                    test
     1.001007226              7,506      cache-misses

after:
     1.000834097      <not counted>      cycles                    test
     1.000834097      <not counted>      cache-misses              test

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 tools/perf/util/cgroup.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index d9ffc1e..38aaeb2 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -154,9 +154,11 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
 		  int unset __maybe_unused)
 {
 	struct perf_evlist *evlist = *(struct perf_evlist **)opt->value;
+	struct perf_evsel *counter;
+	struct cgroup_sel *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	char *s;
-	int ret;
+	int ret, i;
 
 	if (list_empty(&evlist->entries)) {
 		fprintf(stderr, "must define events before cgroups\n");
@@ -185,5 +187,18 @@ int parse_cgroups(const struct option *opt __maybe_unused, const char *str,
 			break;
 		str = p+1;
 	}
+	/* for the case one cgroup combine to multiple events */
+	i = 0;
+	if (nr_cgroups == 1) {
+		evlist__for_each_entry(evlist, counter) {
+			if (i == 0)
+				cgrp = counter->cgrp;
+			else {
+				counter->cgrp = cgrp;
+				refcount_inc(&cgrp->refcnt);
+			}
+			i++;
+		}
+	}
 	return 0;
 }
-- 
2.9.4
