Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724CDDAC
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 09:21:45 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77AA9
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 02:21:39 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3939Cng2010458;
	Tue, 3 Oct 2023 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ojWVqqCanbWIGjBqj/6z6jpt30YBiwx6HH/W2OdozDU=;
 b=SwyHo+YPQx1hV33CQov7QaWSPURpyNZtpbCr6Ya4LxSkD7aHOzAS6Me4uge8NaL6c8gR
 TvdUCJpdiAr0eb7MzIwBmUi2fNRmXfMvHZSlVhaXOsWm0Iys+BPGYRKVzpcHpgyGj1aG
 OLqzyrYmki5e393fjAVJCIAGlCRhMeEH49hB5MvZyzWi7eZ66qB6RezR7ti1hUEkSCQx
 0m4fg/rpcuzd6HOZLRQoZL/xgFwDq5TRWdixLyMVE4UcdnfeZQ7K1joYDdtaweOE4Cx0
 iJ3zVpYv38HNkIw96SD72Ok6VKkIxpoRIWMSay83q2lSeCjGvN0lEHZprRjcunwTgsgV 2w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgg49r6sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 09:21:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3938tMvU010941;
	Tue, 3 Oct 2023 09:21:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q1g0be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 09:21:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3939LWRC30015764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Oct 2023 09:21:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F67E20043;
	Tue,  3 Oct 2023 09:21:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BE82004B;
	Tue,  3 Oct 2023 09:21:30 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.171.39.117])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Oct 2023 09:21:30 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org
Cc: maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: [PATCH] tools/perf: Update call stack check in builtin-lock.c
Date: Tue,  3 Oct 2023 14:51:13 +0530
Message-Id: <20231003092113.252380-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PZVq9_28fDphR-wzA-3Qr4MVpA225fnh
X-Proofpoint-ORIG-GUID: PZVq9_28fDphR-wzA-3Qr4MVpA225fnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The perf test named "kernel lock contention analysis test"
fails in powerpc system with below error:

[command]# ./perf test 81 -vv
 81: kernel lock contention analysis test                            :
 --- start ---
test child forked, pid 2140
Testing perf lock record and perf lock contention
Testing perf lock contention --use-bpf
[Skip] No BPF support
Testing perf lock record and perf lock contention at the same time
Testing perf lock contention --threads
Testing perf lock contention --lock-addr
Testing perf lock contention --type-filter (w/ spinlock)
Testing perf lock contention --lock-filter (w/ tasklist_lock)
Testing perf lock contention --callstack-filter (w/ unix_stream)
[Fail] Recorded result should have a lock from unix_stream:
test child finished with -1
 ---- end ----
kernel lock contention analysis test: FAILED!

The test is failing because we get an address entry with 0 in
perf lock samples for powerpc, and code for lock contention
option "--callstack-filter" will not check further entries after
address 0.

Below are some of the samples from test generated perf.data file, which
have 0 address in the 2nd entry of callstack:
 --------
sched-messaging    3409 [001]  7152.904029: lock:contention_begin: 0xc00000c80904ef00 (flags=SPIN)
        c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kallsyms])
                       0 [unknown] ([unknown])
        c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.kallsyms])
        c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
        c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
        c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
        c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
        c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])

sched-messaging    3408 [005]  7152.904036: lock:contention_begin: 0xc00000c80904ef00 (flags=SPIN)
        c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kallsyms])
                       0 [unknown] ([unknown])
        c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.kallsyms])
        c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
        c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
        c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
        c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
        c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])
 --------

Based on commit 20002ded4d93 ("perf_counter: powerpc: Add callchain support"),
incase of powerpc, the callchain saved by kernel always includes first
three entries as the NIP (next instruction pointer), LR (link register), and
the contents of LR save area in the second stack frame. In certain scenarios
its possible to have invalid kernel instruction addresses in either of LR or the
second stack frame's LR. In that case, kernel will store the address as zer0.
Hence, its possible to have 2nd or 3rd callstack entry as 0.

As per the current code in match_callstack_filter function, we skip the callstack
check incase we get 0 address. And hence the test case is failing in powerpc.

Fix this issue by updating the check in match_callstack_filter function,
to not skip callstack check if the 2nd or 3rd entry have 0 address
for powerpc.

Result in powerpc after patch changes:

[command]# ./perf test 81 -vv
 81: kernel lock contention analysis test                            :
 --- start ---
test child forked, pid 4570
Testing perf lock record and perf lock contention
Testing perf lock contention --use-bpf
[Skip] No BPF support
Testing perf lock record and perf lock contention at the same time
Testing perf lock contention --threads
Testing perf lock contention --lock-addr
Testing perf lock contention --type-filter (w/ spinlock)
Testing perf lock contention --lock-filter (w/ tasklist_lock)
[Skip] Could not find 'tasklist_lock'
Testing perf lock contention --callstack-filter (w/ unix_stream)
Testing perf lock contention --callstack-filter with task aggregation
Testing perf lock contention CSV output
[Skip] No BPF support
test child finished with 0
 ---- end ----
kernel lock contention analysis test: Ok

Fixes: ebab291641be ("perf lock contention: Support filters for different aggregation")
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/builtin-lock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f2134274..e47cf524d3bb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -524,6 +524,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack)
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
+	const char *arch = perf_env__arch(machine->env);
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -531,7 +532,21 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack)
 	for (int i = 0; i < max_stack_depth; i++) {
 		struct callstack_filter *filter;
 
-		if (!callstack || !callstack[i])
+		/*
+		 * In powerpc, the callchain saved by kernel always includes
+		 * first three entries as the NIP (next instruction pointer),
+		 * LR (link register), and the contents of LR save area in the
+		 * second stack frame. In certain scenarios its possible to have
+		 * invalid kernel instruction addresses in either LR or the second
+		 * stack frame's LR. In that case, kernel will store that address as
+		 * zero.
+		 *
+		 * The below check will continue to look into callstack,
+		 * incase first or second callstack index entry has 0
+		 * address for powerpc.
+		 */
+		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
+						(i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.39.3

