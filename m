Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225215E8B
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909439; cv=none; b=PgrfE15Lrcf1S2CmvJuPiMaNTc/rSpZ03uD1RW5SehN3oadcKI86I/HQl7C7DS5qFD7djl0mSI+NF1j9rVZ4NkaTB9xlOXtGyGMrj5uQzFty8SlYsWdzlAi+H/NJ4NMjHp9GfupeDDtUJ3vPsTcm/xj4atPWOHDcgKqAuFWIpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909439; c=relaxed/simple;
	bh=QsB/HuiAUP3j2oHu6k3JIQBeH864hahx2l563TFJlWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlfRilsJcjHrnpD5owad59gYr1/4rQV8DVwHrfD6sWET3btLf/IuNbw+wTTpQZaN59QDRrihoU+S+P18TrbznmGDsydLonFWHXoj79q+NAilQbP0vampLQbTnkRN3vE3FRKFH29+Wy7RGuTH8XM1xx3+1ZMz0ToiW+Qp83iEtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PuDQ7IVr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PuDQ7IVr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc47abc040so2178805ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722909437; x=1723514237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bL++MozDycDDEd1iq7Ueyfq5gI453oZc8tfgyfS30Lk=;
        b=PuDQ7IVrb15Ln5BVZ4Za2rZaSP1mYOP8U/drjGbaE6k2ygN6oaBBs5Ec+AGwXYx2yJ
         /rSHrGnfUQBjy5alu+f9Zbb3/sgbgxBAmlDYpRf+gr98qefOxJZ8lGy7HH+hb8dcoAQ7
         f1+l8ASvz8SqW88xJ2edSctJDTH7uJJH7Ga6kqQpgn+Kqgi3chX9RYzrmZnLJYQoffeN
         xKa/JzzBwro1QpoAxH2+VKM/I/u66rJWS/MYtSANc9kHfZ+/ia1DGZJaV193Fb7S+r5B
         ojpCOhlnQJw2Z+L8QvBdhxAzGZFBfWltQMLRLh20rWkINIeFYwaOQZssTCDvF8DNxGh4
         Whgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909437; x=1723514237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL++MozDycDDEd1iq7Ueyfq5gI453oZc8tfgyfS30Lk=;
        b=THin3plVuLg746EcqIzXAkCcXVbTvFlt3W7+fLmCplhYYqunpBIxiGQfpS37oPfifv
         oIGDXk8un7twOOgjDy+q934B3Y8+cTCMXC1kWp/i64P5DuYzufLKTJpXURFg8jA5iORl
         MPqDS2cS7NP2jnB8zFt1RK2HIEijWCPsT12y+7Lo1V5DiqZji228r4kW3nPt+Wu2K1/g
         GBlhjDeqoO4hbYNL3Bud2oOnAhS91C6ufbgm+5cfdO8Du3NKp0sc/0srDUadiAXCX3H7
         0TjgIdcdS+9EOF5BwrmLAci6USONDM/rNb7D7ZqOoKzO1SE7fdDyCzk+5pikvE3Kh0Lt
         oV9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1GLzPu6QRUDYAvyM1G/jDgrweKXz7D8tfrpSPUErsu8WRx1iRZU6nx9GjbJHS78BBVSKLZnMnqiUVwQmPQIYGYQ76ZNLRm35awvdqMD7YyQ==
X-Gm-Message-State: AOJu0Yw0/rASCOvOFgL9CzZ6ycIMOnJFc5ZQJIuCY8lu22f1Z3mImh6+
	zyE2swWXdN2YlK9KaxIgjA1ieGY6+uwjOX60S2etRNZUTzXoSzFtZFCtpqa9bDE=
X-Google-Smtp-Source: AGHT+IGk9l+mKPU79nm1kTs+l+wE9ukejKzQQgCpSX2eJ0o/dO9qjq6VkQtkaKgQdK63y3rejl8x5Q==
X-Received: by 2002:a17:902:d501:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-1ff574fd60dmr156153455ad.64.1722909436966;
        Mon, 05 Aug 2024 18:57:16 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917496fsm75509455ad.182.2024.08.05.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:57:16 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 1/2] perf sched timehist: Add --show-prio option
Date: Tue,  6 Aug 2024 09:57:00 +0800
Message-Id: <20240806015701.1309833-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806015701.1309833-1-yangjihong@bytedance.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --show-prio option is used to display the priority of task.
It is disabled by default, which is consistent with original behavior.

