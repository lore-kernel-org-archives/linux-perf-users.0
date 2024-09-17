Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D215748F;
	Tue, 17 Sep 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564574; cv=none; b=C2oLIjs0aB/cqOMa7tKFc4gd9IplaXU2lHK1eZKsR2OUX0F0LNfKVTqTblIj9dNcvOHb4EL7YFGFwnSaawi4KzvC2DrmeUEFqPOBqrgTlsBj5wNDKvUYjJQcWRHDAGNclbXDEyVTT7AsxxvwjDvDuUW+PDabtxrY7pHYwPRI3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564574; c=relaxed/simple;
	bh=ac4/d29mS5O/62gmPzpLeoP9PsaOyE+5JvasKxndmF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNRL66Encrm5d4BfgqhS+L+BYKGGNro7XO+sxJ685R61ZdNKTuW/bvNc64AC/bk1jXJAPAJFxSVPs+jTGDsNZiI8GEc/iWDVflsWcl3kH2a2CaUMK/01p6Pu24g7Y+awTeZhcLbQs2uf28iSPMoZjqpYApnIr5lrayYsQc8Gjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QXzavk42; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXzavk42"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIVDN4023504;
	Tue, 17 Sep 2024 09:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=h3m6jqNZBK6B3p7NN/Fy8H/mok
	WiNS8OHbW7LVLFg7Q=; b=QXzavk42JCY1MkAQQRx7GTuVHTihVdEiDWI2BB9NEz
	v5bxpqTCspS0Oy9X8plIxZSCyLKDv7j0FvzySdl1XsCcMcTcjR9FUcDkkfd3lJx9
	kq4DAR2Qj4Nbqvbzp3gKa63Mx7NmFdE8qPtpWhff/z7RIISDkhS6iaL7oYEuj2VT
	fws9T8MU/WBhIEOLTWIRnCioHhCBsE+8Dkx2JnryLw3YBlduYoOj/rgEfWG2lh/u
	RHKapD97Trwb4bv30tRij2li7B4DRNkg+F0xndcJaqfsXqy3Vh5nansgguedGU00
	mJ5ZtqxqvE74oCkDoN1bGPeLA8eBIiIoaSyZ3mmr9cAQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud75f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:15:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H9FlYs000433;
	Tue, 17 Sep 2024 09:15:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud75f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:15:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H7YOPm001821;
	Tue, 17 Sep 2024 09:15:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3kwju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:15:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H9FiCD59703798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 09:15:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532802004B;
	Tue, 17 Sep 2024 09:15:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D14FF2004D;
	Tue, 17 Sep 2024 09:15:40 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.206.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 09:15:40 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH] perf sched timehist: Add pre-migration wait time option
Date: Tue, 17 Sep 2024 14:45:37 +0530
Message-ID: <20240917091537.46684-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WQeybCeEutxgCkcnvoZMB3a4ByB9eRqb
X-Proofpoint-ORIG-GUID: lE0v7Mp205RLPlsefKfD_eio9bMYFIJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170066

pre-migration wait time is the time that a task unnecessarily spends
on the runqueue of a CPU but doesn't get switched-in there. In terms
of tracepoints, it is the time between sched:sched_wakeup and
sched:sched_migrate_task.

Let's say a task woke up on CPU2, then it got migrated to CPU4 and
then it's switched-in to CPU4. So, here pre-migration wait time is
time that it was waiting on runqueue of CPU2 after it is woken up.

The general pattern for pre-migration to occur is:
sched:sched_wakeup
sched:sched_migrate_task
sched:sched_switch
So, this option expects sched_wakeup also to be recorded and fails
if attempted to use the option without sched:sched_wakeup tracepoint.

pre-migrations are generally not useful and it increases migrations.
This metric would be helpful in testing patches mainly related to wakeup
and load-balancer code paths as better wakeup logic would choose an
optimal CPU where task would be switched-in and thereby reducing pre-
migrations.

The sample output(s) when -P or --pre-migrations is used:
=================
           time    cpu  task name                       wait time  sch delay   run time  pre-mig time
                        [tid/pid]                          (msec)     (msec)     (msec)     (msec)
--------------- ------  ------------------------------  ---------  ---------  ---------  ---------
  103032.721020 [0000]  perf[47206]                         0.000      0.000      0.000      0.000
  103032.721034 [0000]  migration/0[18]                     0.000      0.003      0.013      0.000
  103032.736716 [0001]  schbench[47229/47207]              10.664      9.231      0.039      9.170
  103032.736719 [0005]  <idle>                              0.000      0.000     15.405      0.000
  103032.736726 [0003]  schbench[47216/47207]              11.251      9.193      0.022      9.126
  103032.736727 [0001]  schbench[47228/47207]              10.752      9.264      0.010      9.169
  103032.736731 [0007]  <idle>                              0.000      0.000     15.314      0.000
  103032.736739 [0008]  <idle>                              0.000      0.000     15.249      0.000
  103032.736742 [0003]  schbench[47257/47207]               9.498      9.184      0.015      9.100

   51370.894024 [0012]  schbench[38775/38770]              21.047     21.047      8.950      0.000
   51370.894024 [0008]  schbench[38781/38770]              39.597     39.448      9.984     39.437
   51370.894025 [0009]  stress-ng-cpu[38743]                7.971      7.971      9.997      0.000

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |   8 ++
 tools/perf/builtin-sched.c              | 110 +++++++++++++++++-------
 2 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 3db64954a267..7935499b88b0 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -221,6 +221,14 @@ OPTIONS for 'perf sched timehist'
 	priorities are specified with -: 120-129. A combination of both can also be
 	provided: 0,120-129.
 
