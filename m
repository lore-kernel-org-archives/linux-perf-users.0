Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE46F2E0;
	Sun,  7 Jul 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376881; cv=none; b=smI5g3D6QLsqYW4zb7hBeOrTsPk6FAu479khTARxUlV0Ph0A+oz8Icc3lL5NuYOhsEvXjtERTMz7dvS2NIlyQSsd/UiX06zjlEN3dkaojicVIhhB91jvYJnrnCvT/T0Q0SowSNrBcHk/SMLJuxV4t+AgtPKp5PkbiRL0U2pVLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376881; c=relaxed/simple;
	bh=xrZqfE+VzfsJ8lTDUY4Jksu9qaJNC7ML+0Y4LqG5zA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/CudayRhvZWTz8u8FdGu7e4vFxRVsmGurfYONaSUxeaORYkNMmmsmeQKxqQIIKVtSXt3Q8ajoI5o0QkPgBTPhr460kpoFNKdHRSzo1ltPXfOuKhVsKLIAo2qKVGzen9d5NOYV9V1Uxnc0+cGW2xX3CC3WnwucBv/K0zudKrkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0R/wzqe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0R/wzqe"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467HS7ok001313;
	Sun, 7 Jul 2024 18:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=xV9hzBck1v2Tq
	6mipDLtXnARx2JvTz33ArGktbMudUQ=; b=r0R/wzqemjou0XtfK7u0P30DhuI7R
	f1qm2k3E4Wh26DQAY3k6798gXer0tTwauqS4y1Qht1OJrxJhDmzREuViLBq8Oqac
	q7PZTXR4hextbVV1Omr5SHPnatzR7Ck3Y9UufkxLsGrwC4eB4jra9BszeYzZ8uy8
	L4NqGK5N2oVw0EwKq4nW6aFhlmRx4d8UKM36Jgs+NA4hzWPBtu5VSgoeCMEnrYOv
	O1C1Nf6KvPlzPRi6JQDbaNKuONkbMlgiFVhTQOOUkzM+gBlpL5zO+7gg7qQi8MYr
	1i73498IU735Z0KFc5+nSLKm9AFP2dhveLM0CnCty78+BgFCmG5GY1rRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6gfsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:49 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467IRnkB021654;
	Sun, 7 Jul 2024 18:27:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6gfsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467ELBM6013966;
	Sun, 7 Jul 2024 18:27:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407gn0bdbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467IRh9F43712888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 18:27:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D031120040;
	Sun,  7 Jul 2024 18:27:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 479BF20043;
	Sun,  7 Jul 2024 18:27:37 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.85.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 18:27:36 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v6 1/3] perf sched map: Add task-name option to filter the output map
Date: Sun,  7 Jul 2024 23:57:14 +0530
Message-ID: <20240707182716.22054-2-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240707182716.22054-1-vineethr@linux.ibm.com>
References: <20240707182716.22054-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W38uHy2soKBGqmO3T94pM8Mdej2zWjRj
X-Proofpoint-GUID: IDxry055LMNIOmBuYCIdF5_pO6HpAxDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407070151

By default, perf sched map prints sched-in events for all the tasks
which may not be required all the time as it prints lot of symbols
and rows to the terminal.

With --task-name option, one could specify the specific task name
for which the map has to be shown. This would help in analyzing the
CPU usage patterns easier for that specific task. Since multiple
PID's might have the same task name, using task-name filter
would be more useful for debugging.

For other tasks, instead of printing the symbol, '-' is printed and
the same '.' is used to represent idle. '-' is used instead of symbol
for other tasks because it helps in clear visualization of task
of interest and secondly the symbol itself doesn't mean anything
because the sched-in of that symbol will not be printed(first sched-in
contains pid and the corresponding symbol).

When using the --task-name option, the sched-out time is represented
by a '*-'. Since not all task sched-in events are printed, the sched-out
time of the relevant task might be lost. This representation ensures
that the sched-out time of the interested task is not overlooked.

