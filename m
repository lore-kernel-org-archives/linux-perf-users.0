Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009B481AB6
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329078; cv=none; b=ss80ReUnNwGR3Qdi8mjPR0X2g0fyB3Av26AYlpxPzrefFR9i4Efr7YP/miP9himZt/7VFGlsBgLijJx3uJcrYp1sksr82ErvRiG1tBND2WJ2ZxvvhkBARNbxSyIPanf+azn0AOv/q6DU2cidPStt+d6Jw0XH8UhronynEtBh6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329078; c=relaxed/simple;
	bh=oNBm5JqaDjOMqFxdWU8xI+2ff2U2qRL5KzLYIcE4kr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMbK6ymIZZSnloY8VW8VtQEzYhrOLG9IyyklXyYvip/vzzxpnWc7zuUaqT6m2Dpg2v8BXGB0r5kxdtKA/rpoLHPcHD+c0ueihYZ9HcrILWFWWXnSA/JFy5Q21jC98cc9mXQtqcLq+3Po/hCRzmM52/MD1yKZqXlzg/CijkLRAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKCPsu6P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKCPsu6P"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHhCa3952798;
	Wed, 29 Jul 2026 12:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UUrP+qHkEvCx1RAW9
	jTvLpW68ue7FaDGyZhgWfcg0cA=; b=BKCPsu6PLUgIXUhbu/JlfU3y7Ou9szv8P
	C9LnWK60uaIMaMOM/rX66u5fWe+OiCj9YFf20A1QUaqPYCvr4dBz6NNr1IcVcqwj
	5Tavzzi8kbm6fQv3Ri0wdWARlRPArOYzTmSmLPquZnu/U4Jww1TacJIuTtiyVyjl
	oBtapwVX/xuewKJlJNTulKuol2RE/d0173ZKOGzPCqbXEOvEnBUkgFW0fN0bmLtS
	Qy+YfC/0SqCwRCdp7BhMBqv3HFdbE7NC0ET0GFG41qOhJKrX9/YmTd7avAHHdfAK
	o28sD8CnGGZspPMTVvLgdQxa2bXupi/Hkh/r6NEiH5Vct6L6VK8Cw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj9w22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfKTF030084;
	Wed, 29 Jul 2026 12:44:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y6e7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCiH3233161494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1960420043;
	Wed, 29 Jul 2026 12:44:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C45C620040;
	Wed, 29 Jul 2026 12:44:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:13 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 3/6] tools/perf: Add arch hook to drain remaining data before event close
Date: Wed, 29 Jul 2026 18:13:57 +0530
Message-Id: <20260729124400.65009-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729124400.65009-1-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfXwoOBCtVV4MFH
 jx+CkklP6IbEZkyORSLjAaTqULTre5q0EPf5XI9uaE0+6U7f9rpqpJy/5mjyKUWI92KW8b7qsLR
 5yhge/Uqc8niC/zKZmKn7dG2KljE7vQ=
X-Proofpoint-GUID: GtkWh6S77OISrbQZya-aW49ZX_BF0--A
X-Proofpoint-ORIG-GUID: X_1yub7MyVOQEw7JIjQgX-9dHAgLTw4S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX6Syb0Et+2062
 npfleCn/eGxGhYfovdvmGO13FhKZWCv1JxJviATm49yA2dovKNtLUH5JHdGoopEJJ0A2zXWmlEh
 JEPVN9FHVYlhSics+kTPO4yH7dar81iaX1MHjde/XoLju80b8xHzkDvOBEjBPafA9dhI0gRfPUa
 GBQeUXFmtJ7LP34DA78YEIFHskk0+U3iJkdbKo1udHEguKnlrFZ97dlzf+PV347Ptg6V3RqWqUZ
 J4OaghAN/habubWnWZ5EvhE+b4Zi9Yy95GASq2+rS/F51Dk4Ty/mykI7DuOUJnpPqUvPtLukq5G
 fa5oO+m7vSf73/dfbpczc/klUomyIBW0seRVMAHnS7DIbFxe7fGS3iQTpeNvqv/Z7d3WTJCwOyJ
 pCfGCzKaTO2li3fD4ZlVF31Yu3ixi+vyZzgL2kNf9GXdJlHD+O64bkXXREDO7DAFx1dw3d2+J3l
 i0o6OgHWFC0g+WcA3iw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a69f5a5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=WLsJLc2lzLm1hSGsWXwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290102

