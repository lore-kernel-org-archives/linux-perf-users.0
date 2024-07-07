Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43057CB4;
	Sun,  7 Jul 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376899; cv=none; b=p3imuuwuuBst/7OwUa8o5eR4Jjng2cp4K0nib04qlDRW+fVIast49t7alITgxnCT+kHHkmuHC/jPgMRcgWy606B/hEfdGqK0hAP95jkoJx2nIkhl2F9IpMecI72wtw7DjHQ91HzLy7s2L/mU0opigS0Bd2Nc+pgapORR2kPSqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376899; c=relaxed/simple;
	bh=bYzicIZOdk01yC8oQvG1MswafXxtIfTrxwTYAZGlZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx4uFZD64SpHT1oUQBoHyuMDMZlTPPvnQ6lIHTHIhU1o1Xzq5RNEdNhTs0faFrQOwVNjisuBcCPrX6f/G6/yBTHhGm5K59yzoaABX4csCEpFuSM0w4inLYUegv8fdc42C/jx0bT2a5xcCtYBshtIjo6DXozTjykyhnroEkfKiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHuBj+ab; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHuBj+ab"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467HxHFY015573;
	Sun, 7 Jul 2024 18:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=y42O/Hj8Q4phY
	grWvIsSGvqBV9iNaFV72mSRjyhEg40=; b=YHuBj+abuVMTqiOHjBWJcv8iy+wa2
	UUd2PnnN16dfPrei1nCI948Jbg5jgTNpaxpksZnh+wDllW8pD1S3KRNF6bPnz0YU
	R4/ZZExsboKPMa5ZjE2B1nrPOwk2qgGkPUiEm52mYQm47TQXo4QGaT1iFcBZK36Z
	WPaE4lrPwkFGLfuup2SKMoJYbdKKiHoeqpj8G502DC6JujmkXGokhtbybyPWs+H7
	D1EadDHaKa5lCOxzLCA/CDKfPNDR74+s9+hta3PzZ5jfroy/JOsqm1f0tBwvxZZz
	8vzqRtI6BcJPm+XGp0nrtaHwnYAFMIWq3AGtb71sjXhAMEtPZsFAHKDEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6gftc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:28:09 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467IS8IJ023045;
	Sun, 7 Jul 2024 18:28:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ug6gft9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:28:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467FHd2D014020;
	Sun, 7 Jul 2024 18:28:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 407h8pb905-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 18:28:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467IS3qO44302686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 18:28:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7952620043;
	Sun,  7 Jul 2024 18:28:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3C520040;
	Sun,  7 Jul 2024 18:27:57 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.85.13])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 18:27:56 +0000 (GMT)
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
Subject: [PATCH v6 3/3] perf sched map: Add --fuzzy-name option for fuzzy matching in task names
Date: Sun,  7 Jul 2024 23:57:16 +0530
Message-ID: <20240707182716.22054-4-vineethr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: slpMu76cFTN9mN4pal38Lv8PkectHPC_
X-Proofpoint-GUID: STvOs_61F-ZoncldBmtxcoHkMC104cfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407070151

The --fuzzy-name option can be used if fuzzy name matching is required.
For example, "taskname" can be matched to any string that contains
"taskname" as its substring.

Sample output for --task-name wdav --fuzzy-name
=============
 .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
 .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
 .  *-   B0  .   .   .   -   .   131040.641379 secs
*C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
 C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
 C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
*-   .   B0  .   D0  .   E0  .   131040.641581 secs

Suggested-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |  3 +++
 tools/perf/builtin-sched.c              | 20 +++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 4f8216ee4a74..84d49f9241b1 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -137,6 +137,9 @@ OPTIONS for 'perf sched map'
 	task name(s).
 	('-' indicates other tasks while '.' is idle).
 
+--fuzzy-name::
+	Given task name(s) can be partially matched (fuzzy matching).
+
 OPTIONS for 'perf sched timehist'
 ---------------------------------
 -k::
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7de29c2f3d23..8750b5f2d49b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -158,6 +158,7 @@ struct perf_sched_map {
 	const char		*color_cpus_str;
 	const char		*task_name;
 	struct strlist		*task_names;
+	bool			fuzzy;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -1541,12 +1542,16 @@ map__findnew_thread(struct perf_sched *sched, struct machine *machine, pid_t pid
 	return thread;
 }
 
-static bool sched_match_task(const char *comm_str, struct strlist *task_names)
+static bool sched_match_task(struct perf_sched *sched, const char *comm_str)
 {
+	bool fuzzy_match = sched->map.fuzzy;
+	struct strlist *task_names = sched->map.task_names;
 	struct str_node *node;
 
 	strlist__for_each_entry(node, task_names) {
-		if (strcmp(comm_str, node->s) == 0)
+		bool match_found = fuzzy_match ? !!strstr(comm_str, node->s) :
+							!strcmp(comm_str, node->s);
+		if (match_found)
 			return true;
 	}
 
@@ -1622,7 +1627,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
 	const char *str;
-	struct strlist *task_names = sched->map.task_names;
 
 	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
@@ -1674,7 +1678,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else if (!sched->map.task_name || sched_match_task(str, task_names)) {
+		} else if (!sched->map.task_name || sched_match_task(sched, str)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1703,15 +1707,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	 * Check which of sched_in and sched_out matches the passed --task-name
 	 * arguments and call the corresponding print_sched_map.
 	 */
-	if (sched->map.task_name && !sched_match_task(str, task_names)) {
-		if (!sched_match_task(thread__comm_str(sched_out), task_names))
+	if (sched->map.task_name && !sched_match_task(sched, str)) {
+		if (!sched_match_task(sched, thread__comm_str(sched_out)))
 			goto out;
 		else
 			goto sched_out;
 
 	} else {
 		str = thread__comm_str(sched_out);
-		if (!(sched->map.task_name && !sched_match_task(str, task_names)))
+		if (!(sched->map.task_name && !sched_match_task(sched, str)))
 			proceed = 1;
 	}
 
@@ -3655,6 +3659,8 @@ int cmd_sched(int argc, const char **argv)
                     "display given CPUs in map"),
 	OPT_STRING(0, "task-name", &sched.map.task_name, "task",
 		"map output only for the given task name(s)."),
+	OPT_BOOLEAN(0, "fuzzy-name", &sched.map.fuzzy,
+		"given command name can be partially matched (fuzzy matching)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option timehist_options[] = {
-- 
2.43.2

