Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6B2F32;
	Mon, 17 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628634; cv=none; b=TCyGeoDc7ebriA7qUNuJ6p6Uus+ScvrigDUQkWlPwZHTuIE7tQ0kE3Wtkigj9tavWIjyE5a8WubmaJmt5wbYZS4Xzn+Gc2tQtZejg2nIVpnZii8H7xIsShhNS7vAVMvXdkKXrNKT4qlLqy88Un3im/eIudQEZ266gNjFezypwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628634; c=relaxed/simple;
	bh=/tJncBPrUMMdoB7Mi9Pkhwvbt2NsKviQBpENQRar2Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhWvf3qRTq1vA4gsLPsITjv6ss6RgwmMkmrnX2Ma3vXtHEUmRiDiLswYex770IYEAsaaA+bW4DV3TmJKwlWAchfk1f4tE5loXH28LyWCq4IriQWc3yPg6CwY4PrlO90ypMp9f30Bc8UDD8+I8lFepzRf/WTj7H3QV1pH79EiCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U3AjC5H6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U3AjC5H6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCQ7I3017527;
	Mon, 17 Jun 2024 12:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=aEOPLv/jIj0l/dUGxzkoSVsI+d7ebJ2yvfngY0r
	WDzU=; b=U3AjC5H6LSXVfvFe90dM9ScuOV5H4DrZt66ve61XbeBaPMk1TeZ8X8+
	EhgyEyFJv20njCkDCX1pi+Y1wGvWX41j8MpJV3poZCQWp3t24GMyatFyCbZSF8TB
	03QNheHfSs0wgf60rE7OdZzEjsl7SdMzDDmojSJha+4OkOaOFVX7Wv9ZQArVqNFu
	Q+iYb62+vn1HAE6FGcFZaTVTIFHIVS/WaaT/PA16sbu0erj0KGac92HvzE82FDRt
	7bUs9/7oC0YbXsv/N8nt2KqqCUd+KFf4HJzReQwfxSXx1kybmjmuC1tZ2z7bj/8f
	At3lhoLsl1rE+gVQFVsXsMhwUwZJiEg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkwq88rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 12:50:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HCoHic022287;
	Mon, 17 Jun 2024 12:50:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytkwq88r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 12:50:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HBIN9T019519;
	Mon, 17 Jun 2024 12:50:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0taf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 12:50:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HCoBk344958140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 12:50:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E002005A;
	Mon, 17 Jun 2024 12:50:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9762B20063;
	Mon, 17 Jun 2024 12:50:08 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.206.228])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 12:50:08 +0000 (GMT)
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
Subject: [PATCH v3] perf sched map: Add command-name, fuzzy-name options to filter the output map
Date: Mon, 17 Jun 2024 18:19:30 +0530
Message-ID: <20240617125006.31654-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3fHBlepNu3EcsSVHACvcTWv-JbAKcss8
X-Proofpoint-ORIG-GUID: Y0xqvmnCJsPXozyEW9T398-dyR2ewI4-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_10,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170096

By default, perf sched map prints sched-in events for all the tasks
which may not be required all the time as it prints lot of symbols
and rows to the terminal.

With --command-name option, one could specify the specific command(s)
for which the map has to be shown. This would help in analyzing the
CPU usage patterns easier for that specific command(s). Since multiple
PID's might have the same command name, using command-name filter
would be more useful for debugging.

Multiple command names can be given with a comma separator without
whitespace.

The --fuzzy-name option can be used if fuzzy name matching is required.
For example, "taskname" can be matched to any string that contains
"taskname" as its substring.

For other tasks, instead of printing the symbol, ** is printed and
the same . is used to represent idle. ** is used instead of symbol
for other tasks because it helps in clear visualization of command(s)
of interest and secondly the symbol itself doesn't mean anything
because the sched-in of that symbol will not be printed(first sched-in
contains pid and the corresponding symbol).

When using the --command-name option, the sched-out time is represented
by a '+'. Since not all task sched-in events are printed, the sched-out
time of the relevant commands might be lost. This representation ensures
that the sched-out time of the interested commands is not overlooked.
The sched-out values for non-current CPUs are skipped because the sched-out
symbol would be irrelevant.

6.10.0-rc1
==========
*A0                     794225.687532 secs A0 => migration/0:18
  *.                    794225.687544 secs .  => swapper:0
   .  *B0               794225.687628 secs B0 => migration/1:21
   .  *.                794225.687639 secs
   .   .  *C0           794225.687704 secs C0 => migration/2:26
   .   .  *.            794225.687715 secs
  *D0  .   .            794225.687829 secs D0 => perf-exec:332914
   D0  .   .  *.        794225.687926 secs
   D0  .   .  *E0       794225.689369 secs E0 => schbench:332916
   D0  .  *F0  E0       794225.689409 secs F0 => schbench:332917

