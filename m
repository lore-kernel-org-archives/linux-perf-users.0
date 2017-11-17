From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/83] perf tests: Add missing WRITE_ASS for new fields of perf_event_attr
Date: Fri, 17 Nov 2017 17:15:21 -0300
Message-ID: <20171117201601.24110-44-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbdKQUSi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:38 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seonghyun Park <seonghyun0p@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Seonghyun Park <seonghyun0p@gmail.com>

Include newly added fields 'mmap2', 'comm_exec', 'use_clockid', 'namespaces',
'write_backward' and 'context_switch' from perf_event_attr to store_event().

Signed-off-by: Seonghyun Park <seonghyun0p@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Seonghyun Park <seonghyun0p@gmail.com>
Link: http://lkml.kernel.org/n/tip-vltn7pqhcv8h5fmo9cthk87q@git.kernel.org
[ Fix log message to add 'write_backward', fix the patch to add 'use_clock_id' ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 0e1367f90af5..97f64ad7fa08 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -124,6 +124,12 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	WRITE_ASS(exclude_guest,  "d");
 	WRITE_ASS(exclude_callchain_kernel, "d");
 	WRITE_ASS(exclude_callchain_user, "d");
+	WRITE_ASS(mmap2,	  "d");
+	WRITE_ASS(comm_exec,	  "d");
+	WRITE_ASS(context_switch, "d");
+	WRITE_ASS(write_backward, "d");
+	WRITE_ASS(namespaces,	  "d");
+	WRITE_ASS(use_clockid,    "d");
 	WRITE_ASS(wakeup_events, PRIu32);
 	WRITE_ASS(bp_type, PRIu32);
 	WRITE_ASS(config1, "llu");
-- 
2.13.6
