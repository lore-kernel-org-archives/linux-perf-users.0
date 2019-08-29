From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/37] tools lib traceevent: Do not free tep->cmdlines in add_new_comm() on failure
Date: Thu, 29 Aug 2019 11:39:16 -0300
Message-ID: <20190829143917.29745-37-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, linux-trace-devel@vger.kernel.org, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the re-allocation of tep->cmdlines succeeds, then the previous
allocation of tep->cmdlines will be freed. If we later fail in
add_new_comm(), we must not free cmdlines, and also should assign
tep->cmdlines to the new allocation. Otherwise when freeing tep, the
tep->cmdlines will be pointing to garbage.

Fixes: a6d2a61ac653a ("tools lib traceevent: Remove some die() calls")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190828191819.970121417@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index b36b536a9fcb..13fd9fdf91e0 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -269,10 +269,10 @@ static int add_new_comm(struct tep_handle *tep,
 		errno = ENOMEM;
 		return -1;
 	}
+	tep->cmdlines = cmdlines;
 
 	cmdlines[tep->cmdline_count].comm = strdup(comm);
 	if (!cmdlines[tep->cmdline_count].comm) {
-		free(cmdlines);
 		errno = ENOMEM;
 		return -1;
 	}
@@ -283,7 +283,6 @@ static int add_new_comm(struct tep_handle *tep,
 		tep->cmdline_count++;
 
 	qsort(cmdlines, tep->cmdline_count, sizeof(*cmdlines), cmdline_cmp);
-	tep->cmdlines = cmdlines;
 
 	return 0;
 }
-- 
2.21.0
