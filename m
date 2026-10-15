Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C731716E;
	Thu, 15 Oct 2026 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026743; cv=fail; b=in7hP2PI/COF2mcu7hLx8T93G2asNhlctxmm1TCTUgv8k2o/ajOVwcUpWBnnX4GJxGSdIxpC9IXjSItkeIJyF+qpSnX0EIP065YpPB+EpnX5RJ4PNjnUVtzVcbHCbIvHMisAN2Lpih58Summvjqytm0D2JPxA5RncegLVtayMAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026743; c=relaxed/simple;
	bh=M3Rn2E8flc3REoQI7k9rqrc8GRCXCQZ5SB/k22PWqGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPsMqzM2UuiOB9jdLAvuyvjh+E2Hh1NbGMk/kZU2ul/Q5ni7YNoCgZ4ynCM/Jnvi8GA4sfLX/TLkQtA1uKdgBRw9QUKJstbjIwkadpk24ZaKDk1Y7PGKp3+1VY7BkwRZ0A6uK7kv/ZJ2Ph9RdnaHi4kymPQoOfW5P4ZUJTJ5CHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlvGwGI6Dh/bePWLqCv/Tjwoq7jVYJUZG97YGd6AUKoqsSe8qvQvsJcjYJxTjMsuOkyNR/9E+Z2b8EqioOu7JW7AIqtCm7qrGHcYUQt7RjEr90jsVYtmJ2sLOHHTo6NVbhivMno1qkmjP5IpUAtaquupeGifE/AyJ6V8xnCnhDB62GRdpFo1s4f0X5QIuuTMWT24gY21XLX09G7aB2t4f2llXxFnASdD2o9lzGWwM04i0D3sWfH6DiIE3JlIVrjui3tP4+aCAGG2e6nybUvA/UMQLaU94AbMtYt1Jng7jB2YzkEVZ5ZTYKFnpWhBXi86/dQZThZPEXyMZsAzPlAkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yAhIsrjRWSx42asNcDxEL3b5iVjX5bWsvyld3z1KFCg=;
 b=qOAubhRSrj1JkhSOiAct7YA5OYttiNS2NGSJhu8TrbKfb8Zffkg8gqwDFl82xxJBKY+x0Y9aNn/OJW0Zb2L/iQfvjraADhnNhjMUa6z6PxiAsbXv8X9t4yLGWtDO72W8fS9Ims+lPNklx9yLQapg2UGhIPX8e/1n0VNUKEBTSaERAJZ0JY0RML3hChtTuTrg2ZZTMUwnGg/1T4MyfbcGSYicdYzEr8yta4kInXLQbAAwlnwuvOg/LmpjVd7HXs7O0CibsHZqC2P41gMpkA//y5wK8mm88+SlaFf00zWmH0hTI6EJ6OJlgim1udpg6YXstrByaUx5aHKd6duzulNilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:12:18 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:12:18 +0000
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
Subject: [PATCH perf-tools-next v5 5/5] perf ftrace: Filter extraneous functions in function graph tracer
Date: Wed, 14 Oct 2026 21:11:55 -0400
Message-ID: <20261015011155.414667-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015011155.414667-1-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:408:e8::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: 270e6bd8-2174-41ec-e3d5-08df2a595b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	UBdLsncMblGDvSzKO3L8ar9quPUlc9IPVacAL37yG9/lErUlITeSYVRelGdba3/HLpox+L1WWbiCtGMVxT07mAvz8Is3yl87SKp2L5SW5rz00pPVNSPMITQLRFC/ieLPaWfJ3jCOXG3WEvZMmp6DmPlWsPp8q2QulLMkbzA0jol5tgkrvLR1DMn1QvWlGiO0i0M3NtAnRowx/6dY1qhPdhCTJPbCDNF6jXoP4Ox3DlfmGDQLw8QU91j1jyzJ483AIvXU+I7qjKzF19BA/675eoiVRRWp5FyWIa40C5Xel5guguc9XsQisiTTdbvx6gCCmHrv1s8JFE8IVZspNYz8D94TgTzivzapQGupx9foBnuTVdDaTZ+TMgQgGBFD6kIBHF2GsLFKxf935ux+rC5m3SlSE/otfZ+SkZ+rgBqOrIo1Xrc4SdOPLjC/tvTg/UTGAQx5U4pPKMnKILjoLHPb2CAqCy+mrJRnMsIA1Gl7XdwXBQx53jQgrxsKWCma+C/gbKvP2lWAm6rtaIz/fEclBeRunXEFsJlq8da1wBJ5LcpdbaQlATGYTAcjfXVav2jk+02yb/rEMSV6NtYvBPfkckwyOn2bBQWsBySqnduYvQbReHbefZHfFFP5/y4N+eWG8ijc1sH7km2FcXapYj4nQqLwzn82IsPof16RtS7gHfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZT/NG2GJBWcVc2RPqn/LyT442tqq+3qZig0yPzn2qqI3kkAvrXPsCAeJInH?=
 =?us-ascii?Q?LhqQEh28wleF6NNrJ8O/7fWtpAqsZmssedqQsQ+hp0Jny0w8k2SL85pf2G1t?=
 =?us-ascii?Q?9SHXlv81ZeSTHacu+CCTaYlcejPwsKz8CDR54aCG1bDu40icKKmJiAdy2gH9?=
 =?us-ascii?Q?eT4QASBaCymRKsXFGnELV5eu9sEXg8SoqD+0b0YWZlBGaw6lKQTn4V3ZQh9j?=
 =?us-ascii?Q?SyAbwZy3oAu3PXuFLtjumvTrGXl11t7yM40f6+kKqslBjohsFKepInyKh6J2?=
 =?us-ascii?Q?fiv4jpLuYTOnKF0OkwQ0/BRW51PgDNWbg3adYqpfdqOE2Zc1XRwwsK/jsBlO?=
 =?us-ascii?Q?qkNorrcxDfTMcymQEAHYqc6bhq1YT8AGQJqo5ZtWhEEcWtcOMK83Wf0/hMMb?=
 =?us-ascii?Q?bfUadxsQyrJ0Qle01xawYkJYAhjqljSWwgC19nfXkC0OtU7YGJC79I+a+F7Q?=
 =?us-ascii?Q?ePNu2BltyV6bs5/IldV2kq7/GImUGFC5ZhLitmOJSZF3HdLwRGkqN7ooQV+Y?=
 =?us-ascii?Q?HuXtxVpUuAjt1u3Gwl9z3hJ1IjT0YO2MLuNkVdK5BaZ07qGyxVFcxugGAzaE?=
 =?us-ascii?Q?Fx0+M+FwfE76DP8L2HLfXgyIHoCyb4ZKHOEjZ9V6rZvhLMSVsEAI3n1wUhYw?=
 =?us-ascii?Q?gRG5/dAKeDp5nG8hwx1Adqpk04c0vBeQZy0wNBkqN91wneELvyS5Xlh4AYM6?=
 =?us-ascii?Q?OCk8JF6bZP8bRHS46+5TYvXmltCdKnSZYhRuWZuarN6Ydkjvv6ZJ2cTRUR/x?=
 =?us-ascii?Q?nuKVirkHAbLSdbmIelwLYz4wzxP/afhnIEN4b6qM1m1uACaEUZJezsCgdx5z?=
 =?us-ascii?Q?mbcWIEath2uxsk8NWpfyLD8Gc9e7mu6u7zixYPIPMR61BmKQyjNJsLyu0BVd?=
 =?us-ascii?Q?BqvfcM9Iqc17k6YsZynYo/JD3sbmpoLsdclYxJUFdPP9MzhiMvNonKZ4VsFn?=
 =?us-ascii?Q?SsZSCegRot1XxizJhpIaq3UxneXLshYxk67tKsbPbHiNBZ8Ne3fxdd9h5Q2r?=
 =?us-ascii?Q?9b/OWm1mVXoAIaVpKOkdlJrAd96iyTTgfX+y6gv1d2zn5XtuwFFEJx7u2wdI?=
 =?us-ascii?Q?7AwiO7p7YsQcRUfl22khHkZywu5G7CKEeOpuG1cjmAnGzA576xXoQS1+hJtW?=
 =?us-ascii?Q?UGjXew8hqWuXlyhPCdhNrzx0Xwemah0MiE1amcQbq2vE5AgoOwN4i8hG0keT?=
 =?us-ascii?Q?lnCbliLx+FJiuhX0UjIJ3qnknjm1wEwTkaX0PKsEWvksqaCwdxlt9eFs/hoU?=
 =?us-ascii?Q?JswE97O1MS/9FuSWAn3soqkfj8KdV+haXECszkB/EaKFe4l/Lxr/cyfH9dAu?=
 =?us-ascii?Q?UROSjOmCj7sBxfr6G0JopmTuQT9jtzDDWkwoMcgc1Pdv3ae6HVhUfIeUCzwA?=
 =?us-ascii?Q?xC8laHKF5K0VroEYHIAMP3lx2I74MtpScboMkWeW8c9CFfLaHUaZcppPVWNI?=
 =?us-ascii?Q?LviwPtQWUfSXsbCLRF8VTdeZnCPc7X9qiQ+V6FBtN97HKl1Vu169AJJ4cUbb?=
 =?us-ascii?Q?+8mXCMrbju3srzISOZgjTUq4eEK36PShBrMkh7CmGOz4jediPkXtngdEPt8V?=
 =?us-ascii?Q?qLwP/NDRzEHSithWOoj+Yn6l98+HjnmPmlqCUWXXRISF6UdzPxSmzABVaYnn?=
 =?us-ascii?Q?IqyMcj5guURyt9fR6M4fw/y7ZRU/RlWnWqNDekInluwNCprri6XFWCLX7rqf?=
 =?us-ascii?Q?Do/tL/aJabPXcwhcgYqMvAwAfcWlN2A3JTZUSR+oGZqqnZwd+0HdtcxZe/+W?=
 =?us-ascii?Q?xmu14cJjuw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270e6bd8-2174-41ec-e3d5-08df2a595b85
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:12:18.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMqFGZqiC1ZokYCC8qOkwqTB0ihy0VRVPtUd9eu7Lqg4IpIjSzycO9Oi6Azk614a18/Of3Grq0gom5NPsXtMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

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
 tools/perf/tests/ftrace.c | 323 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.c  | 215 +++++++++++++++++++++++--
 2 files changed, 526 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index a1262c92ad9f..5954706dafe6 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -484,6 +484,325 @@ static int test_column_layouts(void)
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
+	/* 6. Test targeted leaf call with synthesized DWARF inlines closing and resetting filter */
+	if (access("vmlinux", R_OK) == 0) {
+		symbol_conf.vmlinux_name = "vmlinux";
+		symbol_conf.ignore_vmlinux_buildid = true;
+		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
+			out = open_memstream(&out_buf, &out_len);
+			if (!out) {
+				perf_ftrace__cleanup_inlines(&ftrace);
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)               |  wake_up_new_task() {", out);
+			/* Targeted leaf with caller having inline activate_task */
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   1.500 us    |    enqueue_task(); /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				out);
+			/* Sibling call after targeted leaf */
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   1.000 us    |    check_preempt_curr(); /* <-wake_up_new_task+0x0/0x3e0 */",
+				out);
+			ftrace_process_fgraph_line(&ftrace,
+				" 0)   2.500 us    |  } /* wake_up_new_task */", out);
+
+			fclose(out);
+			ftrace_cpu_states__clear();
+			perf_ftrace__cleanup_inlines(&ftrace);
+
+			if (!strstr(out_buf, "enqueue_task();")) {
+				pr_debug("FAILED: targeted leaf enqueue_task missing\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+			if (!strstr(out_buf, "} /* activate_task (inline) */")) {
+				pr_debug("FAILED: inline activate_task not closed after leaf target\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+			if (strstr(out_buf, "check_preempt_curr")) {
+				pr_debug("FAILED: sibling check_preempt_curr leaked after leaf target\n");
+				ret = TEST_FAIL;
+				goto out_free_filter;
+			}
+
+			free(out_buf);
+			out_buf = NULL;
+		}
+	}
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
@@ -504,6 +823,10 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
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
index 71f00d393349..90d0e3c9f8b5 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -35,6 +35,9 @@ struct ftrace_cpu_state {
 	int depth;
 	int inlined_depth;
 	int overflow_depth;
+	bool in_target;
+	int target_root_depth;
+	int orphan_depth;
 };
 
 static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
