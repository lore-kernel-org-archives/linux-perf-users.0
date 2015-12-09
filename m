From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core  08/22] perf: Make thread uses refcnt for debug
Date: Wed, 09 Dec 2015 11:11:05 +0900
Message-ID: <20151209021105.10245.83142.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:53384 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbLICS6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 8 Dec 2015 21:18:58 -0500
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Make 'thread' object to use refcnt interface for debug.
This can find refcnt related memory leaks.
E.g.

  ----
  # ./perf top --stdio
  ^q
  REFCNT: BUG: Unreclaimed objects found.
  REFCNT: Total 3525 objects are not reclaimed.
    "map" leaks 3285 objects
    "dso" leaks 225 objects
    "thread" leaks 8 objects
    "map_groups" leaks 7 objects
     To see all backtraces, rerun with -v option
  ----

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/thread.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0a9ae80..392fc32 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -53,7 +53,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 			goto err_thread;
 
 		list_add(&comm->list, &thread->comm_list);
-		atomic_set(&thread->refcnt, 0);
+		refcnt__init(thread, refcnt, 0);
 		RB_CLEAR_NODE(&thread->rb_node);
 	}
 
@@ -81,6 +81,7 @@ void thread__delete(struct thread *thread)
 		comm__free(comm);
 	}
 	unwind__finish_access(thread);
+	refcnt__exit(thread, refcnt);
 
 	free(thread);
 }
@@ -88,13 +89,13 @@ void thread__delete(struct thread *thread)
 struct thread *thread__get(struct thread *thread)
 {
 	if (thread)
-		atomic_inc(&thread->refcnt);
+		refcnt__get(thread, refcnt);
 	return thread;
 }
 
 void thread__put(struct thread *thread)
 {
-	if (thread && atomic_dec_and_test(&thread->refcnt)) {
+	if (thread && refcnt__put(thread, refcnt)) {
 		list_del_init(&thread->node);
 		thread__delete(thread);
 	}