While collecting samples using perf record, __cmd_record() disables the
evlist once recording is complete. After that, event fds are no longer
read and any remaining PMU-specific data cannot be drained.

Add a weak arch_perf_record__need_read() hook so architecture code can
indicate that more data remains to be collected before events are
disabled and closed. When the hook reports pending data, perf record
performs another read pass via record__final_data().

A static volatile sig_atomic_t drain_interrupted flag is added.
sig_handler() sets it when a second signal (SIGINT/SIGTERM) arrives
while done is already set, allowing a second Ctrl+C during the drain
loop to abort immediately.  Without this, a user who presses Ctrl+C
twice while HTM data is being drained would have no way to interrupt
a stalled drain loop.

This allows architectures such as powerpc HTM to drain trace data and
associated metadata before the event is closed.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- Fix drain_interrupted to not trigger on SIGCHLD: change the condition
  in sig_handler() from "if (done)" to "if (done && sig != SIGCHLD)".
  V3 set drain_interrupted on a SIGCHLD that arrived while done was
  already set, aborting the drain loop on normal child workload
  completion even though no second Ctrl+C was pressed.
- Drain all thread mmaps in record__final_data(): iterate over all
  rec->nr_threads slots and temporarily switch the TLS 'thread' pointer
  to each thread_data[t] before calling record__mmap_read_all(), then
  reset it to thread_data[0] afterwards.  V3 called
  record__mmap_read_all() once with whatever 'thread' pointed to,
  leaving the mmaps of worker threads un-drained when --threads is in
  use.  Adds local variable 'int t' for the loop counter.
- Fix the post-loop fallback condition from "if (!disabled)" to
  "if (target__none(&opts->target) || !disabled)" so that the final
  drain is always executed for child workloads.  In the child-workload
  path (target__none == true) the in-loop disable block is never
  entered, so disabled stays false, but the old "!disabled" test
  happened to be true there only by accident; making the intent
  explicit also handles any future path where disabled could be set
  early.  Remove the now-redundant evlist__disable() call that V3
  placed inside the post-loop block, since the disable is handled by
  the existing code below.

Changes in V3:
- Add static volatile sig_atomic_t drain_interrupted.  Set it in
  sig_handler() when a second signal arrives while done is already set.
  This lets a second Ctrl+C abort the drain loop immediately.  V2
  tested done > 1 to detect a second signal, which is unreachable
  because done is only ever set to 1.
- Replace rec->bytes_written with record__bytes_written(rec)
  (which includes rec->thread_bytes_written) so the no-progress
  check accounts for data written by the AIO/thread path.
- Add a retry counter (FINAL_DATA_MAX_RETRIES 20, 20 x 1 ms = 20 ms
  maximum) instead of aborting on the first stall.  The no-progress
  sleep of 1 ms is enough for the AUX ring buffer consumer (perf's
  ~1 ms poll interval) to advance the tail pointer.
- Move record__final_data() into the in-loop disable block
  (before evlist__disable()) as well as into a post-loop if
  (!disabled) block that covers both the early-break and
  child-workload paths.  V2 only called it inside the loop
  with a final_data_drained guard, missing the early-break
  and child-workload cases.
- Remove the now-unnecessary bool final_data_drained local variable.

Changes in V2:
-  V1's callback was responsible for driving the read loop
  including evlist__enable cycling. Removed that logic
- Use bytes written to check if session needs to be continued.
- Patch is now 3/6 instead of 3/9.

 tools/perf/builtin-record.c | 77 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/record.h    |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..4c3b96fc0ac0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -192,6 +192,7 @@ struct record {
 };
 
 static volatile int done;
