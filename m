Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983504;
	b=JCIfZiOB6Tg1iB9SBjOrYbzgeEmcEbCArBye4Pa8JDwE9r6oiMX3ZOYqe/jUuPpR1w0b
	 8hDS+eCMcYBNYa4kU0+Sl8Vd6ZQpKH8113qbLNzBUGtcUdsGrFONm6I7bGSnCAHUGUWdC
	 PnE+4YQBZmPQ5E/dwBNMk7to7Us8GksfRydS03D1xiZxsAOqvEaDhyRUmd9Ego15zZkfx
	 pnSYyljvPkFZM8IFfI4VMcCfmYV3L+2iWMd9xLf4+EcCPKPmSitkJn43+7xjojdU9GKdo
	 tO+4Fur+9XGnZ1D8zW2hH5jfcNNIGGf7xOVpgJNFzsBhml6QR7YJdA4U0UhW9cbZz5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983504;
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
	bh=G9NVR1z6zlHNypL5eGRUQELtnKTYA2oXn3YYab7yb5o=;
	b=YNmw9wfrE9PTkAZjOPN+mToMHYjmwmZDkcVZHyY5Gh7btnOD3IWHqs08JlJhztkhuNxh
	 Wd0DFd3IbPqy4L9nunODLYOR2uK9Vt66e0RL3roQyTmDrJYuucNK+FaYkxNLzquNXmpPp
	 E71C82444UtILyY2cKVz9l7jd6sgK2bTv+ufWZ/Hlizv19pztR2CwXBY7mpnBNhwm4OBf
	 XIGFur/Yf4O0TM0X2O0n7pFvFfC4/OVz1h/Jxbh9VaU8IffZNFO+PkrRHZA//YrKUS1vL
	 4kBwjQk/C3kIBUV3FvPMtodmEGBepvcDso85pNNKZgSaSKsJmqCXRE1yVJBJjON+3/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.119
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022119.outbound.protection.outlook.com [52.101.101.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C03606A31F;
	Mon, 26 Oct 2026 02:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C03606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyd2f7RO0LT8wOLUpNpae6Xqx+2gTyov1p4DInVG68SA5bi9s/CdHvJaVp1gCY3SAUTkkPg8oLh07ndIrpig0KzgZvPiigw2msK/RQyz/112FanjnoBpRNU9aoK5vIvFiYRexgjznSDeu8GVNHFWFcQ+PJuKBYlGRJyEeVw2wjBcZgsTKYY/VbP6Kv7OP2Gqh14QEXpthaYBZabURQZXbe38gwPNu7zm6Vj9Bbfd8Y1RQabRHUQIBUvK8X6ZWkPcDnnGfoHgCeqGslmfEpX8UCd4MItu3cM+N5CJtKWQIL/SOw7DHAf0xWPIQQ4sqJA4/asCKOe4ZzNER/H46v+n7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=G9NVR1z6zlHNypL5eGRUQELtnKTYA2oXn3YYab7yb5o=;
 b=aDFq+aHH9hsABivjY1P7NQC0kIUUVPxdrTG06/ayaADmkSteRN1qQ9lObaJWeCscTGhy4/KUKzonHKTVOfwLnPglggKziFu0H4j09B+mndON3iS0ybw15jTLSc3H/nDqt3dIbByYoprp4eYKukKOacgV44GxAyVjCMm8sGNComFLwmdSDT5w/BXzSFdmo1ueTJ420Kdi7ENYsonTYcazXIDMqMbeMDGZvcY0Z6tyHFxA/2MWlEBW3LuN0tZDwMWr9hPdJYY6iFKUTGkt0YX+8ZzIOSFJFl71lCQsxKQnFsr2+B/73odRtFIUQ809oQm/CajysHLJFsSQeL5I6vC66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:58:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:58:01 +0000
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
Subject: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context switch tracking in function graph tracer
Date: Sun, 25 Oct 2026 22:57:30 -0400
Message-ID: <20261026025735.546101-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:408:ea::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae04ade-8ee1-4b16-bf6c-08df330cf2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4XkwtDlL3CjW920PYjJGpPyHku7RrjdKftL7Mj1Nz1wVa0MGLwcS+E0OGwSgjGaNkbbwDLsWFYLcb9feUoK5hJaSGwKiwwMxoU4jMnvGbemZFijrvAXM3w42v1qLt53MEZtE13PskjsEUJTkCe4uvRELyuZgHMAU2vKxPr5DJGjc67QKoQrIhrGRJB2LmP+WciZpmlvGENzFZIiVMoie5bPJ0dcZTkxt/+33tdVEb/ddMIrT6k2XUTLvH9JTO+Rs03khrdb84JgRVd1ck93Ri2/ji4n/dyscOyAGF8aYdyqIMA++ekR27is+gbj8L+u2iAfJ9fX0vJOfbqfKwf+54AytAqse7n/CMweOryhoScC+uiaHeksOmR+U3NcI99KOakFTL4DNVgngCg/aTFsVxViAUlmZzaPxXqGe9YIykKf+7hp+prxY6dQe7eu82YxrFYGi/8OTxuQ1FBFjCF9XhqbFV61ry22moOey25Qa7DzVM3Q1ubBM9UycNrt7+xpFyQCen7+ETa0UGJYA/Ph1S6C5hEZsK6osnWqjU9B6Vi/KldEbL/aH7DyPxSNCzAgVwRO3Xc/14D+UKJ5m7IXYGYwnzFZ7BvreRZXoqcB7h9azrcZ7Cpxt+myNKeqowA4xJPcJo48/RuSDw9aHVxkKMqSfNt2m3FoW11I9+KcXpEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3++owJxfsJfUdVsWRjTuSiOylGjoF6CrmtMUQ8zpiB1+YO8/ISLoTkloXiw?=
 =?us-ascii?Q?eCEZKuHPXO43wh9CkL2GOZ5bVuoMZjMHSoqHrJFc6KDJTgTzlMu1LWcMaxpG?=
 =?us-ascii?Q?TD8iB82fMxz3LWktZ7Yrd8OkZ4V1mejYwd3qHOfEtvlhpd243nd1e+E73DRm?=
 =?us-ascii?Q?OJ6MeXQCMMMxgUjtqrxmdDTMDfpr/x+IRQ1YbBtY1V7bin6ZFQ3D7KxSaL8C?=
 =?us-ascii?Q?sRuqwv4QpBnZep8MlRanTz12zvHLLy0xF86FdvRhFMYhIC+eooPm2MOTO+3/?=
 =?us-ascii?Q?l1R3vo4kmr1OPj5qiawE6fkF8tKnsHb2bF/NLF0Sj+mAWrcjbKAVGD+QbJdG?=
 =?us-ascii?Q?6vDK6yza9d9w73db/QFn9PyP/Smd4wbwAHFDh6+zJERAxRckCoD25OsCetXT?=
 =?us-ascii?Q?3jdns27DkfGE20qRJjgBKp1krGi0zSuPxoXm0f/a11ftbE0MRsLCpUubiph7?=
 =?us-ascii?Q?wxKvpncHbatcIhSSz5b+MZzE2tENZ32l3cQPnEqI+7KnaqFBABAoI/sDBpSA?=
 =?us-ascii?Q?tz3OWkhkEPl7LjXExW4sbwC+5vXaiMUXvhBHNQJEQeyblpvWlLSG0c0CnJut?=
 =?us-ascii?Q?Rq5UctaH+MoTOK5pLvKAuO2HsE9afAb5P933+kX0KK7uGkCfNeeLnhbuFVr2?=
 =?us-ascii?Q?Ckey0m1vvrkj4z9UDnWs1sckTnVPlO1yKgLQFcegFQKS/EDLUVeGpowOKMAe?=
 =?us-ascii?Q?iXl/gWy5WpE0u+HGn8rpO2ngHoze8m+MoycIyZkeRKYuFTi6PNYHIJWGlMS7?=
 =?us-ascii?Q?E9BZyQZTwd0jsxhuhopKvmTHE/HrE1dL1vpYWl5emEMxo18crVQJGaZtE+rD?=
 =?us-ascii?Q?FpDw85Oz6QdAcA5VYVKTqCOboPEA9IpLJz0AQ/Uz9iuPY5D5BXYwsZWvx5az?=
 =?us-ascii?Q?aGyp885O62h4ujInwu2aalkBpWQQU+KLIC652l6lO3/ahxf5VkmOO3ZMFJel?=
 =?us-ascii?Q?xNAZCdmjTHUQusqlsMfOBSgvoRge+JS+ZVgZbke0/CjxB88i7KoSkvYp1sEd?=
 =?us-ascii?Q?4z2756lzi6JcYtTOfl/RYtbmpCk3/CzXRKUSI8Tk0/6aSwQmjEF/6rPgmVhe?=
 =?us-ascii?Q?20lx773CiN9w5sJ83+oQUb23exJViudJ9DL6f+k3M8XOEN5mSaAZ4ZL7C+pm?=
 =?us-ascii?Q?0MM7WWtbNmCYMlTtbvafVNqVlvehbzxLlHBqYZgsgOeT02/kMVLf6MIRx4Ru?=
 =?us-ascii?Q?FpuGQxYwsEnpQoc52GuEvFx8zJNy0/CsJU0IP3BI62T5Ye9dNHRkUeAKDuXj?=
 =?us-ascii?Q?F7unsVS3q0oQxCnPCvkYN60zQlOpaYmaRgr2nG9vlTqALHEqOV5zh1o6RVU3?=
 =?us-ascii?Q?M+NC6Ft7JfGJgT4ZGkjdCMq5JDIZ9BpICsnDxgU51VEQhBC9tDhWAgieOUmv?=
 =?us-ascii?Q?iHfnZ6+hNO3pfY5oo32+wUxkGZw0vQCQe13ndQHVR8LKAM40ps1is9EtY7/s?=
 =?us-ascii?Q?W4VDaBn8DAJsqbrsJd9Mjf6HdjHEY/mRHxP4WKkvwzY5Y1oHpUEiqjIBa7Dj?=
 =?us-ascii?Q?keTnTP8q8Rnwfv6OJdS1w6a3AJXPzeyksaj5FNlNbba+KtRdGE0HBM72piDU?=
 =?us-ascii?Q?YTO0LgTdu0S9bsbjCgPbiJtKDh1uQIFK6jM06d+5soed3g+p9/T1iQgx0xnE?=
 =?us-ascii?Q?NcZFyLvP7JtupdkfPErMJqHP2hJjhvmaLfu0cEoystqU+TqQ8e8IAW5y3+uX?=
 =?us-ascii?Q?dxfPNBypON05KBadKUws86CXfoQUwdWXQF2JUV2wP1G1j/Q6WXKpWoOCMZib?=
 =?us-ascii?Q?zGqc4Pb7ZA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae04ade-8ee1-4b16-bf6c-08df330cf2b2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:58:01.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqaz7dYn2N4xPQIu91Hc7CusqlIZ3j+lMZeXSvygBWMCP17ekNvTELtmiMoHq1rXmNHAn7QwR7tBPVPtexs1tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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
 tools/perf/util/ftrace.c | 430 ++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/ftrace.h |  10 +
 2 files changed, 436 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 95db57e70d11..fc385d680911 100644
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
@@ -36,12 +39,14 @@ void ftrace_cpu_states__clear(void)
 			for (j = 0; j < ts->depth; j++)
 				free(ts->stack[j].name);
 			free(ts->stack);
+			free(ts->watermarks);
 			hlist_del_init(&ts->node);
 			free(ts);
 		}
 	}
 
 	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