6.10.0-rc1 + patch (--command-name perf)
=============
   ** *A0  **  **       794226.581112 secs A0 => perf:332915
      +A0               794226.581145 secs
   ** *A0  **  **       794227.582150 secs
      +A0               794227.582162 secs
   ** *A0  .   .        794228.583167 secs
      +A0               794228.583177 secs
   ** *A0  **  **       794229.634027 secs
      +A0               794229.634040 secs
   ** *A0  .   **       794230.635045 secs
      +A0               794230.635058 secs
   **  **  ** *B0       794231.204272 secs B0 => perf:332912
              +B0       794231.204352 secs

This helps in visualizing how a benchmark or a task is spread over
the available cpus while also knowing which cpus are idle(.) and which
are not(**). This will be more useful as number of CPUs increase.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>

---
Changes in v3:
- Print the sched-out timestamp as a row when using the --command-name
  option. (Namhyung Kim)
- Refactor the code.
- Rebase against perf-tools-next commit eae7044b67a6 ("perf hist: Honor
  symbol conf.skip_empty")
- Link to v2: https://lore.kernel.org/lkml/20240608124915.33860-1-vineethr@linux.ibm.com/

Changes in v2:
- Add support for giving multiple command-names in CSV. (Namhyung Kim)
- Add fuzzy name matching option. (Chen Yu)
- Add Reviewed-and-tested-by tag from Athira Rajeev.
- Rebase against perf-tools-next commit d2307fd4f989 ("perf maps: Add/use
  a sorted insert for fixup overlap and insert")
- Link to v1: https://lore.kernel.org/lkml/20240417152521.80340-1-vineethr@linux.ibm.com/
---
 tools/perf/Documentation/perf-sched.txt |  10 ++
 tools/perf/builtin-sched.c              | 205 +++++++++++++++++++-----
 2 files changed, 178 insertions(+), 37 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a216d2991b19..28637d097ddb 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -130,6 +130,16 @@ OPTIONS for 'perf sched map'
 --color-pids::
 	Highlight the given pids.
 
+--command-name::
+	Map output only for the given command name(s). Separate the
+	command names with a comma (without whitespace). The sched-out
+	time is printed and is represented by '+' for the given command
+	name(s).
+	(** indicates other tasks while . is idle).
+
+--fuzzy-name::
+	Given command name can be partially matched (fuzzy matching).
+
 OPTIONS for 'perf sched timehist'
 ---------------------------------
 -k::
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8cdf18139a7e..7fdd98a455ab 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -156,6 +156,8 @@ struct perf_sched_map {
 	const char		*color_pids_str;
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
+	const char              *command;
+	bool                    fuzzy;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -177,6 +179,7 @@ struct perf_sched {
 	struct perf_cpu	 max_cpu;
 	u32		 *curr_pid;
 	struct thread	 **curr_thread;
+	struct thread    **curr_out_thread;
 	char		 next_shortname1;
 	char		 next_shortname2;
 	unsigned int	 replay_repeat;
@@ -1538,23 +1541,125 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
+struct CommandList {
+	char **command_list;
+	int command_count;
+};
+
+static struct CommandList *parse_commands(const char *commands)
+{
+	char *commands_copy = strdup(commands);
+	char *token = strtok(commands_copy, ",");
+	struct CommandList *cmd_list = malloc(sizeof(struct CommandList));
+
+	if (cmd_list == NULL)
+		return NULL;
+
+	cmd_list->command_count = 0;
+	cmd_list->command_list = NULL;
+
+	while (token != NULL) {
+		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
+							*(cmd_list->command_count + 1));
+		cmd_list->command_list[cmd_list->command_count] = strdup(token);
+		cmd_list->command_count++;
+		token = strtok(NULL, ",");
+	}
+
+	free(commands_copy);
+	return cmd_list;
+}
+
+static void free_command_list(struct CommandList *cmd_list)
+{
+	for (int i = 0; i < cmd_list->command_count; i++)
+		free(cmd_list->command_list[i]);
+	free(cmd_list->command_list);
+	free(cmd_list);
+}
+
+static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list, bool fuzzy_match)
+{
+	bool match_found = false;
+
+	for (int i = 0; i < cmd_list->command_count && !match_found; i++) {
+		if (fuzzy_match)
+			match_found = !!strstr(comm_str, cmd_list->command_list[i]);
+		else
+			match_found = !strcmp(comm_str, cmd_list->command_list[i]);
+	}
+
+	return match_found;
+}
+
+static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu, int cpus_nr,
+								const char *color, bool sched_out)
+{
+	for (int i = 0; i < cpus_nr; i++) {
+		struct perf_cpu cpu = {
+		.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
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
+		if (cpu.cpu == this_cpu.cpu) {
+			if (sched_out)
+				symbol = '+';
+			else
+				symbol = '*';
+		}
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
+			if (sched_out && cpu.cpu != this_cpu.cpu)
+				color_fprintf(stdout, color, "   ");
+			else
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
+
+	struct CommandList *cmd_list = NULL;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1583,7 +1688,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	sched_in = map__findnew_thread(sched, machine, -1, next_pid);
-	if (sched_in == NULL)
+	sched_out = map__findnew_thread(sched, machine, -1, prev_pid);
+	if (sched_in == NULL || sched_out == NULL)
 		return -1;
 
 	tr = thread__get_runtime(sched_in);
@@ -1593,8 +1699,13 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
+	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
+
+	if (sched->map.command)
+		cmd_list = parse_commands(sched->map.command);
 
 	new_shortname = 0;
+	str = thread__comm_str(sched_in);
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
 			/*
@@ -1603,7 +1714,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else {
+		} else if (!sched->map.command || sched_match_task(str, cmd_list,
+								sched->map.fuzzy)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1616,6 +1728,9 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 				else
 					sched->next_shortname2 = '0';
 			}
+		} else {
+			tr->shortname[0] = '*';
+			tr->shortname[1] = '*';
 		}
 		new_shortname = 1;
 	}
@@ -1623,42 +1738,27 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
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
+	 * Check which of sched_in and sched_out matches the passed --command-line
+	 * arguments and call the corresponding print_sched_map.
+	 */
+	if (sched->map.command && !sched_match_task(str, cmd_list, sched->map.fuzzy)) {
+		if (!sched_match_task(thread__comm_str(sched_out), cmd_list, sched->map.fuzzy))
+			goto out;
 		else
-			color_fprintf(stdout, cpu_color, "*");
-
-		if (sched->curr_thread[cpu.cpu]) {
-			curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
-			if (curr_tr == NULL) {
-				thread__put(sched_in);
-				return -1;
-			}
-			color_fprintf(stdout, pid_color, "%2s ", curr_tr->shortname);
-		} else
-			color_fprintf(stdout, color, "   ");
+			goto sched_out;
+	} else {
+		str = thread__comm_str(sched_out);
+		if (!(sched->map.command && !sched_match_task(str, cmd_list, sched->map.fuzzy)))
+			proceed = 1;
 	}
 
+	printf("  ");
+
+	print_sched_map(sched, this_cpu, cpus_nr, color, false);
+
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
 	color_fprintf(stdout, color, "  %12s secs ", stimestamp);
 	if (new_shortname || tr->comm_changed || (verbose > 0 && thread__tid(sched_in))) {
@@ -1675,9 +1775,32 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	if (sched->map.comp && new_cpu)
 		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
 
+	if (proceed != 1) {
+		color_fprintf(stdout, color, "\n");
+		goto out;
+	}
+
+sched_out:
+	if (sched->map.command) {
+		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
+		if (strcmp(tr->shortname, "") == 0)
+			goto out;
+		if (proceed == 1)
+			color_fprintf(stdout, color, "\n");
+		printf("  ");
+		print_sched_map(sched, this_cpu, cpus_nr, color, true);
+		timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
+		color_fprintf(stdout, color, "  %12s secs ", stimestamp);
+	}
+
 	color_fprintf(stdout, color, "\n");
 
 out:
+	if (sched->map.command) {
+		free_command_list(cmd_list);
+		thread__put(sched_out);
+	}
+
 	thread__put(sched_in);
 
 	return 0;
@@ -3307,6 +3430,10 @@ static int perf_sched__map(struct perf_sched *sched)
 	if (!sched->curr_thread)
 		return rc;
 
+	sched->curr_out_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_out_thread)));
+	if (!sched->curr_out_thread)
+		return rc;
+
 	if (setup_cpus_switch_event(sched))
 		goto out_free_curr_thread;
 
@@ -3560,6 +3687,10 @@ int cmd_sched(int argc, const char **argv)
                     "highlight given CPUs in map"),
 	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
+	OPT_STRING(0, "command-name", &sched.map.command, "command",
+		"map output only for the given command name(s)"),
+	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
+		"given command name can be partially matched (fuzzy matching)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
-- 
2.43.2

