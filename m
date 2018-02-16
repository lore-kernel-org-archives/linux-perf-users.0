From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/41] perf tools: Fix comment for sort__* compare functions
Date: Fri, 16 Feb 2018 16:17:11 -0300
Message-ID: <20180216191746.11095-7-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeBPTSU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:20 -0500
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

In commit 2f15bd8c6c6e ("perf tools: Fix "Command" sort_entry's cmp and
collapse function") we switched from pointer to string comparison.

But failed to remove related comments. Removing them and adding another
one to warn before pointer comparison in here.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2da4d0456a03..e8514f651865 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -111,17 +111,20 @@ struct sort_entry sort_thread = {
 
 /* --sort comm */
 
+/*
+ * We can't use pointer comparison in functions below,
+ * because it gives different results based on pointer
+ * values, which could break some sorting assumptions.
+ */
 static int64_t
 sort__comm_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	/* Compare the addr that should be unique among comm */
 	return strcmp(comm__str(right->comm), comm__str(left->comm));
 }
 
 static int64_t
 sort__comm_collapse(struct hist_entry *left, struct hist_entry *right)
 {
-	/* Compare the addr that should be unique among comm */
 	return strcmp(comm__str(right->comm), comm__str(left->comm));
 }
 
-- 
2.14.3
