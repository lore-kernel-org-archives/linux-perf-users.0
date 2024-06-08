Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A5182DF;
	Sat,  8 Jun 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850993; cv=none; b=tJILPvriDt+KtigNp6FSM44l8rtQXIaz48ei3IoZg6UkxgmSBKnga8OaxY3LyQFN/c+OsRKxoAKq5zv8Ki2mcCrx/ZG9H0rHGYUuNlb2N3uThGVCeBaTDhNQ3thsSbVaHg9VFzVa0gsefiKbWdKLGAQcpj7CWcn7HifSgL+XLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850993; c=relaxed/simple;
	bh=h/6jKdlYQQplofgSURQ/paBvEfYEJ2GnbiE1G1T6u28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hN39WI36E6ihq0CozcrdIzTKp2xFNqDS1jWC/qyPxTk71b8iNmvyVtL9PS6B3hcTdxrCV/rZunX9Kb2ghl/chCe8N2UUymCV/HOqVBTdsPzZys/Jn0F3shvcre745FOGsxN+M0/wrMVZnEHqbFqKV1jhAigCiTHNYg6/G3DOcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GtEjqwX+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GtEjqwX+"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458CnZss006948;
	Sat, 8 Jun 2024 12:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=zQ/wCCZVB63ujnWP8P3hNLOaumRAv7eN8/OJmgi
	SXhA=; b=GtEjqwX+ixZqSXnSDMCW72+szJCXdquvDSx+GA9oa8OqAzqFJ13yF6G
	ZU4OENqNKN3Sg9a2n4sM1MSgP42WXU+UuydCoqvmpDASuk3wnqkEyg6QONoqWl+F
	VDZWGsBIHS+PQy0itJp4GM+bT61ZRRuy3BuEj9F/eusEmJ3PX3tzlSWRCYzmpliQ
	bQfzwlmaVrQ8aDl1wao+1vxh7Q5p1Z1m8XgEog+Yh04qrsL6A8jk7JH3foLbsnIz
	B20+b+4ZUqC/VV1MZcXe0YUq3evVWCKi8KHS8tE41vL27JXRkC22KwLJjMpFq6Hy
	WDjvmuFmBecHZqSZq3R0WCzYnVwaTtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ymq38g0yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 12:49:35 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 458CnY0T006918;
	Sat, 8 Jun 2024 12:49:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ymq38g0yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 12:49:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 458BZIUX002535;
	Sat, 8 Jun 2024 12:49:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ymff9t045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 12:49:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 458CnTHG48038218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Jun 2024 12:49:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF3A720049;
	Sat,  8 Jun 2024 12:49:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33ABE20040;
	Sat,  8 Jun 2024 12:49:23 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.48.11])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Jun 2024 12:49:22 +0000 (GMT)
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
Subject: [PATCH v2] perf sched map: Add command-name, fuzzy-name options to filter the output map
Date: Sat,  8 Jun 2024 18:18:29 +0530
Message-ID: <20240608124915.33860-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zTy95yR-PIFjOMYzHGc1SU1ntDe0uJI_
X-Proofpoint-GUID: tV8_InFo-w8OuINviXzkIB15X4bvkjbY
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
 definitions=2024-06-08_06,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406080092

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

6.10.0-rc1
==========
  *A0                   213864.670142 secs A0 => migration/0:18
  *.                    213864.670148 secs .  => swapper:0
   .  *B0               213864.670217 secs B0 => migration/1:21
   .  *.                213864.670223 secs
   .   .  *C0           213864.670247 secs C0 => migration/2:26
   .   .  *.            213864.670252 secs

6.10.0-rc1 + patch (--command-name = schbench)
=============
   **  .   ** *A0       213864.671055 secs A0 => schbench:104834
  *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
  *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
  *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
  *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
   E0  .  *D0  A0

This helps in visualizing how a benchmark like schbench is spread over
the available cpus while also knowing which cpus are idle(.) and which
are not(**). This will be more useful as number of CPUs increase.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>

---
Changes in v2:
- Add support for giving multiple command-names in CSV. (Namhyung Kim)
- Add fuzzy name matching option. (Chen Yu)
- Add Reviewed-and-tested-by tag from Athira Rajeev.
- Rebase against perf-tools-next commit d2307fd4f989 ("perf maps: Add/use
  a sorted insert for fixup overlap and insert")
- Link to v1: https://lore.kernel.org/lkml/20240417152521.80340-1-vineethr@linux.ibm.com/
---
 tools/perf/Documentation/perf-sched.txt |  8 +++++
 tools/perf/builtin-sched.c              | 41 +++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a216d2991b19..6901c192eb6f 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -130,6 +130,14 @@ OPTIONS for 'perf sched map'
 --color-pids::
 	Highlight the given pids.
 
+--command-name::
+	Map output only for the given command name(s). Separate the
+	command names with a comma (without whitespace).
+	(** indicates other tasks while . is idle).
+
+--fuzzy-name::
+	Given command name can be partially matched (fuzzy matching).
+
 OPTIONS for 'perf sched timehist'
 ---------------------------------
 -k::
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5977c49ae2c7..364f48170e65 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -156,6 +156,8 @@ struct perf_sched_map {
 	const char		*color_pids_str;
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
+	const char		*command;
+	bool			fuzzy;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -1538,6 +1540,26 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
+static bool command_matches(const char *comm_str, const char *commands, bool fuzzy_match)
+{
+	char *commands_copy = strdup(commands);
+	char *token = strtok(commands_copy, ",");
+
+	bool match_found = false;
+
+	while (token != NULL) {
+		if ((fuzzy_match && strstr(comm_str, token) != NULL) ||
+					strcmp(comm_str, token) == 0) {
+			match_found = true;
+			break;
+		}
+	token = strtok(NULL, ",");
+	}
+
+	free(commands_copy);
+	return match_found;
+}
+
 static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine)
 {
@@ -1594,8 +1616,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 
 	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 
-	printf("  ");
-
 	new_shortname = 0;
 	if (!tr->shortname[0]) {
 		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
@@ -1605,7 +1625,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else {
+		} else if (!sched->map.command || command_matches(thread__comm_str(sched_in),
+							sched->map.command, sched->map.fuzzy)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1618,10 +1639,19 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 				else
 					sched->next_shortname2 = '0';
 			}
+		} else {
+			tr->shortname[0] = '*';
+			tr->shortname[1] = '*';
 		}
 		new_shortname = 1;
 	}
 
+	if (sched->map.command && !command_matches(thread__comm_str(sched_in), sched->map.command,
+										sched->map.fuzzy))
+		goto skip;
+
+	printf("  ");
+
 	for (i = 0; i < cpus_nr; i++) {
 		struct perf_cpu cpu = {
 			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
@@ -1678,6 +1708,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 out:
 	color_fprintf(stdout, color, "\n");
 
+skip:
 	thread__put(sched_in);
 
 	return 0;
@@ -3560,6 +3591,10 @@ int cmd_sched(int argc, const char **argv)
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
2.31.1