The display format is xxx (priority does not change during task running)
or xxx->yyy (priority changes during task running)

Testcase:

  # perf sched record nice -n 9 true
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.497 MB perf.data ]

  # perf sched timehist -h

   Usage: perf sched timehist [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -g, --call-graph      Display call chains if present (default on)
      -I, --idle-hist       Show idle events only
      -i, --input <file>    input file name
      -k, --vmlinux <file>  vmlinux pathname
      -M, --migrations      Show migration events
      -n, --next            Show next task
      -p, --pid <pid[,pid...]>
                            analyze events only for given process id(s)
      -s, --summary         Show only syscall summary with statistics
      -S, --with-summary    Show all syscalls and summary with statistics
      -t, --tid <tid[,tid...]>
                            analyze events only for given thread id(s)
      -V, --cpu-visual      Add CPU visual
      -v, --verbose         be more verbose (show symbol address, etc)
      -w, --wakeups         Show wakeup events
          --kallsyms <file>
                            kallsyms pathname
          --max-stack <n>   Maximum number of functions to display backtrace.
          --show-prio       Show task priority
          --state           Show task state when sched-out
          --symfs <directory>
                            Look for files with symbols relative to this directory
          --time <str>      Time span for analysis (start,stop)

  # perf sched timehist
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     23952.006537 [0000]  perf[534]                           0.000      0.000      0.000
     23952.006593 [0000]  migration/0[19]                     0.000      0.014      0.056
     23952.006899 [0001]  perf[534]                           0.000      0.000      0.000
     23952.006947 [0001]  migration/1[22]                     0.000      0.015      0.047
     23952.007138 [0002]  perf[534]                           0.000      0.000      0.000
  <SNIP>

  # perf sched timehist --show-prio
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       prio      wait time  sch delay   run time
                          [tid/pid]                                    (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  --------  ---------  ---------  ---------
     23952.006537 [0000]  perf[534]                       120           0.000      0.000      0.000
     23952.006593 [0000]  migration/0[19]                 0             0.000      0.014      0.056
     23952.006899 [0001]  perf[534]                       120           0.000      0.000      0.000
  <SNIP>
     23952.034843 [0003]  nice[535]                       120->129      0.189      0.024     23.314
  <SNIP>
     23952.053838 [0005]  rcu_preempt[16]                 120           3.993      0.000      0.023
     23952.053990 [0005]  <idle>                          120           0.023      0.023      0.152
     23952.054137 [0006]  <idle>                          120           1.427      1.427     17.855
     23952.054278 [0007]  <idle>                          120           0.506      0.506      1.650

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Documentation/perf-sched.txt |  3 +
 tools/perf/builtin-sched.c              | 91 +++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 84d49f9241b1..3efa5c58418d 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -212,6 +212,9 @@ OPTIONS for 'perf sched timehist'
 --state::
 	Show task state when it switched out.
 
+--show-prio::
+	Show task priority.
+
 OPTIONS for 'perf sched replay'
 ------------------------------
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..2af9dbdf4ba2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -228,6 +228,7 @@ struct perf_sched {
 	bool		show_next;
 	bool		show_migrations;
 	bool		show_state;
+	bool		show_prio;
 	u64		skipped_samples;
 	const char	*time_str;
 	struct perf_time_interval ptime;
@@ -258,6 +259,8 @@ struct thread_runtime {
 	bool comm_changed;
 
 	u64 migrations;
+
+	int prio;
 };
 
 /* per event run time data */
@@ -920,6 +923,11 @@ struct sort_dimension {
 	struct list_head	list;
 };
 
+static inline void init_prio(struct thread_runtime *r)
+{
+	r->prio = -1;
+}
+
 /*
  * handle runtime stats saved per thread
  */
@@ -932,6 +940,7 @@ static struct thread_runtime *thread__init_runtime(struct thread *thread)
 		return NULL;
 
 	init_stats(&r->run_stats);
+	init_prio(r);
 	thread__set_priv(thread, r);
 
 	return r;
@@ -2036,6 +2045,24 @@ static char *timehist_get_commstr(struct thread *thread)
 	return str;
 }
 
+/* prio field format: xxx or xxx->yyy */
+#define MAX_PRIO_STR_LEN 8
+static char *timehist_get_priostr(struct evsel *evsel,
+				  struct thread *thread,
+				  struct perf_sample *sample)
+{
+	static char prio_str[16];
+	int prev_prio = (int)evsel__intval(evsel, sample, "prev_prio");
+	struct thread_runtime *tr = thread__priv(thread);
+
+	if (tr->prio != prev_prio && tr->prio != -1)
+		scnprintf(prio_str, sizeof(prio_str), "%d->%d", tr->prio, prev_prio);
+	else
+		scnprintf(prio_str, sizeof(prio_str), "%d", prev_prio);
+
+	return prio_str;
+}
+
 static void timehist_header(struct perf_sched *sched)
 {
 	u32 ncpus = sched->max_cpu.cpu + 1;
@@ -2053,8 +2080,14 @@ static void timehist_header(struct perf_sched *sched)
 		printf(" ");
 	}
 
-	printf(" %-*s  %9s  %9s  %9s", comm_width,
-		"task name", "wait time", "sch delay", "run time");
+	if (sched->show_prio) {
+		printf(" %-*s  %-*s  %9s  %9s  %9s",
+		       comm_width, "task name", MAX_PRIO_STR_LEN, "prio",
+		       "wait time", "sch delay", "run time");
+	} else {
+		printf(" %-*s  %9s  %9s  %9s", comm_width,
+		       "task name", "wait time", "sch delay", "run time");
+	}
 
 	if (sched->show_state)
 		printf("  %s", "state");
@@ -2069,8 +2102,14 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %*s ", ncpus, "");
 
-	printf(" %-*s  %9s  %9s  %9s", comm_width,
-	       "[tid/pid]", "(msec)", "(msec)", "(msec)");
+	if (sched->show_prio) {
+		printf(" %-*s  %-*s  %9s  %9s  %9s",
+		       comm_width, "[tid/pid]", MAX_PRIO_STR_LEN, "",
+		       "(msec)", "(msec)", "(msec)");
+	} else {
+		printf(" %-*s  %9s  %9s  %9s", comm_width,
+		       "[tid/pid]", "(msec)", "(msec)", "(msec)");
+	}
 
 	if (sched->show_state)
 		printf("  %5s", "");
@@ -2085,9 +2124,15 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %.*s ", ncpus, graph_dotted_line);
 
-	printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
-		graph_dotted_line, graph_dotted_line, graph_dotted_line,
-		graph_dotted_line);
+	if (sched->show_prio) {
+		printf(" %.*s  %.*s  %.9s  %.9s  %.9s",
+		       comm_width, graph_dotted_line, MAX_PRIO_STR_LEN, graph_dotted_line,
+		       graph_dotted_line, graph_dotted_line, graph_dotted_line);
+	} else {
+		printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
+		       graph_dotted_line, graph_dotted_line, graph_dotted_line,
+		       graph_dotted_line);
+	}
 
 	if (sched->show_state)
 		printf("  %.5s", graph_dotted_line);
