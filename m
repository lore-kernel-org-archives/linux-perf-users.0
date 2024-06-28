Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E621F934;
	Fri, 28 Jun 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559139; cv=none; b=cMbBlHYsDT5KtVWvxBG9ZZdpwBK0mwk17uGDKowQXiL6M0/Y+3PrPIEDUuKZffk8eH5HorkXa7sh0Wg38emNycHgocUIH21EkC+YgH87O6NAj9LEIJ4yGFJXHhYtB8DHWmhmG1voBbH+dnrVpTPJ3pLtHMAYjL7fTTiaxckoTQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559139; c=relaxed/simple;
	bh=+omgK3V3k7mwk0w+1bKjEPFewXPSIpHMXLQBhfBTCQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdPu7kUC3o/4zhYEocpYffDo0gLxaTXVnIRoAghz5fXup1YAy3nm2D/z7nBoGud+CcLADIHTa36YmgNatSeXvmtMFeUMgoB+8CJj8GoQS9EOy0HWhQIpB4+bUV2sRW/A9ZLvjMcLMso/LRjBf1SymV20/Y16tMFwwGTXsy6wu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YgTMU2jg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YgTMU2jg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S6tQK0024335;
	Fri, 28 Jun 2024 07:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=pZjZbsjqZksvm+BakShr19nrDjJxArwJM4jxtO/
	wQAo=; b=YgTMU2jgjLj4bqZ711weT86PHVVIeh56DvKoXuzdbxS7wbcXsdakJIi
	YD3Tus6v/WE/V10VFmLAWJZd76h4bAOt6ZImvhpZYa51sYDVXO50GcNIv7wHMHvd
	EA4tHZkzc3rP5Bvn6YebB0vKBV7Sz8YcePYhZZapRob9iptFV0AVLyU1OwBD5GoR
	qZbtSJVq32NFdC+VOEQ2Bu8i3qdyoHR8ftjeF/glIA6fHDpfgOHIsKSNehjdlO/b
	/MJi6BDN8ltaNDCPrfiCYuAEcmKMmJFaXtkKxaKSeUYd+hzbHrOJrb1xfZG2YcNg
	VlRGnCbSPNKUOWepAIsTLfo8vLUx2Fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qgb8572-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:18:38 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45S7IbmK027693;
	Fri, 28 Jun 2024 07:18:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401qgb856x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:18:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45S6W7K7000575;
	Fri, 28 Jun 2024 07:18:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenf2ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:18:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45S7IWmN20185392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 07:18:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E1B2005A;
	Fri, 28 Jun 2024 07:18:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFBF22006E;
	Fri, 28 Jun 2024 07:18:25 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown [9.43.26.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Jun 2024 07:18:25 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3] perf sched replay: Fix -r/--repeat command line option for infinity
Date: Fri, 28 Jun 2024 12:48:21 +0530
Message-ID: <20240628071821.15264-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wTDgxX5rJRhIRVGB6ozhNyfLnHfLramq
X-Proofpoint-GUID: vqVynXlftA79-lVQNh6pNkmDbmS_IQBH
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
 definitions=2024-06-28_02,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280049

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

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

---
Changes in v3:
- Used UINT_MAX for replay_repeat to maintain the original intent
  of an indefinite loop. (Namhyung Kim)
- Rebase against perf-tools-next commit e8b86f0311a4 ("perf test
  stat_bpf_counter.sh: Stabilize the test results")
- Link to v2: https://lore.kernel.org/all/20240621171909.24119-1-vineethr@linux.ibm.com/

Changes in v2:
- Kept the existing 'for' loop and added a condition for infinite
  looping. (James Clark)
- Add Reviewed-by tag from James Clark.
- Rebase against perf-tools-next commit 788c5160526a ("perf vendor
  events: Add westmereex counter information")
- Link to v1: https://lore.kernel.org/all/20240618112907.15131-1-vineethr@linux.ibm.com/

 tools/perf/Documentation/perf-sched.txt | 7 +++++++
 tools/perf/builtin-sched.c              | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 74c812f7a4a4..f0e5617f6652 100644
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
index aa59f763ca46..24e9d83c7bb6 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3386,6 +3386,9 @@ static int perf_sched__replay(struct perf_sched *sched)
 	sched->thread_funcs_exit = false;
 	create_tasks(sched);
 	printf("------------------------------------------------------------\n");
+	if (sched->replay_repeat == 0)
+		sched->replay_repeat = UINT_MAX;
+
 	for (i = 0; i < sched->replay_repeat; i++)
 		run_one_test(sched);
 
@@ -3551,7 +3554,7 @@ int cmd_sched(int argc, const char **argv)
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

