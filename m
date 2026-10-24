Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877174;
	b=BTg1LkRJavoYWOYvPndvB9yJ1JKod0+3kWeFwTOK+jSORX+vE5NspD1nuTbDG9giwk3H
	 toQIp3LT4LSbOK9gtZTl1sFnLIF2bF9MR84leJtT2NNXQrkWg6ijJSFQa8TtAmbZE562x
	 sMFBDlKn9hKCwBlNRS13HmA62u9kkQ218BQ0xLBd/TI5C380eIaW1YfhLHXky0ZKU2/85
	 zQ2J4KWcaOzU+TwMsLUvKgB3SM6useCy1J8qS7l+S97IjtSXts7rLhkpr7JR0R4lKRRhO
	 u8+rJigUU5NKxgX1zoc9N+orYQNYpg2nb+jk8c/xgbnpXy8ptkCEXMRl0VRsSYGVH8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877174;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3gn/ly0cCUqcagG7ieP7zMMQqm7M8PJ+fH3es450JQs=;
	b=a9E8HH6/n3FW4WDiyYyXoLAaM1GSGT2jbGXZ3pchPOsQicgkZHsshQaIG6eW59UX+Oph
	 Dr6+U0vgWG3h4cw0RxSJAhm86bolaKowtf0L6lXYgdvhdhvM9ue6hT9E7scIWUqViqssC
	 ipCzBk+wa2+6S30+2WsGYGPre7CELpRF83HXn2cEHx1skgY31h/+UM8MUGJs0Lbvxw+AQ
	 T4gU6E+3tebjoSeNHnTZQl/GWoKoa9epNeIZVaRtVSzcv3l56va8od2c3zacHw8SgBqt+
	 8pqSf69UPQD5fE71IXf1qWvxyTCPSkypDn4XRwChO1E1LUvoz/nDhGPl5kos3u6dddA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.98
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022098.outbound.protection.outlook.com [52.101.101.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26400606A31A;
	Sat, 24 Oct 2026 21:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26400606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1PVOn5NnqnRXDr4FqpzJh9In9bDrB/ueldg7l//kv6ALkdxHRwPibG5LleAQjn46kghH6fXzFmMvxCA26YqzrOrPIXRUWtfoJk51kmeMeyxa6t4fhm1Qkhz6PN+BOMqzds2h8OxgX8fh/5mvtIgujfHIUokUefg2MA14NlOMLU/mvpxjrKX1muu2M/xVdlC6tegUvNRY+ARlmLAejZ9JMQ4TfA1zbeq9t6fUeXAybDRrBFYajoAPwa0kaP31MOQE54wSSNN09nNcZkm9/TDVn1B8OQ4x7DnbBVLArqiVIRlRqbYlrQw0O2QW8Ta0/bCSj9YlXjlfHOfQPIEPoSpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3gn/ly0cCUqcagG7ieP7zMMQqm7M8PJ+fH3es450JQs=;
 b=TpitTMscv1lanaJwboE3rdp1Y3nSov55eMnwfld8czjoQPV9zpKsYgZxIA9F3QVRq9M0ljHuUntR3K5kWcYu2E7iiynzTwx5lKKLXrhQKkUpw2iHOxzBRVJ8kjuaZovs9k9d7n5InXgebopzxh/W0TK66F4Pyr63zPkyJnU6LAleFX8PFSE9p9oPyJjfaBJfJc6Szw0LBOk9HuoYFJySYyUjuB6Fvr4czBwXGn56aSKcWuRTOgFnREQVhDyWNOfKBiAiHEL1tbfztQq4pdvwDjjIxHtvrah0bnUnGbTJPnj/oOq9RFV6dfVhlR87i6XVh7S9fe8TOCQXbPXV1o2xpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:12 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atomlin@atomlin.com,
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v10 05/10] perf ftrace: Support context switch tracking in function graph tracer
Date: Sat, 24 Oct 2026 17:25:44 -0400
Message-ID: <20261024212549.450634-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0869.namprd03.prod.outlook.com
 (2603:10b6:408:13d::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 642abf07-4fe7-4af0-7b74-08df32156d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|261022115727099003|10067099003|261009223027099003|261021130227099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	+NyVukyCEo906X3TSpcEkLaWXAwIhUW5umlrpyWnTx8affoXylvIw4F2esNt/5ZYF4/YFoApXFzElf5I/EzMlEh0hrv9JdYoe7gg7TaQkGm7KVcWO/YLbOiT4rS2iMXU6zyHb6g90sOZsaHDAbs4Dp5pAxjWqZWQ9QB9OuOWXf82u2Mmvq7W9R2PfHGjQrztNgmGdGCdKsJSLeIGhzCBnUeSYpqwBVLOjRWMLYijijNJtBbVc9CiubONhbqgU96FVnOz8927HykGQPmITRZdbujWmktLmMVfplRiWGisBR3AoCtXfT3TYCizkNLSIRt8WkmGcRZOunP9iqbi/M/DOLJqpi7bEf12qbwoREJsWfyFjgpN4UUr19cIDMEi7lOxZye9PWHmtsWJuMihxzKhsKMPu1U5HC05906+vEa9xiLVXDHFBi8Z8/nNkjwg3+WQ3Ap21sk4igLvJyblDMfxhFINM3du1zB+E0K9xMDAknmmvIvRjnBJhhZbymbAVhLGOs3657Ws5qOhXtwcf9GISqihtv3Ftt0tUkYZW9sBGEoFQBy+IQvD11fcsVL40tlr1dPBecta3oUoRmt+n98PR8usRhDaxCfIBq62ANphWe8uxbM7sIyemdth0PYQJiEepzLYPNCsnSi5XvlemHh+D6IDCdff1lTWKHV1hoXRChU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(261022115727099003)(10067099003)(261009223027099003)(261021130227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021133027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+GZKdZPA4ak+MKdiCy8IHgDWKiX1qzw30Ae4nsVoFOSMizdgDpuywp4CjJM?=
 =?us-ascii?Q?9chajZF6TAXH8Wbu19NX+FVs8k/4i3BSNBS5LtO058WAHYM4zvnOyvrVhAkN?=
 =?us-ascii?Q?X8Fq7GPiRyUfhkvcFcBqq8N9quudXrK6C7NX1ltJdAB1E9t8/oQlqU9N4WxH?=
 =?us-ascii?Q?g9GY73hYSbnkPAH7bW75B1RKtWqAjCI5O3Ewh5hOIJ/BF5d81lQbhtuJfY/T?=
 =?us-ascii?Q?rCDWLmbMjzUnt8v/dLgK/mRoC1KbWiQqn0Ix3uxs9GI50Ivmy38uMjcjM3Ef?=
 =?us-ascii?Q?AAY59gUwtDheAiy7DFJy+AaOBza7YXUgpZVAoRIoupwaJSbFmwBV8RepkBuZ?=
 =?us-ascii?Q?k+Ilt4vy18Pb66zAd6NVm3jwmvIS8mFrOqDJWHp3UJfAT3ob1tA47QLUC6gT?=
 =?us-ascii?Q?g6z1zX9k60fO9U2wYXPTJII8gL/fR3tZTafR4HqWpbRvLgWxYP5/kncj6BMI?=
 =?us-ascii?Q?3JAhYodZgS+9yzfZ9T8blyUubO421DvZpWQF30wJThxrqjaPSNossjZkiNXd?=
 =?us-ascii?Q?Tks40RGl6RcEwTTqmNmEwtf7Lnn7ZWYSULKK/cjVDp/YNTNWEJx1SD6i49Hi?=
 =?us-ascii?Q?QNGPHQyGoVYEv+bfcOk/WpdmVjeImEaU0rrppYiloBIlQAxFqFVbUQDBhAry?=
 =?us-ascii?Q?uzZ3ns0+G5cZ3shtr73Zna/Fu8k7bLqGDRcTlj3rk4QVzZ7maF0xN/fowhCR?=
 =?us-ascii?Q?y3CuexN+L78nW6+SWfqZ646PJ5jIWfcvMnvB8gWF8htdpMqAHqV1oZxppyWn?=
 =?us-ascii?Q?c40fysTkMVBMLAMRzdkJyk2P55BNERkCA2RjOvosEm/KyLHL4IgOQxxgzEQH?=
 =?us-ascii?Q?an6KN9Goo9WfkmEoLCUtlbt/n2BjZOcJUKOp9yKTUl9nTW5w5SOQtT+zRekv?=
 =?us-ascii?Q?Ifq9ThW+cWJXX/qRKe3X3LKLdq/m4RAjB5fUW1HMQVTGoW65LtAbcD8eedpp?=
 =?us-ascii?Q?11JIBHV8mhYFQp3si+XLqDkVt9bBMOOefqVMSlfIjsMbfBaHIS+pKKS72GAc?=
 =?us-ascii?Q?H7l6D7jZylSOSVFaZ1XaJQ5lEaOUqdjPKGo1Pbd3bJAeq6YeK4EDbO6WmZia?=
 =?us-ascii?Q?uckrzc5h8aO/TK45+kRM3JncQDbVHpYOHezOdH/fs0xNmnXCyzfvgNf3hw8T?=
 =?us-ascii?Q?Kks1drqFteHOuZ3l0aD9bBFm33z4EfIjt1VAKWJQ+Al9NHXJ9QbkCPEGZCG2?=
 =?us-ascii?Q?1wcEBF/LMCrSmcy2TP1cpfiOfSFEp8IMOxOPZh5i/RZTDnNHubNBqxmUL7WU?=
 =?us-ascii?Q?Q0vD6jkYMl7AMsWkyd4u8f4KmIwk0gRlUwv5goiGSJe3wkGHuZbVjSS0Iv6g?=
 =?us-ascii?Q?jwiMXQgY4NTkf/tP/B+NS6Hb327wW89LUA6y6w/QI9whCzkD9TlJHMTtaIvI?=
 =?us-ascii?Q?KWmL+87ykj/W51nkQYM29WJ9BUTeJeOZBJNk4lLZmodF5D2x5TqCOBm2/ccX?=
 =?us-ascii?Q?03KU7qbeXXWYV1NJ+odQCwgCtOTPTcwDBLXmNJlcUDf8kX6DsiURFMJ1e3V2?=
 =?us-ascii?Q?hEirGKYc6iWSd3rH8w0Br6jxl+tyXIVgVV6lXmTcIo/tVbpmV0p411t/BrgQ?=
 =?us-ascii?Q?nCobh5kxSNDfud4KuQ+MhdFR5iRE3WwWGFzCpBbVzLn+PxqKcawZQy/wCfB3?=
 =?us-ascii?Q?zHh9rvr1VKjd/VrBxhUM35c/xL8cKDd/kQ54gZOlUXXBLe1et08Vg0wTzPAC?=
 =?us-ascii?Q?wN8JOWQyJJ8JvL/IyB5e/waz3BtZ0zhnhmXBgQZY7TD4AgFSo7dH1NVHX0Ld?=
 =?us-ascii?Q?ZkJNpbECHw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642abf07-4fe7-4af0-7b74-08df32156d4f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:12.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTwFUd2YjhpJ/Wjk6pLwbaIHIk7mrXE0w6qTt2lgJahfCuvZsYuaq7IgW+TiHf43BjlFtPb1IyWBZlIg37Dd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

When tracing multiple tasks across multiple CPUs, kernel context switches
cause different threads of execution to interleave on the same CPU. Without
context switch awareness, interleaved function calls corrupt the tracked
call stack.

Add context switch detection and per-task state tracking:

    1.  Context switch banner parsing

        Implement parse_context_switch() to parse context switch banners
        (e.g. " 0) <idle>-0 => migrati-19") in the trace stream, extracting
        the CPU number and both outgoing and incoming task PIDs.

    2.  Task state rekeying and migration

        Implement ftrace_task_state__rekey() to reassign initial unknown
        task states to real PIDs upon discovering outgoing task identity,
        pruning exited frames from older states and merging active call
        stacks when a task migrates across CPUs.

    3.  Verbose mode and single-PID binding

        In find_func_column(), parse the comm-pid column in verbose mode
        to bind active task state on each line record.

        In get_cpu_state(), pre-bind single-PID workloads across all CPUs
        when context-switch banners are absent.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/util/ftrace.c | 284 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/ftrace.h |   2 +
 2 files changed, 282 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 95db57e70d11..fea61a9e17b1 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -13,11 +13,14 @@
 #include <errno.h>
 #include <sys/types.h>
 #include "debug.h"
+#include "evlist.h"
 #include "util/ftrace.h"
 #include "util/string2.h"
+#include <perf/threadmap.h>
 
 static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
 static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
+static u64 ftrace_event_seq;
 
 /**
  * ftrace_cpu_states__clear - Free allocated CPU and task stack states
@@ -42,6 +45,7 @@ void ftrace_cpu_states__clear(void)
 	}
 
 	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
+	ftrace_event_seq = 0;
 }
 
 /**
@@ -92,6 +96,7 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	ts->max_stack = FTRACE_MAX_STACK;
 
 	ts->pid = pid;
+	ts->min_raw_indent = -1;
 	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
 	head = &ftrace_task_hash[key];
 	hlist_add_head(&ts->node, head);
@@ -124,6 +129,157 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
 	return 0;
 }
 
+/**
+ * ftrace_task_state__rekey - Reassign a task state to a new PID
+ * @ts: The task state to re-key
+ * @new_pid: The new process ID to associate with the state
+ *
+ * Rehash @ts under @new_pid. If a task state for @new_pid already exists,
+ * merge or replace it and update active CPU references accordingly.
+ *
+ * Return: A pointer to the active task state associated with @new_pid.
+ */
+static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_state *ts,
+							  pid_t new_pid)
+{
+	struct ftrace_task_state *existing;
+	u32 key;
+	int j, c;
+	int to_copy;
+
+	if (ts->pid == new_pid)
+		return ts;
+
+	hlist_del_init(&ts->node);
+
+	existing = find_task_state(new_pid);
+	if (existing) {
+		struct ftrace_task_state *older, *newer;
+		int base_raw_indent;
+
+		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
+			if (ftrace_cpu_tasks[c] == ts)
+				ftrace_cpu_tasks[c] = existing;
+		}
+
+		if (ts->seq < existing->seq) {
+			older = ts;
+			newer = existing;
+		} else {
+			older = existing;
+			newer = ts;
+		}
+
+		base_raw_indent = -1;
+		if (newer->depth > 0)
+			base_raw_indent = newer->stack[0].raw_indent;
+		else if (newer->min_raw_indent >= 0)
+			base_raw_indent = newer->min_raw_indent;
+
+		/*
+		 * Prune frames on the older stack that have already exited
+		 * (i.e. whose raw_indent >= base_raw_indent, along with any
+		 * synthesized inlined frames).
+		 */
+		if (base_raw_indent >= 0) {
+			while (older->depth > 0) {
+				struct ftrace_stack_frame *top =
+					&older->stack[older->depth - 1];
+
+				if (top->inlined) {
+					free(top->name);
+					if (older->inlined_depth > 0)
+						older->inlined_depth--;
+					older->depth--;
+				} else if (top->raw_indent >= base_raw_indent) {
+					free(top->name);
+					older->depth--;
+				} else {
+					break;
+				}
+			}
+		}
+
+		to_copy = ts->depth;
+		if (to_copy > 0) {
+			while (existing->depth + to_copy > existing->max_stack) {
+				if (ftrace_task_state__grow_stack(existing) < 0)
+					break;
+			}
+			if (existing->depth + to_copy > existing->max_stack)
+				to_copy = existing->max_stack - existing->depth;
+
+			if (older == ts) {
+				memmove(&existing->stack[to_copy], &existing->stack[0],
+					existing->depth * sizeof(existing->stack[0]));
+				memcpy(&existing->stack[0], &ts->stack[0],
+				       to_copy * sizeof(existing->stack[0]));
+			} else {
+				memcpy(&existing->stack[existing->depth], &ts->stack[0],
+				       to_copy * sizeof(existing->stack[0]));
+			}
+
+			existing->depth += to_copy;
+			for (j = 0; j < to_copy; j++) {
+				if (ts->stack[j].inlined)
+					existing->inlined_depth++;
+			}
+			for (j = to_copy; j < ts->depth; j++)
+				free(ts->stack[j].name);
+		}
+
+		if (ts->seq > existing->seq)
+			existing->seq = ts->seq;
+		if (existing->depth > 0) {
+			existing->min_raw_indent = -1;
+		} else {
+			int m = newer->min_raw_indent;
+
+			if (older->min_raw_indent >= 0 &&
+			    (m < 0 || older->min_raw_indent < m))
+				m = older->min_raw_indent;
+			existing->min_raw_indent = m;
+		}
+
+		free(ts->stack);
+		free(ts);
+		return existing;
+	}
+
+	ts->pid = new_pid;
+	key = hash_32((u32)new_pid, FTRACE_PID_HASH_BITS);
+	hlist_add_head(&ts->node, &ftrace_task_hash[key]);
+	return ts;
+}
+
+/**
+ * ftrace__get_single_pid - Retrieve the single target process ID being traced
+ * @ftrace: Perf ftrace context
+ *
+ * Check whether @ftrace is configured to trace a single process without
+ * child inheritance. If the thread map contains exactly one valid process
+ * ID and child task inheritance is disabled, return that PID so that
+ * initial per-CPU task states can be bound directly to the target process.
+ *
+ * Return: The target process ID if tracing a single process without
+ *         inheritance, or -1 otherwise.
+ */
+static pid_t ftrace__get_single_pid(struct perf_ftrace *ftrace)
+{
+	struct perf_thread_map *threads;
+	pid_t pid;
+
+	if (!ftrace || !ftrace->evlist || ftrace->inherit)
+		return -1;
+
+	threads = evlist__core(ftrace->evlist)->threads;
+	if (!threads || perf_thread_map__nr(threads) != 1)
+		return -1;
+
+	pid = perf_thread_map__pid(threads, 0);
+	return (pid > 0) ? pid : -1;
+}
+
 /**
  * get_cpu_state - Get or allocate active task stack state for a given CPU
  * @ftrace: Perf ftrace context
@@ -132,17 +288,107 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
  * Return: A pointer to the CPU's active task stack state, or NULL on error or
  * out-of-bounds CPU index.
  */
