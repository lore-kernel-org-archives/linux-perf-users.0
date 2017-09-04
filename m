From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/13] perf trace: Support syscall name globbing
Date: Mon,  4 Sep 2017 11:00:34 -0300
Message-ID: <20170904140044.22912-4-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So now we can use:

  # perf trace -e pkey_*
   532.784 ( 0.006 ms): pkey/16018 pkey_alloc(init_val: DISABLE_WRITE) = -1 EINVAL Invalid argument
   532.795 ( 0.004 ms): pkey/16018 pkey_mprotect(start: 0x7f380d0a6000, len: 4096, prot: READ|WRITE, pkey: -1) = 0
   532.801 ( 0.002 ms): pkey/16018 pkey_free(pkey: -1                ) = -1 EINVAL Invalid argument
  ^C[root@jouet ~]#

Or '-e epoll*', '-e *msg*', etc.

Combining syscall names with perf events, tracepoints, etc, continues to
be valid, i.e. this is possible:

  # perf probe -L sys_nanosleep
  <SyS_nanosleep@/home/acme/git/linux/kernel/time/hrtimer.c:0>
      0  SYSCALL_DEFINE2(nanosleep, struct timespec __user *, rqtp,
                        struct timespec __user *, rmtp)
         {
                struct timespec64 tu;

      5         if (get_timespec64(&tu, rqtp))
      6                 return -EFAULT;

                if (!timespec64_valid(&tu))
      9                 return -EINVAL;

     11         current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
     12         current->restart_block.nanosleep.rmtp = rmtp;
     13         return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
         }

  # perf probe my_probe="sys_nanosleep:12 rmtp"
  Added new event:
    probe:my_probe       (on sys_nanosleep:12 with rmtp)

  You can now use it in all perf tools, such as:

	perf record -e probe:my_probe -aR sleep 1

  #
  # perf trace -e probe:my_probe/max-stack=5/,*sleep sleep 1
     0.427 ( 0.003 ms): sleep/16690 nanosleep(rqtp: 0x7ffefc245090) ...
     0.430 (         ): probe:my_probe:(ffffffffbd112923) rmtp=0)
                                       sys_nanosleep ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       return_from_SYSCALL_64 ([kernel.kallsyms])
                                       __nanosleep_nocancel (/usr/lib64/libc-2.25.so)
     0.427 (1000.208 ms): sleep/16690  ... [continued]: nanosleep()) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-elycoi8wy6y0w9dkj7ox1mzz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  2 +-
 tools/perf/builtin-trace.c              | 39 +++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index c1e3288a2dfb..d53bea6bd571 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -37,7 +37,7 @@ OPTIONS
 --expr::
 --event::
 	List of syscalls and other perf events (tracepoints, HW cache events,
-	etc) to show.
+	etc) to show. Globbing is supported, e.g.: "epoll_*", "*msg*", etc.
 	See 'perf list' for a complete list of events.
 	Prefixing with ! shows all syscalls but the ones specified.  You may
 	need to escape it.
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d59cdadf3a79..771ddab94bb0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1261,6 +1261,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0, i;
+	size_t nr_allocated;
 	struct str_node *pos;
 
 	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
@@ -1274,13 +1275,18 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		goto out;
 	}
 
+	nr_allocated = trace->ev_qualifier_ids.nr;
 	i = 0;
 
 	strlist__for_each_entry(pos, trace->ev_qualifier) {
 		const char *sc = pos->s;
-		int id = syscalltbl__id(trace->sctbl, sc);
+		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
 
 		if (id < 0) {
+			id = syscalltbl__strglobmatch_first(trace->sctbl, sc, &match_next);
+			if (id >= 0)
+				goto matches;
+
 			if (err == 0) {
 				fputs("Error:\tInvalid syscall ", trace->output);
 				err = -EINVAL;
@@ -1290,13 +1296,37 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 
 			fputs(sc, trace->output);
 		}
-
+matches:
 		trace->ev_qualifier_ids.entries[i++] = id;
+		if (match_next == -1)
+			continue;
+
+		while (1) {
+			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
+			if (id < 0)
+				break;
+			if (nr_allocated == trace->ev_qualifier_ids.nr) {
+				void *entries;
+
+				nr_allocated += 8;
+				entries = realloc(trace->ev_qualifier_ids.entries,
+						  nr_allocated * sizeof(trace->ev_qualifier_ids.entries[0]));
+				if (entries == NULL) {
+					err = -ENOMEM;
+					fputs("\nError:\t Not enough memory for parsing\n", trace->output);
+					goto out_free;
+				}
+				trace->ev_qualifier_ids.entries = entries;
+			}
+			trace->ev_qualifier_ids.nr++;
+			trace->ev_qualifier_ids.entries[i++] = id;
+		}
 	}
 
 	if (err < 0) {
 		fputs("\nHint:\ttry 'perf list syscalls:sys_enter_*'"
 		      "\nHint:\tand: 'man syscalls'\n", trace->output);
+out_free:
 		zfree(&trace->ev_qualifier_ids.entries);
 		trace->ev_qualifier_ids.nr = 0;
 	}
@@ -2814,7 +2844,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	struct trace *trace = (struct trace *)opt->value;
 	const char *s = str;
 	char *sep = NULL, *lists[2] = { NULL, NULL, };
-	int len = strlen(str) + 1, err = -1, list;
+	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
 
@@ -2831,7 +2861,8 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 			*sep = '\0';
 
 		list = 0;
-		if (syscalltbl__id(trace->sctbl, s) >= 0) {
+		if (syscalltbl__id(trace->sctbl, s) >= 0 ||
+		    syscalltbl__strglobmatch_first(trace->sctbl, s, &idx) >= 0) {
 			list = 1;
 		} else {
 			path__join(group_name, sizeof(group_name), strace_groups_dir, s);
-- 
2.13.5
