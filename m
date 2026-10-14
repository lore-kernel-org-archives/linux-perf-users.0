Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E754CF53;
	Wed, 14 Oct 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994541; cv=fail; b=bu0zfTG2riIfdOR+AIDs+RLXwlIxbuOR5HMefTvkzX9GCrbq7SyB68YXU9itq21mvnhRo2VegHu4Y1jLpQvgOkt7ufu5tmkrtKA6t+tdutM2LeSuk0GbH47Nu2zCNqjrpjv140h890Z+pNHgTzI/2xPD8QtGOwqNFXITY8aU1iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994541; c=relaxed/simple;
	bh=1ieHytNuxQy9sL3xkFe6Z4Y0oVTZF/qbpeIdeJ6OWiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYnCLQ1wjtjNwvzlSfh1RtXSUJvccJeRm0zt935BZU02PHZhRwayyKowLcCv+YlczPB05XBkCKE0XZxPQtb/3LIvaKbzfpDeHbuQPLy+iKuJ7D7OoLfscLvn1/Gp6P2WtabhDolc62ocNc4demXB9xd5KOSOHXB1onfenRL58cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEM2/Xp1J03RkH9Es3rgxx9McBFBdz2FgV6aAKWGRzDxdpPOGC+eu/bwvkLzigc0p8qsvyspGRF13YP721PGdH9yGQxgksu27U5bfLKlB+aRLHeJEgIa0Ss20HSCYRZ623sFevmB0zp0HwX+hCdCAMYLk9o69YHGIFbzE+PegE+bkHZ9QdpQekUt2SoD5VxMn05SB86yYgrWEizztR3vXw++XUllBSdIxkCFgTtAxIbxnVEj19PSxTNprA3ixzcuDJke7pw+PRghYRKnFUjZEuEQ2NAhl2UVPm1jVYqGMXpdOOz647QuexyJi7j+i5U93vJw8lsp0L3mS/abo9AHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TFqJoecKC8AcbniffwKtYPi6KPLmFYdYjJUQCreBiSc=;
 b=AqnMb7zWAugmlw1EjjaYaBw52qY5ziy8aCPtvsGmqFysqPKMJDGn0JxVkJCA/H8xHzltnctMs5HgITwAOFN/r9VCgiZUQAYxCP87aO5fi9VYBQUAaDqD3tG4ILv/yLm9odJnnYG2Uf7untzVB+SfXvSrC682OB16yT8BlSMddalqka+41cTTZz1W1SxElxF1yTio+rYM9Mxqt7DME2/Gmetiza5FoZAGB6RaoKA4Q2Su816nQFP1ujFS9loEkJSh/dmDIBPvPGk1jE4+aroOPzws1zK5Zys1H9OXPfVeYiG2SBadZTFry+yLg8wLiQPfhUerDSJlBlPpZ+5Eng6HQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3299.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:15:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:15:20 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v4 5/5] perf ftrace: Filter extraneous functions in function graph tracer