-static struct ftrace_task_state *get_cpu_state(struct perf_ftrace *ftrace __maybe_unused, int cpu)
+static struct ftrace_task_state *get_cpu_state(struct perf_ftrace *ftrace, int cpu)
 {
+	pid_t single_pid;
+
 	if (cpu < 0 || cpu >= FTRACE_MAX_CPUS)
 		return NULL;
 
-	if (!ftrace_cpu_tasks[cpu])
-		ftrace_cpu_tasks[cpu] = get_task_state(FTRACE_UNKNOWN_PID(cpu));
+	if (!ftrace_cpu_tasks[cpu]) {
+		single_pid = ftrace__get_single_pid(ftrace);
+		if (single_pid > 0)
+			ftrace_cpu_tasks[cpu] = get_task_state(single_pid);
+		else
+			ftrace_cpu_tasks[cpu] = get_task_state(FTRACE_UNKNOWN_PID(cpu));
+	}
 
 	return ftrace_cpu_tasks[cpu];
 }
 
+/**
+ * parse_context_switch - Parse context switch banner and update CPU's task
+ * @line: The trace line containing the banner
+ *
+ * Check if @line is a context switch banner (e.g. " 0) <idle>-0 => migrati-19").
+ * If so, extract the CPU number and both the outgoing and incoming task PIDs,
+ * re-key any initial unknown task state on this CPU to the outgoing PID, and
+ * update the active task mapping for that CPU to the incoming PID.
+ *
+ * Return: true if @line was a context switch banner, false otherwise.
+ */
+static bool parse_context_switch(const char *line)
+{
+	const char *arrow = strstr(line, " => ");
+	const char *p;
+	const char *next;
+	const char *hyphen;
+	const char *h;
+	char *endptr;
+	char *end_pid;
+	long cpu_val;
+	long prev_pid;
+	long next_pid;
+	pid_t real_prev;
+	pid_t real_next;
+
+	if (!arrow)
+		return false;
+
+	/* Find CPU number before ')' */
+	p = skip_spaces(line);
+	cpu_val = strtol(p, &endptr, 10);
+	if (endptr == p || *endptr != ')')
+		return false;
+
+	if (cpu_val < 0 || cpu_val >= FTRACE_MAX_CPUS)
+		return false;
+
+	/*
+	 * Parse outgoing task PID before " => " (" CPU) comm-pid => ...").
+	 * Scan backwards from arrow to find the hyphen before the numeric PID.
+	 */
+	h = arrow - 1;
+	while (h > endptr && *h == ' ')
+		h--;
+	while (h > endptr && *h != '-')
+		h--;
+	if (h <= endptr || *h != '-')
+		return false;
+
+	prev_pid = strtol(h + 1, &end_pid, 10);
+	if (end_pid == h + 1)
+		return false;
+
+	/* Parse target task PID after " => " (" => comm-pid") */
+	next = skip_spaces(arrow + 4);
+	hyphen = strrchr(next, '-');
+	if (!hyphen)
+		return false;
+
+	next_pid = strtol(hyphen + 1, &end_pid, 10);
+	if (end_pid == hyphen + 1)
+		return false;
+
+	real_prev = (prev_pid == 0) ? FTRACE_IDLE_PID(cpu_val) : (pid_t)prev_pid;
+	real_next = (next_pid == 0) ? FTRACE_IDLE_PID(cpu_val) : (pid_t)next_pid;
+
+	/*
+	 * If no context switch was seen previously on this CPU, its initial
+	 * pre-banner trace records were accumulated under an unknown synthetic
+	 * PID. Re-key that state to real_prev so the initial task's stack and
+	 * frames are preserved when it schedules back in.
+	 */
+	if (ftrace_cpu_tasks[cpu_val] &&
+	    ftrace_cpu_tasks[cpu_val]->pid == FTRACE_UNKNOWN_PID(cpu_val)) {
+		ftrace_cpu_tasks[cpu_val] =
+			ftrace_task_state__rekey(ftrace_cpu_tasks[cpu_val], real_prev);
+	}
+
+	ftrace_cpu_tasks[cpu_val] = get_task_state(real_next);
+	return true;
+}
+
 /**
  * ftrace_parse_retaddr - Parse return address comment from trace line
  * @str: The trace line containing the comment
@@ -307,10 +553,32 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
 	p = endptr;
 
 	if (ftrace->graph_verbose) {
+		const char *proc_start = p;
+
 		p = strchr(p, '|');
 		if (!p)
 			return NULL;
 
+		if (val >= 0 && val < FTRACE_MAX_CPUS) {
+			const char *h = p - 1;
+
+			while (h >= proc_start && *h != '-')
+				h--;
+			if (h >= proc_start && *h == '-') {
+				long pid_val = strtol(h + 1, NULL, 10);
+				pid_t task_pid = (pid_val == 0) ?
+						 FTRACE_IDLE_PID(val) :
+						 (pid_t)pid_val;
+
+				ftrace_cpu_tasks[(int)val] = get_task_state(task_pid);
+			}
+		}
+
+		/*
+		 * In verbose mode, latency-format is also enabled by
+		 * set_tracing_funcgraph_verbose(), emitting a "<lat-fmt> |"
+		 * column after the comm-pid column.
+		 */
 		p = strchr(p + 1, '|');
 		if (!p)
 			return NULL;
