Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7248168486;
	Wed, 26 Jun 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393442; cv=none; b=YTaZw0+taiulPkQInH4p0gnS31ysykLtaakIzAf/PzejlrAjIo9WiwLI6e+fhUbAZO5QnKstua/Yj6U5qP2YfOcb73OIxLutp0gLoovWe/tWX68y2dUTRrh62+O1+yGYtzNtdIiYOgxW3tNL9kSQks5weyzgQft/pLMNMBXAWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393442; c=relaxed/simple;
	bh=tYPyX6886SAJdc9m6hgCgPEn28NWpQzFqWmfB546fS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXlhGu2F0BCrCEgOvP22UEagijm8o4btdDQyk8vmdtUYGE0K8ZQfVHpNr4jIKApWv9MJ1fBduSP8sQvWXST823y+3XdmLPoiDf+vFsg+/ThpzVqvuS2WPwCQVGvaNVQTA1eed/am6KUzrgFytbiw+vR6iuEY3NmgD2j2ULE+HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a39n9O97; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a39n9O97"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8SXeH006364;
	Wed, 26 Jun 2024 09:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=YTbEobxX0rS76
	TFeDHHtgoJ3WXZMfYodjrAvpvqJhJE=; b=a39n9O97KESMHoqrEfcY8d2K0UyRJ
	HbtDnngVCwFDudbc/7MBwtouaMcemNSyGoGOyiQ0F06/sXNh32AlOw/FHy2OTcIq
	/bacGFLuc10ti7DRkgKTZsfMnahqXXSend4zkZ3wXOsK0rx8C6QrDSKqSDtbK5T2
	9lKWLzIxiabv5gq07HfGY45ZtLykkT6HlOzsDcxs29Voq3jigeSMOo5woOfnS7ow
	bqZtB8aIPVIkNHIY1j2WmKj8JVDP506bN4gr20pjQc3njoF11S1vW7ncywn6NOdM
	kzWQiilQtmPBegLBw+o0foLG+tvJrDAvsQMYgvT2lJrZAHdLKF0Favi1Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fgng3nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:17:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q9H7JC014220;
	Wed, 26 Jun 2024 09:17:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fgng3n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:17:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q7UlDf000402;
	Wed, 26 Jun 2024 09:17:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3ayt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 09:17:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45Q9H3dx49479998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 09:17:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A082005A;
	Wed, 26 Jun 2024 09:17:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E70E2004B;
	Wed, 26 Jun 2024 09:16:56 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.51.102])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 09:16:55 +0000 (GMT)
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
Subject: [PATCH v5 3/3] perf sched map: Add --fuzzy-name option for fuzzy matching in task names
Date: Wed, 26 Jun 2024 14:45:50 +0530
Message-ID: <20240626091550.46707-4-vineethr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: eLGAuKoBOWZ16HksXPOGGGszb8clGvKc
X-Proofpoint-GUID: _NnUdIRmtGhsYSwgeFaeFf_tsdxUrRMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260067

The --fuzzy-name option can be used if fuzzy name matching is required.
For example, "taskname" can be matched to any string that contains
"taskname" as its substring.

Sample output for --task-name wdav --fuzzy-name
=============
 .  *A0  .   .   .   .   -   .   131040.641346 secs A0 => wdavdaemon:62509
 .   A0 *B0  .   .   .   -   .   131040.641378 secs B0 => wdavdaemon:62274
 -  *-   -   -   -   -   -   -   131040.641379 secs
*C0  .   B0  .   .   .   .   .   131040.641572 secs C0 => wdavdaemon:62283
 C0  .   B0  .  *D0  .   .   .   131040.641572 secs D0 => wdavdaemon:62277
 C0  .   B0  .   D0  .  *E0  .   131040.641578 secs E0 => wdavdaemon:62270
*-   -   -   -   -   -   -   -   131040.641581 secs

Suggested-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-and-tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt |  3 +++
 tools/perf/builtin-sched.c              | 22 +++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 3095e280eb92..938b41a3befa 100644
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
index ecb43deb9d74..c801c38e8b9a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -157,6 +157,7 @@ struct perf_sched_map {
 	struct perf_cpu_map	*color_cpus;
 	const char		*color_cpus_str;
 	const char		*task_name;
+	bool			fuzzy;
 	struct perf_cpu_map	*cpus;
 	const char		*cpus_str;
 };
@@ -1599,12 +1600,16 @@ static struct CommandList *parse_commands(const char *commands)
 	return cmd_list;
 }
 
-static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list)
+static bool sched_match_task(const char *comm_str, struct CommandList *cmd_list, bool fuzzy_match)
 {
 	bool match_found = false;
 
-	for (int i = 0; i < cmd_list->command_count && !match_found; i++)
-		match_found = !strcmp(comm_str, cmd_list->command_list[i]);
+	for (int i = 0; i < cmd_list->command_count && !match_found; i++) {
+		if (fuzzy_match)
+			match_found = !!strstr(comm_str, cmd_list->command_list[i]);
+		else
+			match_found = !strcmp(comm_str, cmd_list->command_list[i]);
+	}
 
 	return match_found;
 }
@@ -1727,7 +1732,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			 */
 			tr->shortname[0] = '.';
 			tr->shortname[1] = ' ';
-		} else if (!sched->map.task_name || sched_match_task(str, cmd_list)) {
+		} else if (!sched->map.task_name || sched_match_task(str, cmd_list,
+								sched->map.fuzzy)) {
 			tr->shortname[0] = sched->next_shortname1;
 			tr->shortname[1] = sched->next_shortname2;
 
@@ -1756,15 +1762,15 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	 * Check which of sched_in and sched_out matches the passed --task-name
 	 * arguments and call the corresponding print_sched_map.
 	 */
-	if (sched->map.task_name && !sched_match_task(str, cmd_list)) {
-		if (!sched_match_task(thread__comm_str(sched_out), cmd_list))
+	if (sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)) {
+		if (!sched_match_task(thread__comm_str(sched_out), cmd_list, sched->map.fuzzy))
 			goto out;
 		else
 			goto sched_out;
 
 	} else {
 		str = thread__comm_str(sched_out);
-		if (!(sched->map.task_name && !sched_match_task(str, cmd_list)))
+		if (!(sched->map.task_name && !sched_match_task(str, cmd_list, sched->map.fuzzy)))
 			proceed = 1;
 	}
 
@@ -3707,6 +3713,8 @@ int cmd_sched(int argc, const char **argv)
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