+	ftrace_event_seq = 0;
 }
 
 /**
@@ -98,6 +103,119 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	return ts;
 }
 
+/**
+ * ftrace_task_state__record_indent - Record an indentation watermark for a task
+ * @cs: Task state to update
+ * @seq: Event sequence number of the observed trace record
+ * @raw_indent: Raw indentation (leading spaces) of the observed trace record
+ *
+ * Maintain a monotonic suffix-minima array of (seq, raw_indent) pairs. Any
+ * previously recorded watermarks with an indentation greater than or equal to
+ * @raw_indent are dominated by this newer, shallower (or equal) event for all
+ * earlier frames and are popped before appending the new watermark.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails.
+ */
+static int ftrace_task_state__record_indent(struct ftrace_task_state *cs,
+					    u64 seq, int raw_indent)
+{
+	while (cs->nr_watermarks > 0 &&
+	       cs->watermarks[cs->nr_watermarks - 1].raw_indent >= raw_indent)
+		cs->nr_watermarks--;
+
+	if (cs->nr_watermarks >= cs->max_watermarks) {
+		int new_max = cs->max_watermarks ? cs->max_watermarks * 2 : 16;
+		struct ftrace_indent_watermark *new_wm;
+
+		new_wm = realloc(cs->watermarks, new_max * sizeof(*new_wm));
+		if (!new_wm)
+			return -ENOMEM;
+		cs->watermarks = new_wm;
+		cs->max_watermarks = new_max;
+	}
+
+	cs->watermarks[cs->nr_watermarks].seq = seq;
+	cs->watermarks[cs->nr_watermarks].raw_indent = raw_indent;
+	cs->nr_watermarks++;
+	return 0;
+}
+
+/**
+ * ftrace_task_state__min_indent_after - Query minimum indentation after a sequence number
+ * @cs: Task state whose watermarks are queried
+ * @frame_seq: Sequence number of the frame to check against
+ *
+ * Because @cs->watermarks stores suffix minima in strictly increasing order of
+ * both sequence number and indentation, the first watermark with seq > @frame_seq
+ * holds the minimum raw indentation observed on @cs after @frame_seq.
+ *
+ * Return: The minimum raw indentation observed on @cs after @frame_seq, or -1
+ *         if no events were recorded on @cs after @frame_seq.
+ */
+static int ftrace_task_state__min_indent_after(const struct ftrace_task_state *cs,
+					       u64 frame_seq)
+{
+	int i;
+
+	for (i = 0; i < cs->nr_watermarks; i++) {
+		if (cs->watermarks[i].seq > frame_seq)
+			return cs->watermarks[i].raw_indent;
+	}
+
+	return -1;
+}
+
+/**
+ * ftrace_task_state__prune_stack - Prune frames that exited on another task state
+ * @cs: Task state whose call stack should be pruned
+ * @other: Other task state representing the same task on another CPU
+ *
+ * Remove any frames on @cs->stack that are known to have exited based on
+ * subsequent trace events recorded in @other->watermarks (i.e. events with
+ * seq > frame->seq and raw_indent <= frame->raw_indent). Synthesised inline
+ * frames are retained if and only if their enclosing real frame survives.
+ */
+static void ftrace_task_state__prune_stack(struct ftrace_task_state *cs,
+					   const struct ftrace_task_state *other)
+{
+	bool keep_inlines = false;
+	bool seen_real = false;
+	int i, dst = 0;
+
+	for (i = cs->depth - 1; i >= 0; i--) {
+		struct ftrace_stack_frame *frame = &cs->stack[i];
+		int min_indent = ftrace_task_state__min_indent_after(other, frame->seq);
+		bool prune;
+
+		if (frame->inlined) {
+			if (seen_real)
+				prune = !keep_inlines;
+			else
+				prune = (min_indent >= 0);
+		} else {
+			prune = (min_indent >= 0 && frame->raw_indent >= min_indent);
+			seen_real = true;
+			keep_inlines = !prune;
+		}
+
+		if (prune) {
+			free(frame->name);
+			frame->name = NULL;
+			if (frame->inlined && cs->inlined_depth > 0)
+				cs->inlined_depth--;
+		}
+	}
+
+	for (i = 0; i < cs->depth; i++) {
+		if (cs->stack[i].name) {
+			if (dst != i)
+				cs->stack[dst] = cs->stack[i];
+			dst++;
+		}
+	}
+	cs->depth = dst;
+}
+
 /**
  * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
  * @cs: Task state whose stack should be resized
@@ -124,6 +242,182 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
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
+		int orig_existing_depth;
+		int total_needed;
+
+		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
+			if (ftrace_cpu_tasks[c] == ts)
+				ftrace_cpu_tasks[c] = existing;
+		}
+
+		/*
+		 * Prune frames on existing and ts that exited during subsequent
+		 * execution recorded on the other state.
+		 */
+		ftrace_task_state__prune_stack(existing, ts);
+		ftrace_task_state__prune_stack(ts, existing);
+
+		orig_existing_depth = existing->depth;
+		to_copy = ts->depth;
+		total_needed = orig_existing_depth + to_copy;
+
+		while (total_needed > existing->max_stack) {
+			if (ftrace_task_state__grow_stack(existing) < 0)
+				break;
+		}
+		if (total_needed > existing->max_stack) {
+			if (existing->max_stack > orig_existing_depth)
+				to_copy = existing->max_stack - orig_existing_depth;
+			else
+				to_copy = 0;
+		}
+
+		if (to_copy > 0) {
+			int e_idx = 0, t_idx = 0, out_idx = 0;
+
+			if (orig_existing_depth > 0) {
+				memmove(&existing->stack[to_copy],
+					&existing->stack[0],
+					orig_existing_depth * sizeof(existing->stack[0]));
+			}
+
+			while (e_idx < orig_existing_depth && t_idx < to_copy) {
+				if (existing->stack[to_copy + e_idx].seq <=
+				    ts->stack[t_idx].seq) {
+					existing->stack[out_idx++] =
+						existing->stack[to_copy + e_idx++];
+				} else {
+					if (ts->stack[t_idx].inlined)
+						existing->inlined_depth++;
+					existing->stack[out_idx++] =
+						ts->stack[t_idx++];
+				}
+			}
+			while (t_idx < to_copy) {
+				if (ts->stack[t_idx].inlined)
+					existing->inlined_depth++;
+				existing->stack[out_idx++] = ts->stack[t_idx++];
+			}
+			while (e_idx < orig_existing_depth) {
+				existing->stack[out_idx++] =
+					existing->stack[to_copy + e_idx++];
+			}
+		}
+
+		for (j = to_copy; j < ts->depth; j++)
+			free(ts->stack[j].name);
+
+		existing->depth = orig_existing_depth + to_copy;
+
+		if (ts->seq > existing->seq)
+			existing->seq = ts->seq;
+
+		if (ts->nr_watermarks > 0) {
+			struct ftrace_indent_watermark *old_wm = existing->watermarks;
+			int old_nr = existing->nr_watermarks;
+			int e_wm = 0, t_wm = 0;
+
+			existing->watermarks = NULL;
+			existing->max_watermarks = 0;
+			existing->nr_watermarks = 0;
+
+			while (e_wm < old_nr && t_wm < ts->nr_watermarks) {
+				if (old_wm[e_wm].seq <= ts->watermarks[t_wm].seq) {
+					ftrace_task_state__record_indent(
+						existing,
+						old_wm[e_wm].seq,
+						old_wm[e_wm].raw_indent);
+					e_wm++;
+				} else {
+					ftrace_task_state__record_indent(
+						existing,
+						ts->watermarks[t_wm].seq,
+						ts->watermarks[t_wm].raw_indent);
+					t_wm++;
+				}
+			}
+			while (e_wm < old_nr) {
+				ftrace_task_state__record_indent(
+					existing,
+					old_wm[e_wm].seq,
+					old_wm[e_wm].raw_indent);
+				e_wm++;
+			}
+			while (t_wm < ts->nr_watermarks) {
+				ftrace_task_state__record_indent(
+					existing,
+					ts->watermarks[t_wm].seq,
+					ts->watermarks[t_wm].raw_indent);
+				t_wm++;
+			}
+			free(old_wm);
+		}
+
+		free(ts->watermarks);
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
@@ -132,17 +426,107 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
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
@@ -307,10 +691,32 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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
@@ -383,13 +789,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
@@ -402,6 +812,8 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		ftrace_task_state__record_indent(cs, cs->seq, leading_spaces);
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		top_raw_indent = -1;
@@ -453,6 +865,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
+	if (has_open_brace || has_semicolon)
+		ftrace_task_state__record_indent(cs, cs->seq, leading_spaces);
+
 	top_raw_indent = -1;
 	for (i = cs->depth - 1; i >= 0; i--) {
 		top_raw_indent = cs->stack[i].raw_indent;
@@ -466,6 +881,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (has_open_brace && !has_semicolon) {
 		char entry_name[128];
 
+		while (cs->depth > 0 &&
+		       cs->stack[cs->depth - 1].raw_indent >= leading_spaces) {
+			free(cs->stack[cs->depth - 1].name);
+			cs->depth--;
+		}
+
 		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
 		if (cs->depth >= cs->max_stack &&
 		    ftrace_task_state__grow_stack(cs) < 0) {
@@ -479,6 +900,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			cs->stack[cs->depth].inlined = false;
 			cs->stack[cs->depth].indent = leading_spaces;
 			cs->stack[cs->depth].raw_indent = leading_spaces;
+			cs->stack[cs->depth].seq = cs->seq;
 			cs->depth++;
 		}
 	}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index fa2974f46582..45f5090d0115 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -109,6 +109,12 @@ struct ftrace_stack_frame {
 	bool inlined;
 	int indent;
 	int raw_indent;
+	u64 seq;
+};
+
+struct ftrace_indent_watermark {
+	u64 seq;
+	int raw_indent;
 };
 
 struct ftrace_task_state {
@@ -119,6 +125,10 @@ struct ftrace_task_state {
 	int			depth;
 	int			inlined_depth;
 	int			overflow_depth;
+	u64			seq;
+	struct ftrace_indent_watermark *watermarks;
+	int			max_watermarks;
+	int			nr_watermarks;
 };
 
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
-- 
2.55.0