@@ -414,6 +417,39 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
@@ -450,8 +486,10 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	bool has_open_brace;
 	bool has_semicolon;
 	bool has_retaddr = false;
+	bool has_filter = ftrace_has_graph_funcs(ftrace);
+	bool is_target_root = false;
 
-	if (!ftrace->use_inline)
+	if (!has_filter && !ftrace->use_inline)
 		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
@@ -476,12 +514,23 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	if (is_exit) {
 		char exit_name[128];
 
+		if (cs->orphan_depth > 0) {
+			cs->orphan_depth--;
+			return 0;
+		}
+
 		if (cs->overflow_depth > 0) {
 			cs->overflow_depth--;
-			extra_indent = cs->inlined_depth * 2;
-			fprintf(out, "%.*s%*s%s\n",
-				(int)(pipe_char - line + 1), line,
-				leading_spaces + extra_indent, "", func_start);
+			if (!has_filter || cs->in_target) {
+				if (!ftrace->use_inline) {
+					print_line(ftrace, line, out);
+				} else {
+					extra_indent = cs->inlined_depth * 2;
+					fprintf(out, "%.*s%*s%s\n",
+						(int)(pipe_char - line + 1), line,
+						leading_spaces + extra_indent, "", func_start);
+				}
+			}
 			return 0;
 		}
 
@@ -510,8 +559,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
@@ -529,9 +579,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
 
@@ -539,6 +601,98 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
+				is_target_root = true;
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
+				} else {
+					cs->overflow_depth++;
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
+			} else {
+				cs->overflow_depth++;
+			}
+		}
+		print_line(ftrace, line, out);
+		if (has_filter && cs->in_target && is_target_root &&
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
@@ -565,6 +719,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
@@ -595,8 +764,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 			if (cs->inlined_depth > 0)
 				cs->inlined_depth--;
-			fprintf(out, "%s%*s} /* %s (inline) */\n",
-				blank_prefix, exit_indent, "", top->name);
+			if (!has_filter || cs->in_target)
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
 		}
 		free(top->name);
 		cs->depth--;
@@ -675,6 +845,27 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		}
 	}
 
+	if (has_filter && cs->in_target && is_target_root &&
+	    has_semicolon && !has_open_brace) {
+		while (cs->depth > cs->target_root_depth) {
+			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+			if (top->inlined) {
+				int exit_indent = top->indent;
+
+				if (cs->inlined_depth > 0)
+					cs->inlined_depth--;
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
+			}
+			free(top->name);
+			cs->depth--;
+		}
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

