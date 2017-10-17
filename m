From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: Fix crash on buildid-list with namespace
Date: Tue, 17 Oct 2017 22:29:00 +0900
Message-ID: <20171017132900.11043-1-namhyung@kernel.org>
References: <20171017120132.GA4204@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017120132.GA4204@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Thomas reported that perf buildid-list gets a segfault due to NULL
pointer when he ran it on a data with namespace events.  It was because
the buildid_id__mark_dso_hit_ops lacks the namespace event handler and
perf_too__fill_default() didn't set it.

  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000000000 in ?? ()
  Missing separate debuginfos, use: dnf debuginfo-install audit-libs-2.7.7-1.fc25.s390x bzip2-libs-1.0.6-21.fc25.s390x elfutils-libelf-0.169-1.fc25.s390x
  +elfutils-libs-0.169-1.fc25.s390x libcap-ng-0.7.8-1.fc25.s390x numactl-libs-2.0.11-2.ibm.fc25.s390x openssl-libs-1.1.0e-1.1.ibm.fc25.s390x perl-libs-5.24.1-386.fc25.s390x
  +python-libs-2.7.13-2.fc25.s390x slang-2.3.0-7.fc25.s390x xz-libs-5.2.3-2.fc25.s390x zlib-1.2.8-10.fc25.s390x
  (gdb) where
  #0  0x0000000000000000 in ?? ()
  #1  0x00000000010fad6a in machines__deliver_event (machines=<optimized out>, machines@entry=0x2c6fd18,
      evlist=<optimized out>, event=event@entry=0x3fffdf00470, sample=0x3ffffffe880, sample@entry=0x3ffffffe888,
      tool=tool@entry=0x1312968 <build_id.mark_dso_hit_ops>, file_offset=1136) at util/session.c:1287
  #2  0x00000000010fbf4e in perf_session__deliver_event (file_offset=1136, tool=0x1312968 <build_id.mark_dso_hit_ops>,
      sample=0x3ffffffe888, event=0x3fffdf00470, session=0x2c6fc30) at util/session.c:1340
  #3  perf_session__process_event (session=0x2c6fc30, session@entry=0x0, event=event@entry=0x3fffdf00470,
      file_offset=file_offset@entry=1136) at util/session.c:1522
  #4  0x00000000010fddde in __perf_session__process_events (file_size=11880, data_size=<optimized out>,
      data_offset=<optimized out>, session=0x0) at util/session.c:1899
  #5  perf_session__process_events (session=0x0, session@entry=0x2c6fc30) at util/session.c:1953
  #6  0x000000000103b2ac in perf_session__list_build_ids (with_hits=<optimized out>, force=<optimized out>)
      at builtin-buildid-list.c:83
  #7  cmd_buildid_list (argc=<optimized out>, argv=<optimized out>) at builtin-buildid-list.c:115
  #8  0x00000000010a026c in run_builtin (p=0x1311f78 <commands+24>, argc=argc@entry=2, argv=argv@entry=0x3fffffff3c0)
      at perf.c:296
  #9  0x000000000102bc00 in handle_internal_command (argv=<optimized out>, argc=2) at perf.c:348
  #10 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:392
  #11 main (argc=<optimized out>, argv=0x3fffffff3c0) at perf.c:536
  (gdb)

Fix it by adding a stub event handler for namespace event.

Reported-and-Tested-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a7ebd9fe8e40..76ab0709a20c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -374,6 +374,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->mmap2 = process_event_stub;
 	if (tool->comm == NULL)
 		tool->comm = process_event_stub;
+	if (tool->namespaces == NULL)
+		tool->namespaces = process_event_stub;
 	if (tool->fork == NULL)
 		tool->fork = process_event_stub;
 	if (tool->exit == NULL)
-- 
2.14.2
