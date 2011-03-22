From: Arun Sharma <asharma@fb.com>
Subject: [PATCH] Teach perf script about PERF_TYPE_RAW
Date: Tue, 22 Mar 2011 15:49:53 -0700
Message-ID: <1300834193-9825-1-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <perfmon2-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=perfmon2-devel>
List-Post: <mailto:perfmon2-devel@lists.sourceforge.net>
List-Help: <mailto:perfmon2-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: perfmon2-devel-bounces@lists.sourceforge.net
To: acme@redhat.com
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, linux-perf-users@vger.kernel.org, Tom Zanussi <tzanussi@gmail.com>, Paul Mackerras <paulus@samba.org>, perfmon2-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Arun Sharma <asharma@fb.com>
List-Id: linux-perf-users.vger.kernel.org

Useful for getting stack traces for hardware events not handled
by PERF_TYPE_HARDWARE.

Signed-off-by: Arun Sharma <asharma@fb.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: perfmon2-devel@lists.sourceforge.net
---
 tools/perf/builtin-script.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9f5fc54..97c66df 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -61,6 +61,10 @@ static u64 output_fields[PERF_TYPE_MAX] = {
 	[PERF_TYPE_TRACEPOINT] = PERF_OUTPUT_COMM | PERF_OUTPUT_TID | \
 				 PERF_OUTPUT_CPU | PERF_OUTPUT_TIME | \
 				 PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE,
+
+	[PERF_TYPE_RAW] = PERF_OUTPUT_COMM | PERF_OUTPUT_TID | \
+			  PERF_OUTPUT_CPU | PERF_OUTPUT_TIME | \
+			  PERF_OUTPUT_EVNAME | PERF_OUTPUT_SYM,
 };
 
 static bool output_set_by_user;
@@ -481,6 +485,8 @@ static int parse_output_fields(const struct option *opt __used,
 		type = PERF_TYPE_SOFTWARE;
 	else if (!strcmp(tok, "trace"))
 		type = PERF_TYPE_TRACEPOINT;
+	else if (!strcmp(tok, "raw"))
+		type = PERF_TYPE_RAW;
 	else {
 		fprintf(stderr, "Invalid event type in field string.");
 		return -EINVAL;
@@ -836,7 +842,7 @@ static const struct option options[] = {
 	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
 		    "Look for files with symbols relative to this directory"),
 	OPT_CALLBACK('f', "fields", NULL, "str",
-		     "comma separated output fields prepend with 'type:'. Valid types: hw,sw,trace. Fields: comm,tid,pid,time,cpu,event,trace,sym",
+		     "comma separated output fields prepend with 'type:'. Valid types: hw,sw,trace,raw. Fields: comm,tid,pid,time,cpu,event,trace,sym",
 		     parse_output_fields),
 
 	OPT_END()
-- 
1.7.4


------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