Date: Wed, 14 Oct 2026 12:14:57 -0400
Message-ID: <20261014161457.373253-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014161457.373253-1-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:610:118::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b45bb73-c7d7-4583-9375-08df2a0e5809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1gRaK4IsEyR7r6qA7fdVBL3oC0KykFElOgTuVAKnZibEwSti5hYcK45iYDEJM1YHeyYbbOjeL/nvVTOSmfpF2AOdn+iIjh+bP9ZUP0Rz6kYv2s759YkugdozGeOj7eWsjPInN7pZUAV51bHn0FR98d6A8gaQrNQ32StuzIUhNG5pBeOqDgIQQLKdD2oQw3p5wO2MF24Urs81M0kuxBo9L7xAQZNirwULzcSAL9MYBbTEAPOyuiJ6qIUPDdzZqwNvPvJdhjvyJNz7H6ERHjflkJ8Fr5vsd79Vld2tu0S6TJpHcSDovpF9YRJONq4K+lQqhqKB+fLR+NkSIpMxczEacNJjsDzh+VGQhTdii1w4t74EVQ/ST5dAY+tjHm2UQbdBTDPvzDBOaYrLRTsW2pCc4xwkPwdvL5waFKn4GujR285StlBjN41zIdnXGUHQvPAh+2/R/tEGPaf27UbB+UzLT7kvhdsqrPH5Q085Wo7M21jsh5Kw2CQ6/gYcZ2eBD1t7Tr6c1N/roXx6lIk40//2et3HTnsInJ59KLtyrlaWpcaN8y+vnJoWJm2t1nv7lxFG9zzHhKnTeO2lyAmq4ukfSY6sHuRgfJA5G7pgBgL2yUrG0ey5Nr+Siegc071mveE+Pt+gvZa/rRpHBoRy/qd1uwO7CZNWBpDMybm0HycFhnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?py9REBoSgtsS1a4yErIhPt4DdNljA17n8ToIs2OfM9oKXQi6+mlFy+io/g7M?=
 =?us-ascii?Q?CB+RdpdGLl4+3uubFLfddZhri45BN7LS6FS2iwuj9qvRhRDV7QFASDomHKRn?=
 =?us-ascii?Q?bmeYT+DIHwHZFiXxkNY9q7/DilPISsby1GDwe5NbbGUnkwUFdgonLS2/kx8v?=
 =?us-ascii?Q?W7coqsraHKlvN22rqNQwfdm2AnFrhIAkzZKSRCLZ34qRAYq7VJ6bIDkgleet?=
 =?us-ascii?Q?S1NXpf7j+ixvoNmOnckUA8rKMFnqoP3MbVGmHZfhc2DPD9sXJshRErSnynpC?=
 =?us-ascii?Q?b9n2W+TLmNRPVFETorkQsfrS/NJbT2PwvsH+Wghr0hDZm+dBNl9MzrQSld45?=
 =?us-ascii?Q?7Uem70qUDMbwRmy3FxcPnkQp211Qd5n3AXDYMWf8lg6GJLB0MnjN7Y5WqvU4?=
 =?us-ascii?Q?MSwVgaRcleG30nZpNwZBB0RSD4gWHdaSSnU5XAgkUoC+KXBPhiF9HkHFfHiF?=
 =?us-ascii?Q?1R7m6vwj/jz1AQbw5+SqvfJECEaPYerFjtC/E4CXJAXlteHCjPkcAxyTPPuN?=
 =?us-ascii?Q?sz3ANuJBHSocwF6ibcGzaaRgfKzMH7voKtcW6fwVxYqg/T2r1Nh2Xb3Q/HkD?=
 =?us-ascii?Q?CQkfbmxU7c9oV9/+wquSn1Qp6fpgcAm+jv+C+lFKVI0eGW2Mt9zD9astC27q?=
 =?us-ascii?Q?csRNhP7ilPJMRvKLEyLzqUBjJrW/R9gZ90Fc5z9DErfLGbCO5JgO+ub50R2C?=
 =?us-ascii?Q?5Yo0wsYd0sl7qx04bJ0uHT0sYvikB7dmKqr4UyfWraEzWMwddjmqqgavaNrt?=
 =?us-ascii?Q?szy96mbp01Kx+BLFpefMwR6Pb5BArf5rCooVzsT05o62APMJXvFHseyHSQZJ?=
 =?us-ascii?Q?op3xM3ZX+K7uP3A0GFEF2E9dK/aSwSVrPSw6SyOpL8Q82pDr66Mc2o82wdE6?=
 =?us-ascii?Q?ptMNZHZKrEa1joykPiTj29rTEGZdJ4FmGtGSwAtBkJTpc9+XQ62djpGXL2Pz?=
 =?us-ascii?Q?crn42dcB1yyj56Pv6XDc7YSWcfulQYcLrb8eg6YfsRlPV7YKXHIolD2DGRZg?=
 =?us-ascii?Q?zNFdoSB8Fz6q1ZF+iBgEvWP/0Vkrhai5NFG2EhLErRdm1tfzqhuUiqGKU9hi?=
 =?us-ascii?Q?Nb2XBqjkZJfAtb9hFpa1oF0VFBezi6H79Ld8fhHlUKlKGj7Sz7CNHBmaijZI?=
 =?us-ascii?Q?4tVg9pyFqGLoyFaKfiDN6le8HEkFgAH7Nl6gCE1aMKBKudSA43c7GOlSr/Mb?=
 =?us-ascii?Q?uHqSKry8Ozstf867cVLSsp+Snw5yCvGj0prSp+QGZpUJ2ZdWn/YMidXAyrBl?=
 =?us-ascii?Q?+eZMHybgeN6qGcvCDL+IwtzUgqfrFe6VX97KdPAi7c60PLUKXpewzURuWwM9?=
 =?us-ascii?Q?ydfgJl211yL1ejh6eA06xHZ2YXnIFdb5PVZdhUdM1x3Vlz8LWI7dlFWHJrbi?=
 =?us-ascii?Q?D+Orr8GsIBNfL6/354Hu1CXXCwAgFqfAfd3EAtsJ9yGhWCw1punziPGlJR+R?=
 =?us-ascii?Q?VSkBa6ljvLUO2lVGLeHO5wgv/WL+KQEeZQmRFD8bk6upGToWbiWFlpq0pVrh?=
 =?us-ascii?Q?KvlwN7JpzjtobmNp6B9AZWFVpOtjocwebNcRMmCbJpmsi+djXKgqlibhtim/?=
 =?us-ascii?Q?w6vIFAJYfKFC2JSXR+fsPGG+IUowsfaijHIoyFMyoMFLJYW1KN6OoBhN0tYt?=
 =?us-ascii?Q?PxwCDnzz2Tk8ZlScZxGu5P0hFXm5Dojk1zLfrEWptB5LyTnwR0LC5fJG4I2I?=
 =?us-ascii?Q?VxY9pK1rVL//Vq3UxeyD6NmNFj5SFQhdVHaPOH4ArPANFQtWh/wihFL9kbIo?=
 =?us-ascii?Q?uCtUJaCTvg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b45bb73-c7d7-4583-9375-08df2a0e5809
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:15:20.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOZmUZ1mg2X+GUWPUGmj3M9KhoXzClCn2KBAct1HkrLAlFi1BXIx5Q1SifHITYDzsG41BfJyo0fpUUTnN82x5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3299

