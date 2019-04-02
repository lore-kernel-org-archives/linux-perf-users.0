From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/44] tools lib traceevent: Removed unneeded !! and return parenthesis
Date: Tue,  2 Apr 2019 13:05:23 -0300
Message-ID: <20190402160549.13544-19-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As return is not a function we do not need parenthesis around the return
value. Also, a function returning bool does not need to add !!.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: http://lkml.kernel.org/r/20190401164343.817886725@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 2ac8b44854ce..002b3f73862b 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -88,7 +88,7 @@ void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag)
 bool tep_test_flag(struct tep_handle *tep, enum tep_flag flag)
 {
 	if (tep)
-		return (tep->flags & flag);
+		return tep->flags & flag;
 	return false;
 }
 
@@ -340,7 +340,7 @@ void tep_set_latency_format(struct tep_handle *pevent, int lat)
 bool tep_is_old_format(struct tep_handle *tep)
 {
 	if (tep)
-		return !!(tep->old_format);
+		return tep->old_format;
 	return false;
 }
 
-- 
2.20.1
