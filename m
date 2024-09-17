Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97822157485;
	Tue, 17 Sep 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563693; cv=none; b=rlgMnkOZ46UxSivYaf+qV/HYvPo7hoqK9vIpYAcCr/5c1CVRAmlXmhRc5AtmkA10ctQzz8K/Hs40lfxmYtQEU20zh2MrRcj3+nVjX00oIW8r2nwBXcfA+ZirqevOcHu4x75HQhEFiNCjLisyAImTdO5mOUL224jSfiXdNI2w4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563693; c=relaxed/simple;
	bh=QmmcVgg2r6Jv08Yqq+gxobNYdSCsToL9/I3bZiZSC4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huTXoU1lxSf5d+1sFDdQY+Y52sMcAR1g+qmPyNjWWEp6Nn4Q8T/wkN1ko4qu1atPoADtZtCW4ZjzCDp2ajrZBZ0dV/GaROAMRqp9oIxBPqFmHX+xz+znvhzRLf8SXrXS3OyFiVO/LgUNSJYxZwc/HKJ60sVAx0CzM5E3gB+jsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ooEti+rc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ooEti+rc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIUwPv030245;
	Tue, 17 Sep 2024 09:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=SWB4bupZXFblmHZBV47cloHzPo
	dL2jWg/q8JaiEkl2g=; b=ooEti+rcLYSXTQMktciwdduxu9OkNdE2deC7tuKqRB
	ImeT4UNfXZ15fxJROpkOrFs6GVw4KiBkqKEHt1FLMo+CuBe7b7FOxlOH87+Vg4Pm
	sz4f/lzDnK1nBuJ3yvOYhKbQ9Kb8q6Lzh11t/xeHNx1JO3G9e10lAx9saeIQ7n4+
	4mcnfTw7nhsQ3BkYIs1K9Knbe307K4Y2iH0autXvijSaaOHl/L8ShCHpZXVntNKI
	Wca0iDX94zfu9H5JW9Dbd6F8FFpzHxSlRKTfMzTrUn2Ox/5ZqetvAqKS4QCu45uh
	B5MbZievsd8RIuB8NTQ6SkVtg47n47IGbVBWYpY9GndQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8e22h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:01:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H91DCL030474;
	Tue, 17 Sep 2024 09:01:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8e226-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:01:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6eBA6030625;
	Tue, 17 Sep 2024 09:01:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npan43bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 09:01:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H918KP51249578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 09:01:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C869B2004E;
	Tue, 17 Sep 2024 09:01:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1DB20040;
	Tue, 17 Sep 2024 09:01:05 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.in.ibm.com (unknown [9.204.206.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 09:01:05 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH] perf sched replay: Remove unused parts of the code
Date: Tue, 17 Sep 2024 14:31:00 +0530
Message-ID: <20240917090100.42783-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8V8OVRMvfHiRmMJGVJWIZbTSdgrlbZLL
X-Proofpoint-ORIG-GUID: 5eFctY55oAic0tb9R_ONKobSXbp4tKLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170066

The sleep_sem semaphore and the specific_wait field (member of sched_atom)
are initialized but not used anywhere in the code, so this patch removes
them.

The SCHED_EVENT_MIGRATION case in perf_sched__process_event() is currently
not used and is also removed.

Additionally, prev_state in add_sched_event_sleep() is marked with
__maybe_unused and is not utilized anywhere in the function. This patch
removes the parameter.

If the task_state parameter was intended for future use, it can be
reintroduced when needed.

No functionality change intended.

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 tools/perf/builtin-sched.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5981cc51abc8..fdf979aaf275 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -68,7 +68,6 @@ struct task_desc {
 	struct sched_atom	**atoms;
 
 	pthread_t		thread;
-	sem_t			sleep_sem;
 
 	sem_t			ready_for_work;
 	sem_t			work_done_sem;
@@ -80,12 +79,10 @@ enum sched_event_type {
 	SCHED_EVENT_RUN,
 	SCHED_EVENT_SLEEP,
 	SCHED_EVENT_WAKEUP,
-	SCHED_EVENT_MIGRATION,
 };
 
 struct sched_atom {
 	enum sched_event_type	type;
-	int			specific_wait;
 	u64			timestamp;
 	u64			duration;
 	unsigned long		nr;
@@ -421,14 +418,13 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 
 	wakee_event->wait_sem = zalloc(sizeof(*wakee_event->wait_sem));
 	sem_init(wakee_event->wait_sem, 0, 0);
-	wakee_event->specific_wait = 1;
 	event->wait_sem = wakee_event->wait_sem;
 
 	sched->nr_wakeup_events++;
 }
 
 static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
-				  u64 timestamp, const char task_state __maybe_unused)
+				  u64 timestamp)
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
@@ -468,7 +464,7 @@ static struct task_desc *register_pid(struct perf_sched *sched,
 	 * every task starts in sleeping state - this gets ignored
 	 * if there's no wakeup pointing to this sleep state:
 	 */
-	add_sched_event_sleep(sched, task, 0, 0);
+	add_sched_event_sleep(sched, task, 0);
 
 	sched->pid_to_task[pid] = task;
 	sched->nr_tasks++;
@@ -529,8 +525,6 @@ static void perf_sched__process_event(struct perf_sched *sched,
 				ret = sem_post(atom->wait_sem);
 			BUG_ON(ret);
 			break;
-		case SCHED_EVENT_MIGRATION:
-			break;
 		default:
 			BUG_ON(1);
 	}
@@ -673,7 +667,6 @@ static void create_tasks(struct perf_sched *sched)
 		parms->task = task = sched->tasks[i];
 		parms->sched = sched;
 		parms->fd = self_open_counters(sched, i);
-		sem_init(&task->sleep_sem, 0, 0);
 		sem_init(&task->ready_for_work, 0, 0);
 		sem_init(&task->work_done_sem, 0, 0);
 		task->curr_event = 0;
@@ -697,7 +690,6 @@ static void destroy_tasks(struct perf_sched *sched)
 		task = sched->tasks[i];
 		err = pthread_join(task->thread, NULL);
 		BUG_ON(err);
-		sem_destroy(&task->sleep_sem);
 		sem_destroy(&task->ready_for_work);
 		sem_destroy(&task->work_done_sem);
 	}
@@ -751,7 +743,6 @@ static void wait_for_tasks(struct perf_sched *sched)
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
-		sem_init(&task->sleep_sem, 0, 0);
 		task->curr_event = 0;
 	}
 }
@@ -852,7 +843,6 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -884,7 +874,7 @@ static int replay_switch_event(struct perf_sched *sched,
 	sched->cpu_last_switched[cpu] = timestamp;
 
 	add_sched_event_run(sched, prev, timestamp, delta);
-	add_sched_event_sleep(sched, prev, timestamp, prev_state);
+	add_sched_event_sleep(sched, prev, timestamp);
 
 	return 0;
 }
-- 
2.43.2