+-P::
+--pre-migrations::
+	Show pre-migration wait time. pre-migration wait time is the time spent
+	by a task waiting on a runqueue but not getting the chance to run there
+	and is migrated to a different runqueue where it is finally run. This
+	time between migrate_task and sched_wakeup is the pre-migration wait
+	time. This option is valid only if sched_wakeup tracepoint is recorded.
+
 OPTIONS for 'perf sched replay'
 ------------------------------
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5981cc51abc8..252e71d83d82 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -228,6 +228,7 @@ struct perf_sched {
 	bool		show_wakeups;
 	bool		show_next;
 	bool		show_migrations;
+	bool		pre_migrations;
 	bool		show_state;
 	bool		show_prio;
 	u64		skipped_samples;
@@ -247,7 +248,10 @@ struct thread_runtime {
 	u64 dt_iowait;      /* time between CPU access by iowait (off cpu) */
 	u64 dt_preempt;     /* time between CPU access by preempt (off cpu) */
 	u64 dt_delay;       /* time between wakeup and sched-in */
+	u64 dt_pre_mig;     /* time between migration and wakeup */
 	u64 ready_to_run;   /* time of wakeup */
+	u64 woken;	    /* time when sched_wakeup tracepoint is hit */
+	u64 migrated;	    /* time when a thread is migrated */
 
 	struct stats run_stats;
 	u64 total_run_time;
@@ -255,6 +259,7 @@ struct thread_runtime {
 	u64 total_iowait_time;
 	u64 total_preempt_time;
 	u64 total_delay_time;
+	u64 total_pre_mig_time;
 
 	char last_state;
 
@@ -2083,14 +2088,15 @@ static void timehist_header(struct perf_sched *sched)
 		printf(" ");
 	}
 
-	if (sched->show_prio) {
-		printf(" %-*s  %-*s  %9s  %9s  %9s",
-		       comm_width, "task name", MAX_PRIO_STR_LEN, "prio",
-		       "wait time", "sch delay", "run time");
-	} else {
-		printf(" %-*s  %9s  %9s  %9s", comm_width,
-		       "task name", "wait time", "sch delay", "run time");
-	}
+	printf(" %-*s", comm_width, "task name");
+
+	if (sched->show_prio)
+		printf("  %-*s", MAX_PRIO_STR_LEN, "prio");
+
+	printf("  %9s  %9s  %9s", "wait time", "sch delay", "run time");
+
+	if (sched->pre_migrations)
+		printf("  %9s", "pre-mig time");
 
 	if (sched->show_state)
 		printf("  %s", "state");
@@ -2105,17 +2111,15 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %*s ", ncpus, "");
 
-	if (sched->show_prio) {
-		printf(" %-*s  %-*s  %9s  %9s  %9s",
-		       comm_width, "[tid/pid]", MAX_PRIO_STR_LEN, "",
-		       "(msec)", "(msec)", "(msec)");
-	} else {
-		printf(" %-*s  %9s  %9s  %9s", comm_width,
-		       "[tid/pid]", "(msec)", "(msec)", "(msec)");
-	}
+	printf(" %-*s", comm_width, "[tid/pid]");
 
-	if (sched->show_state)
-		printf("  %5s", "");
+	if (sched->show_prio)
+		printf("  %-*s", MAX_PRIO_STR_LEN, "");
+
+	printf("  %9s  %9s  %9s", "(msec)", "(msec)", "(msec)");
+
+	if (sched->pre_migrations)
+		printf("  %9s", "(msec)");
 
 	printf("\n");
 
@@ -2127,15 +2131,15 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %.*s ", ncpus, graph_dotted_line);
 
-	if (sched->show_prio) {
-		printf(" %.*s  %.*s  %.9s  %.9s  %.9s",
-		       comm_width, graph_dotted_line, MAX_PRIO_STR_LEN, graph_dotted_line,
-		       graph_dotted_line, graph_dotted_line, graph_dotted_line);
-	} else {
-		printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
-		       graph_dotted_line, graph_dotted_line, graph_dotted_line,
-		       graph_dotted_line);
-	}
+	printf(" %.*s", comm_width, graph_dotted_line);
+
+	if (sched->show_prio)
+		printf("  %.*s", MAX_PRIO_STR_LEN, graph_dotted_line);
+
+	printf("  %.9s  %.9s  %.9s", graph_dotted_line, graph_dotted_line, graph_dotted_line);
+
+	if (sched->pre_migrations)
+		printf("  %.9s", graph_dotted_line);
 
 	if (sched->show_state)
 		printf("  %.5s", graph_dotted_line);
@@ -2190,6 +2194,8 @@ static void timehist_print_sample(struct perf_sched *sched,
 
 	print_sched_time(tr->dt_delay, 6);
 	print_sched_time(tr->dt_run, 6);
+	if (sched->pre_migrations)
+		print_sched_time(tr->dt_pre_mig, 6);
 
 	if (sched->show_state)
 		printf(" %5c ", thread__tid(thread) == 0 ? 'I' : state);
@@ -2249,6 +2255,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 	r->dt_iowait  = 0;
 	r->dt_preempt = 0;
 	r->dt_run     = 0;
+	r->dt_pre_mig = 0;
 
 	if (tprev) {
 		r->dt_run = t - tprev;
@@ -2257,6 +2264,11 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 				pr_debug("time travel: wakeup time for task > previous sched_switch event\n");
 			else
 				r->dt_delay = tprev - r->ready_to_run;
+
+			if (r->woken && r->migrated) {
+				if ((r->migrated > r->woken) && (r->migrated < tprev))
+					r->dt_pre_mig = r->migrated - r->woken;
+			}
 		}
 
 		if (r->last_time > tprev)
@@ -2280,6 +2292,7 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 	r->total_sleep_time   += r->dt_sleep;
 	r->total_iowait_time  += r->dt_iowait;
 	r->total_preempt_time += r->dt_preempt;
+	r->total_pre_mig_time += r->dt_pre_mig;
 }
 
 static bool is_idle_sample(struct perf_sample *sample,
@@ -2579,12 +2592,27 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 	printf("\n");
 }
 
-static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
+static int timehist_sched_wakeup_consider(const struct perf_tool *tool __maybe_unused,
 					union perf_event *event __maybe_unused,
 					struct evsel *evsel __maybe_unused,
 					struct perf_sample *sample __maybe_unused,
 					struct machine *machine __maybe_unused)
 {
+	struct thread *thread;
+	struct thread_runtime *tr = NULL;
+	const u32 pid = evsel__intval(evsel, sample, "pid");
+
+	thread = machine__findnew_thread(machine, 0, pid);
+	if (thread == NULL)
+		return -1;
+
+	tr = thread__get_runtime(thread);
+	if (tr == NULL)
+		return -1;
+
+	if (tr->woken == 0)
+		tr->woken = sample->time;
+
 	return 0;
 }
 
@@ -2694,8 +2722,14 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 
 	tr->migrations++;
 
+	if (tr->migrated == 0)
+		tr->migrated = sample->time;
+
 	/* show migrations if requested */
-	timehist_print_migration_event(sched, evsel, sample, machine, thread);
+	if (sched->show_migrations) {
+		timehist_print_migration_event(sched, evsel, sample,
+							machine, thread);
+	}
 
 	return 0;
 }
