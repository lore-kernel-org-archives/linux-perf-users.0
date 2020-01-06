From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/20] perf sched timehist: Add support for filtering on CPU
Date: Mon,  6 Jan 2020 13:06:49 -0300
Message-ID: <20200106160705.10899-5-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Allow user to limit output to one or more CPUs. Really helpful on
systems with a large number of cpus.

Committer testing:

  # perf sched record -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.765 MB perf.data (1412 samples) ]
  [root@quaco ~]# perf sched timehist | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802686 [0000]  perf[13086]                         0.000      0.000      0.000
     66307.802700 [0000]  migration/0[12]                     0.000      0.001      0.014
     66307.802766 [0001]  perf[13086]                         0.000      0.000      0.000
     66307.802774 [0001]  migration/1[15]                     0.000      0.001      0.007
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.802913 [0003]  perf[13086]                         0.000      0.000      0.000
  #
  # perf sched timehist --cpu 2 | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.964485 [0002]  <idle>                              0.000      0.000    161.635
     66307.964811 [0002]  CPU 0/KVM[3589/3561]                0.000      0.056      0.325
     66307.965477 [0002]  <idle>                              0.325      0.000      0.666
     66307.965553 [0002]  CPU 0/KVM[3589/3561]                0.666      0.024      0.076
     66307.966456 [0002]  <idle>                              0.076      0.000      0.903
  #

Signed-off-by: David Ahern <dsahern@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191204173925.66976-1-dsahern@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-sched.txt |  4 ++++
 tools/perf/builtin-sched.c              | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b887dd..5fbe42bd599b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
+-C=::
+--cpu=::
+	Only show events for the given CPU(s) (comma separated list).
+
 -p=::
 --pid=::
 	Only show events for given process ID (comma separated list).
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8a12d71364c3..82fcc2c15fe4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,9 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 
+static const char *cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 struct sched_atom;
 
 struct task_desc {
@@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 	char nstr[30];
 	u64 wait_time;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return;
+
 	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
 	printf("%15s [%04d] ", tstr, sample->cpu);
 
@@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (cpu_list) {
+		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
+		if (err < 0)
+			goto out;
+	}
+
 	evlist = session->evlist;
 
 	symbol__init(&session->header.env);
@@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given process id(s)"),
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.21.1