@@ -2134,6 +2179,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
+	if (sched->show_prio)
+		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
+
 	wait_time = tr->dt_sleep + tr->dt_iowait + tr->dt_preempt;
 	print_sched_time(wait_time, 6);
 
@@ -2301,6 +2349,7 @@ static int init_idle_thread(struct thread *thread)
 	if (itr == NULL)
 		return -ENOMEM;
 
+	init_prio(&itr->tr);
 	init_stats(&itr->tr.run_stats);
 	callchain_init(&itr->callchain);
 	callchain_cursor_reset(&itr->cursor);
@@ -2627,6 +2676,30 @@ static int timehist_migrate_task_event(struct perf_tool *tool,
 	return 0;
 }
 
+static void timehist_update_task_prio(struct evsel *evsel,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	struct thread *thread;
+	struct thread_runtime *tr = NULL;
+	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u32 next_prio = evsel__intval(evsel, sample, "next_prio");
+
+	if (next_pid == 0)
+		thread = get_idle_thread(sample->cpu);
+	else
+		thread = machine__findnew_thread(machine, -1, next_pid);
+
+	if (thread == NULL)
+		return;
+
+	tr = thread__get_runtime(thread);
+	if (tr == NULL)
+		return;
+
+	tr->prio = next_prio;
+}
+
 static int timehist_sched_change_event(struct perf_tool *tool,
 				       union perf_event *event,
 				       struct evsel *evsel,
@@ -2650,6 +2723,9 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		goto out;
 	}
 
+	if (sched->show_prio)
+		timehist_update_task_prio(evsel, sample, machine);
+
 	thread = timehist_get_thread(sched, sample, machine, evsel);
 	if (thread == NULL) {
 		rc = -1;
@@ -3691,6 +3767,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.25.1

