Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFC13C675;
	Tue, 18 Jun 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710179; cv=none; b=i9NJMIMBfv3crdF8XX07Ba7Mwp3ZcHrkC3WgJvr5uAbWmLsZShB9UgeSR14iEjXjao9r/ZMeCo2XDqf4rrGtR9J2Nm1WJ8rkfWn8avH7Nd3w0W8EBb8KfbXx0ANnLl8cZB4pWWA8yJOZsInXEK2nW0CF805QW+spuaK0l0Ye0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710179; c=relaxed/simple;
	bh=TA7OjIEM/X1uHBt4iiiAuNXmHyEcBBG9kaKR1mO6HKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m69AA0AfFBj+GfL23oHYr3a3b49IhWO5NUPqsNBI27FRKfx2mNMcey/9cBJwVDNdq+J3DKWpW7chUOdKdHLhZOUiuapXZ0fv0NRAgY70ayo1xPd+MOVA8fIkestUnaaL+P5QC+5IbID50dxNqJFHyVr0saE8h2n3D7LIIPrY3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c2ZVLPxS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c2ZVLPxS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAx197003195;
	Tue, 18 Jun 2024 11:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=p1LUKWhi517aLgEOWstkzIXOVg
	aUrZJ10qQxi8+pq8s=; b=c2ZVLPxSaNUWn6sXkbw6+rfJMWtlmWmuS/50Otj2Qu
	jZL4pKQ8tFBM22dXMB/VTzmZCTcpZAh3OuUttAJcTntOmsLm75M2C10wedEbxo4j
	Sqnqi0DxoF0KJVQgOVBwdpxio63Sz/i52jxLZFN7fV+TNKJyGrE+YjVCrCyjlSt+
	uTReEJUjRrALztA6FL3sxIZnGYveMd5/+wj6zhQiKlPFHJSQQMEwPAGxmEn7wPjS
	XfY6Zlw/+lfWJAxzrURK0UbtB1nF57YEoFQGPAPHwCksoA4VYhtpTRu5HDNLMw8x
	7+Ozbif4j09BCBE4W7UuhPSTp/auyr6wnlr+DxGMS0aA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu8xxr2fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:29:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IBTLCC017119;
	Tue, 18 Jun 2024 11:29:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu8xxr2fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:29:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45I9c96K011031;
	Tue, 18 Jun 2024 11:29:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsn2apf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:29:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IBTFrd50856328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 11:29:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C708820040;
	Tue, 18 Jun 2024 11:29:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF912004B;
	Tue, 18 Jun 2024 11:29:11 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.206.228])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 11:29:11 +0000 (GMT)
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
Subject: [PATCH] perf sched replay: Fix -r/--repeat command line option for infinity
Date: Tue, 18 Jun 2024 16:59:07 +0530
Message-ID: <20240618112907.15131-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jz1WA5SyOEM8jark49ScsX7u5cd3il6G
X-Proofpoint-GUID: XW-vtEuyVtGQJUNOz0olaJ0-ZGn63uGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180084

Currently, the -r/--repeat option accepts values from 0 and complains
for -1. The help section specifies:
-r, --repeat <n>      repeat the workload replay N times (-1: infinite)

The -r -1 option raises an error because replay_repeat is defined as
an unsigned int.

In the current implementation, the workload is repeated n times when
-r <n> is used, except when n is 0.

When -r is set to 0, the workload is also repeated once. This happens
because when -r=0, the run_one_test function is not called. (Note that
mutex unlocking, which is essential for child threads spawned to emulate
the workload, happens in run_one_test.) However, mutex unlocking is
still performed in the destroy_tasks function. Thus, -r=0 results in the
workload running once coincidentally.

To clarify and maintain the existing logic for -r >= 1 (which runs the
workload the specified number of times) and to fix the issue with infinite
runs, make -r=0 perform an infinite run.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/Documentation/perf-sched.txt | 7 +++++++
 tools/perf/builtin-sched.c              | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a216d2991b19..f1be8f0b249e 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -202,6 +202,13 @@ OPTIONS for 'perf sched timehist'
 --state::
 	Show task state when it switched out.
 
+OPTIONS for 'perf sched replay'
+------------------------------
+
+-r::
+--repeat <n>::
+	repeat the workload n times (0: infinite). Default is 10.
+
 SEE ALSO
 --------
 linkperf:perf-record[1]
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8cdf18139a7e..2c4ed5c2d695 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3383,8 +3383,12 @@ static int perf_sched__replay(struct perf_sched *sched)
 	sched->thread_funcs_exit = false;
 	create_tasks(sched);
 	printf("------------------------------------------------------------\n");
-	for (i = 0; i < sched->replay_repeat; i++)
+
+	i = 0;
+	while (sched->replay_repeat == 0 || i < sched->replay_repeat) {
 		run_one_test(sched);
+		i++;
+	}
 
 	sched->thread_funcs_exit = true;
 	destroy_tasks(sched);
@@ -3548,7 +3552,7 @@ int cmd_sched(int argc, const char **argv)
 	};
 	const struct option replay_options[] = {
 	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
-		     "repeat the workload replay N times (-1: infinite)"),
+		     "repeat the workload replay N times (0: infinite)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option map_options[] = {
-- 
2.31.1