6.10.0-rc1
==========
*A0                              131040.639793 secs A0 => migration/0:19
*.                               131040.639801 secs .  => swapper:0
 .  *B0                          131040.639830 secs B0 => migration/1:24
 .  *.                           131040.639836 secs
 .   .  *C0                      131040.640108 secs C0 => migration/2:30
 .   .  *.                       131040.640163 secs
 .   .   .  *D0                  131040.640386 secs D0 => migration/3:36
 .   .   .  *.                   131040.640395 secs

6.10.0-rc1 + patch (--task-name wdavdaemon)
=============
 .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
 .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
 -  *-   B0  .   .   .   -   .   131040.641379 secs
*C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
 C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
 C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
*-   .   B0  .   D0  .   E0  .   131040.641581 secs
 .   .   B0  .   D0  .  *-   .   131040.641583 secs

Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 147 ++++++++++++++++++------
 2 files changed, 117 insertions(+), 36 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index f0e5617f6652..964036c48ac4 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -130,6 +130,12 @@ OPTIONS for 'perf sched map'
 --color-pids::
 	Highlight the given pids.
 
+--task-name <task>::
+	Map output only for the given task name. The sched-out
+	time is printed and is represented by '*-' for the given
+	task name
+	('-' indicates other tasks while '.' is idle).
+
 OPTIONS for 'perf sched timehist'
 ---------------------------------
 -k::
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 24e9d83c7bb6..3ee3f7fd78b0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -156,6 +156,7 @@ struct perf_sched_map {
 	const char		*color_pids_str;
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
+	const char		*task_name;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -177,6 +178,7 @@ struct perf_sched {
 	struct perf_cpu	 max_cpu;
 	u32		 *curr_pid;
 	struct thread	 **curr_thread;
+	struct thread	 **curr_out_thread;
 	char		 next_shortname1;
 	char		 next_shortname2;
 	unsigned int	 replay_repeat;
@@ -1538,23 +1540,75 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
+static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu, int cpus_nr,
+								const char *color, bool sched_out)
+{
+	for (int i = 0; i < cpus_nr; i++) {
+		struct perf_cpu cpu = {
+			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
+		};
+		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
+		struct thread *curr_out_thread = sched->curr_out_thread[cpu.cpu];
+		struct thread_runtime *curr_tr;
+		const char *pid_color = color;
+		const char *cpu_color = color;
+		char symbol = ' ';
+		struct thread *thread_to_check = sched_out ? curr_out_thread : curr_thread;
+
+		if (thread_to_check && thread__has_color(thread_to_check))
+			pid_color = COLOR_PIDS;
+
+		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
+			cpu_color = COLOR_CPUS;
+
+		if (cpu.cpu == this_cpu.cpu)
+			symbol = '*';
+
+		color_fprintf(stdout, cpu.cpu != this_cpu.cpu ? color : cpu_color, "%c", symbol);
+
+		thread_to_check = sched_out ? sched->curr_out_thread[cpu.cpu] :
+								sched->curr_thread[cpu.cpu];
+
+		if (thread_to_check) {
+			curr_tr = thread__get_runtime(thread_to_check);
+			if (curr_tr == NULL)
+				return;
+
+			if (sched_out) {
+				if (cpu.cpu == this_cpu.cpu)
+					color_fprintf(stdout, color, "-  ");
+				else {
+					curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
+					if (curr_tr != NULL)
+						color_fprintf(stdout, pid_color, "%2s ",
+										curr_tr->shortname);
+				}
+			} else
+				color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
+		} else
+			color_fprintf(stdout, color, "   ");
+	}
+}
+
 static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine)
 {
 	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	struct thread *sched_in;
+	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
+	struct thread *sched_in, *sched_out;
 	struct thread_runtime *tr;
 	int new_shortname;
 	u64 timestamp0, timestamp = sample->time;
 	s64 delta;
-	int i;
 	struct perf_cpu this_cpu = {
 		.cpu = sample->cpu,
 	};
 	int cpus_nr;
+	int proceed;
 	bool new_cpu = false;
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
+	const char *str;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1583,7 +1637,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
-	if (sched_in == NULL)
+	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
+	if (sched_in == NULL || sched_out == NULL)
 		return -1;
 
 	tr = thread__get_runtime(sched_in);
@@ -1593,7 +1648,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
+	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
 
+	str = thread__comm_str(sched_in);
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
@@ -1603,7 +1660,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else {
+		} else if (!sched->map.task_name || !strcmp(str, sched->map.task_name)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1616,6 +1673,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 				else
 					sched->next_shortname2 = '0';
 			}
+		} else {
+			tr->shortname[0] = '-';
+			tr->shortname[1] = ' ';
 		}
 		new_shortname = 1;
 	}
