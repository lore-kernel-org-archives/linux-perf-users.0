From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/31] perf script: Introduce --deltatime option
Date: Fri,  3 Apr 2020 11:54:18 -0300
Message-ID: <20200403145443.24774-7-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Hagen Paul Pfeifer <hagen@jauu.net>

For some kind of analysis a deltatime output is more human friendly and
reduce the cognitive load for further analysis.

The following output demonstrate the new option "deltatime": calculate
the time difference in relation to the previous event.

  $ perf script --deltatime
  test  2525 [001]     0.000000:            sdt_libev:ev_add: (5635e72a5ebd)
  test  2525 [001]     0.000091:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000051: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000685:            sdt_libev:ev_add: (5635e72a5ebd)
  test  2525 [001]     0.000048:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000104: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.003895:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.996034: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000058:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000004: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000064:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.999934: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000056:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.999930: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1

Committer testing:

So go from default output to --reltime and then this new --deltatime, to
contrast the various timestamp presentation modes for a random perf.data file I
had laying around:

  [root@five ~]# perf script --reltime | head
     perf 442394 [000]     0.000000:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000004:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000006:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000009: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000036:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000038:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000040:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000041:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000044: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]# perf script --deltatime | head
     perf 442394 [000]     0.000000:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000001:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000001:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000027:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000001:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000001:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000002: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]# perf script | head
     perf 442394 [000]  7600.157861:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157864:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157866:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157867:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157870: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157897:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157900:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157901:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157903:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157906: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]#

Andi suggested we better implement it as a new field, i.e. -F deltatime, like:

  [root@five ~]# perf script -F deltatime
  Invalid field requested.

   Usage: perf script [<options>]
      or: perf script [<options>] record <script> [<record-options>] <command>
      or: perf script [<options>] report <script> [script-args]
      or: perf script [<options>] <script> [<record-options>] <command>
      or: perf script [<options>] <top-script> [script-args]

      -F, --fields <str>    comma separated output fields prepend with 'type:'. +field to add and -field to remove.Valid types: hw,sw,trace,raw,synth. Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,addr,symoff,srcline,period,iregs,uregs,brstack,brstacksym,flags,bpf-output,brstackinsn,brstackoff,callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc
  [root@five ~]#

I.e. we have -F for maximum flexibility:

  [root@five ~]# perf script -F comm,pid,cpu,time | head
            perf 442394 [000]  7600.157861:
            perf 442394 [000]  7600.157864:
            perf 442394 [000]  7600.157866:
            perf 442394 [000]  7600.157867:
            perf 442394 [000]  7600.157870:
            perf 442394 [001]  7600.157897:
            perf 442394 [001]  7600.157900:
            perf 442394 [001]  7600.157901:
            perf 442394 [001]  7600.157903:
            perf 442394 [001]  7600.157906:
  [root@five ~]#

But since we already have --reltime, having --deltatime, documented one after
the other is sensible.

Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20200204173709.489161-1-hagen@jauu.net
[ Added 'perf script' man page entry for --deltatime ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index db6a36aac47e..4af255bb0977 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -390,6 +390,9 @@ include::itrace.txt[]
 --reltime::
 	Print time stamps relative to trace start.
 
+--deltatime::
+	Print time stamps relative to previous event.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 656b347f6dd8..f63869aef914 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,7 +63,9 @@
 static char const		*script_name;
 static char const		*generate_script_lang;
 static bool			reltime;
+static bool			deltatime;
 static u64			initial_time;
+static u64			previous_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -704,6 +706,13 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			if (!initial_time)
 				initial_time = sample->time;
 			t = sample->time - initial_time;
+		} else if (deltatime) {
+			if (previous_time)
+				t = sample->time - previous_time;
+			else {
+				t = 0;
+			}
+			previous_time = sample->time;
 		}
 		nsecs = t;
 		secs = nsecs / NSEC_PER_SEC;
@@ -3555,6 +3564,7 @@ int cmd_script(int argc, const char **argv)
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
 	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
+	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3651,6 +3661,13 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (reltime && deltatime) {
+		fprintf(stderr,
+			"reltime and deltatime - the two don't get along well. "
+			"Please limit to --reltime or --deltatime.\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
-- 
2.21.1
