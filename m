Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655687;
	b=pyaQV5LpyqnWQ3JtY2Lo/LjMR6WHn0RbBOptrR0z81dftrBsop0bdsNMvsggYVH6k30i
	 cSwDzgyktI13hJoRBJAFBK7pJ/DPJU+DTgWG/NOSJgm+1pzvpjqcjVf7Tz5r71mggms6N
	 OaGywCgwfx1ZSo55xw2QGVb2IJKsP2xVB1MpgjJalnARDNKqDTSdELVHokHzvgWOQb0kc
	 +ZPusJOUQ/wleul7UNupkX8nJGOSuTHR04rZJgilJkHYRAezat1iwElGXns4UyIq/U/pO
	 iGfelMhXRfY+ODHL6KcVwIA1vbB6BsrZcCiAYSO7Gz59fxns0HUwmLirjDlSG7WDBYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655687;
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
	bh=SQNBQV+ghCpXH/m12bPLkewByzbKfF4HF44ERKvcYPM=;
	b=pJd0uSI1rH6mpmZ2R5vP3PRNiwWWdP1K8KB4glGx5bUmwjanhQtxOmJY9s1gHQdWL9TI
	 r62CexFrWSCzlX6geM0yej/jaldDPKpqxLtF2/zg9rpRf3yBN2lUnr+aVT9HGT+4gJT7i
	 47aoxw8NORTweNDFYv3OUvaKhoo3HkR07qszbnXjw2MmVIXZD0/nw90by5faZOr8/7IJ5
	 g2b5KtRWWbUW8fPzcqP732FOlTzlhC4S97ScL7NBnjpaVPgFd3ZREP3Q80PtOibFA6S95
	 y0klP/F0991v6CZpm03jp5k3hkLvBkZSXQ5G3n1addx1XtChT3QLesnTJsippPPQUXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.73
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F5606A335;
	Mon,  2 Nov 2026 21:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320F5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCj5IU7JS7A43KHx2d9lYHIj6ZT0G5DQFkng7zMZ9VHcAF6Zd74ojfzaHCoqcu0qCWQ9SnIN7w95UYeEanHyRf6JAyLzPd02+vl02yd4lw0KNHUGQePaTpTJbmnOILzKqEys9pw/M3Fhf4L8CpBBbPQDIiQK1J2kBEnNfxthtCoLsBkHSX8Du28C0UuDFCr3VBb9JHdg8B6BrD3ecf7XruZ2JPQp8sTm65gToeGWhh41RYi1N6MjGtz/1J+9kQ5KeP3oS4KOviKJ683ZpiiIq4e46W0zFvhT9WB+fOVxKv5Rm/p9+UCtZS3SAsBa1wjMew8tFIEFreXutT/n/6hZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SQNBQV+ghCpXH/m12bPLkewByzbKfF4HF44ERKvcYPM=;
 b=sARPtLwLA0c7N0d7YYYHwWW6FlZ7hwEN2tiFMOdbDoMzgnSDviZ17FLcCzSKLX8nK2yjIUp9u+GVJKN/yvbZyZ/yOpuvmm4KUSUYDk9N+u8x2up5PbaU1qyCsUwh0JsEom3xYjZoL+ljNO837tYModlvbFPIeQMCZfYeOJU824Cb0kFwrQHTyOVSVggi7pER3THW/M0LIxkAFK2tdZ/CQ9RhIMFvlTqLzk+NV+LT+bUyZjMtxbdPdtdogyrUVGVSFg5JEYTMPd0U9e9Api+0VJbGWczX5VmzR4fku5HSn10iotdmJ1RSETrxiioey+Pmx3ZKORaJfBzvWB/9/wlZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO8P123MB7487.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:22 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:22 +0000
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
Subject: [PATCH perf-tools-next v13 05/10] perf ftrace: Support context switch tracking in function graph tracer
Date: Mon,  2 Nov 2026 16:40:49 -0500
Message-ID: <20261102214054.911298-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::29) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO8P123MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: eac2d479-31b5-4973-bff9-08df392a09af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|56012099006|261102123227099003|3023799007|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261021135927099003|261022075727099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	dDSFVfGorFEGymj+1sqygdYIqfstRMMspfy8bTISRbQSALfv8btAgip2sK1s/YL3Q8d8xUv7lUwFyLUW+GIjIr+6VrbxSs33/k9YHLUHOzYYFwZOQXM+PuC0gUR4SvjDVN3oepqG/r8C/pKjLriOIpDEic5mJenTTYB5KTdUhMRoLnC9WO352kav5lsffNYUoccZzjOi1x3BYAES0UTYVoJRDyDOftzFSReWTjD3WIqxm0U4TyriMcJhCsgUgOFhawIciIwRb+IC0oG7J5NJ/hjcWfoFRA8yjpmDSXs/nwrSIftOCAj6JZ8BZh8yYzL2YOJuw3QCtDdZdR5tSA0JUf+GpPPj/bReqyk7j+s/LLbh5wsIY7GNzc1Cj+j9NT/M7hahRA7Gs3wc7g9497raqTM4b7WSs4aa0FOwsqLakR/A5GRaeslLMZCfQ6PM9ZdrXQ54BkQtQFANNAZgsSeC/w+DhGwmYY4MI10BPOkv7PbG/ZQcOGeit4N3h4Ox51Kjd+CVH4+5vLf0XKuT4DxpUHM6vQj8X6ToTnavh1PGZ0YK7mOycgeJRGysLu3cbxiqn9xFniXUoc8iQqXbM6EmHYtAwqUcMrDKr6oP35kAuKyYjBwtvVMiKXdDR+Y62BZhdO6wXaoGpg8OXCrs+Klc/wbvPCEjZnkNPvNbSaD/+Js=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(261102123227099003)(3023799007)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022075727099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVSrlR/r0cUvhuShucXikRtd1tzXWty8lmJuDO6JnTkibfarT+TTBu2Igm65?=
 =?us-ascii?Q?g+BYF3zwbeF7b7FJRji0ds1Ib8RFdu+cqc52ImrG5JtQ9iITkWCEVGRNqinH?=
 =?us-ascii?Q?Py5f9ntrSuva5HWzN+kXJ/KZE0cntFWOI/T6Rf/+eErLxBocqOLdBinEZEYM?=
 =?us-ascii?Q?Fgcgsq7KhTkUVnKnkL2aZm2J4OzD659+wnY0wajL7vtxxrQk63FeYBUTYv41?=
 =?us-ascii?Q?fZYnenN/IxmSxx+xHCsneZn+u6GUsw0rRWDqhAqvcVUkYUYIqu6HzwbNwCiH?=
 =?us-ascii?Q?YQqyWhnPqCHfVj8EZxSdDBLtVE4UvtBIcN8dJVNJXeDLFn14bxHW7J/gqUxk?=
 =?us-ascii?Q?RViepQQeyZVpjXGQZt+fWBhZQ7UNl4RultjKHjNu+hyZrYWMNE2nug2YlajG?=
 =?us-ascii?Q?v65La27S+HqxvFsRafcd1vBYuXEbcVP8YyvlX/YMotSQcLKRE09QUjm1blOi?=
 =?us-ascii?Q?4+UNZZhmN7fG39aOsYJxgCKGEsUKAqtil0dZygLmSrheCahL5mX2G4X9SRDy?=
 =?us-ascii?Q?y0TsVlonFgkPaGXYPKBsnuJajfMCM1QENjK5JvjGbDASKC9JAn9OvPjQYcXT?=
 =?us-ascii?Q?6fQ8ZabtJOk9alSVFUKRyjSqYd3F/nOUCFaaaK8/ntt25oqgv4oAT4941ciT?=
 =?us-ascii?Q?mbNfd4i28WzT2RdvZFNugRPoWUPXzKmJUGRL0LYIFNCz7okunpS0JKWdKEh1?=
 =?us-ascii?Q?bNNw/Z3Wv4VZ+qtp7bGMInxGosOQDYsc0ATgsnp3Ve9g830EHvnuAUqPHmUI?=
 =?us-ascii?Q?BfV966VVuiVFAAlHBWvhKJiiuxwmk3YKayRfLYRMndC5Wp7Ul08Mh9K3PUgx?=
 =?us-ascii?Q?NgGMdt05TQjpX/oVJk2Htfxfaz64mfMfMWkLhqjqW87iekApLr1zBymImFCW?=
 =?us-ascii?Q?6dhtVhEYcpjOj048w3Ydhh44hJ9RWsSTtcSobQ3NjDQg8WZ+qd/aDx3jiMjC?=
 =?us-ascii?Q?64qmO3/LKDyKT/SoD9l9e4fI9psLhNsu653hJex53qFODorO+SzlmQqeCDER?=
 =?us-ascii?Q?rkCHh5+yDCiG8UsIADHTtCfw/v9B3unRHJ6nWYl6h6MQUVoJ/rU1RvJ/y5k5?=
 =?us-ascii?Q?Db3eEDCgysKBzrvgRC3xmOy6mK5z2I8BjR0gl4dTSSP5XQrWX8yM1hDfVWvJ?=
 =?us-ascii?Q?Py2ApUcWngvuHYEJ4WlLIxRVozmd3A6INwJ0rzingJ+9/jWzTn6sBc8joBKN?=
 =?us-ascii?Q?wbb4JoUaYIiKVKJM6HjBItmr7IFF1WEVDYx7xFDW3GQESUBIwvk4pE+CJz2J?=
 =?us-ascii?Q?ZsXXie/GDlpsOAKMlrFxKXs79uiLI+vKvc6iCERdF8gx8gOk0FcXGcggMJQ2?=
 =?us-ascii?Q?LYGz0hw+5HvDleIn6spQGq6HbNr1sYfKxKhwGDRFwQX3/H8xJ/dzssCJgGo4?=
 =?us-ascii?Q?jJsgq+sGPsl0vS11qwHtxxHLEppNPOklSpbEjdySmK7OAfumKD5cNNeYQxs7?=
 =?us-ascii?Q?L32+RC5lrGL0jtg/bNSFnORMokIAsM9HebYB7EobSf/tuPUZxHzwLX3D96Kq?=
 =?us-ascii?Q?ydmyIOksFoEQFJiqMJ03R7iDa6vRM75kEJeQiM5txlzm0o0ZFccKLbuw2MHl?=
 =?us-ascii?Q?4eaWxsBK5D541DZ68snfohPlYV5eCNaFv9Z0ArGnIkP6CijIOyw5V/6P9Wc8?=
 =?us-ascii?Q?rGqu177aO9kc4tNnSxhMw4Q4BFzZq/G674AtKdgV2xH4laMuTZAJuvx/62vh?=
 =?us-ascii?Q?1Y/NY7GZA43GhQzQE/5krxedXMHBlQVu7KeIskdEZNnOCTU99F+dhN7zq2rk?=
 =?us-ascii?Q?GJ7L8+DFqA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac2d479-31b5-4973-bff9-08df392a09af
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:22.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4eTT8rE7zKYvqnPbnjXOE2d8KgzdJQie6252M1rDVpcoS3tv5eJ6n+z1ITYHUoMCa7eYN/8Jddw4O1LpRDmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7487

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
 tools/perf/util/ftrace.c | 356 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 350 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 21d40c6eb288..5c7d1c71c635 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -13,8 +13,10 @@
 #include <errno.h>
 #include <sys/types.h>
 #include "debug.h"