@@ -383,13 +651,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_semicolon;
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
-	if (!pipe_char)
+	if (!pipe_char) {
+		parse_context_switch(line);
 		return print_line(ftrace, line, out);
+	}
 
 	cs = get_cpu_state(ftrace, cpu);
 	if (!cs)
 		return print_line(ftrace, line, out);
 
+	cs->seq = ++ftrace_event_seq;
+
 	after_pipe = pipe_char + 1;
 	func_start = skip_spaces(after_pipe);
 	leading_spaces = func_start - after_pipe;
@@ -402,6 +674,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		if (cs->min_raw_indent < 0 || leading_spaces < cs->min_raw_indent)
+			cs->min_raw_indent = leading_spaces;
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		top_raw_indent = -1;
@@ -480,6 +755,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			cs->stack[cs->depth].indent = leading_spaces;
 			cs->stack[cs->depth].raw_indent = leading_spaces;
 			cs->depth++;
+			cs->min_raw_indent = -1;
 		}
 	}
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index fa2974f46582..00e7eb636083 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -119,6 +119,8 @@ struct ftrace_task_state {
 	int			depth;
 	int			inlined_depth;
 	int			overflow_depth;
+	u64			seq;
+	int			min_raw_indent;
 };
 
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
-- 
2.55.0