When tracing with the function graph tracer using a targeted filter
(-G or --graph-funcs), users occasionally observe unrelated functions in
the trace output:

    1.  Top-level functions (e.g. most notably
        finish_task_switch.isra.0()) appearing before or alongside the
        requested target function. This occurs because clearing and
        rewriting set_graph_function creates a transient window where
        remote CPUs still observe an empty filter (tracing all
        functions) before RCU synchronisation completes, coupled with
        perf ftrace sleeping in poll() on trace_pipe right as tracing
        starts.

    2.  Detached/orphan calls inside the target callgraph (e.g.
        housekeeping_any_cpu() and arch_irq_work_raise()) appearing as
        child frames under the target function. These routines are
        invoked by rb_wakeups() to notify perf's poll() on trace_pipe
        whenever an event is committed, and execute while the target
        function is on the CPU.

Resolve both issues deterministically in userspace:

    1.  Track active target callgraph state per CPU in
        tools/perf/util/ftrace.c. Any entry not matching the requested
        -G targets is suppressed along with its nested children until
        its scope exits. When a target function is matched (at root or
        nested depths), record its root depth; for leaf target calls,
        immediately reset the filter state upon completion to ensure
        subsequent sibling functions remain suppressed.

    2.  Within an active target callgraph, validate that child entries
        descend from an active frame on the target stack using their
        return addresses (CONFIG_FUNCTION_GRAPH_RETADDR). Any detached
        calls originating outside the target hierarchy (such as
        ring-buffer wakeups) are suppressed along with their subtrees.

