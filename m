Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517526CDCC;
	Sun,  7 Jul 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376892; cv=none; b=CwKmKwBOT2cO5uXyzyKNnldIr0vIGUX4eCnMBlDB8jPYCTaTUq0vq+jRJNxUOqXdmhiEIT3kZ1b5ymmwRd2XfjDJ7WnssGuKmpAjawgGzUW3ucbaQQYH1Eyv6qT3kh+vZtGy5WH2xrLermBSitpd2BSLmD4l9fje2mBf1/hqFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376892; c=relaxed/simple;
	bh=B2LV7J7jmjUTo2AWAtnjidOcGC9cQ1gJ5VGcG+tntE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKplgi8eBg2N9ZEs934UGCD72giZBEgJcrwZ+/FS6kWNWtQU6lF+HKJErsBjJ8k5UMwRCwraawkjwFNz+MdSVekHbc1B5GJ6hjDF0RjKGnMGUX7kymd+ZHu0Alv1rKpDDpNixLR+6K4A5ZtKY8BCLADWbrdB32WbmIOA88wdb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dqy5ELiE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dqy5ELiE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467Hv7no013871;
	Sun, 7 Jul 2024 18:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vTFGdkCR3LoZ9
	c6Glik++PEOZHy/PgEqcAbN4v4nQfE=; b=Dqy5ELiEqJMBpae4hsP6dsGgMJIOO
	uxlF4KXPYuzsTs9n2e3g0M4oP/tCOsfhiHF0jVoKNQxAdObUhNZlwsY12J1LeAtB
	kBTPMW/y4HZkTue+N3lrGnnMZ+t6yJ5YQ88BMn/N8lP5Rg2rM2Qvh3pdVdJWxOE7
	fPXg10hEOP23/EPiirm7VHW/c1QXtpGdqqwYx7n1t8qSVElXVTaFJj3GjpVmKxLN
	tp74gCZu63DdROnRW87i2K8xUEwWhgKvgcQx6/aNtY1E512yrxwxbz/na5Xzor6a
	0O/w3YZ1AAfJZu9Gn8digBVJ3dXWPkl6JIQJJJ/zvoGDJsHkcOwAHDzzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugpg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467IRx1N024101;
	Sun, 7 Jul 2024 18:27:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ruugpfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467E2TRp024698;
	Sun, 7 Jul 2024 18:27:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8tug9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:27:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467IRsXf16187674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 18:27:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61E1620043;
	Sun,  7 Jul 2024 18:27:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3307420040;
	Sun,  7 Jul 2024 18:27:47 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.85.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 18:27:46 +0000 (GMT)
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
Subject: [PATCH v6 2/3] perf sched map: Add support for multiple task names using CSV
Date: Sun,  7 Jul 2024 23:57:15 +0530
Message-ID: <20240707182716.22054-3-vineethr@linux.ibm.com>
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
X-Proofpoint-GUID: adcLG7gAmpUaOPcPYTRNAYhqOKtydx6-
X-Proofpoint-ORIG-GUID: dEVLfBriNqAM73uQRTWXtGq0rw9xSZaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070151

To track the scheduling patterns of multiple tasks simultaneously,
multiple task names can be specified using a comma separator
without any whitespace.

Sample output for --task-name perf,wdavdaemon
=============
 .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
 .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
 .  *-   B0  .   .   .   -   .   131040.641379 secs
*C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283

...

 .  *-   .   .   .   .   .   .   131041.395649 secs
 .   .   .   .   .   .   .  *X2  131041.403969 secs X2 => perf:70211
 .   .   .   .   .   .   .  *-   131041.404006 secs

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |  5 ++--
 tools/perf/builtin-sched.c              | 32 +++++++++++++++++++++----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 964036c48ac4..4f8216ee4a74 100644
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
index 3ee3f7fd78b0..7de29c2f3d23 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -157,6 +157,7 @@ struct perf_sched_map {
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
 	const char		*task_name;
+	struct strlist		*task_names;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -1540,6 +1541,18 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
+static bool sched_match_task(const char *comm_str, struct strlist *task_names)
+{
+	struct str_node *node;
+
+	strlist__for_each_entry(node, task_names) {
+		if (strcmp(comm_str, node->s) == 0)
+			return true;
+	}
+
+	return false;
+}
+
 static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu, int cpus_nr,
 								const char *color, bool sched_out)
 {
@@ -1609,6 +1622,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
 	const char *str;
+	struct strlist *task_names = sched->map.task_names;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1660,7 +1674,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else if (!sched->map.task_name || !strcmp(str, sched->map.task_name)) {
+		} else if (!sched->map.task_name || sched_match_task(str, task_names)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1689,15 +1703,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	 * Check which of sched_in and sched_out matches the passed --task-name
 	 * arguments and call the corresponding print_sched_map.
 	 */
-	if (sched->map.task_name && strcmp(str, sched->map.task_name)) {
-		if (strcmp(thread__comm_str(sched_out), sched->map.task_name))
+	if (sched->map.task_name && !sched_match_task(str, task_names)) {
+		if (!sched_match_task(thread__comm_str(sched_out), task_names))
 			goto out;
 		else
 			goto sched_out;
 
 	} else {
 		str = thread__comm_str(sched_out);
-		if (!(sched->map.task_name && strcmp(str, sched->map.task_name)))
+		if (!(sched->map.task_name && !sched_match_task(str, task_names)))
 			proceed = 1;
 	}
 
@@ -3640,7 +3654,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
 	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
-		"map output only for the given task name"),
+		"map output only for the given task name(s)."),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
@@ -3739,6 +3753,14 @@ int cmd_sched(int argc, const char **argv)
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
 			if (argc)
 				usage_with_options(map_usage, map_options);
+
+			if (sched.map.task_name) {
+				sched.map.task_names = strlist__new(sched.map.task_name, NULL);
+				if (sched.map.task_names == NULL) {
+					fprintf(stderr, "Failed to parse task names\n");
+					return -1;
+				}
+			}
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-- 
2.43.2