@@ -2846,11 +2880,14 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		/* last state is used to determine where to account wait time */
 		tr->last_state = state;
 
-		/* sched out event for task so reset ready to run time */
+		/* sched out event for task so reset ready to run time, woken and migrated time */
 		if (state == 'R')
 			tr->ready_to_run = t;
 		else
 			tr->ready_to_run = 0;
+
+		tr->woken = 0;
+		tr->migrated = 0;
 	}
 
 	evsel__save_time(evsel, sample->time, sample->cpu);
@@ -3278,7 +3315,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	/* prefer sched_waking if it is captured */
 	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
-		handlers[1].handler = timehist_sched_wakeup_ignore;
+		handlers[1].handler = timehist_sched_wakeup_consider;
 
 	/* setup per-evsel handlers */
 	if (perf_session__set_tracepoints_handlers(session, handlers))
@@ -3290,8 +3327,14 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		goto out;
 	}
 
-	if (sched->show_migrations &&
-	    perf_session__set_tracepoints_handlers(session, migrate_handlers))
+	if (sched->pre_migrations && !evlist__find_tracepoint_by_name(session->evlist,
+									"sched:sched_wakeup")) {
+		pr_err("No sched_wakeup events found. sched_wakeup tracepoint is mandatory for -P option\n");
+		goto out;
+	}
+
+	if ((sched->show_migrations || sched->pre_migrations) &&
+		(perf_session__set_tracepoints_handlers(session, migrate_handlers)))
 		goto out;
 
 	/* pre-allocate struct for per-CPU idle stats */
@@ -3833,6 +3876,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
 	OPT_STRING(0, "prio", &sched.prio_str, "prio",
 		   "analyze events only for given task priority(ies)"),
+	OPT_BOOLEAN('P', "pre-migrations", &sched.pre_migrations, "Show pre-migration wait time"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.43.1

