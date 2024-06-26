Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51F16CD1F;
	Wed, 26 Jun 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393430; cv=none; b=Wl6fF3kiAuq14gAi5I8sVCGrhxpadb5M3J0EDxIlP8KruKJhtbPEaf3Cnoxnc0KQv8lWDeLr6Uodj9ZSgye61MMprLN4kjcYC8O826E24PW0aHLiJA+qZSarvrRsddfG14rzzGvrfOWR470GbDpqfsv8YUrAfkCds2/VL3gmGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393430; c=relaxed/simple;
	bh=pxU8wxwEchZg4usm9UkgJxhSfItDyauTPdyaxRAxViE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PigcqNDVUSzgP2nbQOsawk9JdTkLTM2bnoQa//weqMCsVM+/E20p3g3Ju30ktcjONyitIpRa9EcjGxw6kimzJJei4nblXkjmY+KXkEowj2x01mecZnh50z0UcZlJF6tYVKB7S1MYd8Mp8aT2aNXU4KNG+mKU2zQqyWnNh9fHNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sf8fPtCs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sf8fPtCs"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8ur27017759;
	Wed, 26 Jun 2024 09:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=VGQ+NVZnPbtDn
	Sezx+FmAuKkRAciQsN6HL8sSUrN0zM=; b=Sf8fPtCsPMmVhhfOpCx6TRIuuB6sx
	2clOealZMqvotwhsszRg7l1ZgJIkRVZuGQWRqBOCMlbk+IzRj2n/cIgOmvM8I1KC
	H6/MCamUkcygbVKhefrw1A96T5NMI9FnfNxarGHX2n/GHItv4Eq4tgqZ3VSeU8iK
	iRqXw/PG0GwS/0g04LMuaniWEEnku4kkT51AwaKjo4g2fqv85jQeY5pLPKslYxlc
	8BaYPcqltxqxt2ODOSjHw7Ltk1P1R1rlEWkx0oUTaUls+dIdF7Cg7nYtBlByASVC
	Q9GQQPtp807C5akziJASczBe5p4iV5a5vhykzfqn5r7maFFmVeYSYWbKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400e6frb9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:58 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q9DCFm011618;
	Wed, 26 Jun 2024 09:16:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400e6frb9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q8MXQN018096;
	Wed, 26 Jun 2024 09:16:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xubkx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:16:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45Q9GrA950201000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 09:16:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F9902005A;
	Wed, 26 Jun 2024 09:16:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C9B82004E;
	Wed, 26 Jun 2024 09:16:46 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.51.102])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 09:16:46 +0000 (GMT)
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
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v5 2/3] perf sched map: Add support for multiple task names using CSV
Date: Wed, 26 Jun 2024 14:45:49 +0530
Message-ID: <20240626091550.46707-3-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240626091550.46707-1-vineethr@linux.ibm.com>
References: <20240626091550.46707-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -l80oSjXWfHLwiI0ryA9Fu4h-GjQF6dp
X-Proofpoint-GUID: Mz-WoBvURYLuPR6VM1yTGBB8Z1fHgCoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260067

To track the scheduling patterns of multiple tasks simultaneously,
multiple task names can be specified using a comma separator
without any whitespace.

Sample output for --task-name perf,wdavdaemon
=============
 .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
 .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
 -  *-   -   -   -   -   -   -   131040.641379 secs
*C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283

...

 -  *-   -   -   -   -   -   -   131041.395649 secs
 .   .   .   .   .   .   .  *X2  131041.403969 secs X2 => perf:70211
 -   -   -   -   -   -   -  *-   131041.404006 secs

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |  5 +-
 tools/perf/builtin-sched.c              | 77 +++++++++++++++++++++----
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 3255e5b8e74b..3095e280eb92 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -131,9 +131,10 @@ OPTIONS for 'perf sched map'
 	Highlight the given pids.
 
 --task-name <task>::
-	Map output only for the given task name. The sched-out
+	Map output only for the given task name(s). Separate the
+	task names with a comma (without whitespace). The sched-out
 	time is printed and is represented by '*-' for the given