+static volatile sig_atomic_t drain_interrupted;
 
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
@@ -681,6 +682,8 @@ static void sig_handler(int sig)
 	else
 		signr = sig;
 
+	if (done && sig != SIGCHLD)
+		drain_interrupted = 1;
 	done = 1;
 #ifdef HAVE_EVENTFD_SUPPORT
 	if (done_fd >= 0) {
@@ -2437,6 +2440,68 @@ static unsigned long record__waking(struct record *rec)
 	return waking;
 }
 
+/*
+ * Weak symbol - architecture can override to indicate if more
+ * data needs to be collected before finishing output.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+__weak int arch_perf_record__need_read(struct evlist *evlist __maybe_unused)
+{
+	return 0;  /* Default: no arch-specific data to collect */
+}
+
+static void record__final_data(struct record *rec)
+{
+	u64 last_bytes_written = 0;
+	int retries = 0;
+	int t;
+#define FINAL_DATA_MAX_RETRIES 20  /* 20 * 1 ms = 20 ms max wait */
+
+	/*
+	 * Collect any remaining architecture-specific data.
+	 * The arch code checks if more data exists, and we do the actual
+	 * reading here since we have access to record__mmap_read_all().
+	 * This code performs the additional read pass while events are
+	 * still live.  A second SIGINT/SIGTERM during drain sets
+	 * drain_interrupted and aborts the loop immediately.
+	 *
+	 * When --threads is enabled, record__mmap_read_evlist() reads the
+	 * maps belonging to the calling thread's TLS 'thread' pointer.
+	 * Calling record__mmap_read_all() from the main thread only reads
+	 * thread_data[0]'s maps.  Iterate over all thread slots and
+	 * temporarily switch 'thread' to each one so that every worker's
+	 * mmaps are drained, matching the pattern used in record__thread().
+	 */
+	while (arch_perf_record__need_read(rec->evlist)) {
+		if (drain_interrupted)
+			break;
+
+		last_bytes_written = record__bytes_written(rec);
+
+		for (t = 0; t < rec->nr_threads; t++) {
+			thread = &rec->thread_data[t];
+			if (record__mmap_read_all(rec, true) < 0) {
+				thread = &rec->thread_data[0];
+				return;
+			}
+		}
+		thread = &rec->thread_data[0];
+
+		if (record__bytes_written(rec) == last_bytes_written) {
+			if (++retries >= FINAL_DATA_MAX_RETRIES) {
+				pr_warning("Final data drain made no forward progress after %d retries.\n",
+					   FINAL_DATA_MAX_RETRIES);
+				break;
+			}
+			usleep(1000); /* 1 ms: let AUX ring buffer consumer advance */
+		} else {
+			retries = 0;
+			usleep(100);
+		}
+	}
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -2864,11 +2929,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		 */
 		if (done && !disabled && !target__none(&opts->target)) {
 			trigger_off(&auxtrace_snapshot_trigger);
+			record__final_data(rec);
 			evlist__disable(rec->evlist);
 			disabled = true;
 		}
 	}
 
+	/*
+	 * If the loop exited via the early break (ring buffer empty when done
+	 * was set, so the in-loop disable block was never reached), or this is
+	 * a child workload (target__none, so the in-loop block is never entered
+	 * and disabled stays false), drain any remaining arch-specific data now.
+	 * Events are still live in both cases: for child workloads they die with
+	 * the process after this point; for non-child they are disabled below.
+	 */
+	if (target__none(&opts->target) || !disabled)
+		record__final_data(rec);
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 93627c9a7338..56de4f95a836 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -10,6 +10,7 @@
 #include "util/target.h"
 
 struct option;
+struct evlist;
 
 struct record_opts {
 	struct target target;
@@ -95,4 +96,6 @@ static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 	return opts->record_switch_events_set && !opts->record_switch_events;
 }
 
+int arch_perf_record__need_read(struct evlist *evlist);
+
 #endif // _PERF_RECORD_H
-- 
2.43.0