+#include "evlist.h"
 #include "util/ftrace.h"
 #include "util/string2.h"
+#include <perf/threadmap.h>
 
 #define FTRACE_MAX_CPUS 4096
 #define FTRACE_MAX_STACK 256
@@ -27,12 +29,17 @@
 /*
  * Represents a single call frame on a task's function_graph stack.
  *
- * @name:   Function name extracted from the trace entry.
- * @indent: Indentation (in spaces) used to correlate entry and exit frames.
+ * @name:    Function name extracted from the trace entry.
+ * @inlined: Whether the frame represents a synthesised inlined function.
+ * @indent:  Indentation (in spaces) used to correlate entry and exit frames
+ *           (or visual indentation for synthesised inlined frames).
+ * @seq:     Monotonic event sequence number when the frame was entered.
  */
 struct ftrace_stack_frame {
 	char *name;
+	bool inlined;
 	int indent;
+	u64 seq;
 };
 
 /*
@@ -45,6 +52,9 @@ struct ftrace_stack_frame {
  * @depth:          Current number of active frames stored in @stack.
  * @overflow_depth: Nesting count of frames entered beyond @stack capacity,
  *                  preventing their exits from popping valid parent frames.
+ * @seq:            Event sequence number of the most recent trace record.
+ * @min_raw_indent: Minimum raw indentation observed on this task state, or -1 if none.
+ * @min_indent_seq: Event sequence number of the shallowest observed trace record.
  */
 struct ftrace_task_state {
 	struct hlist_node node;
@@ -53,10 +63,14 @@ struct ftrace_task_state {
 	int max_stack;
 	int depth;
 	int overflow_depth;
+	u64 seq;
+	int min_raw_indent;
+	u64 min_indent_seq;
 };
 
 static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
 static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
+static u64 ftrace_event_seq;
 
 /**
  * ftrace_cpu_states__clear - Free allocated CPU and task stack states
@@ -81,6 +95,7 @@ void ftrace_cpu_states__clear(void)
 	}
 
 	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
+	ftrace_event_seq = 0;
 }
 
 /**
@@ -153,6 +168,7 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 		free(ts);
 		return NULL;
 	}
+	ts->min_raw_indent = -1;
 
 	ts->pid = pid;
 	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
@@ -161,6 +177,205 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	return ts;
 }
 
+/**
+ * ftrace_task_state__record_indent - Record an indentation watermark for a task
+ * @ts: Task state to update
+ * @raw_indent: Raw indentation (leading spaces) of the observed trace record
+ *
+ * Record the shallowest indentation observed on @ts along with its event
+ * sequence number so that earlier frames that have already exited can be
+ * pruned when merging task states across CPUs.
+ */
+static void ftrace_task_state__record_indent(struct ftrace_task_state *ts,
+					     int raw_indent)
+{
+	if (ts->min_raw_indent < 0 || raw_indent <= ts->min_raw_indent) {
+		ts->min_raw_indent = raw_indent;
+		ts->min_indent_seq = ts->seq;
+	}
+}
+
+/**
+ * ftrace_task_state__prune_stack - Prune frames that exited on another task state
+ * @ts: Task state whose call stack should be pruned
+ * @other: Other task state representing the same task on another CPU
+ *
+ * Remove any frames on @ts->stack that are known to have exited based on
+ * subsequent trace events recorded on @other (i.e. @other->min_indent_seq >
+ * frame->seq and @other->min_raw_indent <= frame->indent). Synthesised
+ * inline frames are retained if and only if their enclosing real frame
+ * survives.
+ */
+static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
+					   const struct ftrace_task_state *other)
+{
+	bool keep_inlines = false;
+	bool seen_real = false;
+	int i, dst = 0;
+
+	for (i = ts->depth - 1; i >= 0; i--) {
+		struct ftrace_stack_frame *frame = &ts->stack[i];
+		int min_indent = (other->min_indent_seq > frame->seq) ?
+				 other->min_raw_indent : -1;
+		bool prune;
+
+		if (frame->inlined) {
+			if (seen_real)
+				prune = !keep_inlines;
+			else
+				prune = (min_indent >= 0);
+		} else {
+			prune = (min_indent >= 0 && frame->indent >= min_indent);
+			seen_real = true;
+			keep_inlines = !prune;
+		}
+
+		if (prune)
+			zfree(&frame->name);
+	}
+
+	for (i = 0; i < ts->depth; i++) {
+		if (ts->stack[i].name) {
+			if (dst != i)
+				ts->stack[dst] = ts->stack[i];
+			dst++;
+		}
+	}
+	ts->depth = dst;
+}
+
+/**
+ * ftrace_task_state__rekey - Reassign a task state to a new PID
+ * @ts: The task state to re-key
+ * @new_pid: The new process ID to associate with the state
+ *
+ * Rehash @ts under @new_pid. If a task state for @new_pid already exists,
+ * merge or replace it and return the unified task state.
+ *
+ * Return: A pointer to the active task state associated with @new_pid.
+ */
+static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_state *ts,
+							  pid_t new_pid)
+{
+	struct ftrace_task_state *existing;
+	int orig_existing_depth;
+	int total_needed;
+	int to_copy;
+	u32 key;
+	int j;
+
+	if (ts->pid == new_pid)
+		return ts;
+
+	hlist_del_init(&ts->node);
+
+	existing = find_task_state(new_pid);
+	if (!existing) {
+		ts->pid = new_pid;
+		key = hash_32((u32)new_pid, FTRACE_PID_HASH_BITS);
+		hlist_add_head(&ts->node, &ftrace_task_hash[key]);
+		return ts;
+	}
+
+	/*
+	 * Prune frames on existing and ts that exited during subsequent
+	 * execution recorded on the other state.
+	 */
+	ftrace_task_state__prune_stack(existing, ts);
+	ftrace_task_state__prune_stack(ts, existing);
+
+	orig_existing_depth = existing->depth;
+	to_copy = ts->depth;
+	total_needed = orig_existing_depth + to_copy;
+
+	while (total_needed > existing->max_stack) {
+		if (ftrace_task_state__grow_stack(existing) < 0)
+			break;
+	}
+	if (total_needed > existing->max_stack) {
+		if (existing->max_stack > orig_existing_depth)
+			to_copy = existing->max_stack - orig_existing_depth;
+		else
+			to_copy = 0;
+	}
+
+	if (to_copy > 0) {
+		int e_idx = 0, t_idx = 0, out_idx = 0;
+
+		if (orig_existing_depth > 0) {
+			memmove(&existing->stack[to_copy],
+				&existing->stack[0],
+				orig_existing_depth * sizeof(existing->stack[0]));
+		}
+
+		while (e_idx < orig_existing_depth && t_idx < to_copy) {
+			if (existing->stack[to_copy + e_idx].seq <=
+			    ts->stack[t_idx].seq) {
+				existing->stack[out_idx++] =
+					existing->stack[to_copy + e_idx++];
+			} else {
+				existing->stack[out_idx++] =
+					ts->stack[t_idx++];
+			}
+		}
+		while (t_idx < to_copy)
+			existing->stack[out_idx++] = ts->stack[t_idx++];
+		while (e_idx < orig_existing_depth) {
+			existing->stack[out_idx++] =
+				existing->stack[to_copy + e_idx++];
+		}
+	}
+
+	for (j = to_copy; j < ts->depth; j++)
+		free(ts->stack[j].name);
+
+	existing->depth = orig_existing_depth + to_copy;
+
+	if (ts->seq > existing->seq)
+		existing->seq = ts->seq;
+
+	if (ts->min_raw_indent >= 0 &&
+	    (existing->min_raw_indent < 0 ||
+	     ts->min_raw_indent < existing->min_raw_indent ||
+	     (ts->min_raw_indent == existing->min_raw_indent &&
+	      ts->min_indent_seq > existing->min_indent_seq))) {
+		existing->min_raw_indent = ts->min_raw_indent;
+		existing->min_indent_seq = ts->min_indent_seq;
+	}
+
+	free(ts->stack);
+	free(ts);
+	return existing;
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
@@ -169,17 +384,107 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
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
@@ -349,10 +654,32 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -425,13 +752,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_semicolon;
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
-	if (!pipe_char)
+	if (!pipe_char) {
+		parse_context_switch(line);
 		return print_line(ftrace, line, out);
+	}
 
 	ts = get_cpu_state(ftrace, cpu);
 	if (!ts)
 		return print_line(ftrace, line, out);
 
+	ts->seq = ++ftrace_event_seq;
+
 	after_pipe = pipe_char + 1;
 	func_start = skip_spaces(after_pipe);
 	leading_spaces = func_start - after_pipe;
@@ -444,6 +775,8 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		ftrace_task_state__record_indent(ts, leading_spaces);
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		top_indent = -1;
@@ -493,6 +826,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
+	if (has_open_brace || has_semicolon)
+		ftrace_task_state__record_indent(ts, leading_spaces);
+
 	top_indent = -1;
 	if (ts->depth > 0)
 		top_indent = ts->stack[ts->depth - 1].indent;
@@ -504,6 +840,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (has_open_brace && !has_semicolon) {
 		char entry_name[128];
 
+		while (ts->depth > 0 &&
+		       ts->stack[ts->depth - 1].indent >= leading_spaces) {
+			free(ts->stack[ts->depth - 1].name);
+			ts->depth--;
+		}
+
 		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
 		if (ts->depth >= ts->max_stack &&
 		    ftrace_task_state__grow_stack(ts) < 0) {
@@ -514,7 +856,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 				pr_err("Not enough memory\n");
 				return -ENOMEM;
 			}
+			ts->stack[ts->depth].inlined = false;
 			ts->stack[ts->depth].indent = leading_spaces;
+			ts->stack[ts->depth].seq = ts->seq;
 			ts->depth++;
 		}
 	}
-- 
2.55.0