-	task name
+	task name(s).
 	('-' indicates other tasks while '.' is idle).
 
 OPTIONS for 'perf sched timehist'
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 57f166662d54..ecb43deb9d74 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1540,24 +1540,72 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
-static bool sched_match_task(const char *comm_str, const char *commands)
+struct CommandList {
+	char **command_list;
+	int command_count;
+};
+
+static void free_command_list(struct CommandList *cmd_list)
+{
+	if (cmd_list) {
+		for (int i = 0; i < cmd_list->command_count; i++)
+			free(cmd_list->command_list[i]);
+		free(cmd_list->command_list);
+		free(cmd_list);
+	}
+}
+
+static struct CommandList *parse_commands(const char *commands)
 {
 	char *commands_copy = NULL;
+	struct CommandList *cmd_list = NULL;
 	char *token = NULL;
-	bool match_found = false;
 
 	commands_copy = strdup(commands);
 	if (commands_copy == NULL)
 		return NULL;
 
+	cmd_list = malloc(sizeof(struct CommandList));
+	if (cmd_list == NULL) {
+		free(commands_copy);
+		return NULL;
+	}
+
+	cmd_list->command_count = 0;
+	cmd_list->command_list = NULL;
+
 	token = strtok(commands_copy, ",");
+	while (token != NULL) {
+		cmd_list->command_list = realloc(cmd_list->command_list, sizeof(char *)
+							*(cmd_list->command_count + 1));
+		if (cmd_list->command_list == NULL) {
+			free_command_list(cmd_list);
+			free(commands_copy);
+			return NULL;
+		}
 
-	while (token != NULL && !match_found) {
-		match_found = !strcmp(comm_str, token);
+		cmd_list->command_list[cmd_list->command_count] = strdup(token);
+		if (cmd_list->command_list[cmd_list->command_count] == NULL) {
+			free_command_list(cmd_list);
+			free(commands_copy);
+			return NULL;
+		}
+
+		cmd_list->command_count++;
 		token = strtok(NULL, ",");
 	}
 
 	free(commands_copy);
+	return cmd_list;
+}
+
+static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
+{
+	bool match_found = false;
+
+	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
+		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
+
 	return match_found;
 }
 
@@ -1624,6 +1672,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	char stimestamp[32];
 	const char *str;
 
+	struct CommandList *cmd_list = NULL;
+
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
 	if (this_cpu.cpu > sched->max_cpu.cpu)
@@ -1664,7 +1714,11 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 	sched->curr_out_thread[this_cpu.cpu] = thread__get(sched_out);
 
+	if (sched->map.task_name)
+		cmd_list = parse_commands(sched->map.task_name);
+
 	new_shortname = 0;
+	str = thread__comm_str(sched_in);
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
 			/*
@@ -1673,8 +1727,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else if (!sched->map.task_name || sched_match_task(thread__comm_str(sched_in),
-								sched->map.task_name)) {
+		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1703,15 +1756,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	 * Check which of sched_in and sched_out matches the passed --task-name
 	 * arguments and call the corresponding print_sched_map.
 	 */
-	if (sched->map.task_name && !sched_match_task(str, sched->map.task_name)) {
-		if (!sched_match_task(thread__comm_str(sched_out), sched->map.task_name))
+	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
+		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
 			goto out;
 		else
 			goto sched_out;
 
 	} else {
 		str = thread__comm_str(sched_out);
-		if (!(sched->map.task_name && !sched_match_task(str, sched->map.task_name)))
+		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
 			proceed = 1;
 	}
 
@@ -1758,8 +1811,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	color_fprintf(stdout, color, "\n");
 
 out:
-	if (sched->map.task_name)
+	if (sched->map.task_name) {
+		free_command_list(cmd_list);
 		thread__put(sched_out);
+	}
 
 	thread__put(sched_in);
 
@@ -3651,7 +3706,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
 	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
-		"map output only for the given task name"),
+		"map output only for the given task name(s)."),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
-- 
2.43.2

