Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951916;
	b=S5yJdphQhiavgIe1Bq5FY7AJR4D4Puxugy9sKYLz3wXTUExirf6nf4MX8ZqsY42dSoD0
	 HFkgBFbXOn8vxIs6AyjcpAqqlbMVl5WRFfgIIAw2Scza9UGV8iq3ZoQsknU1fXhpPo3jS
	 1qqV0NMYuYxuX+W0FWYLI4QNsNzvl5t2kTdhz6SUepSzfQ5LLGuJC1PexON0co+VyLDyO
	 cegeBpHQgGlKoKJ9442QP3BvaT/Kgs//xYF/pgHj3QMfoqYVBhRK4KE7wfFlqnqete5oA
	 NpgVPCz3POPHL40HZSV1zksnkRFrHPXAF3/y0FnyrzOlloeBw2DKa8WmwQ1kZyjv5VA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951916;
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
	bh=Kc0JHhPutDLfEkkJBnD5JAF8Q7Hw8Nz0T6eEHPnBgQ0=;
	b=qq4CJ5I1jktPC5vdwqDftpKMFN/L7lT+j1iZPXcOayrj8L1BkjQgRaZjBM/2nMskUzq/
	 z4ZRO8OhXU6q1gc2mCQhHdG+5hu5igSIec+S+8oRCatpFcSlO1FU1Yf8mpLLD1gs79xNq
	 q3uZsJ9x8aptKYYdiwItzBjRTiSS5t7q/B/D3y9HAv2mFn4BnMhXMVwFGEy/6oQkbjbID
	 FgjUVNpgc49TPdsns3Wcvg6CY5LQUjKLPqlqTelV+4v7JKUG69JIPkDCfvw/lkGNQUYPN
	 snycSqQ6TFOg9qNRwdUKrFLSqPnFdodugpCwYghXNpSh6qcrWwaIqOL/kEgCQekliqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.97
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022097.outbound.protection.outlook.com [52.101.96.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B6606A31A;
	Sun, 25 Oct 2026 18:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N35dGwGLwJfiuycme6UeqmuYATMdhHKDDCIaOM6Ee+4f2492qGeMuJacP3l0UCYw2U8v0kgFshVuGOf14yyig8fzd4VjmcSsUvU7bb8BH3IUIE4kDL1VlTAkEdMsK2DYPeqfgVDLsOTMz+FoQZzyVgQ3pz+p0d11GQ8CSMAiKKtLuQ1wh/e0EHlznlflSCwoCw3qCDvYYSjfaBD8YJ20FsJOIaY25KfKoackPC8oxle3iYDsGaqJkWoqn57j5xlzZ4N2ipc4IOArDHHAjZfa0UerN37gkm6axpHkPQWqdkhMYphHeW5qBD84CXJwbKjWZ/V7a4d5qOXe/TeYJoBZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Kc0JHhPutDLfEkkJBnD5JAF8Q7Hw8Nz0T6eEHPnBgQ0=;
 b=JRe3MyI/qjwKCgbzJIDb6LFoLnSkgbU5y3Sqe9S4fbx7sxsNUlTRqdBtAeW6GgwbJZ8qDhcrsGwY/5YFo5YWTWI1M8Rg6vAqKX2FXW296wh0TWgmU2S3ly5Es5tXTaMkLWS5NbrwREEy3KPy6x89Pq/NW7VIkUBszhMdmqAtl51Y+FsIi4hy5ZLy2JGSUn29hrF3An9cbb1acx5INreFfb0AyRmz/MphtNCa+En9efJX7yLueuRYMh/Izufxo+kKXz+4TH3kGIjsy1m8XQ0ydN7PJGTCP49c3ETOYugOZpGH7NgRjOqpqbGyMpAFUUN6o3fj8baNKV8WAB1OEnfGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:52 +0000
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
Subject: [PATCH perf-tools-next v11 05/10] perf ftrace: Support context switch tracking in function graph tracer
Date: Sun, 25 Oct 2026 14:11:20 -0400
Message-ID: <20261025181125.514372-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bc1527-07c5-4b90-41d4-08df32c3720b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261022105027099003|261021135927099003|261021133027099003|261022115727099003|261022113327099003|261022075727099003|261009223027099003|261021130227099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+EgzejVYTXU/w6mYBhP2EMgLO1GL7nic4e/Ua0p1AQGg607LrErYswTgwC4dzrv/gPT0AYAM03bdx90GjAFQ/kF2trN/v8ys4FsJGJ3V5TzNc6O1f31DYrIFY97+So/cvwDgnJXYpkCsIJ79hqFBqhYals9Sw+8Y46FS5uQpuia846RmhN5thWNMJYRZDg8xVCU8EXnCj6l7PFAtn+h3I7TZvClyjBwZNkb1+NTmjFjghuisBUPbTmwCmoO2B5ADAqsp/ga1D9BmP242hIP7ww6KO29YOaSVqRvfMep0akwYV11HflOscyFAAu3RfLLLZqzjGxlvzwNCawyKpMkEFVqTWDt+KE7dop62BGvi6bwnHV6Atn4L5cwlrR8IvSMKLP9IhJMs2ThykrHDsviG00+pwAnWvLhRyfesUuRSCdi4kGQZbYUPq63blBdqsvPGYboI+Ag/y9xqFT7/8QPATtl/HiiRQ4YwdFZ5ooEcEOa09uOokAnJhtfaYA6CU8C0JZBIYoWYqJaUZf7PLMI5N3ZtE5nj7CcmgC//2zLGvIHsKFFWTSTZnKZMGvfI/Af3lgu4aSwMG4g6QlQUGdhJRpDT93OgPTWJlGpsSOksTw0piZ62xWV80blz5q+zm0RUxSQ5jbjP8quKVOkw2K+KTN7Pdxy3U+NebAu9hy0EoR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261021135927099003)(261021133027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021130227099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8T9PPYvrIATmUStt3HhGEdvWxqoIGO+kUMQkybheKhVp4u4v5MhJWqmui/4G?=
 =?us-ascii?Q?Gq0IcMSBCEtHbR8Kp1Iqx/FvLL3dJCKt7OrYB+8RtSmX5sjn0OzXWu2bxcNd?=
 =?us-ascii?Q?XceHLZuglSM0P2r19i1l6BDhax+TnmwUfikXThtXdg++w66hncuM1x3oQtmB?=
 =?us-ascii?Q?ePloAJICiH2uuDiL4QynZZXfA4bLC27K4d5iAyZ1HbZiwzs9WSke2yItyZgK?=
 =?us-ascii?Q?xJ0xl0pNrxWI3/hL4si0kGPnf0ZuSK9vJBD7aVm0y86EKNSOC4wsMxNpYN6o?=
 =?us-ascii?Q?vRJk8yVnROcGuZ+1SM8ELzIuNVBS/db5KFLqHQnyV071CZgqx3Vh7eIfcZAU?=
 =?us-ascii?Q?swoy7M6N6wxzsQvB6IFVc7EjP01ntp/eLjoONsyglAwFMxLWd9LtqJYA4A5t?=
 =?us-ascii?Q?qxSU/FpHhBQBr6K9wFOOpFarK6SCpgi06bJV6q/00FoaNpr01Mi6nTh+UbKh?=
 =?us-ascii?Q?Hb3iJafQ/dH2/MDVs6ZaPRW2C5YVHgzMCmM4HsyjVc0q+HqKzwIe8206q3/b?=
 =?us-ascii?Q?GYLX6KMD9gIBC3GLOgjW1pmHkfiIR+LaN24LrH2sEBmMmH6Nx1JOG+IWV26E?=
 =?us-ascii?Q?o7H/b0Fr1DKjhrq+PKyVcJue6/PZNu55neJBXM4WrykQ6glmiMRBqbWN4AJt?=
 =?us-ascii?Q?HTV3Nq2KgblCmDJPq1ZNMd6+StbqrY7YD9gXNPx51dE2FU5+O7kuHE4rWaXx?=
 =?us-ascii?Q?fU++9x1mGvePwB6toRFzCY3iyk8N1AC9moVIAHYxMzO4EmDaKHJAcrfwKdJg?=
 =?us-ascii?Q?YR0PkQ+QAKez1DWQ+FwvRkvdPhasC++K0pgal+3slO1qoBJ3y9ZBsNQ3Ag/w?=
 =?us-ascii?Q?3Xnf6pJsVPxYbcuD8LaYby7sn2WiyF4fu7Kj63SfF7l/BGrQaQuPAMZJbTZE?=
 =?us-ascii?Q?tcf95a2m0LXN3JttSfxp2ZOoZgtuV18/iCTYKpVDL5AGUroJpXK+n+YKV9eK?=
 =?us-ascii?Q?MyFOVC0e4eSJc4PdPNBuPAMZ83Ro2+bRHdgowzKdo6u7hQzposVb/jUjjxhE?=
 =?us-ascii?Q?U+DoelP5Kxg7UqD+2evn4tznibuV+2Rz3tXGmG8wTZ8EmlbrhV0ozswzuZpq?=
 =?us-ascii?Q?7uRDq6PfUfMJtgmryrKPlrgN3ol+JwwxuNOFIexBTzB0ZQWsLC0Dfi+9N22V?=
 =?us-ascii?Q?C4BS1enFPQ/WOk13M3SYuWyFpQRC2Y9sFMRf2exR/vHX8i8imju6UZlDLpqD?=
 =?us-ascii?Q?rLYDu8gGbrj3I9ljEF/Mk+SzAhqW5NQhMZ14BsWYyyTtj68Rmdjbw5O8QPVC?=
 =?us-ascii?Q?an9Z7W8+GLpSstj8Y68wWmDXvO2GQPw0ZUurn4+EHGmz/tsZ5MvzaVl6fjiA?=
 =?us-ascii?Q?PgXi6uybIOYGYamKEG9t73pZltm3yN4JhBOhxDCjoRW8cjNMe3s2ol5e5nEy?=
 =?us-ascii?Q?ZqbXn/94/hhvN5UnQ2u0bpwAwsj8iJxejjffvte3sNaNgiS6ZHxNcIKFJ2wn?=
 =?us-ascii?Q?vrVB/fcjtSVF134lQHCinbgyH+JPy7PNy1VNa0e5Ev82OG7wcXlys6kfv05A?=
 =?us-ascii?Q?gWwpvFHRsswZmCtICFA7Yp9HZ4Mvpd8qlY/RYq2AecIdP3j8qPFx7MKuymI2?=
 =?us-ascii?Q?CaPuH117tRmtKBft3DoscFE1dB664Mssfh8r35b9MJMJUhRPLxVI0e0c/jSE?=
 =?us-ascii?Q?Om5F01Da/pnn+G3GhnpkBe8YHc8WnkaCNWo74NDxcxT9GFTCCv1yozTbCMPC?=
 =?us-ascii?Q?kRnJSWZYtbU8igwCfhd2PbW5cyGp0TytF+cRCdlkPkxEqJTDQA6yqqcGgaA0?=
 =?us-ascii?Q?tNYYY7oGVA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bc1527-07c5-4b90-41d4-08df32c3720b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:52.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtzrF66HPO1AELSaMSiJzKypT15NF3cv5uOYMMxCmhtQRC7tiozKrpXCh6/cVtLUUmhKcxg7Yq+DMhdoNR6riw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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
        task states to real PIDs upon discovering outgoing task identity.
        Track monotonic trace event sequence numbers on each frame so
        merges can locate the exact splice boundary when tasks migrate
        across CPUs and back before delayed banners are emitted. Prune
        exited frames from pre-migration calls while preserving
        intermediate active frames and splicing them directly into the
        task call stack.

    3.  Verbose mode and single-PID binding

        In find_func_column(), parse the comm-pid column in verbose mode
        to bind active task state on each line record.

        In get_cpu_state(), pre-bind single-PID workloads across all CPUs
        when context-switch banners are absent.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/util/ftrace.c | 336 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/ftrace.h |   3 +
 2 files changed, 335 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 95db57e70d11..055b5eb6b832 100644
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
@@ -124,6 +129,208 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
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
+		int split_idx = existing->depth;
+		int old_split_idx, post_count;
+		int base_raw_indent, post_raw_indent;
+
+		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
+			if (ftrace_cpu_tasks[c] == ts)
+				ftrace_cpu_tasks[c] = existing;
+		}
+
+		/*
+		 * Find the split point in existing where frames postdate ts.
+		 * Frames 0 .. split_idx - 1 were pushed prior to ts.
+		 * Frames split_idx .. existing->depth - 1 were pushed after ts.
+		 */
+		for (j = 0; j < existing->depth; j++) {
+			if (existing->stack[j].seq > ts->seq) {
+				split_idx = j;
+				break;
+			}
+		}
+		old_split_idx = split_idx;
+		post_count = existing->depth - old_split_idx;
+
+		/*
+		 * Prune pre-ts frames on existing that exited before or during ts
+		 * (i.e. whose raw_indent >= base_raw_indent, along with any
+		 * synthesized inlined frames).
+		 */
+		base_raw_indent = -1;
+		if (ts->depth > 0)
+			base_raw_indent = ts->stack[0].raw_indent;
+		if (ts->min_raw_indent >= 0 &&
+		    (base_raw_indent < 0 || ts->min_raw_indent < base_raw_indent))
+			base_raw_indent = ts->min_raw_indent;
+
+		if (base_raw_indent >= 0) {
+			while (split_idx > 0) {
+				struct ftrace_stack_frame *top =
+					&existing->stack[split_idx - 1];
+
+				if (top->inlined) {
+					free(top->name);
+					top->name = NULL;
+					if (existing->inlined_depth > 0)
+						existing->inlined_depth--;
+					split_idx--;
+					existing->depth--;
+				} else if (top->raw_indent >= base_raw_indent) {
+					free(top->name);
+					top->name = NULL;
+					split_idx--;
+					existing->depth--;
+				} else {
+					break;
+				}
+			}
+		}
+
+		/*
+		 * If newer frames or exits exist on existing, prune any frames
+		 * on ts that exited before them.
+		 */
+		post_raw_indent = -1;
+		if (existing->seq > ts->seq) {
+			if (post_count > 0)
+				post_raw_indent = existing->stack[old_split_idx].raw_indent;
+			if (existing->min_raw_indent >= 0 &&
+			    (post_raw_indent < 0 || existing->min_raw_indent < post_raw_indent))
+				post_raw_indent = existing->min_raw_indent;
+		}
+
+		while (post_raw_indent >= 0 && ts->depth > 0) {
+			struct ftrace_stack_frame *top =
+				&ts->stack[ts->depth - 1];
+
+			if (top->inlined) {
+				free(top->name);
+				top->name = NULL;
+				if (ts->inlined_depth > 0)
+					ts->inlined_depth--;
+				ts->depth--;
+			} else if (top->raw_indent >= post_raw_indent) {
+				free(top->name);
+				top->name = NULL;
+				ts->depth--;
+			} else {
+				break;
+			}
+		}
+
+		to_copy = ts->depth;
+		{
+			int total_needed = split_idx + to_copy + post_count;
+
+			while (total_needed > existing->max_stack) {
+				if (ftrace_task_state__grow_stack(existing) < 0)
+					break;
+			}
+			if (total_needed > existing->max_stack) {
+				if (existing->max_stack > split_idx + post_count)
+					to_copy = existing->max_stack - (split_idx + post_count);
+				else
+					to_copy = 0;
+			}
+
+			if (post_count > 0 && (split_idx + to_copy) != old_split_idx) {
+				memmove(&existing->stack[split_idx + to_copy],
+					&existing->stack[old_split_idx],
+					post_count * sizeof(existing->stack[0]));
+			}
+			if (to_copy > 0) {
+				memcpy(&existing->stack[split_idx], &ts->stack[0],
+				       to_copy * sizeof(existing->stack[0]));
+
+				for (j = 0; j < to_copy; j++) {
+					if (ts->stack[j].inlined)
+						existing->inlined_depth++;
+				}
+			}
+			for (j = to_copy; j < ts->depth; j++)
+				free(ts->stack[j].name);
+
+			existing->depth = split_idx + to_copy + post_count;
+		}
+
+		if (ts->seq > existing->seq)
+			existing->seq = ts->seq;
+		if (existing->depth > 0) {
+			existing->min_raw_indent = -1;
+		} else {
+			int m = existing->min_raw_indent;
+
+			if (ts->min_raw_indent >= 0 &&
+			    (m < 0 || ts->min_raw_indent < m))
+				m = ts->min_raw_indent;
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
@@ -132,17 +339,107 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
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
@@ -307,10 +604,32 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -383,13 +702,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
@@ -402,6 +725,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		if (cs->min_raw_indent < 0 || leading_spaces < cs->min_raw_indent)
+			cs->min_raw_indent = leading_spaces;
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		top_raw_indent = -1;
@@ -479,7 +805,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			cs->stack[cs->depth].inlined = false;
 			cs->stack[cs->depth].indent = leading_spaces;
 			cs->stack[cs->depth].raw_indent = leading_spaces;
+			cs->stack[cs->depth].seq = cs->seq;
 			cs->depth++;
+			cs->min_raw_indent = -1;
 		}
 	}
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index fa2974f46582..95c1b880e836 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -109,6 +109,7 @@ struct ftrace_stack_frame {
 	bool inlined;
 	int indent;
 	int raw_indent;
+	u64 seq;
 };
 
 struct ftrace_task_state {
@@ -119,6 +120,8 @@ struct ftrace_task_state {
 	int			depth;
 	int			inlined_depth;
 	int			overflow_depth;
+	u64			seq;
+	int			min_raw_indent;
 };
 
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
-- 
2.55.0

