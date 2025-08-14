Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A742F60DA
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172172; cv=none; b=p8nmKzU5liKraQ9EDkLJxetW5Inokx6HFhfHjJJGd2UrQNjEDP8qO8vYK/SrgnEshD04w3ogRrk+AR9/PvoWPbqVPcl6rZRagtUq1e5THegAD21k4YMudnptdjwCRZVc3szGIHf4iw2O2cmqfNIyixQWMP9xB2SfecvyZcVyjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172172; c=relaxed/simple;
	bh=eDZVPCG3AIVe2e+o40aNcm1eatVOOMSD7icuVCuW/8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MckY1rE0dWu3SsENZGw6aYlO5DiBT3FUgRxakatZ2F0OZcSk/4MlKGb2utbNoytT/nwEZhudH2gN2Yej2/17Ykaeqe5r+dH52QIfp8sYWrDp5Gz7aMyofoIlCuCYqKsaMkXx15Qki/DRPqP8SONtINoNvzGp3CsKqYtX28mkoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PiWN3mQZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PiWN3mQZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EBC5sT029428;
	Thu, 14 Aug 2025 11:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ihAhV4DmP3vdHgUBclY3MEQtPz+9U4QX6MewKwtoZ
	GY=; b=PiWN3mQZu9m48MIVfgjJWx72A+tZt9BIhJ+Z+XxJpiQdF+f7ptmb0FxxQ
	f9b32m5dFGOESSjW2ErzMuZ4or41nBqf8FnMzmn43vv5cW97hM3RxFQFoQNCUk0k
	HM/rV3C5yNLg5qZA4CsoT7AlrBB+3sO0M8eAqAIlM4KbBY680t00zbO9rRi7Ej03
	k9thMgFWiO1T/FjsjG5eW77nC7O7Hhxdc0hucrSgZvB5Lrn1zaApWjLEw9C4oQcX
	c8Wrh73Ode39ms46d0ZWNU+9mP2cTd9qWVgCmFV7+SzMlJHOMBMKy+c2AbuBFfJA
	qD9IrqC6av8bgeiG3eGR8zVVcFQZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudhvfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 11:49:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57EBcQTd028727;
	Thu, 14 Aug 2025 11:49:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudhvfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 11:49:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9pBwQ028647;
	Thu, 14 Aug 2025 11:49:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5nbuvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 11:49:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57EBnLk052101436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 11:49:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C1F20043;
	Thu, 14 Aug 2025 11:49:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD0D120040;
	Thu, 14 Aug 2025 11:49:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.248.122])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Aug 2025 11:49:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
        Tejas Manhas <tejas05@linux.ibm.com>
Subject: [PATCH] tools/perf/tests: Update perf record testcase to fix usage of affinity for machines with #CPUs > 1K
Date: Thu, 14 Aug 2025 17:19:08 +0530
Message-Id: <20250814114908.45648-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX6+UTFnNX7n++
 WI/+LTDoTypIN6OhTGlKK608o7lho1I0bnZ26T3joQAVez2j0kYGTqShyZ+eCBSIlNuTF9qmV3W
 5CoO9Q7txq2mJ5wVxkDU4m/WQsPoQnqO7B12zot86Ufcr6OUgar/FAvAALPLEsgs2M7QDCB0TwP
 hsZDKhxgATAlnWaESt4aTOVJ8AwOWt6kCJhMSdC84D/WTkwNYuaAep4B0JULe5ANMyiv7lYRHrG
 Jpy0Rz6NOC/1Kaj71AiuENZOu0Pndva2BNid2HghRbo4oh8CkiCi31JlVBWsh9/GfvdrfJb6j9j
 jwSde/nP9uDbaIZej2c1jC9xGrmKnbEdD8kKE4xX4c886sqQeb5F/m4s4PKlkVXxbvIn+NeNmlg
 h7zK1ohq
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689dcd47 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=fkP59d2oNgxiTSZ1VLkA:9
X-Proofpoint-GUID: 2ey94bIgwln7yTuGX3kdK5v1tVXnaLRZ
X-Proofpoint-ORIG-GUID: rpUByUymUXHNRptWHnxzPkIa3Q6bHQBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

The perf record testcase fails on systems with more than 1K CPUs.

Testcase: perf test -vv "PERF_RECORD_* events & perf_sample fields"

  PERF_RECORD_* events & perf_sample fields                       :
  --- start ---
  test child forked, pid 272482
  sched_getaffinity: Invalid argument
  sched__get_first_possible_cpu: Invalid argument
  test child finished with -1
  ---- end ----
  PERF_RECORD_* events & perf_sample fields: FAILED!