For example:

    # tracer: function_graph
    #
    # CPU               FUNCTION CALLS
    # |                 |   |   |   |
     3) activate_task() {
     3)   enqueue_task() {
     3)     psi_enqueue() { /* (inline) */
     3)       arch_static_branch_jump() { /* (inline) */
     3)         enqueue_task_fair() {
     3)           enqueue_hierarchy() { /* (inline) */
     3)             update_curr();
     3)             enqueue_entity() {
     3)               account_entity_enqueue() { /* (inline) */
     3)                 account_llc_enqueue();
     3)               } /* account_entity_enqueue (inline) */
     3)             }
     3)           } /* enqueue_hierarchy (inline) */
     3)           place_entity() {
     3)             avg_vruntime();
     3)           }
     3)           __enqueue_entity();
     3)           dl_server_start();
     3)         }
     3)       } /* arch_static_branch_jump (inline) */
     3)     } /* psi_enqueue (inline) */
     3)     sched_info_enqueue() { /* (inline) */
     3)       psi_task_change() {
     3)         psi_write_begin() { /* (inline) */
     3)           psi_flags_change();
     3)         } /* psi_write_begin (inline) */
     3)         psi_group_change() {
     3)           record_times();
     3)         }
     3)       }
     3)     } /* sched_info_enqueue (inline) */
     3)   }
     3) }

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/tests/ftrace.c | 273 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c  | 176 +++++++++++++++++++++++-
 2 files changed, 443 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index 24b5bd4a1e03..1ae81b3efc2e 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -447,6 +447,275 @@ static int test_column_layouts(void)
 	return TEST_OK;
 }
 