@@ -1623,42 +1683,28 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
 		goto out;
 
-	printf("  ");
-
-	for (i = 0; i < cpus_nr; i++) {
-		struct perf_cpu cpu = {
-			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
-		};
-		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
-		struct thread_runtime *curr_tr;
-		const char *pid_color = color;
-		const char *cpu_color = color;
-
-		if (curr_thread && thread__has_color(curr_thread))
-			pid_color = COLOR_PIDS;
-
-		if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, cpu))
-			continue;
-
-		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
-			cpu_color = COLOR_CPUS;
-
-		if (cpu.cpu != this_cpu.cpu)
-			color_fprintf(stdout, color, " ");
+	proceed = 0;
+	str = thread__comm_str(sched_in);
+	/*
+	 * Check which of sched_in and sched_out matches the passed --task-name
+	 * arguments and call the corresponding print_sched_map.
+	 */
+	if (sched->map.task_name && strcmp(str, sched->map.task_name)) {
+		if (strcmp(thread__comm_str(sched_out), sched->map.task_name))
+			goto out;
 		else
-			color_fprintf(stdout, cpu_color, "*");
+			goto sched_out;
 
-		if (sched->curr_thread[cpu.cpu]) {
-			curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
-			if (curr_tr == NULL) {
-				thread__put(sched_in);
-				return -1;
-			}
-			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
-		} else
-			color_fprintf(stdout, color, "   ");
+	} else {
+		str = thread__comm_str(sched_out);
+		if (!(sched->map.task_name && strcmp(str, sched->map.task_name)))
+			proceed = 1;
 	}
 
+	printf("  ");
+
+	print_sched_map(sched, this_cpu, cpus_nr, color, false);
+
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
 	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
@@ -1675,9 +1721,32 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	if (sched->map.comp && new_cpu)
 		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
 
+	if (proceed != 1) {
+		color_fprintf(stdout, color, "\n");
+		goto out;
+	}
+
+sched_out:
+	if (sched->map.task_name) {
+		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
+		if (strcmp(tr->shortname, "") == 0)
+			goto out;
+
+		if (proceed == 1)
+			color_fprintf(stdout, color, "\n");
+
+		printf("  ");
+		print_sched_map(sched, this_cpu, cpus_nr, color, true);
+		timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
+		color_fprintf(stdout, color, "  %12s secs ", stimestamp);
+	}
+
 	color_fprintf(stdout, color, "\n");
 
 out:
+	if (sched->map.task_name)
+		thread__put(sched_out);
+
 	thread__put(sched_in);
 
 	return 0;
@@ -3310,6 +3379,10 @@ static int perf_sched__map(struct perf_sched *sched)
 	if (!sched->curr_thread)
 		return rc;
 
+	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
+	if (!sched->curr_out_thread)
+		return rc;
+
 	if (setup_cpus_switch_event(sched))
 		goto out_free_curr_thread;
 
@@ -3566,6 +3639,8 @@ int cmd_sched(int argc, const char **argv)
                     "highlight given CPUs in map"),
 	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
+	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
+		"map output only for the given task name"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
-- 
2.43.2

