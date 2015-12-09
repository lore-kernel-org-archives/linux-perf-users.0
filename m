From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 10/22] perf: Make comm_str to use refcnt for debug
Date: Wed, 09 Dec 2015 11:11:10 +0900
Message-ID: <20151209021110.10245.35034.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:42833 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbLICTE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Dec 2015 21:19:04 -0500
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Make 'comm_str' object to use refcnt interface for debug.
This can find refcnt related memory leaks.

  ----
  # ./perf top --stdio
  ^q
  REFCNT: BUG: Unreclaimed objects found.
  REFCNT: Total 3369 objects are not reclaimed.
    "dso" leaks 193 objects
    "map" leaks 3154 objects
    "map_groups" leaks 6 objects
    "comm_str" leaks 9 objects
    "thread" leaks 7 objects
     To see all backtraces, rerun with -v option
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/comm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 21b7ff3..77202ab 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -1,5 +1,6 @@
 #include "comm.h"
 #include "util.h"
+#include "refcnt.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include <linux/atomic.h>
@@ -16,15 +17,16 @@ static struct rb_root comm_str_root;
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
 	if (cs)
-		atomic_inc(&cs->refcnt);
+		refcnt__get(cs, refcnt);
 	return cs;
 }
 
 static void comm_str__put(struct comm_str *cs)
 {
-	if (cs && atomic_dec_and_test(&cs->refcnt)) {
+	if (cs && refcnt__put(cs, refcnt)) {
 		rb_erase(&cs->rb_node, &comm_str_root);
 		zfree(&cs->str);
+		refcnt__exit(cs, refcnt);
 		free(cs);
 	}
 }
@@ -43,7 +45,7 @@ static struct comm_str *comm_str__alloc(const char *str)
 		return NULL;
 	}
 
-	atomic_set(&cs->refcnt, 0);
+	refcnt__init_as(cs, refcnt, 0, "comm_str");
 
 	return cs;
 }