+static int test_graph_target_filter(void)
+{
+	static const char line_idle[] = " 7)   3.000 us    |  sched_idle_set_state();";
+	static const char line_sw_entry[] = " 6)               |  finish_task_switch.isra.0() {";
+	static const char line_sw_child[] = " 6)   1.000 us    |    _raw_spin_unlock();";
+	static const char line_sw_exit[] = " 6)   2.000 us    |  }";
+	static const char line_tgt_entry[] = " 2)               |  activate_task() {";
+	static const char line_tgt_child[] = " 2)   1.500 us    |    enqueue_task();";
+	static const char line_tgt_exit[] = " 2)   2.500 us    |  }";
+	struct perf_ftrace ftrace;
+	struct filter_entry *entry;
+	struct filter_entry *pos, *tmp;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	int ret = TEST_OK;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	INIT_LIST_HEAD(&ftrace.graph_funcs);
+
+	entry = malloc(sizeof(*entry) + strlen("activate_task") + 1);
+	if (!entry)
+		return TEST_FAIL;
+	strcpy(entry->name, "activate_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	/* 1. Test without --inline */
+	ftrace.use_inline = false;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "sched_idle_set_state")) {
+		pr_debug("FAILED: sched_idle_set_state not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: _raw_spin_unlock not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: enqueue_task child missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 2. Test with --inline */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_idle, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	pr_debug("Target filter output with --inline:\n%s\n", out_buf);
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed with --inline\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "activate_task() {")) {
+		pr_debug("FAILED: activate_task entry missing with --inline\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 3. Test suppressing detached orphan calls within target graph */
+	ftrace.use_inline = true;
+	ftrace.filter_retaddr = 1;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_tgt_entry, out);
+	/* Leaf orphan call from ring_buffer_unlock_commit */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+		out);
+	/* Non-leaf orphan call from irq_work_queue_on */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    arch_irq_work_raise() { /* <-irq_work_queue_on+0x81/0xa0 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |      apic_wait_icr_idle() { /* (inline) */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |        x2apic_send_IPI_self();",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |      } /* apic_wait_icr_idle (inline) */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)   1.000 us    |    }",
+		out);
+	/* Genuine child call from activate_task */
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)               |    enqueue_task() { /* <-activate_task+0x1d1/0x3e0 */",
+		out);
+	ftrace_process_fgraph_line(&ftrace,
+		" 2)   1.500 us    |    }",
+		out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	pr_debug("Orphan call filter output:\n%s\n", out_buf);
+
+	if (strstr(out_buf, "housekeeping_any_cpu")) {
+		pr_debug("FAILED: housekeeping_any_cpu orphan not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "arch_irq_work_raise")) {
+		pr_debug("FAILED: arch_irq_work_raise orphan not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "x2apic_send_IPI_self")) {
+		pr_debug("FAILED: x2apic_send_IPI_self not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task() {")) {
+		pr_debug("FAILED: genuine enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 4. Test targeted leaf call at depth > 0 resetting filter */
+	ftrace.use_inline = false;
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	entry = malloc(sizeof(*entry) + strlen("enqueue_task") + 1);
+	if (!entry) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	strcpy(entry->name, "enqueue_task");
+	list_add_tail(&entry->list, &ftrace.graph_funcs);
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: targeted leaf enqueue_task missing\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: sibling _raw_spin_unlock not suppressed after leaf target\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* 5. Test targeted leaf call at depth > 0 with inlines resetting filter */
+	ftrace.use_inline = true;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	ftrace_process_fgraph_line(&ftrace, line_sw_entry, out);
+	ftrace_process_fgraph_line(&ftrace, line_tgt_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_child, out);
+	ftrace_process_fgraph_line(&ftrace, line_sw_exit, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (strstr(out_buf, "finish_task_switch")) {
+		pr_debug("FAILED: finish_task_switch not suppressed with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (!strstr(out_buf, "enqueue_task();")) {
+		pr_debug("FAILED: targeted leaf enqueue_task missing with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+	if (strstr(out_buf, "_raw_spin_unlock")) {
+		pr_debug("FAILED: sibling _raw_spin_unlock leaked with inlines\n");
+		ret = TEST_FAIL;
+		goto out_free_filter;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+out_free_filter:
+	if (out_buf)
+		free(out_buf);
+	list_for_each_entry_safe(pos, tmp, &ftrace.graph_funcs, list) {
+		list_del(&pos->list);
+		free(pos);
+	}
+	return ret;
+}
+
 static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
@@ -467,6 +736,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_graph_target_filter();
+	if (ret != TEST_OK)
+		return ret;
+
 	ret = test_inline_processing();
 	if (ret != TEST_OK)
 		return ret;
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 0602e2cc1793..2b065293bfb9 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -34,6 +34,9 @@ struct ftrace_cpu_state {
 	struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
 	int depth;
 	int inlined_depth;
+	bool in_target;
+	int target_root_depth;
+	int orphan_depth;
 };
 
 static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
@@ -407,6 +410,39 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
 	return 0;
 }
 
+static inline bool ftrace_has_graph_funcs(const struct perf_ftrace *ftrace)
+{
+	return ftrace->graph_funcs.next != NULL && !list_empty(&ftrace->graph_funcs);
+}
+
+/**
+ * ftrace_is_graph_func - Check if a function matches the graph_funcs target filter
+ * @ftrace: Perf ftrace context
+ * @func_name: The function name to test
+ *
+ * Return: true if ftrace->graph_funcs is empty or @func_name matches a
+ * target filter, false otherwise.
+ */
+static bool ftrace_is_graph_func(const struct perf_ftrace *ftrace, const char *func_name)
+{
+	struct filter_entry *pos;
+
+	if (!ftrace_has_graph_funcs(ftrace))
+		return true;
+
+	list_for_each_entry(pos, &ftrace->graph_funcs, list) {
+		size_t len = strlen(pos->name);
+
+		if (strcmp(pos->name, func_name) == 0)
+			return true;
+		if (!strncmp(pos->name, func_name, len) &&
+		    (func_name[len] == '\0' || func_name[len] == '.'))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ftrace_process_fgraph_line - Process and output a function graph trace line
  * @ftrace: Perf ftrace context
@@ -443,8 +479,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
 
-	if (!ftrace->use_inline)
+	if (!has_filter && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
@@ -469,6 +506,11 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		if (cs->orphan_depth > 0) {
+			cs->orphan_depth--;
+			return 0;
+		}
+
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		/* Find matching frame on stack */
@@ -494,8 +536,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 					if (cs->inlined_depth > 0)
 						cs->inlined_depth--;
-					fprintf(out, "%s%*s} /* %s (inline) */\n",
-						blank_prefix, exit_indent, "", top->name);
+					if (!has_filter || cs->in_target)
+						fprintf(out, "%s%*s} /* %s (inline) */\n",
+							blank_prefix, exit_indent, "", top->name);
 				}
 				free(top->name);
 				cs->depth--;
@@ -513,9 +556,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			extra_indent = 0;
 		}
 
-		fprintf(out, "%.*s%*s%s\n",
-			(int)(pipe_char - line + 1), line,
-			leading_spaces + extra_indent, "", func_start);
+		if (!has_filter || cs->in_target) {
+			if (!ftrace->use_inline) {
+				print_line(ftrace, line, out);
+			} else {
+				fprintf(out, "%.*s%*s%s\n",
+					(int)(pipe_char - line + 1), line,
+					leading_spaces + extra_indent, "", func_start);
+			}
+		}
+
+		if (has_filter && cs->in_target && cs->depth <= cs->target_root_depth) {
+			cs->in_target = false;
+			cs->target_root_depth = 0;
+			cs->orphan_depth = 0;
+		}
 		return 0;
 	}
 
@@ -523,6 +578,93 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
+	if (cs->orphan_depth > 0) {
+		if (has_open_brace && !has_semicolon)
+			cs->orphan_depth++;
+		return 0;
+	}
+
+	if (has_filter) {
+		if (cs->depth == 0 || !cs->in_target) {
+			char entry_name[128];
+
+			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+			if (ftrace_is_graph_func(ftrace, entry_name)) {
+				cs->in_target = true;
+				cs->target_root_depth = cs->depth;
+				cs->orphan_depth = 0;
+			} else if (cs->depth == 0) {
+				cs->in_target = false;
+				cs->orphan_depth = 0;
+			}
+		}
+
+		if (!cs->in_target) {
+			/* Non-matching call tree; track depth if entering scope, suppress output */
+			if (has_open_brace && !has_semicolon) {
+				char entry_name[128];
+
+				extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+				if (cs->depth < FTRACE_MAX_STACK) {
+					cs->stack[cs->depth].name = strdup(entry_name);
+					if (!cs->stack[cs->depth].name) {
+						pr_err("Not enough memory\n");
+						return -ENOMEM;
+					}
+					cs->stack[cs->depth].inlined = false;
+					cs->stack[cs->depth].indent = leading_spaces;
+					cs->depth++;
+				}
+			}
+			return 0;
+		}
+	}
+
+	if (!ftrace->use_inline) {
+		if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
+			if (ftrace_parse_retaddr(func_start, caller_sym,
+						 sizeof(caller_sym), &caller_offset)) {
+				caller_idx = -1;
+				for (i = cs->depth - 1; i >= 0; i--) {
+					if (!cs->stack[i].inlined && cs->stack[i].name &&
+					    strcmp(cs->stack[i].name, caller_sym) == 0) {
+						caller_idx = i;
+						break;
+					}
+				}
+				if (caller_idx < cs->target_root_depth) {
+					if (has_open_brace && !has_semicolon)
+						cs->orphan_depth = 1;
+					return 0;
+				}
+			}
+		}
+
+		if (has_open_brace && !has_semicolon) {
+			char entry_name[128];
+
+			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+			if (cs->depth < FTRACE_MAX_STACK) {
+				cs->stack[cs->depth].name = strdup(entry_name);
+				if (!cs->stack[cs->depth].name) {
+					pr_err("Not enough memory\n");
+					return -ENOMEM;
+				}
+				cs->stack[cs->depth].inlined = false;
+				cs->stack[cs->depth].indent = leading_spaces;
+				cs->depth++;
+			}
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && cs->in_target && cs->depth <= cs->target_root_depth &&
+		    has_semicolon && !has_open_brace) {
+			cs->in_target = false;
+			cs->target_root_depth = 0;
+			cs->orphan_depth = 0;
+		}
+		return 0;
+	}
+
 	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
 		has_retaddr = true;
 		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
@@ -549,6 +691,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	/*
+	 * When inside a target graph filter, child functions must descend
+	 * from an active frame on the target stack. Suppress detached
+	 * calls originating outside the target hierarchy.
+	 */
+	if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
+		if (has_retaddr && caller_idx < cs->target_root_depth) {
+			if (has_open_brace && !has_semicolon)
+				cs->orphan_depth = 1;
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return 0;
+		}
+	}
+
 	active_inlines = 0;
 	if (caller_idx >= 0) {
 		for (i = caller_idx + 1; i < cs->depth; i++) {
@@ -659,6 +816,13 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	if (has_filter && cs->in_target && cs->depth <= cs->target_root_depth &&
+	    has_semicolon && !has_open_brace) {
+		cs->in_target = false;
+		cs->target_root_depth = 0;
+		cs->orphan_depth = 0;
+	}
+
 	for (i = 0; i < num_inlines; i++)
 		free((void *)inlined_names[i]);
 	return 0;
-- 
2.55.0