sched__get_first_possible_cpu uses "sched_getaffinity" to get the
cpumask and this call is returning EINVAL (Invalid argument).
This happens because the default mask size in glibc is 1024.  To
overcome this 1024 CPUs mask size limitation of cpu_set_t, change the
mask size using the CPU_*_S macros ie, use CPU_ALLOC to allocate
cpumask, CPU_ALLOC_SIZE for size. Same fix needed for mask which is
used to setaffinity so that mask size is large enough to represent
number of possible CPU's in the system.

Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/tests/perf-record.c | 36 ++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0b3c37e66871..d895df037707 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -13,15 +13,19 @@
 #include "tests.h"
 #include "util/mmap.h"
 #include "util/sample.h"
+#include "util/cpumap.h"
 
 static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
 {
-	int i, cpu = -1, nrcpus = 1024;
+	int i, cpu = -1;
+	int nrcpus = cpu__max_cpu().cpu;
+	size_t size = CPU_ALLOC_SIZE(nrcpus);
+
 realloc:
-	CPU_ZERO(maskp);
+	CPU_ZERO_S(size, maskp);
 
-	if (sched_getaffinity(pid, sizeof(*maskp), maskp) == -1) {
-		if (errno == EINVAL && nrcpus < (1024 << 8)) {
+	if (sched_getaffinity(pid, size, maskp) == -1) {
+		if (errno == EINVAL && nrcpus < (cpu__max_cpu().cpu << 8)) {
 			nrcpus = nrcpus << 2;
 			goto realloc;
 		}
@@ -30,11 +34,11 @@ static int sched__get_first_possible_cpu(pid_t pid, cpu_set_t *maskp)
 	}
 
 	for (i = 0; i < nrcpus; i++) {
-		if (CPU_ISSET(i, maskp)) {
+		if (CPU_ISSET_S(i, size, maskp)) {
 			if (cpu == -1)
 				cpu = i;
 			else
-				CPU_CLR(i, maskp);
+				CPU_CLR_S(i, size, maskp);
 		}
 	}
 
@@ -50,8 +54,9 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		.no_buffering = true,
 		.mmap_pages   = 256,
 	};
-	cpu_set_t cpu_mask;
-	size_t cpu_mask_size = sizeof(cpu_mask);
+	int nrcpus = cpu__max_cpu().cpu;
+	cpu_set_t *cpu_mask;
+	size_t cpu_mask_size;
 	struct evlist *evlist = evlist__new_dummy();
 	struct evsel *evsel;
 	struct perf_sample sample;
@@ -69,12 +74,22 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	int total_events = 0, nr_events[PERF_RECORD_MAX] = { 0, };
 	char sbuf[STRERR_BUFSIZE];
 
+	cpu_mask = CPU_ALLOC(nrcpus);
+	if (!cpu_mask) {
+		pr_debug("failed to create cpumask\n");
+		goto out;
+	}
+
+	cpu_mask_size = CPU_ALLOC_SIZE(nrcpus);
+	CPU_ZERO_S(cpu_mask_size, cpu_mask);
+
 	perf_sample__init(&sample, /*all=*/false);
 	if (evlist == NULL) /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
 		evlist = evlist__new_default();
 
 	if (evlist == NULL) {
 		pr_debug("Not enough memory to create evlist\n");
+		CPU_FREE(cpu_mask);
 		goto out;
 	}
 
@@ -111,7 +126,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	evsel__set_sample_bit(evsel, TIME);
 	evlist__config(evlist, &opts, NULL);
 
-	err = sched__get_first_possible_cpu(evlist->workload.pid, &cpu_mask);
+	err = sched__get_first_possible_cpu(evlist->workload.pid, cpu_mask);
 	if (err < 0) {
 		pr_debug("sched__get_first_possible_cpu: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
@@ -123,7 +138,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	/*
 	 * So that we can check perf_sample.cpu on all the samples.
 	 */
-	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, &cpu_mask) < 0) {
+	if (sched_setaffinity(evlist->workload.pid, cpu_mask_size, cpu_mask) < 0) {
 		pr_debug("sched_setaffinity: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
@@ -328,6 +343,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 		++errs;
 	}
 out_delete_evlist:
+	CPU_FREE(cpu_mask);
 	evlist__delete(evlist);
 out:
 	perf_sample__exit(&sample);
-- 
2.43.7

